-- Bạn hãy tìm ra những giảng viên là Super Teacher của khoa Data

SELECT * 
from TEACHER t 
where tMajor = 'data'

-- Bạn hãy tìm ra những học viên nào học cùng môn MC005, được dạy bởi giáo viên T0003

SELECT *
from ENROLLMENTS e 
where e.cID = 'MC005' and e.tID = 'T0003'

-- Bạn hãy tìm những học viên nào đăng ký các môn học thuộc khoa Data
SELECT * -- lấy thông tin của những học viên đó
from STUDENTS s 
WHERE s.sID in (
				SELECT e.sID  -- tìm mã học tham gia những lớp khóa data
				from ENROLLMENTS e 
				WHERE e.cID in (
								select cID -- tìm mã lớp thuộc khóa data
								from COURSE c 
								where c.cMajor = 'data'
								)
				)


-- Trong bảng ENROLLMENTS, có 1 số dữ liệu bị NULL ở cột tID, bạn hãy tìm ra chúng và thay thế lại thành giáo viên có mã GV là T0003
SELECT *, isnull(tID,'T0003')
from ENROLLMENTS e 

-- MySQL isnull sẽ đổi thành ifnull

select *, ifnull(tID,'T0003') 
from enrollments e 