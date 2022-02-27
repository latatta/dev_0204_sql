
-- 연습문제 : 작성자 정세은

-- 1. jobs 테이블 문제
-- 1) min_salary 컬럼이 10000이상인 Job_title 조회
SELECT JOB_TITLE FROM JOBS j WHERE MIN_SALARY >= 10000; 

-- 2) job_title 컬럼이 programmer인 레코드(모든 칼럼) 조회
SELECT * FROM JOBS j WHERE JOB_TITLE = 'Programmer';
	-- 대소문자 상관없이 한다면 문자열 관련 오라클 함수 : upper(), lower() 사용
SELECT * FROM JOBS j WHERE UPPER(JOB_TITLE) = 'PROGRAMMER';
SELECT * FROM JOBS j WHERE lower(JOB_TITLE) = 'programmer';

-- 3) max_salary 컬럼의 최대값 조회
SELECT MAX(max_salary) FROM JOBS j ; 

-- 미해결 >> 추가 : min_salary 의 평균값보다 작은 행의 job_id, job_title 컬럼 조회 
-- 		아래 명령은 오류 -> group 진도 후에 다시 해봅시다.
SELECT JOB_ID , JOB_TITLE FROM JOBS j WHERE MIN_SALARY < AVG(MIN_SALARY);


------------------------------------------------------------------------------------------
-- 2. locations 테이블 문제
-- 1) city 컬럼이 London인 postal_code 컬럼 조회
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'London';
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'Seattle';

-- 2) LOCATION_ID 컬럼이 1700, 2700, 2500이 아니고 city 컬럼이 Tokyo인 행의 모든 컬럼 조회
SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND CITY = 'Tokyo';


------------------------------------------------------------------------------------------
-- 3. employees 테이블
-- 통계함수(집계함수)를 좀더 연습합니다.
SELECT COUNT(*) FROM EMPLOYEES e ;									-- 총개수 : 107
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';			-- 조건 JOB_ID 직원수 : 5

SELECT AVG(SALARY) FROM EMPLOYEES e;								-- 평균급여 : 6461.83
SELECT AVG(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 평균급여 : 5760

SELECT MAX(SALARY) FROM EMPLOYEES e ;								-- 직원 중 최고급여 : 24000
SELECT MAX(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 최고급여 : 9000

SELECT MIN(SALARY) FROM EMPLOYEES e ;								-- 직원 중 최소급여 : 2100
SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 최소급여 : 4200

-- 통계함수는 그룹함수입니다. 해당함수 결과값을 구하기위해 여러 데이터들을 그룹화하고 실행합니다.
-- 그룹함수 결과와 다른 컬럼을 같이 조회할 수 없습니다. 아래 sql은 오류입니다.
SELECT JOB_ID , MAX(SALARY) FROM EMPLOYEES e ;	

SELECT * FROM EMPLOYEES e WHERE SALARY = (
-- 위의 max, min 구한 sql 명령문을 여기에 넣어보세요. 그 의미를 파악해봅시다.
	--SELECT MAX(SALARY) FROM EMPLOYEES e 
	--SELECT MAX(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
	--SELECT MIN(SALARY) FROM EMPLOYEES e 
	SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
);		-- SELECT 안에 쓰인 또 다른 SELECT 는 서브쿼리입니다. 서브쿼리 결과값이 1개이므로 = 조건식에 사용 가능


-- IT_PROG 중에서 최소급여를 받는 사람의 first_name, last_name 조회
SELECT first_name , last_name, SALARY  FROM EMPLOYEES e WHERE SALARY = (
	SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
) AND JOB_ID = 'IT_PROG';


-- 위의 1번 문제에서 미해결된 sql문장 완성
-- 미해결 >> 추가 : min_salary 의 평균값보다 작은 행의 job_id, job_title 컬럼 조회 
-- 		* 아래 명령은 오류 -> 그룹함수는 반드시 SELECT 문으로 사용합니다. *
SELECT JOB_ID , JOB_TITLE FROM JOBS j WHERE MIN_SALARY < AVG(MIN_SALARY);

SELECT JOB_ID , JOB_TITLE, MIN_SALARY  FROM JOBS j WHERE MIN_SALARY < (
	SELECT AVG(MIN_SALARY) FROM JOBS j 
);


SELECT job_id, FIRST_NAME , hire_date FROM EMPLOYEES e WHERE hire_date < (
	SELECT AVG(hire_date) FROM EMPLOYEES e
);

SELECT job_id, first_name, LAST_NAME  FROM EMPLOYEES e WHERE LAST_NAME = 'Seo';
