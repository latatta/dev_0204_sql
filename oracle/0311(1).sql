-- 프로시저의 BEGIN ~ END ; 사이의 SQL 명령들이 여러개인 경우가 대부분. 그 여러개의 명령어가 하나의 업무를 처리합니다.
--		트랜잭션 : 하나의 업무를 처리하는 SQL 명령들 -> 모두 정상실행되어야 합니다.(commit) 
--				 그렇지 않으면(하나라도 오류가 생기면) 이미 실행된 SQL 명령들은 취소가 됩니다.(rollback)

SELECT * FROM tbl_buy#;
SELECT * FROM "TBL_PRODUCT#" tp ;
-- 오늘의 주제 : 프로시저로 트랜잭션 처리
-- tbl_buy# 테이블에 지불금액 money 컬럼을 추가하고 상품가격*수량 계산해서 저장
ALTER TABLE "TBL_BUY#" ADD money number(8);

-- '결제금액' 구하기라는 트랜잭션이라고 하고 예시로 하나씩 실행해보세요.

-- 처리순서1 : wonder 고객이 CHR-J59를 2개 구매합니다.
INSERT INTO "TBL_BUY#"(BUY_SEQ, CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES (TBL_BUY_SEQ.nextval, 'wonder', 'CHR-J59', 2, sysdate);

-- 처리순서2 : dual 임시테이블 이용해서 현재 seq값 구하기
SELECT TBL_BUY_SEQ.currval FROM dual;

-- 처리순서3 : 구매한 상품의 가격 구하기
SELECT price FROM "TBL_PRODUCT#" tp WHERE PCODE = 'CHR-J59';

-- 처리순서4 : 처리순서1에서 추가된 행에 money 컬럼 계산하고 저장
UPDATE "TBL_BUY#" SET money = 98700*QUANTITY 
WHERE BUY_SEQ = 81;

-- 위의 트랜잭션을 프로시저로 생성합니다.(정의)
CREATE OR REPLACE PROCEDURE proc_set_money(
	acustom_id IN varchar2, 
	apcode IN varchar2, 
	acnt IN NUMBER,
	isSuccess OUT varchar2 
)
IS 
	vseq NUMBER;	-- 변수선언
	vprice number ;
BEGIN 
	INSERT INTO tbl_test 
		VALUES (acustom_id, 2);		-- 트랜잭션의 하나로 가정을 하고 임시테이블에 데이터 추가
	INSERT INTO "TBL_BUY#"(BUY_SEQ, CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
		VALUES (TBL_BUY_SEQ.nextval, acustom_id, apcode, acnt, sysdate);	-- 매개변수값으로 추가
	SELECT tbl_buy_seq.currval INTO vseq 
		FROM dual;
	SELECT price INTO vprice FROM tbl_product# 
		WHERE PCODE = apcode;
	UPDATE "TBL_BUY#" SET money = vprice*acnt 
		WHERE BUY_SEQ = vseq;
	dbms_output.put_line('실행 성공');		
	isSuccess := 'success';
	commit ;
	EXCEPTION 		-- EXCEPTION 추가하여 처리 -> 메세지 출력, rollback
		WHEN OTHERS THEN 
		dbms_output.put_line('실행 실패');		
		isSuccess := 'fail';
		ROLLBACK;
END;


-- 프로시저 실행
BEGIN
	proc_set_money ('twice', 'CJ-BABQ1', 1);		-- 오류발생합니다.(참조관계 컬럼에 잘못된 값으로 실행)
END;
SELECT * FROM "TBL_BUY#" tb ;
SELECT * FROM TBL_TEST tt ;


CREATE TABLE tbl_test(custom_id varchar2(20), buy_seq number(8));	
-- 트랜잭션 테스트용 테이블. 오류가 났을때 rollback 확인용


