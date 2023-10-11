use AWS2019

/* Dựa vào bảng CUSTOMER_GROUP, WAIT_TIME đã tạo trong bài trước
Bạn hãy viết các đoạn truy vấn dùng SubQuery để tìm ra các thông tin sau:   
  > Tìm ra những khách hàng nào nhận hàng lâu nhất?
  > Có bao nhiêu đơn hàng mua hàng có giá trị cao hơn giá trị đơn hàng trung bình của tất cả đơn hàng? */


with 
	A as (
		SELECT CustomerID , max(wait_time) 'maxtime_each_cus'
		from WAIT_TIME wt 
		group by wt.CustomerID )
SELECT *
from CUSTOMER_GROUP cg 
join A 
on cg.CustomerID = A.CustomerID

/* Dựa vào bảng SalesOrderDetail, ProductSubcategory, Product.
Hãy tìm ra tổng doanh số của từng Category.*/

with 
	B as (
		SELECT p.ProductID, p.ProductSubcategoryID , ps.ProductCategoryID 
		from Product p 
		join ProductSubcategory ps 
		on ps.ProductSubcategoryID = p.ProductSubcategoryID )
select ProductCategoryID, sum(sod.LineTotal)
from SalesOrderDetail sod 
join B
on sod.ProductID = B.ProductID
GROUP by ProductCategoryID


/* Hãy tìm ra SubCategory mang lại doanh thu nhiều nhất của mỗi loại Category */

with 
	B as (
		SELECT p.ProductSubcategoryID , ps.ProductCategoryID , sum(sod2.LineTotal) 'SubCategory_Total'
		from Product p 
		join ProductSubcategory ps 
		on ps.ProductSubcategoryID = p.ProductSubcategoryID 
			join SalesOrderDetail sod2 
			on sod2.ProductID = p.ProductID
		group by p.ProductSubcategoryID , ps.ProductCategoryID
			)
select ProductCategoryID,  max(B.SubCategory_Total)
from B 
group by ProductCategoryID


with 
	B as (
		SELECT  C.ProductCategoryID, max(SubCategory_Total) 'max_LineTotal'
		from 
			(SELECT ps.ProductCategoryID, p.ProductSubcategoryID , sum(sod2.LineTotal) 'SubCategory_Total'
			from Product p 
			join ProductSubcategory ps 
			on ps.ProductSubcategoryID = p.ProductSubcategoryID 
				join SalesOrderDetail sod2 
				on sod2.ProductID = p.ProductID
			group by ps.ProductCategoryID, p.ProductSubcategoryID ) as C
		group by C.ProductCategoryID
			),
	D as (
			SELECT ps.ProductCategoryID, p.ProductSubcategoryID , sum(sod2.LineTotal) 'SubCategory_Total'
			from Product p 
			join ProductSubcategory ps 
			on ps.ProductSubcategoryID = p.ProductSubcategoryID 
				join SalesOrderDetail sod2 
				on sod2.ProductID = p.ProductID
			group by ps.ProductCategoryID, p.ProductSubcategoryID 
	      )
select DISTINCT D.ProductCategoryID, D.ProductSubcategoryID , B.max_LineTotal
from B
left join D
on D.ProductCategoryID = B.ProductCategoryID and B.max_LineTotal = D.SubCategory_Total


/*   Với CSDL “MindX_Lec_1”:
Bạn hãy thực hiện các yêu cầu sau:
 
	> Xây dựng VIEW để tìm danh sách học viên đăng ký các môn học thuộc khoa Data
	> Xây dựng VIEW để tìm danh sách học viên đăng ký các môn học thuộc khoa Web
	> Xây dựng VIEW để tìm ra những giảng viên có tham gia giảng dạy nhiều hơn 2 môn học.
	> Tìm ra những sinh viên có điểm tổng kết môn học cao nhất, thấp nhất của 2 khoa kể trên

(Bài tập nâng cao) Dựa vào các thông tin bạn đã làm tìm ra ở các bài học trước như khoảng chênh lệch điểm, 
số lượng sinh viên đạt loại giỏi, khá, trung bình, … Hãy thử suy luận và đưa ra các kết luận về tình trạng học viên - giảng dạy.*/

use MindX_Lec_1

/* > Xây dựng VIEW để tìm danh sách học viên đăng ký các môn học thuộc khoa Data */

SELECT s.sID, s.sFirstName , s.sLastName 
from ENROLLMENTS e 
join COURSE c 
on e.cID = c.cID 
	join STUDENTS s 
	on s.sID = e.sID
where c.cMajor = 'Data'

/* > Xây dựng VIEW để tìm danh sách học viên đăng ký các môn học thuộc khoa Web */

SELECT s.sID, s.sFirstName , s.sLastName 
from ENROLLMENTS e 
join COURSE c 
on e.cID = c.cID 
	join STUDENTS s 
	on s.sID = e.sID
where c.cMajor = 'Web'

/* > Xây dựng VIEW để tìm ra những giảng viên có tham gia giảng dạy nhiều hơn 2 môn học.*/

with A as 
	(
	select t.tID ,COUNT(DISTINCT e.cID) course_total
	from TEACHER t 
	join ENROLLMENTS e 
	on t.tID = e.tID 
	group by t.tID 
	)
select *
from A 
join TEACHER t 
on A.tID = t.tID 
where A.course_total > 1

/* > Tìm ra những sinh viên có điểm tổng kết môn học cao nhất, thấp nhất của 2 khoa kể trên */

with 
	A as (
		SELECT s.sID, s.sFirstName , c.cMajor , avg(l.score) 'avg_score'
		from STUDENTS s 
		join LEARNING l 
		on s.sID = l.sID 
			join COURSE c 
			on c.cID = l.cID 
		group by s.sID, s.sFirstName , c.cMajor 
		having c.cMajor in ('Data','Web')
	)
SELECT *
from (select A.cMajor , max(A.avg_score) 'maxmin_avg_score'
	  from A 
	  group by A.cMajor) as B1, A
where B1.cMajor = A.cMajor and A.avg_score = B1.maxmin_avg_score
union
SELECT *
from (select A.cMajor , min(A.avg_score) 'maxmin_avg_score'
	  from A 
	  group by A.cMajor) as B2, A
where B2.cMajor = A.cMajor and A.avg_score = B2.maxmin_avg_score

-- BTVN 
/* Đề bài : Các phòng ban trong công ty khá đa dạng, BOD muốn bạn xây dựng cho mỗi phòng ban một VIEW của riêng họ để chỉ lấy ra các nhân viên thuộc về phòng ban đó. 
Bạn hãy thực hiện yêu cầu của BOD
Tài liệu sử dụng để làm bài : 
Bảng NHANVIEN trong database MX */

use CtyMX

CREATE view vHeadOffice as 
select *
from NHANVIEN n 
WHERE  DepID = 1

CREATE view vTaichinh as
select *
from NHANVIEN n 
WHERE  DepID = 2

/* Đề bài : Bạn hãy tìm ra khoảng chênh lệch doanh số của nhân viên bán hàng có doanh số cao nhất, 
 * nhân viên có doanh số thấp nhất với trung bình doanh số bán hàng của tất cả các salesman.
 */

with 
	HD as (
		SELECT HDF.SalesID, sum(TotalLine) 'TotalLine_SalesID'
		from (
			SELECT *
			from HOADON h 
			union 
			select *
			from HOADONMOI h) as HDF
		group by HDF.SalesID
	)
SELECT *
from HD
join (select max(TotalLine_SalesID) 'Max_Min_Sales' , avg(TotalLine_SalesID) 'AVG Sales', max(TotalLine_SalesID) - avg(TotalLine_SalesID) 'Range'
	  from HD) as HD1
on HD.TotalLine_SalesID = HD1.Max_Min_Sales
union 
SELECT *
from HD
join (select min(TotalLine_SalesID) 'Max_Min_Sales' , avg(TotalLine_SalesID) 'AVG Sales', min(TotalLine_SalesID) - avg(TotalLine_SalesID) 'Range'
	  from HD) as HD2
on HD.TotalLine_SalesID = HD2.Max_Min_Sales


/* Đề bài : Với mỗi sản phẩm, bạn hãy tìm ra khách hàng nào mua nó nhiều nhất */

with ft as(
	select ProductID ,CusID , sum(QTY) 'Total_Order'
	from (
		SELECT *
		from HOADON h 
		union 
		select *
		from HOADONMOI h) as HDF
	group by ProductID ,CusID 
	)
SELECT ft.ProductID, ft.CusID, ft.Total_Order, ft1.Total_Order_max
from ft 
right join (
	SELECT ft.ProductID ,max(Total_Order) 'Total_Order_max'
	from ft
	group by ft.ProductID) as ft1
on ft.ProductID = ft1.ProductID
where ft.Total_Order = ft1.Total_Order_max

/* Với mỗi category, hãy tìm chênh lệch doanh số bán hàng của sản phẩm mang lại doanh số cao nhất và thấp nhất của category đó */

with 
	A as (
		select ProductID , sum(TotalLine) 'TotalLine_sum'
		from (
			SELECT *
			from HOADON h 
			union 
			select *
			from HOADONMOI h) as HDF
		group by ProductID ),
	B as (
		select ProductID, s.ProductCategoryID 
		from SANPHAM s 
		)
select B.ProductCategoryID, max(TotalLine_sum) 'max_TotalLine', min(TotalLine_sum) 'min_TotalLine' ,
	   max(TotalLine_sum) -  min(TotalLine_sum) 'range'
from A
join B 
on A.ProductID = B.ProductID
group by B.ProductCategoryID








