CREATE database test

use test

CREATE table STUDENTS (
	sID CHAR(5) not null, 
	sFirstName VARCHAR(10),
	sLastName VARCHAR(10),
	sPhone CHAR(10),
	sAddress VARCHAR(50),
	CONSTRAINT PK_STUDENTS PRIMARY KEY (sID)
)

create table COURSE (
	cID CHAR(5) not null,
	cMajor VARCHAR(10),
	cName VARCHAR(30),
	CONSTRAINT PK_COURSE PRIMARY KEY (cID)
)

create table TEACHER (
	tID CHAR(5) not null,
	tFirstName VARCHAR(10),
	tLastName VARCHAR(10),
	tPhone CHAR(10),
	tType int,
	tMajor VARCHAR(10),
	CONSTRAINT PK_TEACHER PRIMARY KEY (tID)
)

CREATE TABLE ENROLLMENTS(
   sID CHAR(5) NOT NULL
  ,cID CHAR(5) NOT NULL
  ,tID CHAR(5)
)

CREATE table MAJOR (
	cMajor VARCHAR(10) NOT NULL,
	tMajor VARCHAR(10) NOT NULL,
	CONSTRAINT PK_MAJOR PRIMARY KEY (cMajor, tMajor)
)

ALTER TABLE ENROLLMENTS 
ADD CONSTRAINT Student_sID_FK_Student
FOREIGN KEY (sID) REFERENCES STUDENTS(sID);

ALTER TABLE ENROLLMENTS 
ADD CONSTRAINT TEACHER_tID_FK_TEACHER
FOREIGN KEY (tID) REFERENCES TEACHER(tID);

ALTER TABLE ENROLLMENTS 
ADD CONSTRAINT COURSE_sID_FK_COURSE
FOREIGN KEY (cID) REFERENCES COURSE(cID);
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

insert INTO STUDENTS
values
('M0001', 'Minh', 'Nguyen', '0323456789', 'Quang Binh'),
('M0002', 'Hai', 'Do', '0143456789', N'Ha Nôi'),
('M0003', 'Bao', 'Nguyen', '0123656789', 'Quang Binh'),
('M0004', 'Thuan', 'Tran', '0123456289', 'Sai Gon'),
('M0005', 'Thao', 'Doan', '0223456589', 'Sai Gon'),
('M0006', 'Giau', 'Le', '0723456459', 'Binh Phuoc'),
('M0007', 'Khoa', 'Tran', '0343452780', 'Dong Nai')

insert into COURSE
values
('MC001', 'Data', 'D4E'),
('MC002', 'Data', 'BI'),
('MC003', 'Data', 'BE Basic'),
('MC004', 'Web', 'Web Basic'),
('MC005', 'Web', 'FullStack'),
('MC006', 'Finance', 'FM Basic'),
('MC007', 'Finance', 'FM Intensive')

insert into TEACHER
values
('T0001', 'Bao', 'Nguyen', '0233456789', 1, 'Finance'),
('T0002', 'Duy', 'Vo', '0233456789', 1, 'Web'),
('T0003', 'Khoa', 'Dao', '0113656789', 0, 'Web'),
('T0004', 'Phuoc', 'Nguyen', '0347456289', 0, 'Finance'),
('T0005', 'Nghia', 'Cao', '0562456590', 0, 'Data'),
('T0006', 'Ha', 'San', '0783456459', 1, 'Data')


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