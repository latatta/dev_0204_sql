
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


-- 2. locations ���̺� ����
-- 1) city �÷��� London�� postal_code �÷� ��ȸ
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'London';
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'Seattle';

-- 2) LOCATION_ID �÷��� 1700, 2700, 2500�� �ƴϰ� city �÷��� Tokyo�� ���� ��� �÷� ��ȸ
SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND CITY = 'Tokyo';

