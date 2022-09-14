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
-- * 수정은 별도로 존재하지 않음! -> 삭제 후 추가를 이요해서 수정 *

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