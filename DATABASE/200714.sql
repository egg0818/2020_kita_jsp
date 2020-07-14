CREATE TABLE t_student (
i_student number,
nm varchar2(15)not null,
age number(3)not null,
primary key(i_student)
);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(5, '������', 24);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(6, '������', 25);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(7, '������', 26);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(8, '���缷', 23);

INSERT INTO t_student
(i_student, nm, age)
VALUES
(9, '��ȿ��', 23);


UPDATE t_student
SET nm = '�赵��'
, age = age + 1
-- .�÷��� = �ٲܰ�
-- age = age + 1
WHERE i_student = 2;

DELETE FROM t_student
WHERE i_student = 3;

SELECT i_student,nm,age as student_age -- as �� ���� ��Ī�� �� �� �ִ�
FROM t_student -- * �������� �� ���°� ����. �Ǽ��� ���̱����Ͽ�
WHERE (i_student <=3 AND age = 21) OR i_student = 5 -- ���ǽ��� �ɼ��ִ�
ORDER BY i_student DESC, age, nm; --DESC ��������

SELECT i_student,nm,age
FROM t_student
ORDER BY nm ASC, age DESC;

SELECT i_student,nm,age
FROM t_student
ORDER BY age DESC, nm DESC;

SELECT i_student,nm,age
FROM t_student
--WHERE nm='��ÿ�' -- �Ѹ� ����
--WHERE nm LIKE '��%' -- �达�λ�� �ٳ���
WHERE nm LIKE '%ȿ%'; -- ȿ��� ���ڰ� �ֱ⸸ �ϸ� ����
--WHERE nm LIKE '%��' -- ���� ���� ��� ����

-- ���Ͽ� ���߿� ����
SELECT 2 as dd, '����' as nm FROM t_student 
union all
SELECT 1 as dd, '����' as nm FROM t_student;

--employees ���̺��� ��ȭ��ȣ(423�� ���Ե� ��� ��� �������� ����϶�)
SELECT *
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '%.423.%'
ORDER BY employee_id ASC, FIRST_NAME ASC;

SELECT
 UPPER(first_name) as first
FROM employees
WHERE phone_number like '%.432.%';




