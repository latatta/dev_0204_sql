CREATE TABLE ENT(               --소속사
ENT_CODE number(3),             --기업코드 (PK)
ENT_NAME VARCHAR2(100) NOT NULL,    --기업명
TEL nVARCHAR2(100),               --대표연락번호
CEO NVARCHAR2(100),               --대표이사
ADDRESS VARCHAR2(100),            --주소
F_DATE DATE,                  --설립일
PRIMARY KEY(ENT_CODE)
);

CREATE TABLE G_GROUP(
ENT_CODE NUMBER(3),               --기업코드 (FK)
TEAM_NAME NVARCHAR2(100),         --팀명(PK)
MEMBER_CNT number(2),            --멤버수
D_SONG NVARCHAR2(100),            --데뷔곡
D_DATE DATE,                  --데뷔일
F_NAME NVARCHAR2(100),            --팬카페
LEADER NVARCHAR2(100),            --리더
PRIMARY KEY(TEAM_NAME),
FOREIGN KEY(ENT_CODE) REFERENCES ENT(ENT_CODE)
);

CREATE TABLE ALB(               --앨범
ALB_CODE NVARCHAR2(100),               --앨범코드 (PK)
TEAM_NAME NVARCHAR2(100),         --팀이름(FK)
ALB_NAME NVARCHAR2(100),         --앨범명
SONG_CNT NUMBER(3),               --수록곡수
T_SONG NVARCHAR2(100),            --타이틀곡
S_DATE DATE,                  --발매일
PRIMARY KEY(ALB_CODE),
FOREIGN KEY(TEAM_NAME) REFERENCES G_GROUP(TEAM_NAME)
);

CREATE TABLE SINGER(            --가수
NUM_SEQ NVARCHAR2(20),               --구분번호(PK)
NAME NVARCHAR2(100),            --이름
BIRTH DATE,                     --생년월일
NAT NVARCHAR2(100),               --국적
TEAM_NAME NVARCHAR2(100),         --팀이름(FK)
PART NVARCHAR2(100),            --담당파트
SNS NVARCHAR2(100),               --sns
PRIMARY KEY(NUM_SEQ),
FOREIGN KEY(TEAM_NAME) REFERENCES G_GROUP(TEAM_NAME)
);

-- 기업
INSERT INTO ENT (ENT_CODE,ENT_NAME,TEL,CEO,ADDRESS,F_DATE)
VALUES (01,'JYP엔터테이먼트','02-3345-3455','박진영','서울시 강남구', '1996-04-25');
INSERT INTO ENT (ENT_CODE,ENT_NAME,TEL,CEO,ADDRESS,F_DATE)
VALUES (02,'SM엔터테이먼트','02-3345-3455','이수만','서울시 강남구', '1998-02-24');
INSERT INTO ENT (ENT_CODE,ENT_NAME,TEL,CEO,ADDRESS,F_DATE)
VALUES (03,'YG엔터테이먼트','02-3345-3455','양현석','서울시 강남구', '1995-02-14');

-----------------------------------------------------------------------------------------

-- 걸그룹
INSERT INTO TEAMA.G_GROUP (ENT_CODE , TEAM_NAME, MEMBER_CNT, D_SONG, D_DATE, F_NAME, LEADER)
VALUES (01, '미쓰에이', 4, 'Bad Girl Good Girl', '2010-07-01', 'Say A', null);
INSERT INTO TEAMA.G_GROUP (ENT_CODE , TEAM_NAME, MEMBER_CNT, D_SONG, D_DATE, F_NAME, LEADER)
VALUES (03, 'f(x)', 4, 'LA chA TA', '2009-09-05', '미유', '빅토리아');
INSERT INTO TEAMA.G_GROUP(ENT_CODE, TEAM_NAME, MEMBER_CNT, D_SONG, D_DATE, F_NAME, LEADER)
VALUES(01, 'TWICE', 9, 'OOH-AHH하게', '2015.10.20', 'Twinkle', '지효');
INSERT INTO TEAMA.G_GROUP(ENT_CODE, TEAM_NAME, MEMBER_CNT, D_SONG, D_DATE, F_NAME, LEADER)
VALUES(03, 'BLACKPINK', 4, '휘파람', '2016.08.08','Blink', '');
INSERT INTO G_GROUP (ENT_CODE, TEAM_NAME, MEMBER_CNT, D_SONG, D_DATE, F_NAME, LEADER)
VALUES (02,'aespa',4,'black mamba','2020-11-17','MY','카리나');
INSERT INTO G_GROUP (ENT_CODE, TEAM_NAME, MEMBER_CNT, D_SONG, D_DATE, F_NAME, LEADER)
VALUES (01,'ITZY',5,'달라달라','2019-02-12','midzy','예지');

-----------------------------------------------------------------------------------------
-- 가수 : 미쓰에이
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('MI01', '페이', '1987-04-27', '중국', '미쓰에이', '보컬', 'https://instagram.com/ff0427/');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('MI02', '지아', '1989-02-03', '중국', '미쓰에이', '래퍼, 보컬, 댄서', 'https://www.instagram.com/MJBABY0203/');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('MI03', '민', '1991-06-21', '한국', '미쓰에이', '보컬, 댄서', 'http://instagram.com/therealminnn');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('MI04', '수지', '1994-10-10', '한국', '미쓰에이', '보컬', 'http://www.instagram.com/skuukzky/');

-- 가수 : f(x)
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('FX01', '빅토리아', '1987-02-02', '중국', 'f(x)', '서브보컬, 메인댄서', 'http://instagram.com/victoria02_02/');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('FX02', '엠버', '1992-09-18', '미국', 'f(x)', '메인래퍼, 서브보컬', 'http://instagram.com/amberliu/');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('FX03', '루나', '1993-08-12', '한국', 'f(x)', '메인보컬, 리드댄서', 'http://www.instagram.com/hermosavidaluna/');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('FX04', '크리스탈', '1994-10-24', '한국,미국', 'f(x)', '센터, 리드보컬', 'http://www.instagram.com/vousmevoyez/');
INSERT INTO TEAMA.SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('FX05', '설리', '1994-03-29', '한국', 'f(x)', null, 'http://instagram.com/jelly_jilli/');

-- 가수 : TWICE 
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW01', '지효', '1997-02-01', '한국', 'TWICE', '리더,메인보컬', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW02', '사나', '1996-12-29', '일본', 'TWICE', '서브보컬', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW03', '나연', '1995-09-22', '한국', 'TWICE', '리드보컬,리드댄서', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW04', '모모', '1996-11-09', '일본', 'TWICE', '서브보컬,서브래퍼,메인댄서', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW05', '정연', '1996-11-01', '한국', 'TWICE', '리드보컬', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW06', '다현', '1998-05-28', '한국', 'TWICE', '리드래퍼,서브보컬', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW07', '채영', '1999-04-23', '한국', 'TWICE', '메인래퍼,서브보컬', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW08', '미나', '1997-03-24', '일본', 'TWICE', '메인댄서,서브보컬', 'https://www.instagram.com/twicetagram/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('TW09', '쯔위', '1999-06-14', '대만', 'TWICE', '서브보컬,리드댄서', 'https://www.instagram.com/twicetagram/');

-- 가수 : BLACKPINK 
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('BL01', '제니', '1996-01-16', '한국', 'BLACKPINK', '메인래퍼,리드보컬', 'https://www.instagram.com/jennierubyjane/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('BL02', '지수', '1995-01-03', '한국', 'BLACKPINK', '리드보컬', 'https://www.instagram.com/sooyaaa__/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('BL03', '로제', '1997-02-11', '한국,뉴질랜드', 'BLACKPINK', '메인보컬,리드댄서', 'https://www.instagram.com/roses_are_rosie/');
INSERT INTO TEAMA.SINGER(NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES('BL04', '리사', '1997-03-27', '태국', 'BLACKPINK', '메인댄서,리드래퍼,서브보컬', 'https://www.instagram.com/lalalalisa_m/');

-- 가수 : aespa
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('AE01','카리나','2000-04-11','한국','aespa','메인댄서','https://www.instagram.com/aespa_official/');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('AE02','윈터','2001-01-01','한국','aespa','리드보컬','https://www.instagram.com/aespa_official/');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('AE03','지젤','2000-10-30','일본','aespa','메인래퍼','https://www.instagram.com/aespa_official/');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('AE04','닝닝','2002-10-23','중국','aespa','메인보컬','https://www.instagram.com/aespa_official/');

-- 가수 : ITZY
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('IT01','예지','2000-05-26','한국','ITZY','메인댄서','');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('IT02','류진','2001-04-17','한국','ITZY','메인래퍼','');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('IT03','유나','2003-12-09','한국','ITZY','서브보컬','');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('IT04','채령','2001-06-05','한국','ITZY','메인댄서','');
INSERT INTO SINGER (NUM_SEQ, NAME, BIRTH, NAT, TEAM_NAME, PART, SNS)
VALUES ('IT05','리아','2000-07-21','한국','ITZY','메인보컬','');
-----------------------------------------------------------------------------------------
-- 앨범(미쓰에이)
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('JM01', '미쓰에이', 'A Class', 13, 'Good-bye Baby', '2011-07-18');
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('JM02', '미쓰에이', 'Hush', 13, 'Hush', '2013-11-06');

-- 앨범(f(x))
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('SF01', 'f(x)', '피노키오', 10, '피노키오', '2011-04-18');
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('SF02', 'f(x)', 'Pink Tape', 12, '첫 사랑니', '2013-07-29');
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('SF03', 'f(x)', 'Red Light', 11, 'Red Light', '2014-07-07');
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('SF04', 'f(x)', '4 Walls', 10, '4 Walls', '2015-10-27');

-- 앨범(트와이스)
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES('JT01', 'TWICE', 'Twicetagram',13,'LIKEY','2017-10-30');
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES('JT02', 'TWICE', 'Eyes wide open',13,'I CANT STOP', '2020.10.26');
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES('JT03', 'TWICE', 'Formula of Love', 17, 'SCIENTIST', '2021.11.12');

-- 앨범(블랙핑크)
INSERT INTO TEAMA.ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES('YB01', 'BLACKPINK', 'The Album', 8, 'Lovesick Girls', '2020.10.02');

-- 앨범(잇지)
INSERT INTO ALB(ALB_CODE, TEAM_NAME, ALB_NAME, SONG_CNT, T_SONG, S_DATE)
VALUES ('JI01','ITZY','CRAZY IN LOVE',16,'LOCO','2021-09-24');







