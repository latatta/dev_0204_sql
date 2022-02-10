-- UPDATE ����
-- 		UPDATE ���̺��
-- 		SET ������ �÷� = �� ���� �����Ͽ� ����
-- 		WHERE ������ �࿡ ���� ���ǽ�

SELECT * FROM "TBL_CUSTOMER#" tc ;

-- *update�� delete�� where ���ǽ��� ���Ǵ� ���� �����մϴ�. *
UPDATE "TBL_CUSTOMER#" 
SET age = 39 
WHERE CUSTOM_ID = 'twice'; 	-- �⺻Ű �÷� ��� ���ǽ��� 1�� �ุ ������

UPDATE "TBL_CUSTOMER#" 
SET age = 23, EMAIL = 'nana@korea.kr' 
WHERE CUSTOM_ID = 'wonder';

-- custom_id : wonder�� twice �� ���� reg_date�� 2022/2/5�� ����
UPDATE "TBL_CUSTOMER#" 
SET REG_DATE = '2022-02-05'
WHERE CUSTOM_ID IN ('wonder', 'twice');		-- IN �����ڴ� OR ��ü



-- DELETE ����
--		DELETE FROM ���̺�� WHERE ���ǽ�;
DELETE FROM "TBL_PRODUCT#" tp WHERE PCODE = 'GAL0123';	-- ���� : BUY#���� �������� �ʴ� ��
DELETE FROM "TBL_PRODUCT#" tp WHERE PCODE = 'IPAD011';	-- ���� : ���Ἲ ����(BUY#���� ������̹Ƿ� ���� �Ұ�)

UPDATE "TBL_PRODUCT#" SET PNAME = '�����е�����' WHERE PCODE = 'IPAD011';
UPDATE "TBL_PRODUCT#" SET PCODE = 'IPAD0111' WHERE PCODE = 'IPAD011';	-- ���� : ���Ἲ ����


-- ���õ����� �߰�
INSERT INTO "TBL_PRODUCT#" (PCODE, CATEGORY, PNAME, PRICE)
VALUES ('GAL0123', 'A1', '������20', 912300);

SELECT * FROM "TBL_CUSTOMER#" tc ;
SELECT * FROM "TBL_PRODUCT#" tp ;
SELECT * FROM "TBL_BUY#" tb ;



-- ON DELETE, ON UPDATE(����Ŭ�� �������� ����) �Ӽ� �����Ͽ� �ܷ�Ű �ٽ� ����
ALTER TABLE IDEV."TBL_BUY#" 
			DROP CONSTRAINT "FK_TBL_PRODUCT#";
ALTER TABLE IDEV."TBL_BUY#" 
			ADD CONSTRAINT "FK_TBL_PRODUCT#"
			FOREIGN KEY (PCODE) REFERENCES IDEV."TBL_PRODUCT#"(PCODE)
			ON DELETE CASCADE ;		-- ���Ἲ�� ���ؼ� �����ϴ� �� ������ ������(���޾Ƽ�)���� ����
			
-- ALTER TABLE ���� : DROP, ADD, MODIFY(���������� ���մϴ�.)			
			

			
-- SELECT�� JOIN : �� �̻��� ���̺�(�ַ� ���������� ���̺�)�� �����Ͽ� �����͸� ��ȸ�ϴ� ���
-- 					�� �̻��� ���̺��� ����� �÷��� ���� �� �÷��� �̿��Ͽ� JOIN �մϴ�.
-- ���� 1: SELECT ~~~ FROM ���̺�1 t1, ���̺�2 t2 
-- 					WHERE t1.�����÷�1 = t2.�����÷�1;
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
 		 WHERE tp.PCODE = tb.PCODE ;
		 
-- ���� 2: JOIN �� ���� ��ɹ� ����(ǥ��)
SELECT * FROM "TBL_PRODUCT#" tp 
		 JOIN "TBL_BUY#" tb
		 ON tp.PCODE = tb.PCODE ; 
 		
-- mina012�� ������ ��ǰ���� �����ΰ�?
SELECT tp.PNAME FROM "TBL_PRODUCT#" tp JOIN "TBL_BUY#" tb 
			 ON tp.PCODE = tb.PCODE 
			 WHERE tb.CUSTOM_ID = 'mina012';

-- mina012�� ������ ��ǰ��� ���� ��ȸ�ϱ�
SELECT tp.PNAME , tp.PRICE FROM "TBL_PRODUCT#" tp JOIN "TBL_BUY#" tb 
					 ON tp.PCODE = tb.PCODE 
					 WHERE tb.CUSTOM_ID = 'mina012';
					
-- ������ ��, ����� �÷��� ���̺���� �� �����ؾ� �մϴ�.				
SELECT PCODE , PNAME FROM "TBL_PRODUCT#" tp JOIN "TBL_BUY#" tb 	-- ���� : PCODE�� BUY#�� PRODUCT# �Ѵ� �ֱ� ������ tp.�� tb. ���� 
					 ON tp.PCODE = tb.PCODE 						-- 			�ϳ��� �տ� ���־�� �Ѵ�.
					 WHERE tb.CUSTOM_ID = 'mina012';

SELECT tp.PCODE , PNAME  FROM "TBL_PRODUCT#" tp JOIN "TBL_BUY#" tb 	
					 ON tp.PCODE = tb.PCODE 						
					 WHERE tb.CUSTOM_ID = 'mina012';
					
-- �ܺ����� ���� 2����					
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
 		 WHERE tp.PCODE = tb.PCODE(+) ;					

 SELECT * FROM "TBL_PRODUCT#" tp 
		 LEFT OUTER JOIN "TBL_BUY#" tb		-- ������ �Ǵ� ���̺��� ���� PRODUCT# ���̺��̹Ƿ� OUTER / RIGHT OUTER�� ����
		 ON tp.PCODE = tb.PCODE ; 

SELECT * FROM "TBL_BUY#" tb 
		 RIGHT OUTER JOIN "TBL_PRODUCT#" tp		-- ������ �Ǵ� ���̺��� ������ PRODUCT# ���̺��̹Ƿ� OUTER / LEFT OUTER�� ����
		 ON tp.PCODE = tb.PCODE ; 
			
-- ������ �׽�Ʈ �Ǵ� ������ ������ ���� ���̺��� ��� ������ �����ϱ�
-- delete : rollback���� ���� ��� ����, truncate : ���� ��� �Ұ���
-- truncate : ���������� ��, fk�� ��Ȱ��ȭ�ϰ� ������ �����ؾ� �մϴ�.			
TRUNCATE TABLE "TBL_BUY#" ;			-- �������̺� ������ ���� ����
DELETE FROM "TBL_PRODUCT#" ;		-- ��ü ������ ������ �������� ��� -> Ȯ��
TRUNCATE TABLE "TBL_CUSTOMER#" ;


