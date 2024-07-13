CREATE database MindX_Lec_1

use MindX_Lec_1

CREATE table STUDENTS (
	sID CHAR(5), 
	sFirstName VARCHAR(10),
	sLastName VARCHAR(10),
	sPhone CHAR(10),
	sAddress VARCHAR(50)
)

create table COURSE (
	cID CHAR(5),
	cMajor VARCHAR(10),
	cName VARCHAR(30)
)

create table TEACHER (
	tID CHAR(5),
	tFirstName VARCHAR(10),
	tLastName VARCHAR(10),
	tPhone CHAR(10),
	tType int,
	tMajor VARCHAR(10)
)

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

exec sp_columns 'TEACHER'

exec sp_columns 'COURSE'

select * 
from STUDENTS s 
WHERE sAddress = 'Nghe An'

select * 
from COURSE c 

select * 
from TEACHER t 
where tMajor = 'Mentor'

select * 
from TEACHER t 
where tMajor = 'Super Teacher'

DELETE from TEACHER 
where tMajor = 'Finance'

DELETE from COURSE 
where cMajor = 'Finance'

UPDATE COURSE
set cName = 'Web'
WHERE cName = 'BE Basic'

DELETE from TEACHER 
where tFirstName = 'Bao'

UPDATE TEACHER
set tMajor = 'Data'
WHERE tFirstName = 'Phuoc'

