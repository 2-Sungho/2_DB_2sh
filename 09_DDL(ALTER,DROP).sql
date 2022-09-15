-- DDL(DATA DEFINITION LANGUAGE)
-- 객체를 만들고 CREATE 바꾸고 ALTER 삭제 DROP 하는 데이터 정의 언어

/* ALTER(바꾸다,수정하다,변조하다)
 * 
 * - 테이블에서 수정할 수 있는 것
 * 1) 제약조건(추가/삭제)
 * 2) 컬럼(추가,수정,삭제)
 * 3) 이름변경(테이블명,제약조건명,컬럼명)
 * 
 */
 
-- 1. 제약조건(추가/삭제)
-- [작성법]
-- 1. 추가 : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 제약조건(지정할 컬럼명)
--          REFERNCES 테이블명[(칼럼명)]; <-- FK인 경우 추가
-- 2. 삭제 : ALTER TABLE 테이블명
--          DROP CONSTRAINT 제약조건명;
-- * 수정은 별도로 존재하지 않음! -> 삭제 후 추가를 이용해서 수정 *

CREATE TABLE DEPT_COPY AS SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;

-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 추가
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DEPT_COPY_TITLE_UQ UNIQUE(DEPT_TITLE);
-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 삭제
ALTER TABLE DEPT_COPY 
DROP CONSTRAINT DEPT_COPY_TITLE_UQ;

-- ** DEPT_COPY의 DEPT_TITLE 컬럼에 NOT_NULL 제약조건 추가/삭제 **
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DEPT_COPY_TITLE_NN NOT NULL(DEPT_TITLE);
--> NOT NULL 제약조건은 새로운 조건을 추가하는 것이 아닌
-- 컬럼 자체에 NULL 허용/비허용을 제어하는 성질 변경의 형태로 인식

-- MODIFY(수정하다) 구문을 사용해서 NULL제어
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NOT NULL; -- DEPT_TITLE 컬럼을 NOT NULL로 수정

ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NULL;

--------------------------------------------------------------------------------

-- 2. 컬럼(추가/수정/삭제)

-- 컬럼 추가 
-- ALTER TALBE 테이블명 ADD(컬럼명 데이터타입 [DEFAULT '값'])

-- 컬럼 수정
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입; -> 데이터 타입만 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT '값'; -> DEFAULT 값만 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 NULL/NOT NULL; -> NULL여부 변경

-- 컬럼 삭제
-- ALTER TABLE 테이블명 DROP(삭제할 컬럼명);
-- ALTER TABLE 테이블명 DROP COLUMN 삭제할 컬럼명;

--> * 컬럼 삭제 시 주의사항! *
-- 테이블이란? 행과 열로 이루어진 DB에 가장 기본적인 객체.
-- 테이블에 데이터가 저장됨

-- 테이블은 최소 1개 이상의 컬럼이 존재해야 되기 때문에 
-- 모든 컬럼을 삭제할 수는 없다.

SELECT * FROM DEPT_COPY;

-- CNAME 컬럼추가
ALTER TABLE DEPT_COPY ADD(CNAME VARCHAR2(30));

-- LNAME 컬럼추가
ALTER TABLE DEPT_COPY ADD(LNAME VARCHAR2(30) DEFAULT '한국');

-- D10 개발1팀 추가
INSERT INTO DEPT_COPY 
VALUES ('D10','개발1팀','L1',DEFAULT,DEFAULT);

-- DEPT_ID 컬럼 수정
ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);

-- LNAME의 기본값을 'KOREA'로 수정
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
SELECT * FROM DEPT_COPY;
--> 기본값을 변경했다고해서 기존 데이터가 변하지는 않음

-- LNAME '한국' -> 'KOREA'로 변경
UPDATE DEPT_COPY
SET LNAME = DEFAULT
WHERE LNAME='한국';
COMMIT;

-- 모든 컬럼 삭제
ALTER TABLE DEPT_COPY DROP(LNAME);
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP(DEPT_TITLE);
ALTER TABLE DEPT_COPY DROP(LOCATION_ID);
ALTER TABLE DEPT_COPY DROP(DEPT_ID);
-- ORA-12983: 테이블에 모든 열들을 삭제할 수 없습니다

-- 테이블 삭제
DROP TABLE DEPT_COPY ;

-- DEPARTMENT 테이블 복사해서 DEPT_COPY 생성
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
--> 컬럼명, 데이터타입 , NOT NULL 여부만 복사

-- DEPT_COPY 테이블에 PK추가(D_COPY_PK)
ALTER TABLE DEPT_COPY ADD CONSTRAINT D_COPY_PK PRIMARY KEY(DEPT_ID);

--------------------------------------------------------------------------------

-- 3. 이름 변경(컬럼, 제약조건, 테이블명)

-- 1) 컬럼명 변경(DEPT_TITLE -> DEPT_NAME)
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
SELECT * FROM DEPT_COPY;

-- 2) 제약조건명 변경(D_COPY_PK -> DEPT_COPY_PK)
ALTER TABLE DEPT_COPY RENAME CONSTRAINT D_COPY_PK TO DEPT_COPY_PK;

-- 3) 테이블명 변경(DEPT_COPY -> DCOPY)
ALTER TABLE DEPT_COPY RENAME TO DCOPY;
SELECT * FROM DCOPY;

--------------------------------------------------------------------------------

-- 4. 테이블 삭제

-- DROP TABLE 테이블명 [CASCADE COSTRAINT];

-- 1) 관계가 형성되지 않은 테이블(DCOPY) 삭제
DROP TABLE DCOPY;

-- 2) 관계가 형성된 테이블 삭제
CREATE TABLE TB1(
	TB1_PK NUMBER PRIMARY KEY,
	TB1_COL NUMBER
);
CREATE TABLE TB2(
	TB2_PK NUMBER PRIMARY KEY,
	TB2_COL NUMBER REFERENCES TB1
);

SELECT * FROM TB1 ;
SELECT * FROM TB2 ;

-- TB1 샘플데이터 삽입
INSERT INTO TB1 VALUES(1,100); 
INSERT INTO TB1 VALUES(2,200); 
INSERT INTO TB1 VALUES(3,300); 
COMMIT;

-- TB2 샘플데이터 삽입
INSERT INTO TB2 VALUES(11,1);
INSERT INTO TB2 VALUES(12,2);
INSERT INTO TB2 VALUES(13,3);

-- TB1 삭제
DROP TABLE TB1 ;
-- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
--> 해결방법
-- 1) 자식, 부모 테이블 순서로 삭제
-- 2) ALTER를 이용해서 FK제약조건을 삭제후 TB1 삭제
-- 3) DROP TABLE 삭제옵션 CASCADE CONSTRAINT 사용
--	-> CASCADE CONSTRAINT : 삭제하려는 테이블과 연결된 FK제약 조건을 모두 삭제

DROP TABLE TB1 CASCADE CONSTRAINT;
--> 삭제 성공

--------------------------------------------------------------------------------

/* DDL 주의사항
 * 
 * 1) DDL은 COMMIT, ROLLBACK이 되지 않는다
 *  -> ALTER, DROP을 신중하게 진행해야함
 * 2) DDL과 DML 구문을 섞어서 수행하면 안된다!
 *  -> DDL은 수행 시 존재하고있는 트랜잭션을 모두 DB에 강제 COMMIT시킴
 *  -> DDL이 종료 된 후 DML구문을 수행할 수 있도록 권장
 */
 
SELECT * FROM TB2 ;
COMMIT;

INSERT INTO TB2 VALUES (14,4); 
INSERT INTO TB2 VALUES (15,5);

--컬럼명 변경 DDL
ALTER TABLE TB2 RENAME COLUMN TB2_COL TO TB2_COLCOL;

ROLLBACK;
