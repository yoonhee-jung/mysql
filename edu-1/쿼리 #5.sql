-- 내장함수: 데이터를 처리하고 분석하는데 사용하는 프로그램

-- 데이터 타입 변환 함수
SELECT
	1234
	,CAST(1234 AS CHAR(4))
	,CONVERT(1234, CHAR(4))  -- 최근 추가됨.
;

-- 제어 흐름 함수
-- IF(수식, 참일 때, 거짓일 때)

-- 수식의 결과에 따라 분기 처리를 하는 함수

SELECT
	emp_id
	,`name`
	,IF(gender = 'M', '남자', '여자') AS ko_gender
	FROM employees
;

-- CASE 문
SELECT
	emp_id
	,`name`
	,CASE gender
		WHEN 'M' THEN '남자'
		WHEN 'F' THEN '여자'
		ELSE '성별없음'
	END AS ko_gender 
	FROM employees
;

-- IFNULL(수식1,수식2)
-- 수식 1이 NULL이면 수식2 반환
-- 수식 1이 NULL이 아니면 수식1 반환

SELECT
	emp_id
	,IFNULL(end_at, '9999-12-31') AS end_at
	FROM title_emps
;

-- NULLIF(수식1, 수식2)
-- 수식1과 수식2가 일치하는지 체크를 하고,
-- 참이면 null 반환, 거짓이면 수식1을 반환
SELECT
	emp_id
	,`name`
	,NULLIF(gender, 'F') AS nullif_gender
	FROM employees
;

-- 문자열 함수:문자열 데이터들 원하는 포맷/처리 하는 함수
-- CONCAT(문자열1, 문자열2, ...)
-- 문자열을 연결하는 함수
SELECT CONCAT('안녕하세요.','','DB입니다.')
;

SELECT CONCAT(gender, `name`) FROM employees
;

-- CONCAT_WS(구분자, 문자열1, 문자열2 ...)
-- 문자열 사이에 구분자를 넣어 연결하는 함수

SELECT CONCAT_WS(',','딸기','바나나','수박')
;

-- FORMAT(숫자, 소수점 자리수)
-- 숫자를 소수점 자리수에 맞는 문자열을 반환하는 함수

SELECT FORMAT(3141592, 7);

