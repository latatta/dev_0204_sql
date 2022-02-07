-- ### �߿�1 : custom ���̺��� ��(row)�����͸� ������ custom_id, PCODE �� �ߺ��Ǹ� �ȵ˴ϴ�.
--				�� �⺻Ű �÷��� ���մϴ�.(�ߺ��� ���� ����� �ȵ˴ϴ�.)
-- 				�� �⺻Ű�� ���̺��� ��(row)�� �ĺ��ϴ°��� �����Դϴ�.
-- 				�� SELECT �� �⺻Ű������ �˻��� �� ���� 1���� ������ ��ȸ�˴ϴ�.
SELECT * FROM "TBL_CUSTOMER#" tc WHERE custom_id = 'mina012';


-- ### �߿� 2: ���� ���, price, quantity ���� �÷��� null�� �Ǹ� �ȵ˴ϴ�(�� �ʼ� �����ͷ� ����Ǿ�� �մϴ�).
-- 				�� NOT NULL �÷����� ����(NULL���� �ȵ�)

-- ### �߿� 3: ������ ��ǰ���̺��� ���� CUSTOM_ID, pcode �÷����� ����ϸ� �ȵ˴ϴ�.
-- 				�� �ܷ�Ű �÷��� ���մϴ�.(�ٸ� ���̺����� ���� �����մϴ�. NULL ��� ���մϴ�.)
--				�� �ܷ�Ű�� �÷��� �����Ͱ� ������(�ٸ� ���̺��� �÷�)�� ����ϰ� �ϴ°��� �����Դϴ�.

-- ���� NOT NULL, �⺻Ű, �ܷ�Ű�� ��ǥ���� ��������(CONSRAINTS) �����Դϴ�.
-- ���������� ������ ���̺��� ������ ���ϴ�.

-- ���� ���̺�
CREATE TABLE tbl_customer# (
	custom_id varchar2(20) PRIMARY KEY,		-- ����/����/��ȣ
	name nvarchar2 (20) NOT NULL ,		-- �ѱ۵� �ٱ���� ����
	email varchar2 (20),
	age number(3),
	reg_date timestamp DEFAULT sysdate
);

-- ��ǰ ���̺� : ��ǰ�ڵ�(�������� 20�ڸ�), ī�װ���(�������� 2�ڸ�)
-- 										A1 : ������ǰ, B1 : ��ǰ
CREATE TABLE tbl_product# (
	pcode varchar2 (20) CONSTRAINT pk_product PRIMARY KEY,
	category char(2),
	pname nvarchar2 (20) NOT NULL ,
	price number(9) NOT NULL
);

-- ���� ���̺� : ��� ������ ���� ��ǰ�� �����ϴ°�?
-- �������̺��� �⺻Ű�� ������ �÷��� �߰��մϴ�.
CREATE TABLE tbl_buy# (
	buy_seq number(8),
	custom_id varchar2 (20),
	pcode varchar2 (20),
	quantity number (5) NOT NULL ,		-- ����
	buy_date timestamp,
	-- ��������Ű���� ���������̸� ������������ (����Ǵ��÷�)
	CONSTRAINT pk_buy_seq PRIMARY KEY (buy_seq), 
	CONSTRAINT fk_custom_id FOREIGN KEY (custom_id) 	-- �� ���̺��� �÷���
		REFERENCES tbl_customer# (custom_id),		-- �������̺��� �� �÷���
	CONSTRAINT fk_pcode FOREIGN KEY (pcode) 
		REFERENCES tbl_product# (pcode)
	-- �ܷ�Ű�� ������ �� �ִ� �÷��� �⺻Ű �Ǵ� unique(������)�� ���ؼ��� �����մϴ�.
	-- �ܷ�Ű �÷��� ����(REFERENCES)���̺��� �÷��� �� �ϳ��� ������ �� �ֽ��ϴ�.
);

---------------------------------------------------------------------------------
-- �������� �߰� : INSERT 
-- �������� �Է�
INSERT INTO IDEV.TBL_CUSTOMER#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('mina012', '��̳�', 'kimm@gmail.com', 20, sysdate);
INSERT INTO IDEV.TBL_CUSTOMER#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('hongGD', 'ȫ�浿', 'gil@korea.com', 32, sysdate);
INSERT INTO IDEV.TBL_CUSTOMER#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('twice', '�ڸ��', 'momo@daum.net', 29, sysdate);
INSERT INTO IDEV.TBL_CUSTOMER#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('wonder', '�̳���', 'lee@naver.com', 40, sysdate);

-- ### �߿�1 : custom ���̺��� ��(row)�����͸� ������ custom_id, PCODE �� �ߺ��Ǹ� �ȵ˴ϴ�.
INSERT INTO IDEV.TBL_CUSTOMER#(CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE)
VALUES('wonder', '�ָ��', 'choi@naver.com', 33, sysdate);

SELECT * FROM TBL_CUSTOMER# tc;


-- ��ǰ���� �Է�
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME, PRICE)
VALUES('IPAD011', 'A1', '�����е�10', 880000);
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME, PRICE)
VALUES('DOWON123a', 'B1', '������ġ������Ʈ', 54000);
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME, PRICE)
VALUES('dk_143', 'A2', '��ǵ���ũ', 234500);

-- ### �߿� 2: ���� ���, price, quantity ���� �÷��� null�� �Ǹ� �ȵ˴ϴ�(�� �ʼ� �����ͷ� ����Ǿ�� �մϴ�).
INSERT INTO IDEV.TBL_PRODUCT#(PCODE, CATEGORY, PNAME)
VALUES('dk_143', 'A2', '�ڵ���ǵ���ũ');





-- ����Ŭ������ �Ϸù�ȣ�� �ڵ����� �����ؼ� ����ϰ� �Ҽ� �ִ� ������ ����� �ֽ��ϴ�.
CREATE SEQUENCE tbl_buy_seq;
-- �ѹ� ��������� ����ϴ� �������� ���� �ǵ��� �� �����ϴ�.


-- ������ ���� ����� �ʹ�. �����ϰ� �ٽ� �����
DROP SEQUENCE tbl_buy_seq ;
-- 		���̺��� �����͵� �����ϰ� �ٽ� ������ ����/������ �߰�



-- ### �߿� 3: ������ ��ǰ���̺��� ���� CUSTOM_ID, pcode �÷����� ����ϸ� �ȵ˴ϴ�.
-- �ܷ�Ű�� ������ CUSTOM_ID�� tbl_custom# ���̺��� �����մϴ�. �������̺��� 
-- custom_id �÷����� ���� ���� ������ �� �����ϴ�.(�ܷ�Ű ����)
INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, BUY_SEQ)
VALUES('min01', 'IPAD011', 1, '2022-02-06', tbl_buy_seq.nextval);

-- �ܷ�Ű�� ������ CUSTOM_ID�� tbl_custom# ���̺��� �����մϴ�.�������̺��� 
-- PCODE �÷����� ���� ���� ������ �� �����ϴ�.
INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, BUY_SEQ)
VALUES('mina012', 'd_14', 1, '2022-02-06', tbl_buy_seq.nextval);

-- �������� �Է�
-- ��̳��� �����е� 1���� ���� ����
INSERT INTO IDEV.TBL_BUY#(buy_seq, CUSTOM_ID, PCODE, QUANTITY, BUY_DATE)
VALUES(tbl_buy_seq.nextval, 'mina012', 'dk_143', 1, sysdate);

-- ȫ�浿�� �����е� 2���� ���� ����
INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, buy_seq)
VALUES('hongGD', 'IPAD011', 2, '2022-02-07', tbl_buy_seq.nextval);

-- �̳����� ��ġ������Ʈ 3�� ���� ����
INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, buy_seq)
VALUES('wonder', 'DOWON123a', 3, '2022-02-06', tbl_buy_seq.nextval);

-- ��̳��� ��ǵ���ũ 1�� ���� ����
INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, buy_seq)
VALUES('mina012', 'dk_143', 1, '2022-02-07', tbl_buy_seq.nextval);

-- �ڸ�� ��ġ������Ʈ 2�� ���� ����
INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, buy_seq)
VALUES('twice', 'DOWON123a', 2, '2022-02-07', tbl_buy_seq.nextval);

INSERT INTO IDEV.TBL_BUY#(CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, buy_seq)
VALUES('mina012', 'IPAD011', 2, '2022-02-07', tbl_buy_seq.nextval);

SELECT * FROM "TBL_CUSTOMER#" tc ;
SELECT * FROM "TBL_PRODUCT#" tp ;
SELECT * FROM "TBL_BUY#" tb ;

-----------------------------------------------------------------------------
-- ����
-- 1. custom# ���̺����� age �� 30�� �̻� ��� ���� ��ȸ
SELECT * FROM "TBL_CUSTOMER#" tc WHERE age >= 30;

-- 2. custom# ���̺����� custom_id 'twice' �� email ��ȸ
SELECT email FROM "TBL_CUSTOMER#" tc WHERE CUSTOM_ID = 'twice';

-- 3. product# ���̺����� category 'A2' �� pname ��ȸ
SELECT pname FROM "TBL_PRODUCT#" tp WHERE CATEGORY = 'A2';

-- 4. product# ���̺����� price �� �ְ��� ��ȸ
SELECT MAX(price) FROM "TBL_PRODUCT#" tp;

-- 5. buy# ���̺����� 'IPAD011' �ѱ��� ���� ��ȸ
SELECT SUM(QUANTITY) FROM "TBL_BUY#" tb WHERE PCODE = 'IPAD011';

-- 6. buy# ���̺����� custom_id 'nayeon' �� ��� ���� ��ȸ
SELECT * FROM "TBL_BUY#" tb WHERE CUSTOM_ID = 'nayeon';

-- 7. buy# ���̺����� pcode �� '1'�� ���Ե� �� ��ȸ
SELECT * FROM "TBL_BUY#" tb WHERE PCODE = '1';		-- ������ġ ��ȸ
SELECT * FROM "TBL_BUY#" tb WHERE PCODE LIKE '%1%';		-- �κ���ġ ��ȸ. 1�� ����
SELECT * FROM "TBL_BUY#" tb WHERE PCODE LIKE '1%';		-- �κ���ġ ��ȸ. 1�� ����
SELECT * FROM "TBL_BUY#" tb WHERE PCODE LIKE '%1';		-- �κ���ġ ��ȸ. 1�� ������

-- 8. buy# ���̺����� pcode�� 'on'�� �����ϴ� �� ��ȸ
SELECT * FROM "TBL_BUY#" tb WHERE UPPER(PCODE) LIKE '%ON%';		

