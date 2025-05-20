create DATABASE Mindx_Lec_D4E113

use Mindx_Lec_D4E113

CREATE TABLE COURSE (
	cID char(5) COLLATE Latin1_General_CI_AS NULL,
	cMajor varchar(10) COLLATE Latin1_General_CI_AS NULL,
	cName varchar(30) COLLATE Latin1_General_CI_AS NULL
);

CREATE TABLE ENROLLMENTS (
	sID char(5) COLLATE Latin1_General_CI_AS NOT NULL,
	cID char(5) COLLATE Latin1_General_CI_AS NOT NULL,
	tID char(5) COLLATE Latin1_General_CI_AS NULL
);

CREATE TABLE LEARNING (
	sID char(5) COLLATE Latin1_General_CI_AS NOT NULL,
	cID char(5) COLLATE Latin1_General_CI_AS NOT NULL,
	score float NOT NULL
);


CREATE TABLE STUDENTS (
	sID char(5) COLLATE Latin1_General_CI_AS NULL,
	sFirstName varchar(10) COLLATE Latin1_General_CI_AS NULL,
	sLastName varchar(10) COLLATE Latin1_General_CI_AS NULL,
	sPhone char(10) COLLATE Latin1_General_CI_AS NULL,
	sAddress varchar(50) COLLATE Latin1_General_CI_AS NULL
);

CREATE TABLE TEACHERS (
	tID char(5) COLLATE Latin1_General_CI_AS NULL,
	tFirstName varchar(10) COLLATE Latin1_General_CI_AS NULL,
	tLastName varchar(10) COLLATE Latin1_General_CI_AS NULL,
	tPhone char(10) COLLATE Latin1_General_CI_AS NULL,
	tType int NULL,
	tMajor varchar(10) COLLATE Latin1_General_CI_AS NULL
);

INSERT INTO COURSE (cID,cMajor,cName) VALUES
	 (N'MC001',N'Data',N'D4E'),
	 (N'MC002',N'Data',N'BI'),
	 (N'MC003',N'Web',N'BE Basic'),
	 (N'MC004',N'Web',N'Web Basic'),
	 (N'MC005',N'Web',N'FullStack');

INSERT INTO ENROLLMENTS (sID,cID,tID) VALUES
	 (N'M0001',N'MC001',N'T0005'),
	 (N'M0002',N'MC002',N'T0006'),
	 (N'M0003',N'MC003',N'T0006'),
	 (N'M0004',N'MC004',N'T0002'),
	 (N'M0005',N'MC005',NULL),
	 (N'M0003',N'MC001',N'T0005'),
	 (N'M0006',N'MC002',N'T0006'),
	 (N'M0002',N'MC003',N'T0006'),
	 (N'M0002',N'MC004',N'T0002'),
	 (N'M0006',N'MC005',N'T0003');

INSERT INTO MIndX_Lec_1.dbo.LEARNING (sID,cID,score) VALUES
	 (N'M0001',N'MC001',4.2),
	 (N'M0002',N'MC002',3.8),
	 (N'M0003',N'MC003',6.5),
	 (N'M0004',N'MC004',2.2),
	 (N'M0005',N'MC005',5.0),
	 (N'M0003',N'MC001',8.4),
	 (N'M0006',N'MC002',6.8),
	 (N'M0002',N'MC003',9.2),
	 (N'M0002',N'MC004',7.4),
	 (N'M0006',N'MC005',5.5);

INSERT INTO MIndX_Lec_1.dbo.STUDENTS (sID,sFirstName,sLastName,sPhone,sAddress) VALUES
	 (N'M0001',N'Minh',N'Nguyen',N'0323456789',N'Quang Binh'),
	 (N'M0002',N'Hai',N'Do',N'0143456789',N'Ha Nôi'),
	 (N'M0003',N'Bao',N'Nguyen',N'0123656789',N'Quang Binh'),
	 (N'M0004',N'Thuan',N'Tran',N'0123456289',N'Sai Gon'),
	 (N'M0005',N'Thao',N'Doan',N'0223456589',N'Sai Gon'),
	 (N'M0006',N'Giau',N'Le',N'0723456459',N'Binh Phuoc'),
	 (N'M0007',N'Khoa',N'Tran',N'0343452780',N'Dong Nai');

INSERT INTO MIndX_Lec_1.dbo.TEACHERS (tID,tFirstName,tLastName,tPhone,tType,tMajor) VALUES
	 (N'T0003',N'Khoa',N'Dao',N'0113656789',0,N'Data'),
	 (N'T0005',N'Nghia',N'Cao',N'0562456590',0,N'Data'),
	 (N'T0006',N'Ha',N'San',N'0783456459',1,N'Data');



