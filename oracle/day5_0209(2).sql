-- commit, rollback �׽�Ʈ
-- 	 �� ���� auto commit ������ �����ؾ���
--   �� ��� 1) ���� �����⿡ ���ؼ��� ����(�����ͺ��̽� �޴� - Ʈ����� ��� - manual commit���� ����)
--   �� ��� 2) DB ���� ������ auto commit�� ����

-- ���� ���� 1��
SELECT * FROM tbl#;		-- ���� ���� Ȯ��

DELETE FROM tbl# WHERE acol = 'momo';
SELECT * FROM tbl#;

rollback ;		-- DELETE ��� ���
SELECT * FROM tbl#;

-- ���� ���� 2��
DELETE FROM tbl# WHERE acol = 'momo';
SELECT * FROM tbl#;
COMMIT;
SELECT * FROM tbl#;
rollback ;		-- ������ COMMIT�� �����Ƿ� DELETE�� ����� �� ����
SELECT * FROM tbl#;


-- ���� ���� 3��
INSERT INTO "TBL#" (acol, age) VALUES ('nana', 33);
SELECT * FROM "TBL#" t ;
rollback ;
SELECT * FROM "TBL#" t ;


-- ���� ���� 4��
INSERT INTO "TBL#" (acol, age) VALUES ('nana22', 33);
INSERT INTO "TBL#" (acol, age) VALUES ('����', 29);
COMMIT;			-- ���� COMMIT �Ǵ� ROLLBACK �� �� ������ ����� COMMIT 
UPDATE "TBL#" SET bcol = 'test' WHERE ACOL = 'nana22';
DELETE FROM "TBL#" t WHERE acol = 'main22';
rollback ;		-- ���� COMMIT �Ǵ� ROLLBACK �� �� ������ ����� ROLLBACK 


