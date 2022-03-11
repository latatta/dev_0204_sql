-- PL/SQL : Procedure(절차, 순서), 기존의 단순한 SQL이 확장된 언어
--			변수, 제어문(if, for, ..)을 사용하여 프로그래밍 언어와 같이 SQL 실행의 흐름을 제어

-- 프로시저의 기본형식
DECLARE 			-- 변수선언
	-- vcustomid varchar2(20);
	-- vage number(3, 0);
	vcustomid tbl_customer#.custom_id %TYPE;
	vage tbl_customer#.age %TYPE;
BEGIN 				-- 프로시저 시작
	-- 프로시저 내부에는 주로 DML 명령문들을 작성(함께 실행해야 할 트랜잭션)
	SELECT custom_id, age
	INTO vcustomid, vage 		-- 프로시저 구문 : 검색결과를 변수에 저장
	FROM "TBL_CUSTOMER#" tc 
	WHERE CUSTOM_ID = 'mina12';	-- 1개 행만 결과 조회되는 조건
	-- 변수값을 콘솔에 출력
	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || vcustomid);
	DBMS_OUTPUT.PUT_LINE('고객나이 : ' || vage);
	EXCEPTION 		-- 예외(오류) 처리
	WHEN no_data_found THEN		-- 예외 이름은 다양합니다. OTHERS 예외는 모든 경우.
		dbms_output.put_line('찾는 데이터가 없습니다.');
END;					-- 끝