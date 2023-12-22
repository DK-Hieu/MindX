use AW2019


with df as (
	SELECT soh.OrderDate , soh.SalesOrderID ,sod.ProductID ,soh.CustomerID, soh.TerritoryID, sod.OrderQty , p.ListPrice, sod.OrderQty * p.ListPrice 'SaleAmount'
	from Sales.SalesOrderHeader soh 
	join Sales.SalesOrderDetail sod 
	on soh.SalesOrderID = sod.SalesOrderID 
		join Production.Product p 
		on p.ProductID  = sod.ProductID 
		)	
select df.CustomerID, max(DATEDIFF(day,df.OrderDate, GETDATE())) 'R'
					, ROUND(COUNT(DISTINCT(df.SalesOrderID)),1)  'F'
					, SUM(df.SaleAmount) 'M' 
into RFM
from df
group by df.CustomerID

CREATE view RFM2 as 
	with df as (
		SELECT soh.OrderDate , soh.SalesOrderID ,sod.ProductID ,soh.CustomerID, soh.TerritoryID, sod.OrderQty , p.ListPrice, sod.OrderQty * p.ListPrice 'SaleAmount'
		from Sales.SalesOrderHeader soh 
		join Sales.SalesOrderDetail sod 
		on soh.SalesOrderID = sod.SalesOrderID 
			join Production.Product p 
			on p.ProductID  = sod.ProductID 
			)	
	select df.CustomerID, max(DATEDIFF(day,df.OrderDate, GETDATE())) 'R'
						, ROUND(COUNT(DISTINCT(df.SalesOrderID)),1)  'F'
						, SUM(df.SaleAmount) 'M' 
from df
group by df.CustomerID



SELECT r.*,
    NTILE(4) OVER (ORDER BY r.R) R_Socre,
    NTILE(4) OVER (ORDER BY r.F) F_Socre,
    NTILE(4) OVER (ORDER BY r.M) M_Socre,
	CAST (NTILE(4) OVER (ORDER BY r.R) as varchar) + 
	CAST (NTILE(4) OVER (ORDER BY r.F) as varchar) + 
	CAST (NTILE(4) OVER (ORDER BY r.M) as varchar)  as 'RFM'
FROM RFM r
