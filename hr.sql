-- EMPLOYEES (scott 계정의 emp 테이블 원본)
-- EMPLOYEES 전체 조회
SELECT * FROM EMPLOYEES e;
-- EMPLOYEES 의 first_name, last_name, job_id 조회
SELECT
	FIRST_NAME,
	LAST_NAME,
	JOB_ID
FROM
	EMPLOYEES e ;
	
--사원번호가 176 사원의 LAST_NAME, 부서번호 조회

SELECT e.LAST_NAME,e.DEPARTMENT_ID FROM EMPLOYEES e WHERE EMPLOYEE_ID = 176 ;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME 과 연봉 조회

SELECT e.SALARY ,e.LAST_NAME FROM EMPLOYEES e WHERE SALARY >= 12000;

-- 연봉이 5000에서 12000 범위가 아닌 사람들의 LAST_NAME 과 연봉조회

SELECT SALARY, LAST_NAME FROM EMPLOYEES e WHERE  5000> SALARY OR 12000 < SALARY;

-- 20번 혹은 50번 부서에서 근무하는 사원들의 last_name, 부서번호를 조회 
-- 단, 이름의 오름차순, 부서의 오름차순으로 정렬
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	DEPARTMENT_ID IN(20, 50)
ORDER BY
	e.LAST_NAME ASC,
	e.DEPARTMENT_ID DESC ;

-- 커미션을 버는 사원들의 last_name, salary, commission_pct 를 조회
-- 단, 연봉의 내림차순, 커미션 내림차순으로 정렬
SELECT
	e.LAST_NAME,
	e.SALARY,
	e.COMMISSION_PCT
FROM
	EMPLOYEES e
WHERE
	COMMISSION_PCT > 0
ORDER BY
	e.SALARY DESC,
	e.COMMISSION_PCT DESC ;

-- 연봉이 2500,3500,7000이 아니며 job_id 가 SA_REP OR ST_CLERK 인 사원 조회
SELECT * FROM EMPLOYEES e WHERE SALARY NOT IN(2500,3500,7000) AND e.JOB_ID IN('SA_REP', 'ST_CLERK'); 

--2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME, 사번, 고용일자(hire_date) 조회
SELECT
	e.LAST_NAME,
	e.EMPLOYEE_ID,
	e.HIRE_DATE
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE >= '2018/02/20'
	AND e.HIRE_DATE <= '2018/05/01' ; 

-- 2015년에 고용된 사원 조회
	SELECT
	e.LAST_NAME,
	e.EMPLOYEE_ID,
	e.HIRE_DATE
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE >= '2015/01/01'
	AND e.HIRE_DATE <= '2015/12/31' ;

-- BETWEEN A AND B
-- 20번 혹은 50번 부서에서 근무하며, 연봉이 5000 ~ 12000 사이인 직원들의
-- FIRST_NAME, LAST_NAME, 연봉 조회 (연봉 오름차순)
SELECT
	E.FIRST_NAME,
	E.LAST_NAME,
	E.SALARY
FROM
	EMPLOYEES e
WHERE
	E.DEPARTMENT_ID IN(20, 50)
	AND SALARY BETWEEN 5000 AND 12000
ORDER BY
	SALARY ;

-- 연봉이 5000 ~ 12000 사이가 아닌 직원들의 정보 조회
SELECT *FROM EMPLOYEES e WHERE  SALARY NOT BETWEEN 5000 AND 12000;


--2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME, 사번, 고용일자(hire_date) 조회
SELECT
	e.LAST_NAME,
	e.EMPLOYEE_ID,
	e.HIRE_DATE
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE BETWEEN '2018/02/20'
	AND  '2018/05/01' ;

--LIKE
--LAST_NAME 에 u가 포함되는 사원들의 사번,last_name 조회
SELECT
	e.EMPLOYEE_ID,
	LAST_NAME
FROM
	EMPLOYEES e
WHERE
	LAST_NAME LIKE '%u%' ;
--LAST_NAME 의 네번째 글자가 a인 사원들의 사번,last_name 조회
SELECT
	e.EMPLOYEE_ID,
	LAST_NAME
FROM
	EMPLOYEES e
WHERE
	LAST_NAME LIKE '___a%' ;
--LAST_NAME 에 a 혹은 e 글자가 포함되는 사원들의 사번,last_name 조회(단 last_name 오름차순)
SELECT
	e.EMPLOYEE_ID,
	LAST_NAME
FROM
	EMPLOYEES e
WHERE
	LAST_NAME LIKE '%a%'
	OR LAST_NAME LIKE '%e%'
ORDER BY
	LAST_NAME ;

--LAST_NAME 에 a 와 e 글자가 포함되는 사원들의 사번,last_name 조회(단 last_name 오름차순)

SELECT
	e.EMPLOYEE_ID,
	LAST_NAME
FROM
	EMPLOYEES e
WHERE
	LAST_NAME LIKE '%a%'
	AND LAST_NAME LIKE '%e%'
ORDER BY
	LAST_NAME;

-- IS NULL
-- MANAGER_ID 가 없는 사원들의 LAST_NAME 및 JOB_ID 조회
SELECT E.LAST_NAME,E.JOB_ID FROM EMPLOYEES e WHERE E.MANAGER_ID IS NULL; 

-- JOB_ID 가 ST_CLERK 가 아닌 사원이 없는 부서 조회
-- 단, 부서번호가 NULL 인 경우는 제외한다.
SELECT
	DISTINCT DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	JOB_ID <> 'ST_CLERK'
	AND E.DEPARTMENT_ID IS NOT NULL; 

-- COMMISION_PCT 가 NULL 이 아닌 사원들 중에서 COMMISSION = SALARY * COMMISION_PCT를 구한다
-- 사원번호, FIRST_NAME,JOB_ID와 함께 조회

SELECT
	E.EMPLOYEE_ID,
	E.FIRST_NAME ,
	E.JOB_ID, SALARY * COMMISSION_PCT AS COMMISSION
FROM
	EMPLOYEES e
WHERE
E.COMMISSION_PCT IS NOT NULL;

-- 부서 80의 사원에 적용 가능한 세율 표시하기
-- LAST_NAME, SALARY, TAX_RATE 출력
-- TAX_RATE 는 SALARY / 2000 으로 나눈 후 버림
--				해당 값이 0이면 0.0 / 1, 0.09 / 2, 0.20 / 3, 0.30 / 4, 0.40 / 5, 0.42/ 6 , 0.44 / 그 외 0.45
SELECT
	E.LAST_NAME ,
	E.SALARY ,
	DECODE(TRUNC(SALARY / 2000), 0, 0.0,
	1, 0.09,
	2, 0.20,
	3, 0.30,
	4, 0.41,
	5, 0.42,
	6, 0.44,
	0.45
	)AS TAX_RATE
FROM EMPLOYEES e;


-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT MAX(SALARY)-MIN(SALARY) AS SALARYGAP
FROM EMPLOYEES e ;
-- 매니저로 근무하는 사원들의 총 숫자를 출력
SELECT COUNT(E.MANAGER_ID) AS MAN_CNT
FROM EMPLOYEES e 

-- 매니저가 없는 사원들은 제외하고 매니저가 관리하는
-- 사원들 중에서 최소 급여를 받는 사원 조회
--(매니저가 관리하는 사원 중에서 연봉이 6000미만 제외)
SELECT
	MANAGER_ID ,
	MIN(SALARY)
FROM
	EMPLOYEES e
GROUP BY
	MANAGER_ID
HAVING
	MANAGER_ID IS NOT NULL
	AND MIN(SALARY) >= 6000
ORDER BY
	MANAGER_ID ;


-- JOIN
-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기
-- 사원번호, 입사일, 이름(last_name), 매니저아이디 출력
-- self 조인
SELECT
	E.EMPLOYEE_ID,
	E.HIRE_DATE,
	E.LAST_NAME,
	E2.EMPLOYEE_ID AS 매니저아이디
FROM
	EMPLOYEES e
JOIN EMPLOYEES e2 ON
	E.MANAGER_ID = E2.EMPLOYEE_ID
	AND E.HIRE_DATE < E2.HIRE_DATE
ORDER BY
	E.EMPLOYEE_ID;
-- 도시 이름이 T로 시작하는 지역에 사는 사원들의 정보 조회
-- 사원번호, 이름(last_name), 부서번호, 지역명
-- employees, department, locations 조인
SELECT
	E.EMPLOYEE_ID ,
	E.LAST_NAME ,
	D.DEPARTMENT_ID ,
	L.CITY
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d ON
	E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS l ON
	D.LOCATION_ID = L.LOCATION_ID
WHERE
	L.CITY LIKE 'T%';
-- 각 부서별 사원 수, 평균 연봉(소수점 2자리까지) 조회
-- 부서명, 부서위치아이디, 부서별 사원 수, 평균 연봉 출력
SELECT
	D.DEPARTMENT_NAME,
	D.LOCATION_ID,
	COUNT(D.DEPARTMENT_NAME) AS 부서별사원수 ,
	ROUND(AVG(E.SALARY)) AS 평균연봉
FROM
	DEPARTMENTS d
JOIN EMPLOYEES e ON
	E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY
	D.DEPARTMENT_NAME,
	D.LOCATION_ID;
-- Executive 부서에 근무하는 모든 사원들의 부서번호, 이름(last_name), job_id조회
-- employees, department 조인
SELECT E.DEPARTMENT_ID , E.LAST_NAME , E.JOB_ID 
FROM EMPLOYEES e JOIN DEPARTMENTS d ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
WHERE D.DEPARTMENT_ID = '90';

-- 기존의 직무를 계속 하고 있는 사원 조회 
-- 사원번호, job_id 출력
-- employees, job_history 조인
SELECT E.EMPLOYEE_ID ,e.JOB_ID 
FROM EMPLOYEES e  JOIN JOB_HISTORY jh ON E.JOB_ID = JH.JOB_ID AND e.EMPLOYEE_ID  = JH.EMPLOYEE_ID; 

-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 많은 급여를 받는 사원의 정보 조회
-- 부서번호 ,first_name 과 last_name 을 연결하여 출력, 급여, 입사일 출력
-- employees self 조인
SELECT  DISTINCT E.DEPARTMENT_ID,E.FIRST_NAME || E.LAST_NAME AS NAME , E.SALARY , E.HIRE_DATE ,E2.FIRST_NAME || E2.LAST_NAME AS NAME , E2.SALARY , E2.HIRE_DATE 
FROM EMPLOYEES e JOIN EMPLOYEES e2 ON E.DEPARTMENT_ID = E2.DEPARTMENT_ID AND e.HIRE_DATE < e2.HIRE_DATE AND E.SALARY < E2.SALARY 
ORDER BY E.DEPARTMENT_ID;


-- 서브 쿼리로 작성
-- Executive 부서에 근무하는 모든 사원들의 부서번호, 이름(last_name), job_id조회

SELECT
	E.DEPARTMENT_ID ,
	E.LAST_NAME ,
	E.JOB_ID
FROM
	EMPLOYEES e
WHERE
	(E.DEPARTMENT_ID,
	'Executive') IN (
	SELECT
		d.department_id,
		d.department_name
	FROM
		DEPARTMENTS d ) ;

































