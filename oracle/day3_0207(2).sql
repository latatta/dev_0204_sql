-- 날짜타입 : DATE, TIMESTAMP (timezone 설정)

CREATE TABLE table_date(
	acol DATE,
	bcol timestamp,
	ccol timestamp DEFAULT sysdate		
);
-- 값을 지정안했을 때 기본값(default) : sysdate는 현재 날짜/시간
-- 클라이언트 컴퓨터의 시간은 current_date

-- 날짜형식은 문자열 타입과 자동캐스팅이 됩니다. '' 안에 yyyy-mm-dd hh:mm:ss 문자열 형식으로 작성
INSERT INTO IDEV.TABLE_DATE (ACOL, BCOL)
VALUES('2022-02-07', '2022-02-07');

SELECT * FROM TABLE_DATE td;

------------------------------------------------------------------------------------------------

-- 문자열 타입
-- CHAR(길이) : 고정길이, 단위는 byte
-- VARCHAR(길이) : 오라클에서 존재하고 사용하지 않는 예비자료형()
-- VARCHAR2(길이) : 가변형길이 단위 바이트, 길이는 최대길이이고 실제로 메모리는 데이터 크기만큼 차지합니다. 
-- 					최대 2000바이트. UTF-8 인코딩에서 한글은 3바이트, 영문/숫자/기호는 1바이트

CREATE TABLE table_string(
	acol char(10),
	bcol varchar2(10),
	ccol nchar(10),
	dcol nvarchar2(10)
);

-- CHAR 타입 확인 - 10바이트가 다 차지 않았을때 (10 - 데이터)만큼 뒤에 공백이 추가됨
INSERT INTO table_string(acol) VALUES ('abcdefghij');
INSERT INTO table_string(acol) VALUES ('abcde');
INSERT INTO table_string(acol) VALUES ('가나다라');	-- 4글자 * 3바이트 = 12바이트 -> 오류
INSERT INTO table_string(acol) VALUES ('가나다');

-- VARCHAR2 타입 확인 : CHAR과 비교했을 때 추가되는 공백 없음
INSERT INTO table_string(bcol) VALUES ('abcdefghij');
INSERT INTO table_string(bcol) VALUES ('abcde');
INSERT INTO table_string(bcol) VALUES ('가나다라');	-- 4글자 * 3바이트 = 12바이트 -> 오류
INSERT INTO table_string(bcol) VALUES ('가나다');

-- NCHAR 타입 확인 : 고정길이, 단위는 문자개수, 뒤에 공백추가됨
INSERT INTO table_string(ccol) VALUES ('abcdefghij');
INSERT INTO table_string(ccol) VALUES ('abcde');
INSERT INTO table_string(ccol) VALUES ('가나다라');	
INSERT INTO table_string(ccol) VALUES ('가나다');
INSERT INTO table_string(ccol) VALUES ('가나다라마바사아자차');		-- 10글자까지 ok
INSERT INTO table_string(ccol) VALUES ('가나다라마바사아자차카');		-- 11글자는 오류

-- NVARCHAR2 타입 확인 : 고정길이, 단위는 문자개수, 뒤에 공백추가 x
INSERT INTO table_string(dcol) VALUES ('abcdefghij');
INSERT INTO table_string(dcol) VALUES ('abcde');
INSERT INTO table_string(dcol) VALUES ('가나다라');	
INSERT INTO table_string(dcol) VALUES ('가나다');
INSERT INTO table_string(dcol) VALUES ('가나다라마바사아자차');		-- 10글자까지 ok
INSERT INTO table_string(dcol) VALUES ('가나다라마바사아자차카');		-- 11글자는 오류

-- 여러가지 언어문자가 사용되고 저장될때 NVARCHAR2 로 글자수를 계산하는것이 권고사항입니다.

