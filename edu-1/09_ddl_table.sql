-- DB생성

CREATE DATABASE mydb;
-- mysql 컬럼명, 테이블명, 데이터베이스명 등 다 소문자로 적음.
-- 대소문자 구분 없기 때문.

-- DB선택
USE mydb;

-- DB삭제
DROP DATABASE mydb;

-- 스키마 : CREATE(생성), ALTER(수정), DROP(삭제) > DDL 문법
-- 스키마 : 구조 조작. 
-- DML 데이터와 관련됨. 데이터 조작.
-- pk, fk, unique, ..ddl에 포함됨. 제약 조건 구조에 포함됨.

-- select로 조회 가능 > 데이터.

-- 테이블 생성
-- 요즘은 시스템이 64bit라 대부분 bigint 씀.
CREATE TABLE users(
id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
,`name` VARCHAR(40) NOT NULL COMMENT '이름'
,gender CHAR(1) NOT NULL COMMENT 'F=여자, M=남자'
,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() -- now()쓰면 안 됨.
,deleted_at DATETIME	
)
ENGINE=INNODB -- select 속도가 빠른 데이터 베이스. default가 innodb임.
CHARSET=UTF8MB4 -- 대소문자 구분 인코딩
COLLATE=UTF8MB4_BIN -- 대소문자 구분 인코딩
;

-- ai 악센트 구분 안 함
-- ci 대소문자 구분 안 함
-- 조합 문자코드 변경할 때 있음

-- 게시글 테이블
-- pk, 유저 번호, 제목, 내용, 작성일, 수정일, 삭제일



-- CREATE TABLE boards(
-- user_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
-- ,title VARCHAR(400) NOT NULL COMMENT '제목'
-- ,content TEXT NOT NULL
-- ,create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
-- ,update_at DATETIME NOT NULL
-- ,delete_at DATETIME NOT NULL
-- )
-- ;
-- 
-- DROP TABLE boards;


CREATE TABLE posts(
id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
,user_id BIGINT UNSIGNED NOT NULL
,title VARCHAR(40) NOT NULL
,contents VARCHAR(600) NOT NULL
,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() -- now()쓰면 안 됨.
,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
,deleted_at DATETIME	
)
;

-- 테이블 수정
ALTER TABLE posts
	ADD CONSTRAINT fk_posts_user_id
-- 	add constraint 제약조건_테이블명_제약조건걸컬럼이름
	FOREIGN KEY (user_id)
	REFERENCES users(id)
	-- ON DELETE CASCADED
	;

-- fk 삭제 
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id
;

-- 컬럼 추가
ALTER TABLE posts
	ADD COLUMN image VARCHAR(100) NOT NULL
	
-- 컬럼 제거
ALTER TABLE posts
DROP COLUMN image
;

-- 컬럼 수정
ALTER TABLE users
MODIFY COLUMN gender VARCHAR(10) NOT NULL COMMENT '남자, 여자, 미선택'
;

-- AUTO_INCREMENT 값 변경
ALTER TABLE users AUTO_INCREMENT = 1; -- auto_increment는 되도록이면 안 건드리는 게 나음

-- 테이블 삭제
DROP TABLE posts;
DROP TABLE users;

-- 테이블의 모든  데이터 삭제
TRUNCATE TABLE users; -- 되도록 안 쓰는 게 좋음
