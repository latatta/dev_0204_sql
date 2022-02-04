-- DML : select, insert, update, delete ���� �˾ƺ���

----------------------------------------------------------------------------------------

-- ������ ��ȸ : select �÷���1, �÷���2, ... from ���̺��
SELECT STUNO, STU_NAME, EMAIL, ADDRESS, ENTER_DATE
FROM IDEV.STUDENTS;

-- ���õǴ� �÷��� �ʿ��� �͵�� �մϴ�.	��ɾ� �Ѱ������� ctrl + enter
SELECT stuno, stu_name from STUDENTS;

-- ��� Į���� ������ ���� wildcard ���� *�� ��ü
SELECT * FROM STUDENTS;

-- ������ ��ȭ�� ���Ǵ� ���� �߰��� where �ڿ� ���ǽ� �ۼ�
SELECT * FROM STUDENTS WHERE STUNO = 1;
SELECT * FROM STUDENTS WHERE STU_NAME = '�ֳ���';
SELECT * FROM STUDENTS WHERE ENTER_DATE > '2020-06-01';

-- null �� �����͸� ��ȸ�ϴ� ���ǽ�
SELECT stuno, stu_name, enter_date, etc from STUDENTS WHERE ETC IS NULL;
SELECT stuno, stu_name, enter_date, etc from STUDENTS WHERE ETC IS NOT NULL;

-- ������ ��ȸ�� �� �÷��� ��ſ� �Լ�(count, sum, avg, max, min)�� ���
SELECT COUNT(*) from STUDENTS;
SELECT MAX(stuno) from STUDENTS s; 	-- s�� ��Ī(alias)
SELECT MIN(stuno) FROM STUDENTS s;

SELECT MAX(stu_name) FROM STUDENTS s;		-- ���ڿ� Ÿ���� Į���� ������ ���Ͽ� ����� ����
SELECT MIN(stu_name) from STUDENTS s ;

-- ������ ��ȸ ���ǽĿ� IN, �Ǵ� NOT IN : or ���ǽ� ��ſ� ����մϴ�.
SELECT * FROM STUDENTS s WHERE STUNO = 1 OR STUNO = 3 OR STUNO = 7 OR STUNO = 9;
SELECT * FROM STUDENTS s WHERE STUNO IN (1, 3, 7, 9);				-- ������ Į���� ���� ������ ���� ���ǰ˻�
----------------------------------------------------------------------------------------

-- ������ �߰�(����) : insert into ���̺��(�÷���1, �÷���2, ...) values (��1, ��2, ...)
INSERT INTO IDEV.STUDENTS
(STUNO, STU_NAME, EMAIL, ADDRESS, ENTER_DATE)
VALUES(0, '', '', '', '');


----------------------------------------------------------------------------------------

-- ������ ���� : update ���̺�� set �÷���1 = ��1, �÷���2 = ��2, ...;
UPDATE IDEV.STUDENTS
SET STUNO=0, STU_NAME='', EMAIL='', ADDRESS='', ENTER_DATE='';


----------------------------------------------------------------------------------------

-- ������ ���� : delete FROM ���̺�� where �÷���1 = ��1 and �÷���2 = ��2 and ...;
--								where : ������ �࿡ ���� ����
DELETE FROM IDEV.STUDENTS
WHERE STUNO=0 AND STU_NAME='' AND EMAIL='' AND ADDRESS='' AND ENTER_DATE='';
