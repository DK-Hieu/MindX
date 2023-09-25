CREATE database test
GO;

use test
GO;
-- Tạo bảng

CREATE table STUDENTSS (
	sID CHAR(5) not null, 
	sFirstName VARCHAR(10),
	sLastName VARCHAR(10),
	sPhone CHAR(10),
	sAddress VARCHAR(50),
	CONSTRAINT PK_STUDENTSS PRIMARY KEY (sID)
)
GO;

create table COURSE (
	cID CHAR(5) not null,
	cMajor VARCHAR(10),
	cName VARCHAR(30),
	CONSTRAINT PK_COURSE PRIMARY KEY (cID)
)
GO;

create table TEACHER (
	tID CHAR(5) not null,
	tFirstName VARCHAR(10),
	tLastName VARCHAR(10),
	tPhone CHAR(10),
	tType int,
	tMajor VARCHAR(10),
	CONSTRAINT PK_TEACHER PRIMARY KEY (tID)
)
GO;

CREATE TABLE ENROLLMENTS(
   sID CHAR(5) NOT NULL
  ,cID CHAR(5) NOT NULL
  ,tID CHAR(5)
)
GO;

CREATE TABLE LEARNING(
   sID   CHAR(5) NOT NULL
  ,cID   CHAR(5) NOT NULL
  ,score float NOT NULL
)
GO;

-- Tạo quan hệ 

ALTER TABLE ENROLLMENTS 
ADD CONSTRAINT STUDENTS_sID_FK_STUDENTS
FOREIGN KEY (sID) REFERENCES STUDENTSS(sID)
GO;

ALTER TABLE ENROLLMENTS 
ADD CONSTRAINT TEACHER_tID_FK_TEACHER
FOREIGN KEY (tID) REFERENCES TEACHER(tID)
GO;


ALTER TABLE ENROLLMENTS 
ADD CONSTRAINT COURSE_sID_FK_COURSE
FOREIGN KEY (cID) REFERENCES COURSE(cID)
GO;


ALTER TABLE LEARNING 
ADD CONSTRAINT COURSE_sID_FK_LEARNING
FOREIGN KEY (cID) REFERENCES COURSE(cID)
GO;


ALTER TABLE LEARNING 
ADD CONSTRAINT STUDENTSS_sID_FK_LEARNING
FOREIGN KEY (sID) REFERENCES STUDENTSS(sID)
GO;
--
--ALTER TABLE COURSE
--  ADD CONSTRAINT FK_MAJOR_TO_COURSE
--    FOREIGN KEY (cMajor)
--    REFERENCES MAJOR (cMajor, tMajor);
--
--ALTER TABLE TEACHER
--  ADD CONSTRAINT FK_MAJOR_TO_TEACHER
--    FOREIGN KEY (tMajor)
--    REFERENCES MAJOR (cMajor, tMajor);


insert INTO STUDENTSS
values
('M0001', 'Minh', 'Nguyen', '0323456789', 'Quang Binh'),
('M0002', 'Hai', 'Do', '0143456789', N'Ha Nôi'),
('M0003', 'Bao', 'Nguyen', '0123656789', 'Quang Binh'),
('M0004', 'Thuan', 'Tran', '0123456289', 'Sai Gon'),
('M0005', 'Thao', 'Doan', '0223456589', 'Sai Gon'),
('M0006', 'Giau', 'Le', '0723456459', 'Binh Phuoc'),
('M0007', 'Khoa', 'Tran', '0343452780', 'Dong Nai')
GO;

insert into COURSE
values
('MC001', 'Data', 'D4E'),
('MC002', 'Data', 'BI'),
('MC003', 'Data', 'BE Basic'),
('MC004', 'Web', 'Web Basic'),
('MC005', 'Web', 'FullStack'),
('MC006', 'Finance', 'FM Basic'),
('MC007', 'Finance', 'FM Intensive')
GO;

insert into TEACHER
values
('T0001', 'Bao', 'Nguyen', '0233456789', 1, 'Finance'),
('T0002', 'Duy', 'Vo', '0233456789', 1, 'Web'),
('T0003', 'Khoa', 'Dao', '0113656789', 0, 'Web'),
('T0004', 'Phuoc', 'Nguyen', '0347456289', 0, 'Finance'),
('T0005', 'Nghia', 'Cao', '0562456590', 0, 'Data'),
('T0006', 'Ha', 'San', '0783456459', 1, 'Data')
GO;


INSERT INTO ENROLLMENTS(sID,cID,tID)
VALUES 
('M0001','MC001','T0005'),
('M0002','MC002','T0006'),
('M0003','MC003','T0006'),
('M0004','MC004','T0002'),
('M0005','MC005',NULL),
('M0003','MC001','T0005'),
('M0006','MC002','T0006'),
('M0002','MC003','T0006'),
('M0002','MC004','T0002'),
('M0006','MC005','T0003'),
('M0004','MC001','T0005'),
('M0001','MC002','T0006'),
('M0006','MC003',NULL),
('M0006','MC004','T0002'),
('M0002','MC005','T0003'),
('M0002','MC006',NULL)
GO;

INSERT INTO LEARNING
VALUES 
('M0001','MC001',4.2),
('M0002','MC002',3.8),
('M0003','MC003',6.5),
('M0004','MC004',2.2),
('M0005','MC005',5.0),
('M0003','MC001',8.4),
('M0006','MC002',6.8),
('M0002','MC003',9.2),
('M0002','MC004',7.4),
('M0006','MC005',5.5),
('M0004','MC001',8.4),
('M0001','MC002',4.8),
('M0006','MC003',9.8),
('M0006','MC004',4.3),
('M0002','MC005',4.6),
('M0002','MC006',2.2)
GO;

-- Dữ liệu bổ sung --

INSERT INTO LEARNING(sID,cID,score) VALUES ('M0010','MC003',7.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0010','MC005',5.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0017','MC001',7.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC002',3.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0028','MC002',5.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC001',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0035','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC001',4.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC006',2.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC005',6.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC006',0.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC001',1.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC006',0.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0011','MC005',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0033','MC007',2.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0019','MC005',9.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC005',2.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0028','MC007',4.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC001',8.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC003',9.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC007',1.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC004',6.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0035','MC007',6.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC007',7.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC001',0.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC007',1.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0021','MC003',7.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC002',3.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC001',4.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC002',7.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC002',9.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0018','MC005',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC001',1.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0011','MC007',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC003',4.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC005',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0037','MC002',9.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0009','MC003',0.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0016','MC003',9.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0031','MC003',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0027','MC007',5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0025','MC004',8.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0036','MC006',0.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC007',0);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC003',8.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0010','MC004',8.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0028','MC007',2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0016','MC006',0.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC004',3.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC005',1.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC001',2.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC003',8.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0023','MC001',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC001',6.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC003',6.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0011','MC001',6.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0022','MC003',3.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC005',7.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0033','MC002',2.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC002',6.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC005',2.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC004',3.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC007',6.1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC001',5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0020','MC001',4.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0014','MC004',3.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0037','MC007',3.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC001',3.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0016','MC001',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0032','MC002',9.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC003',3.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC003',1.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0036','MC007',1.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0023','MC002',0.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0019','MC005',2.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC004',9.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0015','MC001',3.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0027','MC003',1);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC005',9.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC002',5.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0017','MC003',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0030','MC004',1.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0026','MC005',8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0031','MC003',7.9);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0017','MC001',7.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0034','MC004',2.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0024','MC004',10);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0037','MC007',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0021','MC002',1.4);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0019','MC001',2.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0009','MC007',4.6);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC007',4.5);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0018','MC005',5.8);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0029','MC005',0.3);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0012','MC005',5.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0023','MC004',6.7);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0008','MC001',1.2);
INSERT INTO LEARNING(sID,cID,score) VALUES ('M0009','MC001',7);

INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0008','Minh','Nguyen','0912345678','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0009','Linh','Tran','0987654321','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0010','Hoang','Le','0901234567','Da Nang');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0011','Thao','Pham','0976543210','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0012','Binh','Hoang','0923456789','Hai Phong');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0013','Huong','Nguyen','0967890123','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0014','Nam','Tran','0945678901','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0015','Quang','Ly','0934567890','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0016','Lan','Dang','0956789012','Da Nang');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0017','Tu','Vo','0989012345','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0018','Hai','Nguyen','0910123456','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0019','Anh','Tran','0943210765','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0020','Duc','Le','0965432109','Da Nang');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0021','Hanh','Hoang','0921098765','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0022','Hung','Phan','0978901234','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0023','Hong','Nguyen','0932109876','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0024','Tien','Tran','0909876543','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0025','My','Ly','0912345670','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0026','Tam','Do','0987654320','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0027','Thanh','Vuong','0943210789','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0028','Trang','Le','0965432108','Da Nang');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0029','Quynh','Tran','0921098764','Da Nang');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0030','Duc','Pham','0978901236','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0031','Thuy','Le','0932109875','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0032','Hung','Nguyen','0909876541','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0033','Thuy','Hoang','0912345672','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0034','Tan','Tran','0987654323','Ho Chi Minh City');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0035','Thanh','Ly','0943210786','Hanoi');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0036','Ngoc','Dang','0965432105','Da Nang');
INSERT INTO STUDENTS(sID,sFirstName,sLastName,sPhone,sAddress) VALUES ('M0037','Duong','Vo','0921098769','Ho Chi Minh City');


