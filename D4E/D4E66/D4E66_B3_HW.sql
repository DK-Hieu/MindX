use CtyMX

/* bạn hãy tìm ra những đơn hàng nào mua sản phẩm thuộc thể loại sản phẩm (Category) là Chip */

SELECT *
from HOADON h 
join SANPHAM s 
on h.ProductID = s.ProductID 
WHERE s.CategoryName = 'Chip'

/* Bạn hãy tìm những đơn hàng được bán bởi nhân viên có tên là Linh. */

SELECT *
from NHANVIEN n
join HOADON h  
on h.SalesID = n.EmID 
where n.EmName like N'%Linh'

/* Một chi nhánh cửa hàng khác cũng thực hiện mua bán và các dữ liệu được lưu trữ trong file HOADONMOI. 
 * Hãy import file HOADONMOI.csv thành bảng HOADONMOI. Sau đó thực hiện lại bài tập 1 và bài tập 2 với dữ liệu được kết hợp từ 2 bảng HOADON và HOADONMOI.
 * BT1: bạn hãy tìm ra những đơn hàng nào mua sản phẩm thuộc thể loại sản phẩm (Category) là Chip
 * BT2: Bạn hãy tìm những đơn hàng được bán bởi nhân viên có tên là Linh.
 */

SELECT *
from HOADONMOI h 
join SANPHAM s 
on h.ProductID = s.ProductID 
WHERE s.CategoryName = 'Chip'

SELECT *
from NHANVIEN n
join HOADONMOI h  
on h.SalesID = n.EmID 
where n.EmName like N'%Linh'


/* Bạn hãy tìm ra các khoảng thời gian tạo hoá đơn của các đơn hàng sau khi nhận được thông tin Order từ khách hàng */

select DISTINCT DateCreate , OrderDate , DATEDIFF(day,OrderDate,DateCreate) 'time_create'
from HOADON h 
union
select DISTINCT DateCreate , OrderDate , DATEDIFF(day,OrderDate,DateCreate) 'time_create'
from HOADONMOI h 