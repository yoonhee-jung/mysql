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
	
-- 날짜를 필터링 할 때
SELECT *
FROM employees
WHERE
	hire_at >= '2023-01-01'
--	hire_at >= '2023-01-01 00:00:00'
;
	
-- 아직 재직중인 사원들만 조회(NULL 조회)
-- NULL값 존재 자체를 하지 않는 값, 비교 자체를 할 수 없음
SELECT *
FROM employees
WHERE
	fire_at IS NULL
--	fire_at IS NOT NULL
	;

-- WHERE 절에서 AND, OR 복합 사용 시 주의
-- 입사일이 20250101 이후거나, 20000101 이전이고,
-- 이미 퇴사한 직원
SELECT *
FROM employees
WHERE	
	(hire_at >= '2025-01-01'
	OR	hire_at <= '2000-01-01'
	)
	AND fire_at IS	NOT NULL
	;
	
SELECT*
FROM	 employees
WHERE	
	(
	NAME = '원성현'
	OR NAME = '반승현'
	)
	AND birth >= '1990-01-01'
	;

-- between 연산자: 지정한 범위 내의 데이터를 조회
SELECT *
FROM employees
WHERE
	emp_id >= 10000
	AND emp_id <= 10010
	;
	
SELECT *
FROM employees
WHERE
	emp_id BETWEEN	10000 AND 10010
	;

-- IN 연산자 : 지정한 값과 일치하는 데이터를 조회할 때 사용
-- 사번이 5, 7, 9, 12인 사원 조회

SELECT *
FROM employees
WHERE
	emp_id = 5
	OR	 emp_id = 7
	OR  emp_id = 9
	OR  emp_id = 12
	;
	
SELECT *
FROM employees
WHERE
	emp_id IN(5, 7, 9, 12)
	;

-- like 연산자: 문자열 내용을 조회할 때 사용
-- %, _
-- %: 글자수와 상관없이 조회
-- 이름이 '영화'인 사원 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '%영화'
--	NAME LIKE '%영화%'
	;

-- _: 언더바의 개수만 글자의 개수
SELECT	*
FROM employees
WHERE
	NAME LIKE '_영화'
--	NAME LIKE '__영화' 남궁영화 이름 1개
	;
	
-- ORDER BY 절: 데이터 정렬
-- ASC: 오름차순
-- DESC: 내림차순
SELECT *
FROM employees
ORDER BY NAME ASC, birth ASC -- 똑같은 첫 번째 데조건 데이터에 관해 
-- 두 번째 조건 정렬(ex.강가람 > birth)
;

-- 입사일이 2000년 이후인 사원을 이름, 
-- 생일 오름차순으로 정렬해서 조회
SELECT *
FROM employees
WHERE
	hire_at >= '2000-01-01'
ORDER BY 
	NAME ASC
	, birth ASC
;

-- 각 절 적는 순서가 정해져 있음 where > order by 순.

-- 여자 사원을 이름, 생일 오름차순으로 정렬
SELECT *
FROM employees
WHERE gender = 'f'
ORDER BY
	NAME asc
	, birth asc
	;
	
-- DISTINCT 키워드: 검색 결과에서 중복되는 레코드를 제거
-- select문의 distinct 키워드
SELECT DISTINCT NAME, birth
FROM employees
ORDER BY	NAME 
-- default: asc임
;
-- 현업에서 distinct 쓰는 개발자 가끔 있음

-- mysql이group by절 내부 문법 안 지키는 부분 있음
-- group by 절: 그룹으로 묶어서 조회
-- having 절: group by 절의 조건 

-- 집계함수

-- MAX() : 최대값 
-- MIN() : 최소값
-- COUNT() : 개수
-- AVG() : 평균
-- SUM() : 합계

-- 사원 별 최고 연봉
SELECT 
	emp_id
	,MAX(salary) max_salary
--	,MAX(salary) AS max_salary
FROM salaries
GROUP	BY emp_id
	;
-- 내가 그룹핑을 한 그 컬럼(집계치)만 
-- select절에 적어야 하고 나머지는적으면 안 됨	
	
-- 집계 함수 최대값, 최소값, 평균값...

-- 사원 별 최고 연봉이 5000만 원 이상인 사원 조회
SELECT
	emp_id
	,MAX(salary) max_salary
FROM salaries
GROUP BY emp_id
	HAVING MAX(salary) >= 50000000
--	HAVING max_salary >= 50000000
;

-- 성별 사원의 수를 조회해 주세요.
SELECT
	gender
	,COUNT(gender) AS count_gender
FROM employees
GROUP BY gender
	;

-- 재직 중인 성별 사원수를 조회해 주세요.
SELECT
--  emp_id
--	,fire_at
	gender
	,COUNT(gender) AS count_gender
FROM employees
WHERE
	fire_at IS NULL
GROUP BY gender
; 

-- LIMIT, OFFSET: 출력하는 데이터의 개수를 제한
-- 사원번호로 오름차순 정렬해서 10개만 조회
SELECT *
FROM employees
ORDER BY emp_id ASC
LIMIT 10
;

-- SELECT문 잘 쓰는 것이 중요