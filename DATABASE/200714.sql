CREATE TABLE t_student (
-- i_student number primary key 
i_student number,
nm varchar2(15)not null,
age number(3)not null, -- 입력값이 있어야함. but 기존테이블에 새로운 열을 추가할땐 null로 만들어줘야함 (넣어준값이 없으니까!) 
primary key(i_student) -- 이 방법을 추천함. 여러 열에 주려고.
);



INSERT INTO t_student
(i_student, nm, age)
VALUES
(5, '김은정', 24);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(6, '김은정', 25);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(7, '김은정', 26);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(8, '김재섭', 23);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(9, '김효진', 23);


UPDATE t_student
SET nm = '김도빈'
, age = age + 1
-- .컬러명 = 바꿀값
-- age = age + 1
WHERE i_student = 2;

DELETE FROM t_student
WHERE i_student = 3;

SELECT i_student,nm,age as student_age -- as 를 쓰면 별칭을 줄 수 있다
FROM t_student -- * 쓰지말고 다 쓰는게 좋다. 실수를 줄이기위하여
WHERE (i_student <=3 AND age = 21) OR i_student = 5 -- 조건식을 걸수있다
ORDER BY i_student DESC, age, nm; --DESC 내림차순

SELECT i_student,nm,age
FROM t_student
ORDER BY nm ASC, age DESC;

SELECT i_student,nm,age
FROM t_student
ORDER BY age DESC, nm DESC;

SELECT i_student,nm,age
FROM t_student
--WHERE nm='김시운' -- 한명만 나옴
--WHERE nm LIKE '김%' -- 김씨인사람 다나옴
WHERE nm LIKE '%효%'; -- 효라는 글자가 있기만 하면 나옴
--WHERE nm LIKE '%균' -- 균이 끝인 사람 나옴

-- 유니온 나중에 쓰임
SELECT 2 as dd, '하하' as nm FROM t_student 
union all
SELECT 1 as dd, '하하' as nm FROM t_student;

--employees 테이블에서 전화번호(423이 포함된 사람 모두 나오도록 출력하라)
SELECT *
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '%.423.%'
ORDER BY employee_id ASC, FIRST_NAME ASC;

SELECT
 UPPER(first_name) as first
FROM EMPLOYEES
WHERE phone_number like '%.432.%';

-- PK 2개가 나오면 조합했을때 중복이 없으면 된다
-- class no nm 
--  A    1   규환
--  B    1   혜선
--  B    2   

SELECT *
FROM t_student;

commit;

/*
<트랜잭션 (Transaction)>
- 한꺼번에 모두 수행되어야 할 일련의 연산들
- auto commit을 끈다는 말


ex)
	A은행			B은행
고객 	금액		고객	금액
박도흠	100,000	50,000	박도흠	0	50,000

계좌이체 할려면?
update문 실행		update문 실행	

먄약 A은행에서 에러가 걸리면?
에러걸리면 안되니까 트랜잭션을 검 !
에러터지면 ROLLBACK !
둘다 에러가 안뜨면 COMMIT !
*/

delete from t_student;
rollback;
SELECT * FROM t_student;


-- 컬럼명 안넣을수도 있지만, 안넣으면 순서대로 써야하기때문에,★컬럼명을 쓰자!!★
                        -- 버그가 날 가능성을 1도 주지말자!!!!

-- 다른 테이블에 있는 값을 가져오고 싶을때 씀
-- 12행에 있는 값을 13행에 넣는다!!
-- 타입만 맞춰주면 된다!!
INSERT INTO t_student
(i_student,nm,age)
SELECT 13,nm,age FROM t_student where i_student = 12;

-- 위에거랑 같음랑 같음!!!!!
INSERT INTO t_student
(i_student,nm,age)
VALUES
(13,'사공수기',28); 

UPDATE t_student
SET nm='김도빈'
, age = age + 1
WHERE i_student = 25;
-- 0개 행 이(가) 업데이트되었습니다.
-- 자바에서 0이 들어왔다 == 값이 안들어왔다

--한 레코드에 한 컬럼 값 : 스칼라!!
-- 서브쿼리
-- 쿼리문이 세 개라서 느리다~
UPDATE t_student
SET nm = (select first_name from employees where emplyee_id = 100)
, age = (select employee_id from employees where emplyee_id = 100)
WHERE i_student = 3;

DELETE FROM t_student
WHERE i_student in (1, 2, 3);
-- WHERE i_student >=4 AND i_student<=7
-- WHERE i_student between 4 and 7
-- AND OR 만 쓰면 된다

SELECT * FROM t_student
WHERE i_student in (select i_student
                    from t_student
                    where i_student <= 4);
-- 컬럼 하나만 써야함
-- in 대신 = 붙이면 스칼라라서 안됨

-- where is null -> null은 = 로 찾으면 안된다. is로 찾아야한다!

-- 은근히 자주 쓰임. 
select first_name, substr(first_name, 2, 3) -- n번째자리에서 n개 나오게한다.
from employees;

select first_name, instr(first_name, 'a', -1) -- a가 몇번째 자리에 있는지 찾는다. -1값을주면 반대에서 찾음
from employees;

SELECT trim('    a   ')from dual; -- 여백 다 삭제

SELECT LENGTH('123456') FROM dual;

SELECT CONCAT(CONCAT('a', 'b'),'c') FROM DUAL; -- 문자열합치기

SELECT LPAD('abc', '5', '0') FROM DUAL; - 5자리 지정해주고 빈칸에 0 넣기

/* 자주 쓰이는 명령어
LPAD ("값", "총 문자길이", "채움문자")
RPAD ("값", "총 문자길이", "채움문자")
SUBSTR n번째자리에서 n개 나오게한다.
INSTR n가 몇번째 자리에 있는지 찾는다
LENGTH 크기
CONCAT 문자열합치기
TRIM 여백삭제 (HTML에서 값넣을때 많이쓰임
LTRIM 왼쪽여백삭제
RTRIM 오른쪽여백삭제

*/
!commit;


