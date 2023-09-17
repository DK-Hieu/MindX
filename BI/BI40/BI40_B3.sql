use aw2019

/*Kết nối bảng SalesOrderHeader và SalesOrderDetail và Window Function để tính doanh số theo tháng và tháng về trước.*/

select distinct month(ss.ShipDate) 'Monthss', year(ss.ShipDate) 'Yearss' ,
	   sum(LineTotal) over(PARTITION by month(ss.ShipDate),year(ss.ShipDate)
	   					   order by year(ss.ShipDate) asc, month(ss.ShipDate) asc)
from sales_salesorderheader ss 
join sales_salesorderdetail ss2
on ss.SalesOrderID = ss2.SalesOrderID
-- order by year(ss.ShipDate), month(ss.ShipDate) asc

select month(ss.ShipDate) 'Monthss', year(ss.ShipDate) 'Yearss', sum(ss2.LineTotal) 'LineTotal'
from sales_salesorderheader ss 
join sales_salesorderdetail ss2
on ss.SalesOrderID = ss2.SalesOrderID
group by month(ss.ShipDate),year(ss.ShipDate)

select * from sales_salesorderdetail ss 

/* Kết nối bảng SalesOrderHeader và SalesOrderDetail và tạo thêm cột rank để xếp hạng doanh số của SalesMan.
 * Với các SalesMan có cùng doanh số sẽ nhảy rank 
 */
with A as (
	select distinct ss.SalesPersonID , sum(ss2.LineTotal) over(PARTITION by ss.SalesPersonID) 'SP_Linetotal'
	from sales_salesorderheader ss 
	join sales_salesorderdetail ss2
	on ss.SalesOrderID = ss2.SalesOrderID
)
select SalesPersonID, SP_Linetotal,
	   row_number() over (order by SP_Linetotal) as 'Ranking',
	   rank() over (order by SP_Linetotal) as 'Ranking1',
	   dense_rank () over (order by SP_Linetotal) as 'Ranking2'
from A

/*Kết nối bảng SalesOrderHeader, SalesOrderDetail và tạo thêm cột rank để xếp hạng doanh số của các Product. 
 * Với các Product có cùng doanh số sẽ nhảy rank
 * Với các Product có cùng doanh số sẽ không nhảy rank
 */

with A as (
	select distinct ss2.ProductID  , sum(ss2.LineTotal) over(PARTITION by ss2.ProductID ) 'SP_Linetotal'
	from sales_salesorderheader ss 
	join sales_salesorderdetail ss2
	on ss.SalesOrderID = ss2.SalesOrderID
)
select ProductID , SP_Linetotal,
	   row_number() over (order by SP_Linetotal) as 'Ranking',
	   rank() over (order by SP_Linetotal) as 'Ranking1',
	   dense_rank () over (order by SP_Linetotal) as 'Ranking2',
	   rank() over (order by SP_Linetotal) - dense_rank () over (order by SP_Linetotal) 'step_rank'
from A


describe sales_salesorderdetail

describe sales_salesorderheader 