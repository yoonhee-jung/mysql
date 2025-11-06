-- index 확인
SHOW INDEX FROM employees;

SELECT * FROM employees WHERE `name` = '주정웅';

-- index 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`)
;

SELECT * FROM employees WHERE `name` = '주정웅';

-- index 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name;