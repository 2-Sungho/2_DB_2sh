-- Additional SELECT - OPTION 

-- 1. 학생이름과 주소지를 표시하시오.
-- 단 출력헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순으로 표시하도록 한다.

SELECT STUDENT_NAME 학생이름 , STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오
SELECT STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN='Y'
ORDER BY TO_DATE(SUBSTR(STUDENT_SSN,1,6),'YY-MM-DD') DESC ;

-- 3. 주소지가 강원도 경기도인 학생들 중 1900년 대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT STUDENT_NAME , STUDENT_NO , STUDENT_ADDRESS 
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '경기%' OR STUDENT_ADDRESS LIKE '강원%')
AND SUBSTR(EXTRACT(YEAR FROM ENTRANCE_DATE),1,2)=19
ORDER BY STUDENT_NAME;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL문장을 작성하시오.
-- 법학과의 '학과코드'는 학과 테이블을 조회해서 찾아내도록 하자
SELECT PROFESSOR_NAME , PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO = '005'
ORDER BY TO_DATE(SUBSTR(PROFESSOR_SSN,1,6),'YY-MM-DD') ;

-- 5. 2004년 2학기에 'C3118100'과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
SELECT STUDENT_NO , TO_CHAR(POINT,'9.99') 학점 
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE TERM_NO='200402' AND CLASS_NO = 'C3118100'
ORDER BY 학점 DESC ;

-- 6. 학생번호, 학생이름, 학과이름을 학생이름으로 오름차순으로 정렬하여 출력하는 SQL문을 작성하시오.
SELECT STUDENT_NO , STUDENT_NAME , DEPARTMENT_NAME 
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY 2;

-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL문장을 작성하시오.
SELECT CLASS_NAME , DEPARTMENT_NAME
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO);

-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
-- (기존 워크북 PDF에 나타난 조회 결과는 DB 버전이 낮아 현재와 조회 방식이 다름. 결과 행의 수만 동일하게 조회하자)
SELECT CLASS_NAME , PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR tcp 
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO);

-- 9. 8번의 결과 중 '인문 사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT CLASS_NAME,PROFESSOR_NAME
FROM (SELECT CLASS_NAME , PROFESSOR_NAME
	FROM TB_CLASS_PROFESSOR tcp 
	JOIN TB_CLASS USING (CLASS_NO)
	JOIN TB_PROFESSOR USING (PROFESSOR_NO))
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY='인문사회';

-- 10. '음악학과' 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL문장을 작성하시오.
-- 단, 평점은 소수점 1자리 까지만 반올림하여 표시한다.
SELECT STUDENT_NO , STUDENT_NAME , (SELECT ROUND(AVG(POINT),1) FROM TB_GRADE GROUP BY STUDENT_NO)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO=59;

 





