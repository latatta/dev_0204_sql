-- 전체 데이터 갯수는?
SELECT count(*) FROM tbl_campArea ;

-- 강원도 데이터 갯수는?
SELECT count(*) FROM tbl_campArea WHERE ADDRESS LIKE '강원도%';

-- 강원도의 자동차야영장 야영장 이름, 부대시설 조회하기
SELECT CAMP_NAME , ETC1 , ETC2 FROM "tbl_campArea" tca 
WHERE ADDRESS LIKE '강원도%' AND CAMP_TYPE LIKE '자동차%';

-- 자동차 야영장 갯수가 50개 이상인 곳 야영지 이름, 주소 조회
SELECT camp_name, address FROM "tbl_campArea" tca WHERE CAR_CNT >= 50;

-- 카라반 있는 야영장 이름, 주소, 카라반 갯수 조회
SELECT camp_name, address, cara_cnt FROM "tbl_campArea" tca WHERE NOT CARA_CNT = 0 ;
