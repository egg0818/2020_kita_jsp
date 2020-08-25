-- t_user ���̺� ����
create table t_user (
    i_user number primary key,
    user_id varchar2(30) not null,
    user_pw varchar2(100) not null,
    nm varchar2(20) not null,
    email varchar2(40),
    profile_img varchar2(50),
    r_dt date default sysdate,
    m_dt date default sysdate
    );
    
-- nocache : ĳ�ñ�� OFF �ؾ��� �ȱ׷� 2���ͽ�����
create sequence seq_user
start with 1
nocache; 

drop sequence seq_user;

delete from t_user;

select * from t_user ORDER BY i_user ASC;

commit;

---------------------------
-- t_board4 ���̺� ���� (�Խ��� ����)
create table t_board4(
    i_board number primary key,
    title nvarchar2(100) not null,
    ctnt nvarchar2(2000) not null,
    hits number default 0,
    i_user number not null,
    r_dt date default sysdate,
    m_dt date default sysdate,
    foreign key(i_user) references t_user(i_user) on delete CASCADE
);

select * from t_user;

delete from t_user;

select * from t_board4;

delete from t_board4 where i_user = 2;

insert into t_board4
(i_board, title, ctnt, i_user)
values
(3, n'?', '����', 20);

drop table t_board4;

commit;

-----------------------------

SELECT A.i_board, A.title, A.ctnt, B.nm, A.r_dt, A.hits 
FROM t_board4 A
inner join t_user B
on A.i_user = B.i_user
WHERE A.i_board = 2
;

UPDATE t_board4 set title = '����' where i_board = 13;

commit;

delete from t_board4 where i_board=?;

UPDATE t_board4 SET title = '����', ctnt = '����' WHERE i_board = 13;

-----------------------------

UPDATE t_board4 SET hits = hits+1 WHERE i_board = 30;

commit;

-----------------------------

SELECT A.i_board, A.title, A.hits, B.nm, A.r_dt
FROM t_board4 A
INNER JOIN t_user B
ON A.i_user = B.i_user
ORDER BY i_board DESC; 

-------------------------------

-- �����丮 
 CREATE TABLE t_user_loginhistory (
    i_history number primary key,
    i_user number not null,
    ip_addr varchar2(15) not null,
    os varchar2(10) not null,
    browser varchar2(10) not null,
    r_dt date default sysdate,
    -- �ִ� ���� ���ٸ� default�� sysdate�� �ִ´�
    foreign key(i_user) references t_user(i_user)
    -- foreign key�� �߸��� ���� �ִ� �� ��������. (t_user�� �ִ� i_user ���� ��밡���ϴ�)
);


-- �����丮 ������
CREATE SEQUENCE seq_userloginhistory
nocache;

drop table t_user_loginhistory;

drop SEQUENCE seq_userloginhistory;

select * from t_user_loginhistory;

--����
INSERT INTO t_user_loginhistory 
(i_history, i_user, ip_addr, os, browser, r_dt)
VALUES (seq_userloginhistory.nextval, '1241', '15515', '1515', 'ddd', sysdate)
;

-- ���ƿ� ���̺� ���� : i_user, i_board, r_dt �ʿ���
-- �ܷ�Ű�� ������ִ� ���ڵ带 ������� CASCADE �����
CREATE TABLE t_board4_like (
    i_board number,
    i_user number,    
    r_dt date default sysdate,
    PRIMARY KEY(i_user,i_board),
    foreign key(i_user) references t_user(i_user) on delete CASCADE,
    foreign key(i_board) references t_board4(i_board) on delete CASCADE
);

drop table t_board4_like;

SELECT * FROM t_board4_like;

select * from t_user;

-- decode null�̾��ٸ� 0 null�� �ƴ϶�� 1 ���!
select A.*, C.nm, DECODE(B.i_user, null, 0, 1) as ynLike
from t_board4 A
LEFT JOIN t_board4_like B
ON A.i_board = B.i_board
AND B.i_user = 36
INNER JOIN t_user C
ON A.i_user = C.i_user
where A.i_board = 53;

insert into t_board4_like
(i_user, i_board)
values
(36,40);

commit;

select A.*, C.nm, DECODE(B.i_user, null, 0, 1) as yn_like,
(select count(*) from t_board4_like where i_board=53) AS likecnt
from t_board4 A
LEFT JOIN t_board4_like B
ON A.i_board = B.i_board
AND B.i_user = 36
INNER JOIN t_user C
ON A.i_user = C.i_user
where A.i_board = 53;

-- ���ƿ� ���� �������� (������)
select count(*) as likeCount from t_board4_like where i_board=53;

-- ���ƿ� ���� �������� (����Ʈ)
select count(*) as likeCount from t_board4_like group by i_board;

select * from t_board4;


SELECT A.i_board, A.title, A.hits, A.i_user, B.nm, A.r_dt
, (select count(*) from t_board4_like where i_board = A.i_board) as likecnt
FROM t_board4 A
INNER JOIN t_user B
ON A.i_user = B.i_user
ORDER BY i_board DESC;