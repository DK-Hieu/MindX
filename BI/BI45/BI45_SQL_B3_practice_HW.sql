use aw2019
-- Kết nối bảng SalesOrderHeader và SalesOrderDetail và Window Function để tính doanh số theo tháng và tháng về trước

with A as 
   (select YEAR (soh.OrderDate)'Year_sale',MONTH (soh.OrderDate) 'Month_sale', ROUND(SUM(LineTotal),2)  'LineTotal_Month_year'
	from Sales.SalesOrderHeader soh 
	join Sales.SalesOrderDetail sod 
	on soh.SalesOrderID = sod.SalesOrderID 
	GROUP by YEAR (soh.OrderDate),MONTH (soh.OrderDate))
SELECT Month_sale,
	   sum(case when Year_sale = 2011 then LineTotal_Month_year end) sale_2011,
	   sum(case when Year_sale = 2012 then LineTotal_Month_year end) sale_2012,
	   sum(case when Year_sale = 2013 then LineTotal_Month_year end) sale_2013,
	   sum(case when Year_sale = 2014 then LineTotal_Month_year end) sale_2014
from A
group by Month_sale



with B as (
	select distinct month(ss.ShipDate) 'Month_sale', year(ss.ShipDate) 'Year_sale' ,
		   sum(LineTotal) over(PARTITION by month(ss.ShipDate),year(ss.ShipDate)
		   					   order by year(ss.ShipDate) asc, month(ss.ShipDate) asc) LineTotal_Month_year
	from Sales.SalesOrderHeader ss
	join Sales.SalesOrderDetail ss2
	on ss.SalesOrderID = ss2.SalesOrderID)
SELECT Month_sale,
	   sum(case when Year_sale = 2011 then LineTotal_Month_year end) sale_2011,
	   sum(case when Year_sale = 2012 then LineTotal_Month_year end) sale_2012,
	   sum(case when Year_sale = 2013 then LineTotal_Month_year end) sale_2013,
	   sum(case when Year_sale = 2014 then LineTotal_Month_year end) sale_2014
from B
group by Month_sale



SELECT format(soh.OrderDate, 'yyyy-MM')
from Sales.SalesOrderHeader soh  


-- Bạn hãy xây dựng truy vấn để tìm ra top 5 sản phẩm có doanh số cao nhất.
select top 5 sod.ProductID , sum(LineTotal) 'Product_totalsale'
from Sales.SalesOrderDetail sod 
group by sod.ProductID
order by sum(LineTotal) desc

-- Chuyển kết quả của câu 1 thành PIVOT table

SELECT 'Product_totalsale', [782],[783],[779],[780],[781]
from  (
	select top 5 sod.ProductID , sum(LineTotal) 'Product_totalsale'
	from Sales.SalesOrderDetail sod 
	group by sod.ProductID
	order by sum(LineTotal) desc
) as s_table
PIVOT( 
	AVG (Product_totalsale)
	FOR s_table.ProductID in ([782],[783],[779],[780],[781])
) as PV_table;


with A as (
	select top 5 sod.ProductID , sum(LineTotal) 'Product_totalsale'
	from Sales.SalesOrderDetail sod 
	group by sod.ProductID
	order by sum(LineTotal) desc
	)
select 'ProductID',
	sum(case when ProductID = 782 then Product_totalsale end) as [782],
	sum(case when ProductID = 783 then Product_totalsale end) as [783],
	sum(case when ProductID = 779 then Product_totalsale end) as [779],
	sum(case when ProductID = 780 then Product_totalsale end) as [780],
	sum(case when ProductID = 781 then Product_totalsale end) as [781]
from A
group by ProductID

/* Sử dụng Window Function, PIVOT Table và các kiến thức có liên quan như SubQuery, 
 * CTE và sau đó viết truy vấn để thực hiện việc tính toán tổng doanh số của các quý 
 * trong năm và tổng doanh số của các quý trước đó. 
 */

with B as (
	SELECT A.Quarter, A.Year, sum(TotalDue) 'Sale_Quarter'
	from (select * , CONCAT('Q',DATEPART(qq,OrderDate)) 'Quarter' , YEAR (OrderDate) 'Year'
		  from Sales.SalesOrderHeader soh) as A
	group by A.Quarter, A.Year
	)
SELECT B.Quarter, 
		sum(case when B.Year = 2011 then Sale_Quarter end) as [2011],
		sum(case when B.Year = 2012 then Sale_Quarter end) as [2012],
		sum(case when B.Year = 2013 then Sale_Quarter end) as [2013],
		sum(case when B.Year = 2014 then Sale_Quarter end) as [2014]
from B
group by B.Quarter

/* Bạn hãy phân tích theo vùng kinh doanh bằng cách tính toán tổng doanh số của các vùng trong cả năm và tạo thêm cột ranking để xếp hạng tổng doanh số của các khu vực đó. */

select TerritoryID , year(OrderDate) 'year_sale' ,sum(TotalDue) 'Sale_Territory',
	 	RANK() OVER(PARTITION BY year(OrderDate) Order by sum(TotalDue) ASC) 'Rank_Territory'
from Sales.SalesOrderHeader soh 
group by TerritoryID , year(OrderDate)
order by year(OrderDate), Rank_Territory ,TerritoryID

-- BOM muốn bạn tìm ra top 3 salesman có doanh số lớn nhất của mỗi khu vực để quyết định khen thưởng cho việc có doanh số tốt.

select SalesPersonID  , year(OrderDate) 'year_sale' ,sum(TotalDue) 'SalePerson_total',
	 	RANK() OVER(PARTITION BY year(OrderDate) Order by sum(TotalDue) desc) 'Rank_SalePerson'
from Sales.SalesOrderHeader soh 
group by SalesPersonID , year(OrderDate)
order by year(OrderDate) asc , Rank_SalePerson ASC 

SELECT *
from Sales.SalesOrderHeader soh 







