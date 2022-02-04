-- DML : select, insert, update, delete 형식 알아보기

----------------------------------------------------------------------------------------

-- 데이터 조회 : select 컬럼명1, 컬럼명2, ... from 테이블명
SELECT STUNO, STU_NAME, EMAIL, ADDRESS, ENTER_DATE
FROM IDEV.STUDENTS;

-- 선택되는 컬럼은 필요한 것들로 합니다.	명령어 한개실행은 ctrl + enter
SELECT stuno, stu_name from STUDENTS;

-- 모든 칼럼을 선택할 때는 wildcard 문자 *로 대체
SELECT * FROM STUDENTS;

-- 데이터 조화에 사용되는 조건 추가는 where 뒤에 조건식 작성
SELECT * FROM STUDENTS WHERE STUNO = 1;
SELECT * FROM STUDENTS WHERE STU_NAME = '최나나';
SELECT * FROM STUDENTS WHERE ENTER_DATE > '2020-06-01';

-- null 값 데이터를 조회하는 조건식
SELECT stuno, stu_name, enter_date, etc from STUDENTS WHERE ETC IS NULL;
SELECT stuno, stu_name, enter_date, etc from STUDENTS WHERE ETC IS NOT NULL;

-- 데이터 조회할 때 컬럼명 대신에 함수(count, sum, avg, max, min)를 사용
SELECT COUNT(*) from STUDENTS;
SELECT MAX(stuno) from STUDENTS s; 	-- s는 별칭(alias)
SELECT MIN(stuno) FROM STUDENTS s;

SELECT MAX(stu_name) FROM STUDENTS s;		-- 문자열 타입의 칼럼은 사전식 비교하여 결과값 구함
SELECT MIN(stu_name) from STUDENTS s ;

-- 데이터 조회 조건식에 IN, 또는 NOT IN : or 조건식 대신에 사용합니다.
SELECT * FROM STUDENTS s WHERE STUNO = 1 OR STUNO = 3 OR STUNO = 7 OR STUNO = 9;
SELECT * FROM STUDENTS s WHERE STUNO IN (1, 3, 7, 9);				-- 동일한 칼럼에 대해 여러개 값을 조건검사
----------------------------------------------------------------------------------------

-- 데이터 추가(삽입) : insert into 테이블명(컬럼명1, 컬럼명2, ...) values (값1, 값2, ...)
INSERT INTO IDEV.STUDENTS
(STUNO, STU_NAME, EMAIL, ADDRESS, ENTER_DATE)
VALUES(0, '', '', '', '');


----------------------------------------------------------------------------------------

-- 데이터 수정 : update 테이블명 set 컬럼명1 = 값1, 컬럼명2 = 값2, ...;
UPDATE IDEV.STUDENTS
SET STUNO=0, STU_NAME='', EMAIL='', ADDRESS='', ENTER_DATE='';


----------------------------------------------------------------------------------------

-- 데이터 삭제 : delete FROM 테이블명 where 컬럼명1 = 값1 and 컬럼명2 = 값2 and ...;
--								where : 삭제할 행에 대한 조건
DELETE FROM IDEV.STUDENTS
WHERE STUNO=0 AND STU_NAME='' AND EMAIL='' AND ADDRESS='' AND ENTER_DATE='';
