CREATE TABLE t_student (
i_student number,
nm varchar2(15)not null,
age number(3)not null,
primary key(i_student)
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
FROM employees
WHERE phone_number like '%.432.%';




