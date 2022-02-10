-- ���� ���� ���� 1
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
 	WHERE tp.PCODE = tb.PCODE ;
 		 
-- ���� ���� ���� 2
SELECT * FROM "TBL_PRODUCT#" tp 
	JOIN "TBL_BUY#" tb
	ON tp.PCODE = tb.PCODE ;  	
		 
		
-- ���� : �����е�('IPAD012')�� ������ ����� �̸��� ���ų�¥ ��ȸ
SELECT tc.NAME, tb.BUY_DATE FROM "TBL_BUY#" tb, "TBL_CUSTOMER#" tc  
	WHERE tC.CUSTOM_ID = tb.CUSTOM_ID AND PCODE = 'IPAD011';

SELECT tc.NAME, tb.BUY_DATE FROM "TBL_BUY#" tb JOIN "TBL_CUSTOMER#" tc 
	ON tC.CUSTOM_ID = tb.CUSTOM_ID  
	WHERE tb.PCODE = 'IPAD011';
	


-------------------------------------------------------------------------------------------------------------------
-- day5 : alter table ����
-- �׽�Ʈ�� ���̺� : �÷���, ������ �ǹ� �����ϴ�. ���İ� �������Ǹ� �����ϼ���.
CREATE TABLE tbl# (
	acol varchar2(30) NOT NULL,
	bcol varchar2(10),
	ccol number(3)
);

INSERT INTO tbl#(ccol) values(12);						-- ���� : NOT NULL �÷�(acol) ���� ���� �ȵ�
INSERT INTO tbl#(bcol, ccol) values('xytz', 12);		-- ���� : NOT NULL �÷�(acol) ���� ���� �ȵ�
INSERT INTO tbl#(acol, ccol) values('main', 12);		-- �������

-- �÷� �߰�
ALTER table tbl# ADD (dcol timestamp DEFAULT sysdate);
SELECT * FROM tbl#;

-- �÷� ����
ALTER table tbl# MODIFY (ccol NUMBER(3) DEFAULT '0');
INSERT INTO tbl#(acol, bcol) values('main2', 'asdf');		-- ccol�� 0

-- �÷� ����(drop)	
ALTER TABLE tbl# DROP COLUMN dcol;

-- �������� �߰�(�������� �̸� ���� �ʿ�)
ALTER TABLE tbl# ADD CONSTRAINT pk_tbl# PRIMARY KEY (acol);
-- �ߺ����� �ִ� ���(���Ἲ ����) �ߺ��Ǵ� ���� �����ϰ� �⺻Ű �߰��մϴ�.
DELETE FROM tbl# WHERE acol = 'main2' AND ccol = 0;

-- ���� ���������� ���� ��� �����ϴ�. -> ���� �������� �����ϰ� �ٽ� �����ؾ���
ALTER TABLE tbl# DROP CONSTRAINT pk_tbl#;		-- �������� ����

-- tbl# ���̺� age �÷� ����. check �������� : 16 �̻� 90 ������ ��
ALTER TABLE "TBL#" ADD age number(3) CHECK (age BETWEEN 16 AND 90);		-- age >= 16 AND age <= 90
INSERT INTO "TBL#" (acol, age) values ('app',23);	-- ����
INSERT INTO "TBL#" (acol, age) values ('app',99);	-- ����

-- tbl# ���̺� gender �÷� ����. check �������� : 'M', 'F'
ALTER TABLE "TBL#" ADD gender varchar2(3) CHECK (gender IN ('M', 'F'));
INSERT INTO "TBL#" (acol, gender) values ('momo', 'F');
INSERT INTO "TBL#" (acol, gender) values ('momo', 'X');		-- �������� ���� ����



-- SELECT �� ����ϴ� ����Ŭ �Լ�
-- ��ȸ����� �����ϴ� �Լ� : ���� age �÷����� null �϶� 0, gender 'M'�̸� ����, 'F'�̸� ����
SELECT * FROM tbl#;
SELECT acol, nvl(age, 0) AS age2, decode(gender, 'M', '����', 'F', '����') AS gender2 FROM "TBL#" t ;
-- nvl�� null value, �÷��� ��Ī�� as Ű���带 ���� ������ �� �ֽ��ϴ�.




