-- 회원이 도서를 '대여'하는 업무처리와 관련된 테이블

DROP TABLE TBL_BOOKRENT;
DROP TABLE TBL_MEMBER ;
DROP TABLE TBL_BOOK ;


CREATE TABLE tbl_member(
	mem_idx number(5) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	email varchar2(20) NOT NULL,
	tel varchar2(20),
	password varchar2 (10)
);

-- 회원번호 시퀀스
CREATE SEQUENCE memidx_seq START WITH 10001;

CREATE TABLE tbl_book(
	bcode char(5) PRIMARY KEY,
	title varchar2(30) NOT NULL,
	writer varchar2(20),
	publisher varchar2(20),
	pdate DATE
);

CREATE TABLE tbl_bookrent(
	-- 기본키
	rent_no number (5) PRIMARY KEY,
	mem_idx NUMBER (5) NOT NULL,
	bcode char (5) NOT NULL,
	rent_date DATE NOT NULL,		-- 빌린 날짜
	exp_date DATE NOT NULL,			-- 반납예정 날짜
	return_date DATE,				-- 실제 반납 날짜
	delay_days NUMBER(3), 			-- 연체 일수
	-- 참조관계
	CONSTRAINT fk1 FOREIGN KEY (mem_idx)
		REFERENCES tbl_member(mem_idx),
	CONSTRAINT fk2 FOREIGN KEY (bcode)
		REFERENCES tbl_book(bcode)
);

-- 대여 일련번호를 위한 시퀀스
CREATE SEQUENCE bookrent_seq;


-- 회원 데이터 추가
INSERT INTO TBL_MEMBER (mem_idx, name, email, tel, password)
	VALUES (memidx_seq.nextval, '이하니', 'honey@gmail.com', '010-9887-6655', 'password');
insert into tbl_member(mem_idx,name,email,tel,password)
	values(memidx_seq.nextval,'이세종','jong@daum.net','010-2354-6773','2345');
insert into tbl_member(mem_idx,name,email,tel,password)
	values(memidx_seq .nextval,'최행운','lucky@korea.com','010-5467-8792','9876');
insert into tbl_member(mem_idx,name,email,tel,password)
	values(memidx_seq.nextval,'나길동','nadong@kkk.net','010-3456-8765','3456');
insert into tbl_member(mem_idx,name,email,tel,password)
	values(memidx_seq.nextval,'강감찬','haha@korea.net','010-3987-9087','1234');

SELECT * FROM TBL_MEMBER tm ;

-- 책 데이터 추가
-- 문자열에서 날짜타입으로는 자동캐스팅됩니다. 함수를 사용할 때에는 to_date() 함수 사용
-- 참고 : 날짜타입을 문자열로 변환 - to_char() 함수
INSERT INTO TBL_BOOK (bcode, title, writer, publisher, pdate)
	values ('A1101','코스모스','칼세이건','사이언스북스',to_date('06/12/01','YY/MM/DD'));
INSERT INTO TBL_BOOK (bcode, title, writer, publisher, pdate)
	values ('B1101','해커스토익','이해커','해커스랩',to_date('18/07/10','YY/MM/DD'));
INSERT INTO TBL_BOOK (bcode, title, writer, publisher, pdate)
	values ('C1101','푸른사자 와니니','이현','창비',to_date('15/06/20','YY/MM/DD'));
INSERT INTO TBL_BOOK (bcode, title, writer, publisher, pdate)
	values ('A1102','페스트','알베르트 까뮈','민음사',to_date('11/03/01','YY/MM/DD'));

SELECT * FROM TBL_BOOK tb ;

DROP SEQUENCE bookrent_seq ;

-- 대여 테이블 추가
-- 프로시저 예시 : 반납날짜 = 대여일자 + 14일
INSERT INTO TBL_BOOKRENT (rent_no, MEM_IDX, bcode, RENT_DATE, EXP_DATE)
	VALUES (bookrent_seq.nextval,10001,'A1101','2021-10-11','2021-10-25');
INSERT INTO TBL_BOOKRENT (rent_no, MEM_IDX, bcode, RENT_DATE, EXP_DATE, RETURN_DATE)
	VALUES (bookrent_seq.nextval,10001,'B1101','2021-09-01','2021-09-15', '2021-09-14');
INSERT INTO TBL_BOOKRENT (rent_no, MEM_IDX, bcode, RENT_DATE, EXP_DATE, RETURN_DATE)
	values(bookrent_seq.nextval,10002,'C1101','2021-09-12','2021-09-26','2021-09-29');
INSERT INTO TBL_BOOKRENT (rent_no, MEM_IDX, bcode, RENT_DATE, EXP_DATE)
	values(bookrent_seq.nextval,10003,'A1102','2021-10-04','2021-10-18');
INSERT INTO TBL_BOOKRENT (rent_no, MEM_IDX, bcode, RENT_DATE, EXP_DATE, RETURN_DATE)
	values(bookrent_seq.nextval,10003,'B1101','2021-09-03','2021-09-17','2021-09-17');
INSERT INTO TBL_BOOKRENT (rent_no, MEM_IDX, bcode, RENT_DATE, EXP_DATE)
	values(bookrent_seq.nextval,10004,'C1101','2021-10-02','2021-10-16');

SELECT * FROM TBL_BOOKRENT tb ;

-- '대여' 업무처리 (조건 : 회원은 하루에 1개의 책만 대여할 수 있다.)
-- 1) 대여한다 : insert를 rent_date만 하고 exp_date는 rent_date + 14일
--				입력매개변수는 회원IDX, bcode, 대여날짜
-- 2) 반납한다 : 입력매개변수는 회원IDX, bcode , 반납날짜		**시험문제**
--				해당되는 rent_no를 구해서 그 값을 조건으로 update return date, delay_days

-- 2번에 대해서 프로시저 만들기
SELECT rent_no FROM TBL_BOOKRENT tb 
	WHERE BCODE = 'A1101' 
	AND MEM_IDX = 10001
	AND RETURN_DATE IS NULL; -- 대여중인 책이므로 반납날짜가 없음

UPDATE TBL_BOOKRENT SET RETURN_DATE = '2021-10-24' WHERE RENT_NO = 1;
UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE WHERE RENT_NO = 1;
UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE WHERE RENT_NO = 2;
UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE WHERE RENT_NO = 3;
UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE WHERE RENT_NO = 5;

SELECT * FROM TBL_BOOKRENT tb ;

-- ****** 시험문제 답 ******
CREATE OR REPLACE PROCEDURE return_book(
	amem_idx IN tbl_member.MEM_IDX%TYPE ,			-- 현실에서는 회원번호 필요없습니다.
	abcode IN tbl_book.bcode%TYPE ,
	areturn_date IN tbl_bookrent.RETURN_DATE %TYPE,
	-- 출력 매개변수로 성공 또는 실패 문자열 전달
	success OUT varchar2
)
IS 
	vrent_no NUMBER;
	v_idx NUMBER;
	cnt NUMBER;
BEGIN 
	SELECT count(*) INTO cnt
		FROM TBL_BOOKRENT tb
		WHERE BCODE = abcode AND MEM_IDX = amem_idx AND RETURN_DATE IS NULL;
	SELECT RENT_NO , MEM_IDX INTO vrent_no, v_idx
		FROM TBL_BOOKRENT
		WHERE bcode = abcode AND mem_idx = amem_idx AND RETURN_DATE IS NULL;
	IF (v_idx = amem_idx AND cnt = 1) THEN 	
		UPDATE TBL_BOOKRENT SET return_date = areturn_date WHERE RENT_NO = vrent_no ;
		UPDATE TBL_BOOKRENT SET delay_days = return_date - exp_date WHERE RENT_NO = vrent_no ;
	END IF;
	COMMIT;
	dbms_output.put_line('success 성공');
	success := 'success';
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line('fail 실패');
		ROLLBACK;
		success := 'fail';
END;

-- 중요 : 변수 선언할 때 프로시저 생성하는 매개변수 또는 변수에서는 크기 생략하고 varchar2 , number 라고 선언하고
--		 일반 프로시저에서는 크기를 꼭 써줍니다.
DECLARE vresult varchar2(20);
BEGIN
	return_book (10004, 'C1101', to_date('2021-10-02'), vresult);
	dbms_output.put_line('결과 : ' || vresult);
END;

SELECT * FROM TBL_BOOKRENT tb ;


-- 매개변수 2개(bcode, 반납날짜)로만 수정
CREATE OR REPLACE PROCEDURE return_book2(
	vbcode IN tbl_book.bcode%TYPE ,
	vreturn_date IN tbl_bookrent.RETURN_DATE %TYPE,  
	success OUT varchar2
)
IS 
	vrent_no NUMBER;
	cnt NUMBER;
BEGIN 
	SELECT count(*) INTO cnt
		FROM TBL_BOOKRENT tb
		WHERE BCODE = vbcode AND RETURN_DATE IS NULL;
	SELECT RENT_NO INTO vrent_no
		FROM TBL_BOOKRENT
		WHERE bcode = vbcode AND RETURN_DATE IS NULL;
	IF (cnt = 1) THEN 	
		UPDATE TBL_BOOKRENT SET return_date = vreturn_date WHERE RENT_NO = vrent_no ;
		UPDATE TBL_BOOKRENT SET delay_days = return_date - exp_date WHERE RENT_NO = vrent_no ;
	END IF;
	COMMIT;
	dbms_output.put_line('success 성공');
    success := 'success';
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line('fail 실패');
		ROLLBACK;
        success := 'fail';
END;

DECLARE vresult varchar2(20);
BEGIN
	return_book2('C1101', '2021-10-02', vresult);
END;
