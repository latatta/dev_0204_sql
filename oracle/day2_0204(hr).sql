
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


-- 2. locations 테이블 문제
-- 1) city 컬럼이 London인 postal_code 컬럼 조회
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'London';
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'Seattle';

-- 2) LOCATION_ID 컬럼이 1700, 2700, 2500이 아니고 city 컬럼이 Tokyo인 행의 모든 컬럼 조회
SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND CITY = 'Tokyo';

