-- VIEW : 가상 테이블(물리적으로 존재하지 않고 논리적으로 만들어진 테이블)
--			ㄴ 물리적인 테이블을 이용해서 생성합니다.
--  		ㄴ 사용자(개발자)가 테이블처럼 SELECT 를 조회 가능한 테이블
--			ㄴ GRANT RESOURCE, CONNECT TO IDEV;	-> RESOURCE 에 VIEW 생성은 제외입니다.

CREATE VIEW v_buy
AS SELECT PCODE , CUSTOM_ID  FROM tbl_buy#;		-- insufficient PRIVILEGES

/*	idev 유저에게 create view 권한 부여 (sql*plus에서 실행)
SQL> connect system
Enter password:
Connected.
SQL> grant create view to idev;

Grant succeeded.
 */

-- view를 이용한 SELECT 조회
SELECT * FROM V_BUY vb WHERE PCODE = 'dk_143';


-- buy#, custom#을 조인하여 custom_id, pcode, 고객이름, 이메일, 구매수량, 구매날짜
--   ㄴ v_sale 이름의 view를 만들어보아라
CREATE VIEW v_sale AS 
SELECT tc.CUSTOM_ID , tb.PCODE , tc.NAME , tc.EMAIL , tb.QUANTITY , tb.BUY_DATE 
FROM tbl_buy# tb JOIN tbl_customer# tc 
ON tb.CUSTOM_ID = tc.CUSTOM_ID ;

SELECT * FROM v_sale;


