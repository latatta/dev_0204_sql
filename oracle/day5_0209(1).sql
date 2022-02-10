-- 동등 조인 형식 1
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
 	WHERE tp.PCODE = tb.PCODE ;
 		 
-- 동등 조인 형식 2
SELECT * FROM "TBL_PRODUCT#" tp 
	JOIN "TBL_BUY#" tb
	ON tp.PCODE = tb.PCODE ;  	
		 
		
-- 복습 : 아이패드('IPAD012')를 구매한 사용자 이름과 구매날짜 조회
SELECT tc.NAME, tb.BUY_DATE FROM "TBL_BUY#" tb, "TBL_CUSTOMER#" tc  
	WHERE tC.CUSTOM_ID = tb.CUSTOM_ID AND PCODE = 'IPAD011';

SELECT tc.NAME, tb.BUY_DATE FROM "TBL_BUY#" tb JOIN "TBL_CUSTOMER#" tc 
	ON tC.CUSTOM_ID = tb.CUSTOM_ID  
	WHERE tb.PCODE = 'IPAD011';
	


-------------------------------------------------------------------------------------------------------------------
-- day5 : alter table 형식
-- 테스트용 테이블 : 컬럼명, 값들은 의미 없습니다. 형식과 제약조건만 주의하세요.
CREATE TABLE tbl# (
	acol varchar2(30) NOT NULL,
	bcol varchar2(10),
	ccol number(3)
);

INSERT INTO tbl#(ccol) values(12);						-- 오류 : NOT NULL 컬럼(acol) 값이 저장 안됨
INSERT INTO tbl#(bcol, ccol) values('xytz', 12);		-- 오류 : NOT NULL 컬럼(acol) 값이 저장 안됨
INSERT INTO tbl#(acol, ccol) values('main', 12);		-- 정상실행

-- 컬럼 추가
ALTER table tbl# ADD (dcol timestamp DEFAULT sysdate);
SELECT * FROM tbl#;

-- 컬럼 변경
ALTER table tbl# MODIFY (ccol NUMBER(3) DEFAULT '0');
INSERT INTO tbl#(acol, bcol) values('main2', 'asdf');		-- ccol이 0

-- 컬럼 제거(drop)	
ALTER TABLE tbl# DROP COLUMN dcol;

-- 제약조건 추가(제약조건 이름 지정 필요)
ALTER TABLE tbl# ADD CONSTRAINT pk_tbl# PRIMARY KEY (acol);
-- 중복값이 있는 경우(무결성 위반) 중복되는 행을 삭제하고 기본키 추가합니다.
DELETE FROM tbl# WHERE acol = 'main2' AND ccol = 0;

-- 기존 제약조건은 변경 명령 없습니다. -> 기존 제약조건 제거하고 다시 생성해야함
ALTER TABLE tbl# DROP CONSTRAINT pk_tbl#;		-- 제약조건 제거

-- tbl# 테이블에 age 컬럼 생성. check 제약조건 : 16 이상 90 이하의 값
ALTER TABLE "TBL#" ADD age number(3) CHECK (age BETWEEN 16 AND 90);		-- age >= 16 AND age <= 90
INSERT INTO "TBL#" (acol, age) values ('app',23);	-- 실행
INSERT INTO "TBL#" (acol, age) values ('app',99);	-- 오류

-- tbl# 테이블에 gender 컬럼 생성. check 제약조건 : 'M', 'F'
ALTER TABLE "TBL#" ADD gender varchar2(3) CHECK (gender IN ('M', 'F'));
INSERT INTO "TBL#" (acol, gender) values ('momo', 'F');
INSERT INTO "TBL#" (acol, gender) values ('momo', 'X');		-- 제약조건 위반 오류



-- SELECT 에 사용하는 오라클 함수
-- 조회결과를 조작하는 함수 : 예시 age 컬럼값이 null 일때 0, gender 'M'이면 남성, 'F'이면 여성
SELECT * FROM tbl#;
SELECT acol, nvl(age, 0) AS age2, decode(gender, 'M', '남성', 'F', '여성') AS gender2 FROM "TBL#" t ;
-- nvl은 null value, 컬럼명 별칭은 as 키워드를 쓰고 생략할 수 있습니다.




