-- 2번

-- 1)
CREATE OR REPLACE PROCEDURE return_book(
	amem_idx IN tbl_member.MEM_IDX%TYPE ,
	abcode IN tbl_book.bcode%TYPE ,
	areturn_date IN tbl_bookrent.RETURN_DATE %TYPE,
	success OUT varchar2
)
IS 
	vrent_no NUMBER;
	v_idx NUMBER;
	cnt NUMBER;
BEGIN 
	SELECT RENT_NO , MEM_IDX INTO vrent_no, v_idx
		FROM TBL_BOOKRENT
		WHERE bcode = abcode AND mem_idx = amem_idx AND RETURN_DATE IS NULL;
	IF (v_idx = amem_idx) THEN 	
		UPDATE TBL_BOOKRENT SET return_date = areturn_date WHERE RENT_NO = vrent_no ;
		UPDATE TBL_BOOKRENT SET diff_days = return_date - exp_date WHERE RENT_NO = vrent_no ;
	END IF;
	COMMIT;
	dbms_output.put_line('성공');
	success := '성공';
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line('실패');
		ROLLBACK;
		success := '실패';
END;


DECLARE vresult varchar2(20);
BEGIN
	return_book (10004, 'C1101', to_date('2021-10-02'), vresult);
END;



-----------------------------------------------------------------------------------------------
-- 2)
-- tbl_bookrent 에서 mem_idx 가 일치하고, mem_idx가 입력값인 행을 조회합니다.
SELECT tb.RENT_NO, tb.BCODE , tb.RENT_DATE, tm.NAME 
	FROM TBL_BOOKRENT tb, TBL_MEMBER tm 
	WHERE tb.MEM_IDX = tm.MEM_IDX AND tm.MEM_IDX = 10004 ;


CREATE OR REPLACE PROCEDURE join_tbl (
	amem_idx IN tbl_member.MEM_IDX %TYPE ,
	aresult OUT varchar2
)
IS 
	vrent_no NUMBER(5);
	vbcode char(5);
	vrent_date DATE;
	vname varchar2(20) ;
BEGIN 
	SELECT tb.RENT_NO, tb.BCODE , tb.RENT_DATE, tm.NAME 
	INTO vrent_no, vbcode , vrent_date , vname
	FROM TBL_BOOKRENT tb, TBL_MEMBER tm 
	WHERE tb.MEM_IDX = tm.MEM_IDX AND tm.MEM_IDX = amem_idx ;
	aresult := '빌린 내역이 있습니다.' ; 
	dbms_output.put_line('회원이름 : ' || vname || ', 대여번호 : ' || vrent_no || ', 도서 코드 : ' || vbcode || ', 빌린 날짜 : ' || vrent_date);
	EXCEPTION WHEN OTHERS THEN
		ROLLBACK;
		aresult := '오류가 발생했습니다.';
		dbms_output.put_line('오류가 발생했습니다.');
END;

DECLARE vresult varchar2(2000);
BEGIN
	join_tbl (10001, vresult);
END;


