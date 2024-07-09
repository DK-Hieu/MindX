use D4E66HW

/* Quản lý muốn bạn truy vấn, lấy ra dữ liệu của các sản phẩm thuộc loại ‘Disk’ để làm báo cáo cho BOD. 
Bạn hãy viết câu lệnh truy vấn trên CSDL đã tạo ở bài 1 để lấy ra kết quả mà quản lý mong muốn. */

SELECT *
from SANPHAM s 
WHERE CategoryName = 'Disk'


/* Hiện tại các tỉnh miền Trung đang bị ảnh hưởng chung bởi bão, lũ. Nhất là 2 tỉnh Quảng Bình và Quảng Trị. 
 * BOD quyết định sẽ hỗ trợ cho các nhân viên có quê quán ở 2 tỉnh trên. Bạn hãy viết câu lệnh truy vấn để tìm ra các nhân viên có quê quán từ 2 tỉnh trên. */

SELECT *
from NHANVIEN n
WHERE n.Address in (N'Quảng Bình', N'Quảng Trị')

/* BOD nhận thấy các sản phẩm ‘Ổ cứng HDD 1TB’ bán khá chậm và thị trường cũng dần sử dụng ổ cứng SSD để có hiệu quả tốt hơn, nên quyết định sẽ dừng bán sản phẩm này từ ngày 31/12/2022.
 * Bạn hãy cập nhật lại dữ liệu trong CSDL đã tạo ở trên.
 */

exec sp_columns 'SANPHAM'

SELECT *
from SANPHAM s 
where ProductName like N'%HDD 1 TB%'

UPDATE SANPHAM 
set SalesEndDate = '31/12/2022'
where ProductName like N'%HDD 1 TB%'

UPDATE SANPHAM
set SalesEndDate = '10/10/2024'
where ProductName like N'%HDD 1 TB%'

/* Do trong quá trình làm việc, nhân viên có tên ‘Nguyễn Lê Chí Bẻo’ thể hiện tốt. 
 * Nên BOD quyết định thăng chức cho nhân viên ‘Nguyễn Lê Chí Bẻo’ từ vị trí Bảo vệ thành vị trí ‘Trưởng bộ phận an ninh’ với mức lương mới là 150$. 
 * Bạn hãy cập nhật lại chức danh và mức lương của nhân viên này trên CSDL. */

exec sp_columns 'NHANVIEN'

SELECT *
from NHANVIEN n 

update NHANVIEN 
set JobTitle = 'Trưởng bộ phận an ninh', Salary = 100
where EmName = 'Nguyễn Lê Chí Bẻo'

/* Do có vài sai phạm trong quá trình thực hiện báo cáo tài chính, nên nhân viên ‘Đỗ Đắc Hải’,
 * vị trí Trưởng phòng tài vụ bị giáng chức và buộc phải chuyển sang phòng Data để công tác với chức danh ‘Chuyên viên phân tích rủi ro’, mức lương là 2000$. 
 * Bạn hãy cập nhật lại chức danh, phòng ban và mức lương cho nhân viên này
 */ 

update NHANVIEN 
set JobTitle = 'Chuyên viên phân tích rủi ro', Salary = 2000, DepName = 'Data'
where EmName = 'Đỗ Đắc Hải'



