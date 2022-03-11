/*
 * SQL> connect system/1234
 * SQL> alter user hr account unlock;
 * SQL> alter user hr identified by hr;
 */

-- hr 스키마의 테이블을 이용해서 프로시저 연습합니다.

SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;

-- sales 부서의 최고 연봉금액은?
SELECT max(salary) AS MAX_SALARY 
FROM EMPLOYEES e , DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
	AND d.DEPARTMENT_NAME = 'Sales';
	
-- 위의 join으로 조회한 것을 프로시저 활용해서 구하기
DECLARE 
	dept_id departments.department_id%TYPE;		-- NUMBER 타입
	max_sal NUMBER;		-- 데이터타입 크기 생략
	emp EMPLOYEES%ROWTYPE;
BEGIN
	-- Sales 부서의 부서ID 구하기
	SELECT DEPARTMENT_ID 
	INTO dept_id 	-- 변수에 저장
	FROM DEPARTMENTS d WHERE DEPARTMENT_NAME = 'Sales';
	-- 구해진 부서ID로 직원테이블에서 최고 연봉금액 구하기
	SELECT max(salary)
	INTO max_sal	-- 변수에 저장
	FROM EMPLOYEES e 
	WHERE DEPARTMENT_ID = dept_id ;
	dbms_output.put_line('최고 연봉금액(Sales 부서) : ' || max_sal);
	-- 추가 : 'Sales' 부서의 최고연봉금액을 받는 직원의 정보 구하기 (행 전체를 변수에 저장)
	SELECT * 
	INTO emp		-- rowtype 변수에 조회결과 모든 컬럼을 저장
	FROM EMPLOYEES e 
	WHERE department_id = dept_id AND e.SALARY = max_sal;
	dbms_output.put_line('Sales 최고연봉 직원 : ' || emp.last_name || ',' || emp.hire_date);
END;


--------------------------------------------------------------------
-- 프로시저 오라클 객체로 생성하면 호출해서 다시 사용 가능
/* 기본 형식
CREATE OR REPLACE dept_max_salary(		-> 프로시저 이름은 식별자
	-- 매개변수를 선언하는 위치 : IN은 입력 매개변수로서 실행할 때 전달되는 값을 저장하는 변수
)
IS 	
		-- 필요한 변수선언 위치

BEGIN 
END;
*/
-- 프로시저를 생성할 때 create : 없으면 만들기, replace : 있으면 대체하기
CREATE OR REPLACE PROCEDURE dept_max_salary(		
	dept_name IN hr.departments.DEPARTMENT_NAME%TYPE		-- 대입문 := 으로 초기화
)
IS 
	dept_id NUMBER(8);		
	max_sal NUMBER(8);		
	emp EMPLOYEES%ROWTYPE;
BEGIN 
	SELECT DEPARTMENT_ID 
	INTO dept_id 	-- 변수에 저장
	FROM DEPARTMENTS d WHERE DEPARTMENT_NAME = dept_name;	-- 입력매개변수 대입해서 실행
	
	SELECT max(salary)
	INTO max_sal	-- 변수에 저장
	FROM EMPLOYEES e 
	WHERE DEPARTMENT_ID = dept_id ;
	dbms_output.put_line(dept_name || '최고 연봉금액 : ' || max_sal);
	SELECT * 
	INTO emp
	FROM EMPLOYEES e 
	WHERE department_id = dept_id AND e.SALARY = max_sal;
	dbms_output.put_line('최고연봉 직원 : ' || emp.last_name || ',' || emp.hire_date);
END;


BEGIN 
	dept_max_salary('Sales');
END;

SELECT * FROM EMPLOYEES e ;
-- 일반 join sql
select d.department_id id, d.department_name dept , max_sal from departments d,
        (select DEPARTMENT_ID id, max(salary) max_sal
        from employees 
        GROUP by DEPARTMENT_ID) max_sal# 
    where d.DEPARTMENT_ID = max_sal#.id AND d.DEPARTMENT_NAME = 'Sales';

-- 부서별 최고 연봉
SELECT department_id, max(salary) max_sal 
FROM EMPLOYEES e 
GROUP BY DEPARTMENT_ID HAVING DEPARTMENT_ID=80;


-- 프로시저 정의
CREATE OR REPLACE PROCEDURE dept_max_salary2(
	dept_name IN hr.DEPARTMENTS.DEPARTMENT_NAME%TYPE,
	-- 출력 매개변수
	dept_id OUT hr.DEPARTMENTS.DEPARTMENT_ID%TYPE ,
	max_sal OUT NUMBER
)
IS 
	vdept_id NUMBER(8) ;
BEGIN 
	SELECT d.department_id
	INTO vdept_id 		-- 조회결과 저장할 변수
	FROM DEPARTMENTS d 
	WHERE d.DEPARTMENT_NAME = 'Sales';
	--
	SELECT department_id, max(salary) 
	INTO dept_id, max_sal 		-- 조회결과를 출력 매개변수에 저장
		FROM EMPLOYEES e 
		GROUP BY DEPARTMENT_ID 
		HAVING DEPARTMENT_ID=vdept_id;
	
END;

-- 프로시저 실행할 때 출력 매개변수를 선언해야 합니다.
DECLARE 
	dept_id hr.departments.DEPARTMENT_ID%TYPE;
	max_sal NUMBER;
BEGIN
	dept_max_salary2('Sales', dept_id, max_sal);		-- 프로시저 실행후에 출력매개변수를 통해서 조회한 값을 전달받습니다.
	dbms_output.put_line('부서코드 : ' || dept_id || ', 최고 연봉금액 : ' || max_sal);
END;

