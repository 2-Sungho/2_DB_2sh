--[ADDITIONAL SELECT - 함수]

-- 1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학년도를 입학년도가 빠른 순으로 표시하는 SQL문장을 작성하시오.
-- 단, 헤더는 "학번", "이름", "입학년도"가 표시되도록 한다.
SELECT STUDENT_NO 학번 , STUDENT_NAME 이름 , ENTRANCE_DATE 입학년도
FROM TB_STUDENT ts
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;

-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다.
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장을 작성해보자
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR tp
WHERE INSTR(PROFESSOR_NAME,1) 


-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL문장을 작성하시오.
-- 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력헤더는 "교수이름", "나이"로 한다. 나이는 '만'으로 계산한다)
SELECT PROFESSOR_NAME ,
	--EXTRACT(YEAR FROM TO_DATE(19||SUBSTR(PROFESSOR_SSN,1,6)))
	FLOOR(MONTHS_BETWEEN(SYSDATE,TO_DATE(19||SUBSTR(PROFESSOR_SSN,1,6)))/12) 나이
FROM TB_PROFESSOR tp 
WHERE SUBSTR(PROFESSOR_SSN,8,1)=1
ORDER BY 나이;

-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL문장을 작성하시오. 출력 헤더는 "이름"이 찍히도록한다.
SELECT SUBSTR(PROFESSOR_NAME,2,2) 이름
FROM TB_PROFESSOR tp ;

-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?
-- 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT ts 
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)
	 -EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6)))> 19;
	
-- 6. 2020년 크리스마스는 무슨 요일인가?
SELECT EXTRACT (DAY FROM '2020-12-25') FROM DUAL;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')은 각각 몇년몇월몇일을 의미할까?
-- 또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD')은 각각 몇년몇월몇일을 의미할까?
-- YY: 2099/10/11 2049/10/11
-- RR: 1999/10/11 2049/10/11
	
-- 8.
	
-- 9.

-- 10. 학과별 학생수를 구하여 "학과번호", "학생수(명)"의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
SELECT DEPARTMENT_NO 학과번호 , COUNT(*) "학생수(명)"
FROM TB_STUDENT ts 
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11.

-- 12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한 자리까지만 표시한다.
SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE tg
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 년도;


-- 13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호황 휴학생 수를 표시하는 SQL 문장을 작성하시오.
SELECT DEPARTMENT_NO,
--SUM(DECODE(ABSENCE_YN,'Y',1,0))
COUNT(DECODE(ABSENCE_YN,'Y',1)) "휴학생 수"
FROM TB_STUDENT ts 
--WHERE ABSENCE_YN='Y'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ;

-- 14. 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능하겠는가?
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT ts
GROUP BY STUDENT_NAME
HAVING COUNT(*)>=2
ORDER BY 1;

-- 15. 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL문을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT NVL(SUBSTR(TERM_NO,1,4),' ') 년도, NVL(SUBSTR(TERM_NO,5,2),' ') 학기, ROUND(AVG(POINT),1) 평점
FROM TB_GRADE tg
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2);

