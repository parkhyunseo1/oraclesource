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

ALTER TABLE BOOKTBL ADD DESCRIPTION VARCHAR2(1000);
























