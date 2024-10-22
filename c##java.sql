CREATE TABLE usertbl(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT null,
	password varchar2(20) NOT null,
	age number(3) NOT null,
	email varchar2(20) NOT null
);

INSERT INTO usertbl values('hong123','홍길동','hong123',25,'hong123@gmail.com');

--email 열 크기 50으로 변경
ALTER TABLE USERTBL MODIFY email VARCHAR2(50);

-- userid(hong123)와 password(hong123)가 일치하는 회원 조회
SELECT USERID,NAME FROM USERTBL u WHERE USERID ='hong123' AND PASSWORD = 'hong123';

-- 회원 전체 조회
SELECT USERID,name,age,email FROM USERTBl;

-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경

UPDATE USERTBL 
SET PASSWORD ='hong456'
WHERE USERID='hong123'AND PASSWORD = 'hong123';

SELECT * FROM USERTBL u ;

-- 회원 삭제
-- 아이디와 비밀번호 일치시 삭제
DELETE USERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong789';

-- booktbl
-- code number(4) pk
-- title 텍스트(50)
-- writer 텍스트 (50)
-- price number(10) 

CREATE TABLE BOOKTBL(
	CODE NUMBER(4) PRIMARY KEY,
	TITLE VARCHAR2(50) NOT NULL,
	WRITER VARCHAR2(50) NOT NULL,
	PRICE NUMBER(10) NOT NULL
);

-- 1000 자바의 정석 신용균 25000
-- 1001 자바의 신 강신용 29000
-- 1002 자바 1000제 남궁성 32000
-- 1003 오라클 박응용 33000
-- 1004 점프투파이썬 신기성 35000

INSERT INTO BOOKTBL VALUES(1000, '자바의 정석', '신용균', 25000);
INSERT INTO BOOKTBL VALUES(1001, '자바의 신', '강신용', 29000);
INSERT INTO BOOKTBL VALUES(1002, '자바 1000제', '남궁성', 32000);
INSERT INTO BOOKTBL VALUES(1003, '오라클', '박응용', 33000);
INSERT INTO BOOKTBL VALUES(1004, '점프투파이썬', '신기성', 35000);

-- 전체 조회
SELECT * FROM BOOKTBL;


-- 도서번호 1000 번인 도서 조회(상세조회)
SELECT * FROM BOOKTBL WHERE CODE = 1000;

-- 도서번호 1001 번인 도서 가격 수정
UPDATE
	BOOKTBL
SET
	PRICE = 34000
WHERE
	CODE = 1001;
-- 도서번호 1001 번인 도서 가격 및 상세 설명 수정
UPDATE
	BOOKTBL
SET
	PRICE = 34000
	,
	DESCRIPTION = '상세설명'
WHERE
	CODE = 1001;
-- 도서번호 1004 번 도서 삭제
DELETE FROM  BOOKTBL WHERE CODE = 1004;

-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM BOOKTBL WHERE TITLE LIKE '%자바%';


-- 더미 데이터 삽입PRICE
CREATE SEQUENCE book_seq
START WITH 2000;



INSERT INTO BOOKTBL(CODE,TITLE,WRITER,PRICE)
(SELECT book_seq.nextval,TITLE,WRITER,PRICE FROM BOOKTBL);

SELECT COUNT(*) FROM BOOKTBL; 

-- 검색(조회)
-- title 에 자바 키워드가 포함된 도서 조회 후 도서코드 내림차순 정렬
SELECT * FROM BOOKTBL b WHERE TITLE LIKE '%자바%' ORDER BY CODE DESC ;


ALTER TABLE BOOKTBL ADD DESCRIPTION VARCHAR2(1000);


CREATE TABLE MEMBERTBL(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT null,
	password varchar2(20) NOT null
);

INSERT INTO MEMBERTBL(USERID,NAME,PASSWORD) VALUES('hong123','홍길동','hong123');

--아이디와 비밀번호가 일치하는 회원 조회(로그인)
SELECT
	*
FROM
	MEMBERTBL
WHERE
	userid = 'hong123'
	AND password = 'hong123';

-- 중복아이디 검사
-- 
SELECT * FROM MEMBERTBL WHERE userid='hong123';

-- board
-- bno, name(varchar2-20), password(varchar2-20), title(varchar2-100), content(varchar2-2000), attach(varchar2-100), 
-- re_ref, re_lev, re_seq, readcnt, regdate(date-sysdate)
CREATE TABLE board(
	BNO number(8) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	PASSWORD VARCHAR2(20) NOT NULL,
	TITLE VARCHAR2(100) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	attach VARCHAR2(100) NOT NULL,
	RE_REF NUMBER(8) NOT NULL,
	RE_LEV NUMBER(8) NOT NULL,
	RE_SEQ NUMBER(8) NOT NULL,
	READCNT NUMBER(8) DEFAULT 0,
	REGDATE DATE DEFAULT SYSDATE
);

-- 시퀀스 생성 board_seq
CREATE  SEQUENCE board_seq;

--board attach not null ==> null 가능 
ALTER TABLE BOARD MODIFY ATTACH VARCHAR2(100) NULL;

INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
VALUES(BOARD_SEQ.NEXTVAL,'hong','12345','board 작성','board 작성',board_seq.currval,0,0)

SELECT * FROM BOARD b WHERE BNO=3;

--수정
-- bno와 password가 일치 시 title,content 수정
UPDATE BOARD SET TITLE = '박현서', CONTENT ='박현서'WHERE BNO = 1 AND PASSWORD = 12345;
SELECT * FROM BOARD;

-- 조회수 업데이트
UPDATE BOARD SET READCNT = READCNT+1 WHERE BNO = 3;


-- 더미 데이터
INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
(SELECT board_seq.nextval,name,password,title,content,board_seq.currval,RE_LEV,RE_SEQ FROM board);

SELECT count(*) FROM board;

-- 댓글처리

-- 가장 최신글에 댓글 처리
SELECT
	*
FROM
	board
WHERE
	bno = (
	SELECT
		MAX(bno)
	FROM
		board);
	
-- 그룹 개념(re_ref)
	
-- 댓글 추가(re_ref : 부모글의 re_ref 넣어주기)
-- RE_LEV : 부모글 RE_LEV+1
-- RE_SEQ : 부모글 RE_SEQ+1
INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
VALUES(BOARD_SEQ.NEXTVAL,'hong','12345','board 작성','board 작성',10243,0,0);

UPDATE BOARD SET RE_LEV=1, RE_SEQ=1 WHERE BNO = 10244;

-- 원본글과 댓글함께조회

SELECT * FROM BOARD b WHERE RE_REF =10243;

-- 두번째 댓글추가 (최신순 조회 : RE_SEQ)
-- RE_SEQ 낮을수록 최신글

-- 원본글
-- ㄴ 댓글2
--  ㄴ 댓글2의 댓글
-- ㄴ 댓글1

-- 댓글 2 추가
-- 먼저 들어간 댓글이 있다면 RE_SEQ값을 +1 해야함
-- UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 부모글 10243 AND RE_SEQ > 0; 
UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 10243 AND RE_SEQ > 0; 

INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
VALUES(BOARD_SEQ.NEXTVAL,'hong','12345','board 작성','board 작성',10243,1,1);


SELECT * FROM BOARD b WHERE RE_REF =10243 ORDER BY RE_REF DESC, RE_SEQ ASC;




