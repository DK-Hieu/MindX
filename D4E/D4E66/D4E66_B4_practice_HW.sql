/* Với bảng SalesOrderHeader:
1. Với cột TaxAmt, bạn hãy sử dụng CASE WHEN để thêm 1 cột truy vấn Order_Type (loại giá trị đơn hàng) có kết quả:
Giá trị TaxAmt < 500 : Low Order
Giá trị 500 <= TaxAmt < 2000: Medium Order
Giá trị TaxAmt >= 2000 : High Order */

use AWS2019

SELECT *,
	CASE 
		when soh.TaxAmt >= 2000 then 'High Order'
		WHEN soh.TaxAmt >= 500 then 'Medium Order'
		when soh.TaxAmt < 500 then 'Low Order'
	END as 'Order_Type'	
from SalesOrderHeader soh 

/*2. Sử dụng CASE WHEN và bảng SalesOrderHeader để tạo 1 bảng mới có tên WAIT_TIME, là bảng thời gian nhận hàng của khách hàng. 
Gồm mã đơn hàng, mã khách hàng, mã nhân viên bán hàng, số tiền của đơn hàng, 
	số thời gian chờ giữa ngày OrderDate - DueDate, 
	cột wait_type với wait_type được tính bằng số ngày giữa OrderDate và DueDate:
		wait_type >= 20: Long time
		20 > wait_type  >= 5: Medium time
		wait_type < 5 : Short time
*/

select x.* into WAIT_TIME
from (
	select soh.SalesOrderID, soh.CustomerID , soh.SalesPersonID , soh.TotalDue , 
		   DATEDIFF(day,soh.OrderDate, soh.DueDate) 'wait_time',
		   CASE 
		   	when DATEDIFF(day,soh.OrderDate, soh.DueDate) >= 20 then 'Long time'
		   	when DATEDIFF(day,soh.OrderDate, soh.DueDate) >= 5 then 'Medium time'
		   	when DATEDIFF(day,soh.OrderDate, soh.DueDate) < 5 then 'Short time'
		   END as 'wait_type'    
	from SalesOrderHeader soh ) as x
	
	
/* Với bảng SalesOrderHeader:
1. Bạn tạo 1 bảng CUSTOMER_GROUP gồm các mã KH và xếp hạng 
khách hàng dựa vào số lần mua hàng của khách hàng:
	> Số lần mua > 8 : Khách hàng thân thiết
 	> 8 >= Số lần mua >= 3: Khách hàng tiềm năng
	> Số lần mua <3  : Khách hàng mới */
	

select x.* into CUSTOMER_GROUP
from
	(select soh.CustomerID , COUNT(soh.CustomerID) 'Cus_Buyturn', 
		case
			when COUNT(soh.CustomerID) > 8 then N'Khách hàng thân thiết'
			when COUNT(soh.CustomerID) >= 3 then N'Khách hàng tiềm năng'
			ELSE N'Khách hàng mới'
		end as 'Cus_Rank'
	from SalesOrderHeader soh
	group by soh.CustomerID) as x

select * 
from CUSTOMER_GROUP cg 


/* 2. Bạn hãy tính tổng doanh thu theo các TerritoryID và kiểm tra xem các Territory nào đạt KPI, biết rằng tất các các Territory đều có cùng mốc KPI 
là 200000 */

select soh.TerritoryID , sum(soh.TotalDue) 'TotalDue_sum', 
	CASE 
		when sum(soh.TotalDue) >= 200000 then 'pass'
		ELSE 'fail'
	END as 'KPI_rank'
FROM SalesOrderHeader soh
group by soh.TerritoryID 


/* 3. Với bảng WAIT_TIME đã tạo ở phần trước, bạn hãy đếm 
 * 		tổng số đơn hàng, 
 * 		tổng số tiền của các đơn hàng,
 *  	tính thời gian chờ trung bình
 * của các đơn hàng theo từng wait_type. */
	
SELECT wait_type , count(SalesOrderID) 'countID' ,sum(TotalDue) 'TotalDueSales', AVG(wait_time) 'WaitTimeAvg'  
from WAIT_TIME wt 
group by wait_type 

/* Dựa vào bảng CUSTOMER_GROUP, WAIT_TIME đã tạo trong lúc học. Bạn hãy viết các đoạn truy vấn để tìm ra các thông tin sau:
 * Số lượng khách hàng của từng nhóm khách hàng trong CUSTOMER_GROUP là bao nhiêu?
 * Số lượng đơn hàng của từng nhóm wait_type là bao nhiêu? */

SELECT Cus_Rank , COUNT(Cus_rank) 'Cus_rank_count'
FROM CUSTOMER_GROUP cg 
group by Cus_Rank

SELECT wait_type , count(wait_type)
from WAIT_TIME wt 
group by wait_type 


/* Dựa vào bảng SalesOrderDetail. Hãy tìm ra tổng số item được mua của từng đơn hàng. */

SELECT SalesOrderID , sum(OrderQty) 'sumOrderQty'
from SalesOrderDetail sod 
group by SalesOrderID 

/*Dựa vào bảng SalesOrderDetail và Product. Hãy tìm ra tổng doanh số của từng ProductSubCategory. */

SELECT p.ProductSubcategoryID , sum(sod.LineTotal) 'LineTotalSum' 
from SalesOrderDetail sod 
join Product p 
on sod.ProductID = p.ProductID 
group by p.ProductSubcategoryID

 
/*Hãy tính tổng doanh số của các Category có các sản phẩm được thay đổi giá bán. */

select sod.ProductID , sum(sod.LineTotal)
from SalesOrderDetail sod 
join (
		SELECT pch.ProductID , COUNT(pch.ProductID) 'ChangePrice_time'
		from ProductCostHistory pch 
		group by pch.ProductID 
		having COUNT(pch.ProductID) > 1
	 ) as X
on sod.ProductID = X.ProductID
group by sod.ProductID

SELECT pch.ProductID , COUNT(pch.ProductID) 'ChangePrice_time'
from ProductCostHistory pch 
group by pch.ProductID 
having COUNT(pch.ProductID) > 1


select *
from ProductCostHistory pch 
WHERE pch.ProductID = 709


/*Với CSDL “MindX_Lec_1” bạn hãy import thêm dữ liệu cho bảng STUDENTS và LEARNING và làm thêm yêu cầu sau */

use MindX_Lec_1

/*Bạn hãy viết các đoạn truy vấn để tìm ra các thông tin sau: */

--	> Điểm trung bình của các học viên theo từng khoa
	
	SELECT sID , c.cMajor , avg(score) 'avg_score'
	from LEARNING l 
	join COURSE c 
	on l.cID = c.cID 
	group by sID , c.cMajor
	
	
--	> Điểm trung bình của các học viên theo từng môn học
	
	SELECT sID , c.cName , avg(score) 'avg_score'
	from LEARNING l 
	join COURSE c 
	on l.cID = c.cID 
	group by sID , c.cName 
		
	
--	> Hãy đếm số lượng học viên đạt kết quả giỏi, khá và trung bình.
	
	Select Ranking, count(Ranking)
	from (
			SELECT 
				case 
					when avg(score) > 8 then N'Giỏi'
					when avg(score) > 5 then N'Khá'
					ELSE N'Trung bình'
				end as 'Ranking'
			from LEARNING l 
			group by sID
			) as X
	group by Ranking			

--	> Tìm các thông tin sau: điểm lớn nhất, điểm bé nhất, khoảng cách giữa điểm lớn nhất và điểm bé nhất của từng môn học là bao nhiêu? (Sau dấu , lấy 1 chữ số thập phân)
	
	select l.cID ,max(l.score) 'max_score', min(l.score) 'min_score', (max(l.score)-min(l.score)) 'max-min'
	from LEARNING l
	group by l.cID 
	
-- HomeWork:
	use CtyMX
	
/* Bài tập 1  
 * Đề bài : Bạn hãy lấy ra các sản phẩm có giá bán từ 50$ trở lên và tạo thêm trường thông tin để hiển thị nhóm sản phẩm thuộc loại “giá trị cao”, 
 * các sản phẩm còn lại thuộc loại “ giá trị thấp” */

SELECT *, 
	CASE 
		when s.Price > 50 then N'Giá trị cao'
		when s.Price <= 50 then N'Giá trị thấp'
	END as product_type
from SANPHAM s 


/*Bài tập 2: 
 * Đề bài : Bạn hãy tìm ra tổng doanh số và tổng số sản phẩm bán được của từng ProductCategoryID
 */

select s.ProductCategoryID , sum(X.QTY) 'QTY' ,sum(X.TotalLine) 'TotalLine'
from SANPHAM s
join (select *
	  from HOADON h 
	  union 
	  select *
	  from HOADONMOI h2 
	 ) as X
on s.ProductID = X.ProductID
group by s.ProductCategoryID 


select s.ProductCategoryID , sum(h.QTY) 'QTY' ,sum(h.TotalLine) 'TotalLine'
from SANPHAM s
join HOADON h
on s.ProductID = h.ProductID
group by s.ProductCategoryID 
union
select s.ProductCategoryID , sum(h2.QTY) 'QTY' ,sum(h2.TotalLine) 'TotalLine'
from SANPHAM s
join HOADONMOI h2 
on s.ProductID = h2.ProductID
group by s.ProductCategoryID 

/* Bài tập 3 
 * Đề bài : Bạn hãy tìm tổng doanh số của các nhân viên bán hàng và 
 * tạo thêm trường thông tin sale_type trong kết quả truy vấn với điều kiện:
 *  > Tổng doanh số trên 350$ thì hiển thị “Excellent Staff”
 *  > Các trường hợp còn lại thì hiển thị “Normal Staff”
 */ 

SELECT n.EmID , sum(X.TotalLine) 'sum sale', 
	CASE 
		when sum(X.TotalLine) >= 350 then 'Excellent Staff'
		else 'Normal Staff'
	END as 'sale_type'
from NHANVIEN n 
join (select *
	  from HOADON h 
	  union 
	  select *
	  from HOADONMOI h2 
	 ) as X
on n.EmID = X.SalesID
group by n.EmID 



/*Bài tập 4 
 * Đề bài : Bạn hãy tìm tổng số lượng sản phẩm được mua của từng category vào tháng 3, tháng 5 và 
 * tạo thêm trường thông tin hiển thị chi tiết tỷ lệ tăng/giảm bao nhiêu % của tháng 3 -5.
 */

alter TABLE HOADON 
alter column DateCreate Date

alter TABLE HOADONMOI  
alter column DateCreate Date

alter TABLE HOADON 
alter column OrderDate Date

alter TABLE HOADONMOI  
alter column OrderDate Date


select * 
from (
		select s.ProductCategoryID , MONTH(X.DateCreate),sum(X.QTY)
		from SANPHAM s 
		join (
				select *
				from HOADON h 
				union 
				select *
				from HOADONMOI h2 
			) as X
		on s.ProductID = X.ProductID
		GROUP by s.ProductCategoryID , MONTH(X.DateCreate)
		having MONTH(X.DateCreate) = 5 )

		
select s.ProductCategoryID , MONTH(X.DateCreate),sum(X.QTY)
from SANPHAM s 
join (
		select *
		from HOADON h 
		union 
		select *
		from HOADONMOI h2 
	) as X
on s.ProductID = X.ProductID
GROUP by s.ProductCategoryID , MONTH(X.DateCreate)


SELECT *
FROM (
		select s.ProductCategoryID ,MONTH(X.DateCreate) 'Monthsale' ,sum(X.QTY) 'QTY'
		from SANPHAM s 
		join (
				select *
				from HOADON h 
				union 
				select *
				from HOADONMOI h2 
			) as X
		on s.ProductID = X.ProductID
		GROUP by s.ProductCategoryID , MONTH(X.DateCreate)
) AS Source
PIVOT (
    SUM(QTY)
    FOR Monthsale IN ([3] as [Order M3] , [5] as [Order M5])
) AS PivotTable;

SELECT *
FROM (
    SELECT s.ProductCategoryID, MONTH(X.DateCreate) AS Monthsale, SUM(X.QTY) AS QTY
    FROM SANPHAM s 
    JOIN (
        SELECT *
        FROM HOADON h 
        UNION ALL
        SELECT *
        FROM HOADONMOI h2 
    ) AS X ON s.ProductID = X.ProductID
    GROUP BY s.ProductCategoryID, MONTH(X.DateCreate)
) AS Source
PIVOT (
    SUM(QTY)
    FOR Monthsale IN ([3], [5])
) AS PvT;

-----------------------------------------------------------------------------------

SELECT PvT.ProductCategoryID, [3] 'Order M3', [5] 'Order M5', 
	CASE 
		when round(cast([5] as float)/cast([3] as float),2) > 0 then concat(N'Tăng ',cast(round(cast([5] as float)/cast([3] as float),2) as varchar))
		when round(cast([5] as float)/cast([3] as float),2) < 0 then concat(N'Giảm ',cast(round(cast([5] as float)/cast([3] as float),2) as varchar))
		when round(cast([5] as float)/cast([3] as float),2) = 0 then N'Không đổi'
	END as 'Tăng giảm'
FROM (
    SELECT s.ProductCategoryID, MONTH(X.DateCreate) AS Monthsale, SUM(X.QTY) AS QTY
    FROM SANPHAM s 
    JOIN (
        SELECT *
        FROM HOADON h 
        UNION ALL
        SELECT *
        FROM HOADONMOI h2 
    ) AS X ON s.ProductID = X.ProductID
    GROUP BY s.ProductCategoryID, MONTH(X.DateCreate)
) AS Source
PIVOT (
    SUM(QTY)
    FOR Monthsale IN ([3], [5])
) AS PvT;
