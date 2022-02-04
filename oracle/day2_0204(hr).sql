
-- �������� : �ۼ��� ������

-- 1. jobs ���̺� ����
-- 1) min_salary �÷��� 10000�̻��� Job_title ��ȸ
SELECT JOB_TITLE FROM JOBS j WHERE MIN_SALARY >= 10000; 

-- 2) job_title �÷��� programmer�� ���ڵ�(��� Į��) ��ȸ
SELECT * FROM JOBS j WHERE JOB_TITLE = 'Programmer';
	-- ��ҹ��� ������� �Ѵٸ� ���ڿ� ���� ����Ŭ �Լ� : upper(), lower() ���
SELECT * FROM JOBS j WHERE UPPER(JOB_TITLE) = 'PROGRAMMER';
SELECT * FROM JOBS j WHERE lower(JOB_TITLE) = 'programmer';

-- 3) max_salary �÷��� �ִ밪 ��ȸ
SELECT MAX(max_salary) FROM JOBS j ; 

-- ���ذ� >> �߰� : min_salary �� ��հ����� ���� ���� job_id, job_title �÷� ��ȸ 
-- 		�Ʒ� ����� ���� -> group ���� �Ŀ� �ٽ� �غ��ô�.
SELECT JOB_ID , JOB_TITLE FROM JOBS j WHERE MIN_SALARY < AVG(MIN_SALARY);


------------------------------------------------------------------------------------------
-- 2. locations ���̺� ����
-- 1) city �÷��� London�� postal_code �÷� ��ȸ
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'London';
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'Seattle';

-- 2) LOCATION_ID �÷��� 1700, 2700, 2500�� �ƴϰ� city �÷��� Tokyo�� ���� ��� �÷� ��ȸ
SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND CITY = 'Tokyo';


------------------------------------------------------------------------------------------
-- 3. employees ���̺�
-- ����Լ�(�����Լ�)�� ���� �����մϴ�.
SELECT COUNT(*) FROM EMPLOYEES e ;									-- �Ѱ��� : 107
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';			-- ���� JOB_ID ������ : 5

SELECT AVG(SALARY) FROM EMPLOYEES e;								-- ��ձ޿� : 6461.83
SELECT AVG(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id ��ձ޿� : 5760

SELECT MAX(SALARY) FROM EMPLOYEES e ;								-- ���� �� �ְ�޿� : 24000
SELECT MAX(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id �ְ�޿� : 9000

SELECT MIN(SALARY) FROM EMPLOYEES e ;								-- ���� �� �ּұ޿� : 2100
SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id �ּұ޿� : 4200

-- ����Լ��� �׷��Լ��Դϴ�. �ش��Լ� ������� ���ϱ����� ���� �����͵��� �׷�ȭ�ϰ� �����մϴ�.
-- �׷��Լ� ����� �ٸ� �÷��� ���� ��ȸ�� �� �����ϴ�. �Ʒ� sql�� �����Դϴ�.
SELECT JOB_ID , MAX(SALARY) FROM EMPLOYEES e ;	

SELECT * FROM EMPLOYEES e WHERE SALARY = (
-- ���� max, min ���� sql ��ɹ��� ���⿡ �־����. �� �ǹ̸� �ľ��غ��ô�.
	--SELECT MAX(SALARY) FROM EMPLOYEES e 
	--SELECT MAX(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
	--SELECT MIN(SALARY) FROM EMPLOYEES e 
	SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
);		-- SELECT �ȿ� ���� �� �ٸ� SELECT �� ���������Դϴ�. �������� ������� 1���̹Ƿ� = ���ǽĿ� ��� ����


-- IT_PROG �߿��� �ּұ޿��� �޴� ����� first_name, last_name ��ȸ
SELECT first_name , last_name, SALARY  FROM EMPLOYEES e WHERE SALARY = (
	SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
) AND JOB_ID = 'IT_PROG';


-- ���� 1�� �������� ���ذ�� sql���� �ϼ�
-- ���ذ� >> �߰� : min_salary �� ��հ����� ���� ���� job_id, job_title �÷� ��ȸ 
-- 		* �Ʒ� ����� ���� -> �׷��Լ��� �ݵ�� SELECT ������ ����մϴ�. *
SELECT JOB_ID , JOB_TITLE FROM JOBS j WHERE MIN_SALARY < AVG(MIN_SALARY);

SELECT JOB_ID , JOB_TITLE, MIN_SALARY  FROM JOBS j WHERE MIN_SALARY < (
	SELECT AVG(MIN_SALARY) FROM JOBS j 
);


SELECT job_id, FIRST_NAME , hire_date FROM EMPLOYEES e WHERE hire_date < (
	SELECT AVG(hire_date) FROM EMPLOYEES e
);

SELECT job_id, first_name, LAST_NAME  FROM EMPLOYEES e WHERE LAST_NAME = 'Seo';
