-- SELECT절에서 사용
-- 사원별 역대 전체 급여 평균

-- SELECT
-- 	emp.emp_id
-- 	,(
-- 		SELECT AVG(sal.salary)
-- 		FROM salaries sal
-- 		WHERE emp.emp_id = sal.emp_id
-- 	) avg_sal
-- FROM employees emp
-- ;

-- FROM절에서 사용

-- SELECT
-- 	tmp.*
-- FROM (
-- 	SELECT
-- 		emp.emp_id
-- 		,emp.`name`
-- 		FROM employees emp
-- ) tmp
-- ;

-- INSERT 문에서 사용

-- INSERT INTO title_emps(
-- 	emp_id
-- 	,title_code
-- 	,start_at
-- )
-- VALUES(
-- 	(SELECT MAX(emp_id) FROM employees)
-- 	,(SELECT title_code FROM  titles WHERE title = '사원')
-- 	,DATE(NOW())
-- );

-- UPDATE 문에서 사용

-- UPDATE title_emps title1
-- SET
-- 	title1.end_at = (
-- 		SELECT fire_at
-- 		FROM employees emp
-- 		WHERE emp.emp_id = 100000
-- 	)
-- WHERE
-- 	title1.title_emp_id = 100000
-- 	AND title1.end_at IS NULL
-- 	;
	
SELECT *
FROM title_emps

WHERE
emp_id = 10000
;