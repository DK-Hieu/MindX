use MindX_Lec_1

-- Bạn hãy tìm ra tất cả mã học viên, tên học viên có đăng ký môn học

SELECT *
from STUDENTS s 
WHERE s.sID in (SELECT sID
				from ENROLLMENTS e)

select DISTINCT s.sID , s.sFirstName , s.sLastName 
from STUDENTS s 
join ENROLLMENTS e 
on s.sID = e.sID 


select e.sID, s.sFirstName , s.sLastName, e.cID 
from STUDENTS as s 
inner join ENROLLMENTS as e 
on s.sID = e.sID 

-- Bạn hãy tìm thông tin của những học viên nào không đăng ký môn học 

SELECT *
from STUDENTS s 
WHERE s.sID not in (SELECT sID
				    from ENROLLMENTS e)
				    
select DISTINCT s2.sID , s2.sFirstName , s2.sLastName 
from STUDENTS s 
join ENROLLMENTS e 
on s.sID = e.sID 
	RIGHT join STUDENTS s2 
	on e.sID = s2.sID 
where e.sID is null

SELECT *
from LEARNING l 
right join STUDENTS s 
on l.sID = s.sID 
WHERE l.sID is null

-- Bạn hãy tìm những môn học không có học viên nào đăng ký.
SELECT *
from COURSE c 
join ENROLLMENTS e 
on c.cID = e.cID 
	RIGHT join COURSE c2 
	on c2.cID = e.cID 
WHERE e.cID is null 

select *
from ENROLLMENTS e 
right join COURSE c 
on e.cID = c.cID 
where e.cID is NULL

select *
from COURSE c2  
WHERE c2.cID  not in (
					select e.cID
					from ENROLLMENTS e 
					)

/* Bạn hãy tìm ra thông tin gồm mã học viên, tên học viên, SĐT của những học viên nào trượt môn. 
 * Biết rằng điểm < 4 sẽ trượt môn học */

SELECT *
from STUDENTS s  
join LEARNING l 
on s.sID = l.sID 
WHERE l.score < 4

-- Hãy tìm ra thông tin học viên có điểm tổng kết môn cao\thấp nhất

SELECT * -- lỗi
from LEARNING l, 
	 (select Max(l.score) 'score_max'
	 from LEARNING l) as A
--join STUDENTS s 
--on l.sID = s.sID 
where l.score >= A.score_max

select *
from (select Max(l.score) 'score_max'
	  from LEARNING l) as A ,
	 LEARNING l 
join STUDENTS s 
on s.sID = l.sID 
where l.score >= A.score_max;

select * 
from LEARNING l2 ,(select max(l.score) 'max_score'
				   from LEARNING l) as A 
WHERE l2.score = A.max_score

select * 
from (select max(l.score) 'max_score'
	  from LEARNING l) as A, LEARNING l2
join STUDENTS s 
on s.sID = l2.sID 
WHERE l2.score = A.max_score


--------------------------------------------------------------------------------------------------
select *
from (
	  select max(l.score) max_s
	  		,min(l.score) min_s
	  from LEARNING l 
	  ) as mx
	  ,LEARNING l 
join STUDENTS s 
on s.sID = l.sID 
where l.score = mx.max_s 
   or l.score = mx.min_s

				  
/* Môn có học viên học điểm thấp nhất là môn nào? Sau đó bạn hãy lấy ra danh sách các học viên học cùng môn đó với học viên có điểm thấp nhất, 
 * và đánh giá sơ bộ nguyên nhân đến từ học viên hay do chất lượng giáo viên? (Xem hướng dẫn câu 9 ở phần speaker note).
 * => lý do có thể từ giáo viên
 */

select *
from LEARNING l 
WHERE l.cID  = (
				select l.cID 
				from (
					  select min(l.score) min_s
					  from LEARNING l 
					  ) as mx
					  ,LEARNING l 
				join COURSE c 
				on c.cID = l.cID 
				WHERE l.score = mx.min_s
			   )


SELECT *
from STUDENTS s 
join ENROLLMENTS e  
on s.sID = e.sID 
WHERE e.cID in (
				SELECT cID
				from LEARNING l
				where l.score = (select min(l.score) 'score_max'
					 		     from LEARNING l)
				)










