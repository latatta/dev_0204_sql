-- 순서 : 테이블 생성 -> 데이터 추가 -> 라) 회원매출조회 db쿼리 작성 -> 자바에서 조회될수 있도록 dao,vo 클래스를 코딩하세요.
-- 테이블 이름과 컬럼이름등은 문제에서 준 것으로 하세요.
-- 라)회원매출조회의 VIP,일반 출력은 오라클의 DECODE 함수를 사용하세요.

CREATE SEQUENCE member_seq
INCREMENT BY 1
START WITH 100001;

DROP SEQUENCE member_seq ;

CREATE TABLE member_tbl_02(
	custno number(6) NOT NULL,
	custname varchar2(20),
	phone  varchar2(13),
	address varchar2(60),
	joindate DATE,
	grade char(1),
	city char(2),
	PRIMARY KEY(custno)	
);

COMMENT ON COLUMN HR.MEMBER_TBL_02.CUSTNO IS 'Primary key';

INSERT INTO hr.MEMBER_TBL_02 (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY)
	VALUES (member_seq.nextval, '김행복', '010-1111-2222', '서울 동대문구 휘경1동', '2015-12-02', 'A', '01');
INSERT INTO hr.MEMBER_TBL_02 (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY)
	VALUES (member_seq.nextval, '이축복', '010-1111-3333', '서울 동대문구 휘경2동', '2015-12-06', 'B', '01');
INSERT INTO hr.MEMBER_TBL_02 (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY)
	VALUES (member_seq.nextval, '장믿음', '010-1111-4444', '울릉군 울릉읍 독도1리', '2015-10-01', 'B', '30');
INSERT INTO hr.MEMBER_TBL_02 (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY)
	VALUES (member_seq.nextval, '최사랑', '010-1111-5555', '울릉군 울릉읍 독도2리', '2015-11-13', 'A', '30');
INSERT INTO hr.MEMBER_TBL_02 (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY)
	VALUES (member_seq.nextval, '진평화', '010-1111-6666', '제주도 제주시 외나무골', '2015-12-25', 'B', '60');
INSERT INTO hr.MEMBER_TBL_02 (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY)
	VALUES (member_seq.nextval, '차공단', '010-1111-7777', '서제주도 제주시 감나무골', '2015-12-11', 'C', '60');


CREATE TABLE money_tbl_02(
	custno number(6) NOT NULL ,
	salenol number(8) NOT NULL ,
	pcost number(8),
	amount number(4),
	price number(4),
	pcode varchar2(4),
	sdate DATE,
	PRIMARY KEY (custno, salenol)
);

COMMENT ON COLUMN hr.money_tbl_02.custno IS 'Primary Key';
COMMENT ON COLUMN hr.money_tbl_02.salenol IS 'Primary Key';

INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100001, 20160001, 500, 5, 2500, 'A001', '2016-01-01');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100001, 20160002, 1000, 4, 4000, 'A002', '2016-01-01');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100001, 20160003, 500, 3, 1500, 'A008', '2016-01-01');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100002, 20160004, 2000, 1, 2000, 'A004', '2016-01-02');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100002, 20160005, 500, 1, 500, 'A001', '2016-01-03');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100003, 20160006, 1500, 2, 3000, 'A003', '2016-01-03');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100004, 20160007, 500, 2, 1000, 'A001', '2016-01-04');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100004, 20160008, 300, 1, 300, 'A005', '2016-01-04');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100004, 20160009, 600, 1, 600, 'A006', '2016-01-04');
INSERT INTO hr.money_tbl_02 (CUSTNO, SALENOL, PCOST, AMOUNT, PRICE, PCODE, SDATE)
	VALUES (100004, 20160010, 3000, 1, 3000, 'A007', '2016-01-06');

-- step 1) 회원별 매출합계
SELECT custno, sum(price) FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO ;

-- step 2) 정렬 기준 확인하기
SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO 
ORDER BY asum DESC;

-- step 3) 고객정보 가져오기 위한 joindata 
SELECT * FROM MEMBER_TBL_02 mt ,
	(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
	GROUP BY CUSTNO 
	ORDER BY asum DESC) sale
WHERE mt.CUSTNO = sale.custno ;

-- step 4) 필요한 컬럼만 조회
SELECT mt.CUSTNO , CUSTNAME , DECODE(grade, 'A', 'VIP', 'B', '일반', 'C', '직원') AS agrade  
FROM MEMBER_TBL_02 mt ,
	(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
	GROUP BY CUSTNO 
	ORDER BY asum DESC) sale
WHERE mt.CUSTNO = sale.custno ;


-- step 5) 제시한 요구사항에 따라 컬럼결과 변경하기
SELECT mt.CUSTNO , CUSTNAME , DECODE(grade, 'A', 'VIP', 'B', '일반', 'C', '직원') AS agrade, asum
FROM MEMBER_TBL_02 mt ,
	(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
	GROUP BY CUSTNO 
	ORDER BY asum DESC) sale
WHERE mt.CUSTNO = sale.custno ;

-- 문제 변형 : "매출이 없는 회원은 조회되지 않는다."	를 "매출이 없는 회원은 0으로 출력한다."
-- 			1) null값을 0으로 출력하는 함수 : nvl
--			2) 외부조인으로 수정
--			3) 매출합계가 같을 때는 회원순서로 출력
SELECT mt.CUSTNO , CUSTNAME , DECODE(grade, 'A', 'VIP', 'B', '일반', 'C', '직원') AS agrade, 
	NVL(asum, 0) AS bsum
FROM MEMBER_TBL_02 mt ,
	(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
	GROUP BY CUSTNO) sale
WHERE mt.CUSTNO = sale.custno(+)
ORDER BY bsum DESC, custno;

-- 위의 결과를 view로 생성
CREATE VIEW v_by_custno
AS SELECT mt.CUSTNO , CUSTNAME , DECODE(grade, 'A', 'VIP', 'B', '일반', 'C', '직원') AS agrade, asum
FROM MEMBER_TBL_02 mt ,
	(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
	GROUP BY CUSTNO 
	ORDER BY asum DESC) sale
WHERE mt.CUSTNO = sale.custno ;

-- SELECT 쿼리
SELECT * FROM V_BY_CUSTNO ;