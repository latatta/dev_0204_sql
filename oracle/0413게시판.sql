-- 메인글 테이블 : freeboard
CREATE TABLE freeboard (
	idx number(5) NOT NULL,
	name varchar2(30) NOT NULL,				-- 작성자
	password varchar2(10) NOT NULL,			-- 글 비밀번호
	subject varchar2(40) NOT NULL,			-- 글 제목
	content varchar2(2000) NOT NULL,		-- 글 내용
	readCount number(5) DEFAULT '0',		-- 조회수
	wdate DATE DEFAULT sysdate,				-- 작성날짜와 시간 기본값
	ip varchar2(15) DEFAULT '127.0.0.1',	-- 선택
	commentCount number(3) DEFAULT '0',		-- 댓글 갯수
	PRIMARY key(idx)
);

-- freeboard  테이블의 기본키 : idx 시퀀스(오라클에서만 사용)
-- *mysql 데이터베이스는 시퀀스가 없고 컬럼에 autoincrement(자동증가) 설정 합니다.
CREATE SEQUENCE board_idx_seq;

-- 데이터 샘플 추가
INSERT INTO freeboard(idx, name, password, subject, content)
VALUES (board_idx_seq.nextval, '이하니', '1111', '알립니다', '오늘 모임 변경안내입니다.');
INSERT INTO freeboard(idx, name, password, subject, content)
VALUES (board_idx_seq.nextval, '최사랑', '2222', '안녕하세요.', '반갑습니다.');
INSERT INTO freeboard(idx, name, password, subject, content)
VALUES (board_idx_seq.nextval, '홍길동', '3333', '하위', '바위');
INSERT INTO freeboard(idx, name, password, subject, content)
VALUES (board_idx_seq.nextval, '최모모', '4444', '가위', '바위');
INSERT INTO freeboard(idx, name, password, subject, content)
VALUES (board_idx_seq.nextval, '이사나', '5555', '가나', '다라');


SELECT * FROM freeboard ORDER BY idx DESC;

SELECT count(*) FROM FREEBOARD f ;

-- ****** 게시판 유형에서 글목록을 페이지단위로 처리해야합니다.(페이징)
-- 예시 : 한 화면에 보이는 글목록에서 글의 갯수는 10개로 한다. 페이지 이동 버튼은 10개씩 보여준다.
--		 현재 페이지 기준 다음/이전페이지, 맨앞/맨뒤페이지로 이동하는 버튼이 있다.

-- rownum은 오라클에서 select 결과로 행의 위치를 나타내는 컬럼이름입니다.
SELECT * FROM (
SELECT rownum AS R, T.* FROM
	(SELECT * FROM FREEBOARD f ORDER BY idx DESC) T)		-- T는 괄호 안에 대한 별칭
WHERE R BETWEEN 1 AND 10;			-- 페이지 1에 대한 sql
-- WHERE R BETWEEN 11 AND 20;		-- 페이지 2에 대한 sql
-- WHERE R BETWEEN 111 AND 120;		-- 페이지 12에 대한 sql : startNo = (pageNo-1)*10+1

-- 위의 sql을 select 2개로 해결하기


-- 페이징 select 하나씩 테스트
SELECT rownum AS R, T.* FROM
	(SELECT * FROM FREEBOARD f ORDER BY idx DESC) T;

SELECT * FROM freeboard ORDER BY idx DESC;


-- 댓글있는 게시판의 댓글 테이블
CREATE TABLE comments (
	idx number(3) NOT NULL,				-- 댓글 테이블의 기본키
	mref number(5) NOT NULL,				-- freeboard  테이블의 idx 
	name varchar2(30) NOT NULL,
	content varchar2 (2000) NOT NULL,
	wdate DATE DEFAULT sysdate,
	heart number (3) DEFAULT '0',
	ip varchar2 (15) DEFAULT '127.0.0.1',
	PRIMARY KEY (idx)
);

CREATE SEQUENCE cmt_idx_seq;

INSERT INTO comments(idx, "ref", name, content)
VALUES (cmt_idx_seq.nextval, 3, '이하니', '보');


-- freeboard 테이블의 댓글 갯수
-- 	1) 댓글 작성될 때마다 +1		2) 댓글 갯수를 구하는 SELECT 
SELECT count(*) FROM COMMENTS c WHERE "ref" = 3;	-- freeboard 3번글의 댓글갯수
SELECT count(*) FROM COMMENTS c WHERE "ref" = 1;


-- 1)로 구현할 예정 : 트랜잭션 처리
-- insert into comments -> update freeboard set commentCount = commentCount + 1



