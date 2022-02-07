-- 데이터 타입 number 연습 테이블
-- number : 자바의 byte, short, int, long, float, double에 해당
-- 			number(전체자릿수, 소수점자리수)

-- table_number 테이블이름
CREATE TABLE table_number(
	col1 NUMBER,			-- 자릿수를 지정하지 않으면 최대 38자리 입니다. (자바의 BigDecimal)
	col2 number(5),
	col3 number(7,2),
	col4 number(2,5)
);

INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.00012);

-- col2 칼럼의 자릿수가 6개 : 오류
INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 123456, 12345.68, 0.00012);

-- col3 칼럼은 소수점 이하 자릿수가 2개 : 반올림
INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.678, 0.00012);

-- col3 칼럼 전체 자릿수 7개 : 소수점이하 항상 2개, 그리고 정수자릿수 5개 : 자리수 초과 오류 
INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 123456.67, 0.00012);

-- col4 칼럼은 number(2, 5) : 전체 유효자릿수 : 5개,
-- 							 이때 항상 유효자릿수 2개 최대 2개(0 포함 가능), 최소 나머지 3개는 무조건 0
INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.0000123);

-- col4 칼럼은 number(2, 5) : 나머지 3개는 유효자릿수 0 -> 아니면 오류
INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.0012);
INSERT INTO IDEV.TABLE_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234567, 12345, 12345.67, 0.00123);

-- 0.00012300에서 유효한 숫자는 0.000123, 123 뒤에 00은 유효한 값이 아님


