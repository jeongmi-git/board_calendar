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

create table GAJA_SCECART(
	SCECART_NUM NUMBER NOT NULL,
	MEMBER_ID VARCHAR2(100) NOT NULL,
	CONTENTTYPEID NUMBER NOT NULL,
	CONTENTNAME VARCHAR2(100) NOT NULL,
	CONTENT_ID NUMBER NOT NULL
);

select * from GAJA_SCECART where member_id='USER00';
delete  from GAJA_SCECART where SCECART_NUM >1;
create SEQUENCE SEQ_GAJA_SCECART;
ALTER TABLE GAJA_SCECART ADD CONSTRAINT fk_gaja_scecart foreign key(MEMBER_ID) references member_table(MEMBER_ID);
ALTER TABLE GAJA_SCECART ADD CONSTRAINT pk_gaja_scecart primary key (SCECART_NUM);

create table member_table(
		MEMBER_ID VARCHAR2(100) primary key,
		USER_PASSWORD VARCHAR2(100) NOT NULL

);


INSERT INTO  member_table VALUES('USER00','1234');

create table GAJA_SCHEDULE (
	SCH_NUM NUMBER PRIMARY KEY,
	MEMBER_ID VARCHAR2(100) NOT NULL,
	SCECART_NUM NUMBER NOT NULL,
	SCH_YEAR NUMBER NOT NULL,
	SCH_MONTH NUMBER NOT NULL,
	SCH_DAY NUMBER NOT NULL
);


ALTER TABLE GAJA_SCHEDULE ADD CONSTRAINT FK_GAJA_SCHEDULE FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER_TABLE(MEMBER_ID);
ALTER TABLE GAJA_SCHEDULE ADD CONSTRAINT FK_GAJA_SCHEDULE FOREIGN KEY(SCECART_NUM) REFERENCES GAJA_SCECART(SCECART_NUM);


CREATE TABLE TBL_ATTACH(
	uuid VARCHAR2(100) NOT NULL,
	uploadPath varchar2(200) not null,
	fileName varchar2(100) not null,
	filetype char(1) default 'I',
	bno number(10,0)
);
alter table tbl_attach add constraint pk_attach primary key (uuid);
alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);

drop  table users purge;

create table users(
	username varchar2(50) not null primary key,
	password varchar2(50) not null,
	enabled char(1 )default '1'
);

create table authorities(
 username varchar2(50) not null,
 authority varchar2(50) not null,
 constraint fk_authorities_user foreign key(username) references users(username)
 );

 create unique index ix_auth_username on authorities (username, authority);

 drop index ix_auth_username;

 insert into users(username, password) values('user00','pw00');
 insert into users(username, password) values('member00','pw00');
 insert into users(username, password) values('admin00','pw00');
 
 
 insert into authorities(username, authority) values('user00','ROLE_USER');
 insert into authorities(username, authority) values('member00','ROLE_MANAGER');
 insert into authorities(username, authority) values('admin00','ROLE_MANAGER');
 insert into authorities(username, authority) values('admin00','ROLE_ADMIN');
 
-- 인증/ 권한을 위한 테이블
drop table tbl_member purge;

create table tbl_member(
	userid varchar2(50) not null primary key,
	userpw varchar2(100) not null,
	username varchar2(100) not null,
	regdate date default sysdate,
	updatedate date default sysdate,
	enabled char(1) default '1'
	
);

create table tbl_member_auth(
	userid varchar2(50) not null,
	auth varchar2(50) not null,
	constraint fk_member_auth foreign key (userid) references tbl_member(userid)
);

