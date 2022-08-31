--한줄주석

/*
 * 범위주석
 */

-- SQL 하나 수행 : CRTL+ENTER
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 실습용 사용자 계정 생성
CREATE USER kh_lsh IDENTIFIED BY kh1234;

-- 사용자 계정 권한 부여 설정
GRANT RESOURCE, CONNECT TO kh_lsh;

-- 객체 생성(테이블 등) 공간 할당량 지정
ALTER USER kh_lsh DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;