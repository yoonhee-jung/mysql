-- INSERT 문
-- 신규 데이터를 저장하기 위해 사용하는 문법
-- 자동완성: ctrl + space

INSERT INTO employees(
	`name` -- mysql에서 쓰는 예약어 중 하나. 컬럼이라고 나타내기 위해.
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
	,deleted_at
)
VALUES(
	'정윤희'
	,'1994-03-02'
	,'f'
	,'2025-10-31'
	,null
	,null
	,NOW()
	,NOW()
	,null
)
;

-- 생성일 가장 최근,
-- 내 이름,
-- 입사일이 오늘 기준,
-- 가장 큰 pk로 찾기,
-- 필터링을 조합해야 함

SELECT *
FROM employees
WHERE hire_at = '2025-10-31'
AND NAME = '정윤희'
AND birth = '1994-03-02'
;

INSERT INTO salaries(
	emp_id
	,salary
	,start_at
	,end_at
	,created_at
	,updated_at
	,deleted_at
)
VALUES (
	'100005'
	,2156880
	,'2025-10-31'
	,null
	,NOW()
	,NOW()
	,null
)
;

SELECT *
FROM salaries
WHERE salary = '2156880'
AND start_at = '2025-10-31'
AND end_at IS NULL
;

-- SELECT INSERT
