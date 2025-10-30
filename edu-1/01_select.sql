-- 코멘트
-- 단축키: ctrl + /

-- dml: 데이터 조작부터 배울 것

-- 테이블 전체 컬럼 조회

SELECT *
FROM employees;

-- 현재 쿼리 실행 시 세미콜론 단위로 쿼리가 나뉨

-- 특정 컬럼만 지정하여 조회

SELECT 
	name
	,birth
--	,birth del	-- 이런 식으로 코드 이력 기록 남겨둬야 함
	,hire_at		-- 콤마가 제일 오른쪽에 두어지면 신택스 에러 남
FROM employees;

-- WHERE 절: 특정 컬럼의 값과 일치하는 데이터만 조회

SELECT *
FROM employees
WHERE
	emp_id = 5
	;
	
-- 사원 이름:강영화 어떻게 가져올지
-- 홑따옴표: 단순한 문자열, 쌍따옴표: 특별한 식별자열
SELECT *
FROM employees
WHERE
	name = '강영화'
	;

-- 이름이 강영화이고 성별이 남자인 사람
SELECT *
FROM employees
WHERE
	name = '강영화'
	AND gender = 'm'
	;