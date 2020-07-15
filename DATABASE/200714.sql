CREATE TABLE t_student (
-- i_student number primary key 
i_student number,
nm varchar2(15)not null,
age number(3)not null, -- �Է°��� �־����. but �������̺� ���ο� ���� �߰��Ҷ� null�� ���������� (�־��ذ��� �����ϱ�!) 
primary key(i_student) -- �� ����� ��õ��. ���� ���� �ַ���.
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
FROM EMPLOYEES
WHERE phone_number like '%.432.%';

-- PK 2���� ������ ���������� �ߺ��� ������ �ȴ�
-- class no nm 
--  A    1   ��ȯ
--  B    1   ����
--  B    2   

SELECT *
FROM t_student;

commit;

/*
<Ʈ����� (Transaction)>
- �Ѳ����� ��� ����Ǿ�� �� �Ϸ��� �����
- auto commit�� ���ٴ� ��


ex)
	A����			B����
�� 	�ݾ�		��	�ݾ�
�ڵ���	100,000	50,000	�ڵ���	0	50,000

������ü �ҷ���?
update�� ����		update�� ����	

�þ� A���࿡�� ������ �ɸ���?
�����ɸ��� �ȵǴϱ� Ʈ������� �� !
���������� ROLLBACK !
�Ѵ� ������ �ȶ߸� COMMIT !
*/

delete from t_student;
rollback;
SELECT * FROM t_student;


-- �÷��� �ȳ������� ������, �ȳ����� ������� ����ϱ⶧����,���÷����� ����!!��
                        -- ���װ� �� ���ɼ��� 1�� ��������!!!!

-- �ٸ� ���̺� �ִ� ���� �������� ������ ��
-- 12�࿡ �ִ� ���� 13�࿡ �ִ´�!!
-- Ÿ�Ը� �����ָ� �ȴ�!!
INSERT INTO t_student
(i_student,nm,age)
SELECT 13,nm,age FROM t_student where i_student = 12;

-- �����Ŷ� ������ ����!!!!!
INSERT INTO t_student
(i_student,nm,age)
VALUES
(13,'�������',28); 

UPDATE t_student
SET nm='�赵��'
, age = age + 1
WHERE i_student = 25;
-- 0�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
-- �ڹٿ��� 0�� ���Դ� == ���� �ȵ��Դ�

--�� ���ڵ忡 �� �÷� �� : ��Į��!!
-- ��������
-- �������� �� ���� ������~
UPDATE t_student
SET nm = (select first_name from employees where emplyee_id = 100)
, age = (select employee_id from employees where emplyee_id = 100)
WHERE i_student = 3;

DELETE FROM t_student
WHERE i_student in (1, 2, 3);
-- WHERE i_student >=4 AND i_student<=7
-- WHERE i_student between 4 and 7
-- AND OR �� ���� �ȴ�

SELECT * FROM t_student
WHERE i_student in (select i_student
                    from t_student
                    where i_student <= 4);
-- �÷� �ϳ��� �����
-- in ��� = ���̸� ��Į��� �ȵ�

-- where is null -> null�� = �� ã���� �ȵȴ�. is�� ã�ƾ��Ѵ�!

-- ������ ���� ����. 
select first_name, substr(first_name, 2, 3) -- n��°�ڸ����� n�� �������Ѵ�.
from employees;

select first_name, instr(first_name, 'a', -1) -- a�� ���° �ڸ��� �ִ��� ã�´�. -1�����ָ� �ݴ뿡�� ã��
from employees;

SELECT trim('    a   ')from dual; -- ���� �� ����

SELECT LENGTH('123456') FROM dual;

SELECT CONCAT(CONCAT('a', 'b'),'c') FROM DUAL; -- ���ڿ���ġ��

SELECT LPAD('abc', '5', '0') FROM DUAL; - 5�ڸ� �������ְ� ��ĭ�� 0 �ֱ�

/* ���� ���̴� ��ɾ�
LPAD ("��", "�� ���ڱ���", "ä����")
RPAD ("��", "�� ���ڱ���", "ä����")
SUBSTR n��°�ڸ����� n�� �������Ѵ�.
INSTR n�� ���° �ڸ��� �ִ��� ã�´�
LENGTH ũ��
CONCAT ���ڿ���ġ��
TRIM ������� (HTML���� �������� ���̾���
LTRIM ���ʿ������
RTRIM �����ʿ������

*/
!commit;


