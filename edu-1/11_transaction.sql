-- transaction

-- 트랜잭션 시작

START TRANSACTION;
-- insert문
INSERT INTO employees (
`name`, birth, gender, hire_at
)
VALUES (
'정윤희', '1994-03-02','F',DATE(NOW()))
;

-- select 
SELECT *
FROM employees
WHERE `name` = '정윤희'
;

-- ROLLBACK
ROLLBACK;

-- commit
COMMIT;

