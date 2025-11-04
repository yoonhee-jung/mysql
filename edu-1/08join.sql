-- JOIN 문
-- 두 개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력

-- INNER JOIN
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력

-- 전 사원의 사번과 이름과 소속부서명을 출력해주세요

-- SELECT
-- 	emp.emp_id
-- 	,emp.`name`
-- 	,sal.salary
-- FROM	employees emp
-- --	INNER JOIN salaries sal
-- 	JOIN salaries sal
-- 		ON emp.emp_id = sal.emp_id
-- 			AND sal.end_at IS NULL
-- 			ORDER BY emp.emp_id
-- 			;
-- 		
-- 		
-- 	-- 재직 중인 사원의 사번, 이름, 생일, 부서명
-- 	SELECT
-- 	depe.emp_id
-- 	,emp.`name`
-- 	,emp.birth
-- 	,dept.dept_name
-- 	FROM department_emps depe
-- 		JOIN departments dept
-- 		ON depe.dept_code = dept.dept_code
-- 		AND depe.end_at IS NULL
-- 	JOIN employees emp
-- 	ON depe.emp_id = emp.emp_id
-- 	AND depe.fire_at IS NULL	
-- 		;	
-- 		
-- left join
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
	FROM employees emp
		JOIN salaries sal
		ON emp.emp_id = sal.emp_id;
			AND sal.end_at IS NULL	
			;
		-- inner join과 left join 차이: 동작 방식
		
-- 두 개 이상의 쿼리의 결과를 합쳐서 출력
-- union		(중복 레코드 제거)
-- union all (중복 레코드 제거 안 함)

SELECT * FROM employees WHERE emp_id IN (1,3)
UNION
SELECT * FROM employees WHERE eno_id IN (3,6)
;

-- self join
-- 같은 테이블 끼리  join
 -- self join
 
 SELECT 
 emp.emp_id AS junior_id
 ,emp.`name` AS junior_name
 ,supemp.emp_id AS supervisor_id
 ,supemp.`name` AS superviosr_name
  FROM employees emp
	JOIN employees supemp
		ON emp.sup id = supemp.emp_id
AND emp=sup_id IS NOT NULL
;