use D4E
/* Truy xuất các name của tất cả employee có sex là male 
trong Department “Research” mà làm cho ít nhất một project 
nhiều hơn 10 giờ một tuần.*/

/*
select Fname, Sex, Dname, Pno, sum([Hours]) as 'Total_house'
from DEPARTMENT de 
left join employee em
on de.Dnumber = em.Dno
    left join WORKS_ON wo
    on wo.Essn = em.Ssn
where Dname = 'Research' and em.Sex = 'M'
GROUP by Fname, Sex, Dname, Pno 
having sum([Hours]) > 10
*/

/*Tìm tên của tất cả employee được giám sát trực tiếp bởi 
manager của phòng ban “Research”.*/

/*
select Dname, Mgr_ssn, Fname, SSN, Super_ssn  
from DEPARTMENT de 
left join employee em
on de.Dnumber = em.Dno
where Dname = 'Research'
*/


/*Với mỗi project, liệt kê tên project, 
và tổng số giờ một tuần mà tất cả nhân viên 
phải làm cho project đó.*/

/*
SELECT pj.Pnumber,pj.Pname, sum(wo.[Hours]) 'Total_house_pj'
from PROJECT pj
full join WORKS_ON wo 
on pj.Pnumber = wo.Pno
GROUP by pj.Pnumber,pj.Pname */

/* Với mỗi phòng ban, liệt kê tên phòng ban và tên của tất cả 
các employee làm việc cho phòng ban đó. */

/*
SELECT dm.Dnumber, dm.Dname, em.Fname
from DEPARTMENT dm 
full join EMPLOYEE em 
on dm.Dnumber = em.Dno
*/

/*Liệt kê tên của tất cả employee không làm bất cứ project 
nào ở “Houston”.*/

/*
SELECT *
from EMPLOYEE e 
WHERE e.Ssn not in (SELECT em.Ssn
				    from DEPARTMENT dm 
				    full join EMPLOYEE em 
				    on dm.Dnumber = em.Dno
				        full join DEPT_LOCATIONS dls 
				        on dls.Dnumber = dm.Dnumber
				    where Dlocation = 'Houston')
*/
/*
with Houston as (
    SELECT dm.Dnumber, dm.Dname, em.Ssn,em.Fname , dls.Dlocation
    from DEPARTMENT dm 
    full join EMPLOYEE em 
    on dm.Dnumber = em.Dno
        full join DEPT_LOCATIONS dls 
        on dls.Dnumber = dm.Dnumber
    where Dlocation = 'Houston')
SELECT * 
from EMPLOYEE e
left join Houston hs 
on e.Ssn = hs.Ssn
where hs.Ssn is null
*/

/*Liệt kê tên của tất cả employee làm việc cho tất cả các project ở “Houston”.*/

select *
from EMPLOYEE el
where el.Ssn in (select Essn
				from PROJECT pj
				join WORKS_ON wo
				on pj.Pnumber = wo.Pno
				where pj.Plocation = 'Houston')

/*Tìm các employee có tổng số dự án tham gia nhiều nhất trong công ty.*/
select em.Ssn,Fname, COUNT(pj.Pnumber) 'pj_total_num'
from EMPLOYEE em
right join WORKS_ON wo
on em.Ssn = wo.Essn
	join PROJECT pj
	on wo.Pno = pj.Pnumber
group by em.Ssn,Fname
order by pj_total_num desc

/*Liệt kê tên các employee có lương cao nhất trong mỗi phòng ban.*/
with 
	a as(
		select dp.Dnumber, dp.Dname, max(em.Salary) 'max_salary'
		from EMPLOYEE em
		join DEPARTMENT dp
		on em.Dno = dp.Dnumber
		group by dp.Dnumber, dp.Dname)
select * 
from EMPLOYEE em
right join a 
on em.Dno = a.Dnumber

/*Với mỗi phòng ban, tìm các employee có tổng số dự án tham gia nhiều nhất trong phòng ban đó*/
with 
	b as (
		select em.Ssn,em.Dno,count(wo.Pno) 'pj_count'
		from EMPLOYEE em
		join WORKS_ON wo
		on em.Ssn = wo.Essn
		group by em.Ssn,em.Dno),
	c as (
		select dp.Dname,dp.Dnumber, max(b.pj_count) 'max_pj_count'
		from DEPARTMENT dp
		join b
		on dp.Dnumber = b.Dno
		group by dp.Dname,dp.Dnumber)
select *
from c
join EMPLOYEE em
on c.Dnumber = em.Dno
order by c.Dnumber

/*Liệt kê last name của tất cả các manager của các department nhưng không tham gia project nào*/

with 
	d as (
			select *
			from EMPLOYEE em
			where em.Ssn in (select dp.Mgr_ssn
							 from DEPARTMENT dp))
select *
from d 
where d.Ssn in (select wo.Essn
				from WORKS_ON wo
				where wo.Hours is null)



with 
	d as (
			select *
			from EMPLOYEE em
			where em.Ssn in (select dp.Mgr_ssn
							 from DEPARTMENT dp))
select *
from d 
join WORKS_ON wo
on d.Ssn = wo.Essn
where wo.Hours is null

/* II cập nhật dữ liệu*/
/*Nhân viên có mã là “123456789” thay đổi địa chỉ thành “123 Lý Thường Kiệt F.14 Q.10”*/
update EMPLOYEE
set address = '123 Lý Thường Kiệt F.14 Q.10'
where Ssn = '123456789'

/*Mối quan hệ của nhân viên “Franklin” với người phụ thuộc “Joy” thay đổi thành “Friend”*/
update DEPENDENT
set Relationship = 'Friend'
where Dependent_name = 'Joy' and Essn = (select em.Ssn
										 from EMPLOYEE em
										 where em.Fname = 'Franklin')

/*Tất cả nhân viên của phòng ban có ít nhất một vị trí ở “Houston” được tăng lương gấp đôi*/


/*Trừ 5% lương cho các nhân viên có tổng số dự án tham gia ít hơn 2*/
