--1)

CREATE SEQUENCE tblbuy_seq START WITH 2001;

-- CREATE SEQUENCE tblbuy_seq MINVALUE 2001;


--2)
CREATE TABLE tbl_postcode (
postcode char(5) PRIMARY KEY,
area1 varchar2(200) NOT NULL 
);

--3)
ALTER TABLE "TBL_CUSTOMER#" ADD (postcode char(5) );

 

--4) CUSTOMER# 테이블 POSTCODE 컬럼이 POSTCODE 테이블의 POSTCODE 컬럼을 참조합니다.
--					POSTCODE 컬럼값은 POSTCODE 컬럼의 값만 저장할 수 있습니다.
ALTER TABLE "TBL_CUSTOMER#" ADD CONSTRAINTS fk_postcode
FOREIGN KEY (postcode) REFERENCES tbl_postcode(postcode);


--1)
INSERT INTO TBL_POSTCODE (POSTCODE,AREA1) VALUES ('137964','서울특별시 서초구 서초2동');
INSERT INTO TBL_POSTCODE (POSTCODE,AREA1) VALUES ('138761','서울특별시 송파구 장지동 409880');
INSERT INTO TBL_POSTCODE (POSTCODE,AREA1) VALUES ('412510','경기도 고양시 덕양구 벽제동');
INSERT INTO TBL_POSTCODE (POSTCODE,AREA1) VALUES ('409880','인천광역시 옹진군 자월면');

--2)
UPDATE "TBL_CUSTOMER#" SET POSTCODE ='137964' WHERE CUSTOM_ID ='mina012';
UPDATE "TBL_CUSTOMER#" SET POSTCODE ='412510' WHERE CUSTOM_ID ='hongGD';
UPDATE "TBL_CUSTOMER#" SET POSTCODE ='409880' WHERE CUSTOM_ID ='wonder';
UPDATE "TBL_CUSTOMER#" SET POSTCODE ='138761' WHERE CUSTOM_ID ='sana';


-- 3월 14일 평가 데이터 입출력 구현 : 논리적/물리적설계 분석
-- 1) ER 다이어그램을 보고 데이터 저장소 설계를 상세하게 설명합니다. 	->	테이블 예시는 어느것이 나와도 설명할 수 있게 하세요.
-- 		1. 데이터 타입 : NUMBER(n, m) : n의 의미, m의 의미		예시) number(5, 0) 또는 number(6, 2)를 설명
--					  char(n), varchar2(n)는 한글과 영문의 차이, date/timestamp타입 등에 대하여 설명
--		2. 기본키 컬럼 : 기본키 컬럼의 의미(역할)를 작성하고 예시로 설명. tbl_customer# 테이블에서 기본키 custom_id로 했을 때
--						기본키 컬럼을 값으로 행을 구별할 수 있다. 그래서 custom_id 컬럼의 값은 중복된 값이면 안됩니다.
--						문제에 나온 모든 테이블에 대해서 기본키 컬럼을 설명하세요.
--			시퀀스를 기본키로 사용한 경우는 그 이유도 설명하세요. - 기본키는 unique 컬럼이어야 하는데 만족하는 컬럼이 없기 때문에 sequence를 생성하여 기본키로 사용
--			기본키는 여러개 컬럼을 묶어서 (custom_id, pcode)처럼 그룹으로 설정 가능
--			그러나 여기서는 (custom_id, pcode)는 unique 조건을 만족하지 않음	-> 시퀀스 사용
--		3.	unique 제약조건 :	unique는 유일한 값. 즉, 중복된 값은 허용하지 않는 컬럼.
--		4. 참조관계 외래키 제약조건 : 모든 관계에 대해 설명합니다.
--					ㄴ 키워드 : 참조, 참조컬럼, 외래키 컬럼을 테이블 예시로 설명
--					ㄴ on delete 옵션 설명
-- 1번을 예로해서  varvchar2에 대해서 설명하세요 했을때 --VARCHAR2(길이) : 가변형길이, 길이는 최대길이이고 실제로 메모리는 데이터크기만큼 사용합니다.
--	이렇게만쓰면대나요 아니면 더 길게 써야할까요
--			ㄴ 문자 인코딩이 utf-8 입니다. 영문/숫자/특수기호와 다국어문자 예를들면 한글은 다른 바이트 길이를 사용합니다.

