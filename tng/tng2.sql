-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT emp.emp_id
		 ,emp.`name`
		 ,title.title_code
FROM employees AS emp
JOIN title_emps AS title
ON emp.emp_id = title.emp_id
AND title.end_at IS NULL -- 빼먹음
;		 
		 
-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT emp.emp_id
		 ,emp.gender
		 ,sal.salary
FROM employees AS emp
JOIN salaries AS sal  -- from이랑 join 바꿔서 써도 될까?
ON emp.emp_id = sal.emp_id
-- WHERE emp.fire_at IS NULL -- 이게 아니었음
AND sal.end_at IS NULL  -- 이렇게 해야 함
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT sal.salary
		 ,emp.`name`
		 ,sal.start_at -- 넣어주면 좋음
		 ,sal.end_at -- 넣어주면 좋음
FROM salaries AS sal
JOIN employees AS emp -- from이랑 join 바꿔서 써도 될까?
ON emp.emp_id = sal.emp_id
-- WHERE emp.emp_id = '10010'  -- where이랑 and가 join문에서 어떻게 다를까?
AND emp.emp_id = '10010'
ORDER BY sal.start_at ASC -- 연봉을 받기 시작한 날짜부터 오름차순.
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT emp.emp_id
		 ,emp.`name`
		 ,departments.dept_name
FROM employees AS emp
 	JOIN department_emps
 	ON emp.emp_id = department_emps.emp_id
 	AND department_emps.end_at IS NULL	 -- 빼먹음
 	JOIN departments
 	ON department_emps.dept_code = departments.dept_code
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT emp.emp_id
		 ,emp.`name`
		 ,sal.salary
-- 		 ,RANK() OVER(ORDER BY sal.salary DESC) `rank` -- 1. 이렇게 하거나
FROM employees AS emp
JOIN salaries AS sal
ON emp.emp_id = sal.emp_id
AND sal.end_at IS NULL -- 빼먹음
AND emp.fire_at IS NULL  -- 빼먹음
ORDER BY sal.salary DESC -- 2. 이렇게 하면 됨
LIMIT 10
;

-- SELECT emp.emp_id
-- 		 ,emp.`name`
-- 		 ,tmp_sal.salary
-- FROM employees emp
-- JOIN (
-- 	SELECT 
-- 		sal.emp_id
-- 		,sal.salary
-- 		FROM salaries sal
-- 		WHERE
-- 			sal.end_at IS null
-- 		ORDER BY sal.salary DESC
-- 		LIMIT 10
-- ) tmp_sal
-- 	ON emp.emp_id = tmp_sal.emp_id
-- ORDER BY tmp_sal.salary DESC
-- ;	-- 불러오는 속도 빠르게.

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
-- SELECT departments.dept_name
-- 		 ,emp.`name`
-- 		 ,emp.hire_at
-- FROM employees AS emp
-- JOIN department_emps
-- ON emp.emp_id = department_emps.emp_id
-- JOIN departments
-- ON department_emps.dept_code = departments.dept_code
-- JOIN title_emps
-- ON emp.emp_id = title_emps.emp_id
-- WHERE title_emps.title_code = 'T005'
-- ; -- department_mangers에 부서장 있음..

SELECT 
	dept.dept_name
	,emp.`name`
	,emp.hire_at
FROM department_managers depm  -- 부서장은 managers..
	JOIN departments dept
		ON depm.dept_code = dept.dept_code
		AND depm.end_at IS NULL
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
ORDER BY dept.dept_code ASC
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	AVG(sal.salary) avg_sal
FROM titles tit
	JOIN title_emps tite
		ON tit.title_code = tite.title_code
		AND tit.title = '부장'
		AND tite.end_at IS NULL
	JOIN salaries sal
		ON tite.emp_id = sal.emp_id
		AND sal.end_at IS NULL
;

-- 현재 각 부장별 이름, 연봉평균
-- SELECT ROUND(AVG(sal.salary))
-- 		 ,emp.`name`
-- FROM employees AS emp
-- JOIN salaries AS sal
-- ON emp.emp_id = sal.emp_id
-- JOIN title_emps
-- ON title_emps.emp_id = emp.emp_id
-- AND emp.fire_at IS NULL
-- AND title_emps.end_at IS NULL
-- JOIN titles
-- ON titles.title_code = title_emps.title_code
-- AND titles.title ='부장'
-- GROUP BY emp.`name`
-- GROUP BY sal.emp_id, emp.`name`
-- group by도 중복데이터 생성될 수도. 그런 일 일어나지 않게 주의.
; 

SELECT
	emp.`name`
	,sub_sal.avg_sal
FROM employees emp
JOIN (
	SELECT 
	sal.emp_id
	,AVG(sal.salary) avg_sal
	FROM title_emps tite
		JOIN titles tit
			ON tite.title_code = tit.title_code
			AND tit.title = '부장'
			AND tite.end_at IS NULL
		JOIN salaries sal
			ON sal.emp_id = tite.emp_id
	GROUP BY sal.emp_id
) sub_sal -- ☆보통 테이블명은 복수형으로 지음.
 ON emp.emp_id = sub_sal.emp_id
 AND emp.fire_at IS NULL
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT emp.`name`
		 ,emp.hire_at
		 ,emp.emp_id
		 ,department_managers.dept_code
FROM employees AS emp
JOIN department_managers
ON emp.emp_id = department_managers.emp_id
-- JOIN title_emps
-- ON title_emps.emp_id = emp.emp_id
-- WHERE title_emps.title_code = 'T005' -- 적을 필요 없었음
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
-- SELECT titles.title
-- 		 ,ROUND(AVG(sal.salary))
-- FROM titles
-- JOIN title_emps
-- ON titles.title_code = title_emps.title_code
-- JOIN salaries AS sal
-- ON title_emps.emp_id = sal.emp_id
-- WHERE sal.salary >= 60000000 -- 그냥 salary말고 avg(sal.salary)가 60000000 이상..
-- GROUP BY titles.title
-- ORDER BY ROUND(AVG(sal.salary)) DESC
-- ;

SELECT 
	tit.title
	,CEILING(AVG(sal.salary)) avg_sal
FROM salaries sal
JOIN title_emps tite
ON sal.emp_id = tite.emp_id
AND sal.end_at IS NULL
AND tite.end_at IS NULL
JOIN titles tit
ON tit.title_code = tite.title_code
GROUP BY tit.title
	HAVING avg_sal >= 60000000
ORDER BY avg_sal DESC
;
-- WHERE
--  tite.end_at IS NULL

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
-- SELECT COUNT(titles.title)
-- 		 ,titles.title
-- 		 ,employees.gender
-- FROM titles
-- JOIN title_emps
-- -- ON titles.title_code = title_emps.title_code
-- -- JOIN employees
-- ON employees.emp_id = title_emps.emp_id
-- AND emp.fire_at IS NULL -- 빼먹음
-- AND title_emps.end_at IS NULL -- 빼먹음
-- AND emp.gender = 'F'
-- -- WHERE employees.gender = 'f'
-- GROUP BY titles.title
-- ;

SELECT COUNT(*)
		 ,title_emps.title_code
		 ,employees.gender
FROM employees
JOIN title_emps
-- ON titles.title_code = title_emps.title_code
-- JOIN employees
ON employees.emp_id = title_emps.emp_id
AND employees.fire_at IS NULL -- 빼먹음
AND title_emps.end_at IS NULL -- 빼먹음
-- AND employees.gender = 'F'
GROUP BY title_emps.title_code, employees.gender
ORDER BY title_emps.title_code, employees.gender
;

