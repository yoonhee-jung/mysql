-- 기존 데이터 수정 작업: update문

SELECT *
FROM salaries
WHERE 
emp_id = '100005';

SELECT *
FROM employees
WHERE 
emp_id = '100005';

-- 쉬운 방법: select문으로 바꾸고 싶은 데이터 불러와서
-- select없애고 from을 update로 바꾸고 set 넣고 내가 원하는 데이터 갱신
-- UPDATE employees
-- SET
--  	fire_at = NOW()
--  	,delete_at = NOW()
-- WHERE
-- NAME = '정윤희';

-- START TRANSACTION;
-- 
-- UPDATE employees
-- SET
--  	fire_at = NOW()
--  	,deleted_at = NOW()
-- ;
-- 
-- ROLLBACK;

-- UPDATE employees
-- SET
--  	fire_at = NOW()
--  	,deleted_at = NOW()
-- WHERE
-- 	emp_id = 100005
-- ;

-- 개발 서버 데이터 웬만한면 날리지 말기

-- START TRANSACTION;
-- 
-- UPDATE salaries
-- SET
-- start_at = '2025-10-31'
-- ,salary = 30000000
-- WHERE
-- emp_id = '100005'
-- ;

SELECT *
FROM salaries
WHERE
	end_at IS null
	AND emp_id = 100000
	;