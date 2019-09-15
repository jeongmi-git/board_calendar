drop table tbl_board purge;
drop table TBL_REPLY purge;
drop table tbl_ATTACH purge;
drop table tbl_MEMBER purge;
drop table tbl_MEMBER_AUTH purge;
drop table PERSISTENT_LOGINS purge;
SELECT * FROM SCOTT;
SELECT * FROM TBL_BOARD;
SELECT * FROM USER_TABLES;

DROP SEQUENCE SEQ_BOARD;

CREATE SEQUENCE SEQ_BOARD;

CREATE TABLE TBL_BOARD(
	BNO NUMBER(10,0),
	Title VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	Writer VARCHAR2(50) NOT NULL,
	REGDATE DATE DEFAULT SYSDATE,
	UPDATEDATE DATE DEFAULT SYSDATE
);

ALTER TABLE TBL_BOARD ADD CONSTRAINT PK_BOARD PRIMARY KEY (BNO);

insert into tbl_board(bno, title, content, writer) values(seq_board.nextval,'텍스트 제목','텍스트 내용','user00');

create table tbl_reply(
	rno number(10,0),
	bno number(10,0) not null,
	reply varchar2(1000) not null,
	replyer varchar2(50) not null,
	replyDate date default sysdate,
	updateDate date default sysdate
);

drop  SEQUENCE seq_reply;
create SEQUENCE seq_reply;

alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board(bno);

select * from tbl_board where rownum < 10 order by bno desc;