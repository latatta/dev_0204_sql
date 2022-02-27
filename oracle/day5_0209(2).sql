-- commit, rollback 테스트
-- 	 ㄴ 디비버 auto commit 설정을 변경해야함
--   ㄴ 방법 1) 현재 편집기에 대해서만 변경(데이터베이스 메뉴 - 트랜잭션 모드 - manual commit으로 변경)
--   ㄴ 방법 2) DB 연결 유형을 auto commit을 해제

-- 실행 순서 1번
SELECT * FROM tbl#;		-- 현재 상태 확인

DELETE FROM tbl# WHERE acol = 'momo';
SELECT * FROM tbl#;

rollback ;		-- DELETE 명령 취소
SELECT * FROM tbl#;

-- 실행 순서 2번
DELETE FROM tbl# WHERE acol = 'momo';
SELECT * FROM tbl#;
COMMIT;
SELECT * FROM tbl#;
rollback ;		-- 위에서 COMMIT을 했으므로 DELETE를 취소할 수 없음
SELECT * FROM tbl#;


-- 실행 순서 3번
INSERT INTO "TBL#" (acol, age) VALUES ('nana', 33);
SELECT * FROM "TBL#" t ;
rollback ;
SELECT * FROM "TBL#" t ;


-- 실행 순서 4번
INSERT INTO "TBL#" (acol, age) VALUES ('nana22', 33);
INSERT INTO "TBL#" (acol, age) VALUES ('쯔위', 29);
COMMIT;			-- 최종 COMMIT 또는 ROLLBACK 한 그 이후의 명령을 COMMIT 
UPDATE "TBL#" SET bcol = 'test' WHERE ACOL = 'nana22';
DELETE FROM "TBL#" t WHERE acol = 'main22';
rollback ;		-- 최종 COMMIT 또는 ROLLBACK 한 그 이후의 명령을 ROLLBACK 


