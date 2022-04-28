DROP TABLE MEMBER_TBL_02 IF EXISTS;		-- sql을 파일로 실행할 때 사용하세요.

create table member_tbl_02(
    custno number(6) not null,
    custname varchar2(20),
    phone varchar2(13),
    address varchar2(60),
    joindate date,
    grade char(1),
    city char(2),
    primary key(custno)
);

create table money_tbl_02(
    custno number(6) not null,
    salenol number(8) not null,
    pcost number(8),
    amount number(4),
    price number(8),
    pcode varchar2(4),
    sdate date,
    primary key(custno,salenol)
);



--CREATE SEQUENCE member_seq INCREMENT BY 1
--START WITH 100001;
DROP SEQUENCE member_seq IF EXISTS;
CREATE SEQUENCE member_seq MINVALUE 100001;

SELECT member_seq.nextval FROM dual;

SELECT * FROM member_tbl_02 ;
SELECT * FROM MONEY_TBL_02 mt ;

-- step 1) 회원별 매출합계
SELECT custno, sum(price) FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO;

-- step 2) 정렬 기준 확인하기
SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO
ORDER BY asum desc;

-- step 3) 고객정보 가져오기위한 join  
SELECT * FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;

-- step 4) 요구사항에 따라 필요한 컬럼만 조회하기

SELECT mt.CUSTNO , CUSTNAME , grade, asum FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;


-- step 5) 제시한 요구사항에 따라 컬럼결과 변경하기
SELECT mt.CUSTNO , CUSTNAME , 
		decode(grade,'A','VIP','B','일반','C','직원') AS agrade, 
		asum FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;

-- 문제 변형 : "매출이 없는 회원은 조회되지 않는다."를 "매출이 없는 회원은 0으로 출력한다."
--			1) null값을 0으로 출력하는 함수 : nvl함수   2)외부조인으로 수정합니다.
--			3) 매출합계가 같을 때는 회원번호 순서(오름차순)로 출력합니다. (참고:역순은 내림차순)

SELECT mt.CUSTNO , CUSTNAME , 
		decode(grade,'A','VIP','B','일반','C','직원') AS agrade, 
		nvl(asum,0) AS sum_ FROM MEMBER_TBL_02 mt ,		--1)
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		) sale
WHERE mt.CUSTNO = sale.custno(+)   --2)
ORDER BY sum_ DESC,custno;		--3) asum 이 같을 때는 custno 순서로 합니다.

-- 위의 5)번 select 실행 결과를 가상테이블 view 로 생성합니다.
CREATE VIEW v_by_custno
as
SELECT mt.CUSTNO , CUSTNAME , 
		decode(grade,'A','VIP','B','일반','C','직원') AS agrade, 
		asum FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;


-- view 를 대상으로 select 쿼리실행
SELECT * FROM V_BY_CUSTNO ;

-- 프로그램의 검색 기능에는 where 를 잘 사용해서 적용해야 합니다.
SELECT * FROM V_BY_CUSTNO WHERE custno=100003;
SELECT * FROM V_BY_CUSTNO WHERE custname='최사랑';
SELECT * FROM V_BY_CUSTNO WHERE agrade='VIP';
SELECT * FROM V_BY_CUSTNO WHERE asum>4000;


-- 조건을 회원이름 검색
SELECT * FROM MEMBER_TBL_02 mt ;
SELECT * FROM MEMBER_TBL_02 mt WHERE CUSTNAME = '최사랑';  
SELECT * FROM MEMBER_TBL_02 mt WHERE CUSTNAME like '%사랑%';  
SELECT * FROM MEMBER_TBL_02 mt WHERE CUSTNAME like '%'||'사랑'||'%';  




