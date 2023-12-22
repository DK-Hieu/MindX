use MindX_testLv1


-- Câu 1:  
-- A. Bạn hãy xây dựng đoạn truy vấn đếm tổng số đơn hàng được order  (0.25đ)
SELECT count(Invoice_ID) 'Total_Order'
from supermarket_sales ss 

-- B. Bạn hãy xây dựng đoạn truy vấn tính tổng doanh số theo từng Branch. Kết quả làm tròn đến 2 chữ số thập phân (0.25đ)
SELECT Branch , round(sum(Unit_price*Quantity),2) 'Sum_sales'
from supermarket_sales ss
group by Branch 

-- Câu 2:
--  A. Bạn hãy xây dựng đoạn truy vấn tính tổng doanh số và số lượng đơn hàng của từng ProductLine (0.25đ)

SELECT Product_line , round(sum(Unit_price*Quantity),2) 'Sum_sales', COUNT(Invoice_ID) 'Total_Order' 
from supermarket_sales ss 
group by Product_line 

-- B. Bạn hãy xây dựng đoạn truy vấn tính tổng doanh số, tổng số đơn hàng của từng loại khách hàng theo từng Productline. (tổng doanh số làm tròn đến 2 chữ số thập phân) (0.5đ)

SELECT Product_line , Customer_type , round(sum(Unit_price*Quantity),2) 'Sum_sales', COUNT(Invoice_ID) 'Total_Order' 
from supermarket_sales ss 
group by Product_line , Customer_type 

-- Câu 3:
-- A. Với tháng có doanh số cao nhất, bạn hãy tìm ra các khung giờ có tổng số đơn hàng cao hơn số lượng đơn hàng trung bình theo giờ  (0.75đ)

with 
month_maxsales as (
				SELECT Month_sale_max
				FROM (
						SELECT MONTH ([Date]) 'Month_sale_max' , round(sum(Unit_price*Quantity),2) 'Sum_sales', 
							   rank () over(order by round(sum(Unit_price*Quantity),2) DESC) as 'rank_no'
						from supermarket_sales ss 
						group by MONTH ([Date])
						) as max_month
				where rank_no = 1
								),
avg_totalođer as (		
				SELECT avg_ID.Month_sale , avg(avg_ID.Order_sum) Order_avg
				from (SELECT MONTH([Date]) 'Month_sale', DATEPART(HOUR, [Time]) 'Hour_time', COUNT(Invoice_ID) 'Order_sum'
					  from supermarket_sales ss 
					  group by MONTH([Date]),DATEPART(HOUR, [Time])) as avg_ID
				group by avg_ID.Month_sale
					  ),
month_hour as (
				SELECT MONTH([Date]) 'Month_sale', DATEPART(HOUR, [Time]) 'Hour_sale', COUNT(Invoice_ID) 'Order_sum'
				from supermarket_sales ss2 
				group by MONTH([Date]), DATEPART(HOUR, [Time])
		)
SELECT Month_sale_max, mh.Month_sale, mh.Hour_sale, mh.Order_sum, avgt.Order_avg
from month_maxsales, month_hour mh
join avg_totalođer avgt
on mh.Month_sale = avgt.Month_sale
where mh.Month_sale = Month_sale_max and mh.Order_sum > avgt.Order_avg
		
/* B. Với mỗi Product line, đều có 2 loại khách hàng (Customer Type)  mua hàng là Normal, Member. Bạn hãy tìm 
các Product line có loại khách hàng mua ít đơn hàng nhưng lại có doanh số cao hơn loại khách hàng còn 
lại.(1đ) */

with 
	A as (
		SELECT Product_line , Customer_type , COUNT(Invoice_ID) 'Order_count', round(sum(Unit_price*Quantity),2) 'Sum_sales'
		from supermarket_sales ss 
		group by Product_line , Customer_type 
		HAVING Customer_type = 'Normal'),
	B as (
		SELECT Product_line , Customer_type , COUNT(Invoice_ID) 'Order_count', round(sum(Unit_price*Quantity),2) 'Sum_sales'
		from supermarket_sales ss 
		group by Product_line , Customer_type 
		HAVING Customer_type = 'Member')
select A.Product_line, A.Customer_type, A.Order_count, A.Sum_sales ,B.Customer_type, B.Order_count, B.Sum_sales,
	   A.Order_count - B.Order_count 'Order_check', A.Sum_sales - B.Sum_sales 'Sales_check'
from A 
join B 
on A.Product_line = B.Product_line 
where ((A.Order_count - B.Order_count < 0) and ( A.Sum_sales - B.Sum_sales > 0)) or 
      ((A.Order_count - B.Order_count > 0) and ( A.Sum_sales - B.Sum_sales < 0))
      
--------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW View_1 AS (
    SELECT Product_line, 
        Customer_type, 
        ROUND(SUM(cogs),2) as 'SumSales', 
        COUNT(Invoice_ID) as 'Total Order'
    FROM supermarket_sales
    GROUP BY Product_line, Customer_type 
)

WITH Info AS (
	SELECT Product_line,
	        MAX(SumSales) as 'MaxSales', 
	        MAX([Total Order]) as 'MaxOrder'
	FROM View_1
	GROUP BY Product_line
)
SELECT *
FROM View_1 A, Info B
WHERE 
    SumSales = MaxSales and [Total Order] < MaxOrder 
     
-- Câu 4: Bạn hãy xây dựng đoạn truy vấn tìm ra tổng doanh số, tổng số đơn hàng theo tháng, tổng doanh số và tổng số đơn hàng của các tháng về trước (1đ)


with A as (    
	SELECT MONTH([Date]) 'Month_sales', round(sum(Unit_price*Quantity),2) 'Sum_sales', COUNT(Invoice_ID) 'Order_count',
		   lag(round(sum(Unit_price*Quantity),2), 1,0) over (ORDER BY MONTH([Date])) AS sale_before,
		   lag(COUNT(Invoice_ID), 1,0) over (ORDER BY MONTH([Date])) as order_before
	FROM supermarket_sales ss 
	group by MONTH([Date]))
SELECT *, sum(sale_before) over (ORDER BY Month_sales) as Total_sale_before, sum(order_before) over (ORDER BY Month_sales) as Total_order_before
from A


WITH X AS (
SELECT 
    DATEPART(M, [Date]) as [Month], 
    ROUND(SUM(cogs),2) as [SumSales],
    COUNT(Invoice_ID) as [TotalOrder]
FROM supermarket_sales S
GROUP BY DATEPART(M, [Date])
)
SELECT X1.*, 
    (SELECT 
        SUM(SumSales)
    FROM X X2
    WHERE X1.[Month] > X2.[Month]) AS [Total Sales Before], 
    (SELECT 
        SUM(TotalOrder)
    FROM X X2
    WHERE X1.[Month] > X2.[Month]) AS [Total OrderBefore]
FROM X X1
ORDER BY [Month]












