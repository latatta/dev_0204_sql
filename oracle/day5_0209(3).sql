-- VIEW : ���� ���̺�(���������� �������� �ʰ� �������� ������� ���̺�)
--			�� �������� ���̺��� �̿��ؼ� �����մϴ�.
--  		�� �����(������)�� ���̺�ó�� SELECT �� ��ȸ ������ ���̺�
--			�� GRANT RESOURCE, CONNECT TO IDEV;	-> RESOURCE �� VIEW ������ �����Դϴ�.

CREATE VIEW v_buy
AS SELECT PCODE , CUSTOM_ID  FROM tbl_buy#;		-- insufficient PRIVILEGES

/*	idev �������� create view ���� �ο� (sql*plus���� ����)
SQL> connect system
Enter password:
Connected.
SQL> grant create view to idev;

Grant succeeded.
 */

-- view�� �̿��� SELECT ��ȸ
SELECT * FROM V_BUY vb WHERE PCODE = 'dk_143';


-- buy#, custom#�� �����Ͽ� custom_id, pcode, ���̸�, �̸���, ���ż���, ���ų�¥
--   �� v_sale �̸��� view�� �����ƶ�
CREATE VIEW v_sale AS 
SELECT tc.CUSTOM_ID , tb.PCODE , tc.NAME , tc.EMAIL , tb.QUANTITY , tb.BUY_DATE 
FROM tbl_buy# tb JOIN tbl_customer# tc 
ON tb.CUSTOM_ID = tc.CUSTOM_ID ;

SELECT * FROM v_sale;


