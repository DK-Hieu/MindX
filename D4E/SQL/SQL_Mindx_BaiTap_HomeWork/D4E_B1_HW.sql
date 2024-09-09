use MX_company

CREATE database MX_company

CREATE TABLE MX_SANPHAM (
    ProductId CHAR(6),
    ProductName NVARCHAR(50),
    ProductCategoryID INT,
    CategoryName NVARCHAR(10),
    Price INT,
    SalesStartDate DATE,
    SalesEndDate DATE
);

CREATE TABLE MX_NHANVIEN (
    EmID CHAR(5),
    EmName NVARCHAR(50),
    Sex NVARCHAR(5),
    TaxCode INT,
    Email VARCHAR(50),
    Address NVARCHAR(50),
    Salary INT,
    JobTitle NVARCHAR(50),
    DepID INT,
    DepName NVARCHAR(50),
    StartDate DATE
);

CREATE TABLE MX_HOADON ( 	
    OrderID CHAR(5),
    OrderLine VARCHAR(2),
    SalesID CHAR(5),
    CusID CHAR(5),
    ProductID CHAR(6),
    Type VARCHAR(10),
    QTY INT,
    Price FLOAT,
    TotalLine FLOAT,
    DateCreate DATE,
    OrderDate DATE
);

INSERT INTO MX_SANPHAM
VALUES
    ('MXSP01',N'Chip máy tính Intel','1','Chip','55','2022-02-02','2024-10-10'),
    ('MXSP02',N'Chip máy tính Amd','1','Chip','50','2022-02-02','2024-10-10'),
    ('MXSP03',N'Màn hình máy tính LG','2','Monitor','100','2022-02-02','2024-10-10'),
    ('MXSP04',N'Màn hình máy tính Mac','2','Monitor','280','2022-02-02','2024-10-10'),
    ('MXSP05',N'Màn hình máy tính Sony','2','Monitor','180','2022-02-06','2024-10-10'),
    ('MXSP06',N'Bàn phím cơ Razer','3','Keyboard','60','2022-02-07','2024-10-10'),
    ('MXSP07',N'Bàn phím cơ DareU','3','Keyboard','40','2022-02-07','2024-10-10'),
    ('MXSP08',N'Bàn phím cơ Rapoo','3','Keyboard','62','2022-02-07','2024-10-10'),
    ('MXSP09',N'Chuột Logitech','4','Mouse','30','2022-02-07','2024-10-10'),
    ('MXSP10',N'Chuột Asus','4','Mouse','60','2022-02-07','2024-10-10'),
    ('MXSP11',N'Chuột HyperX','4','Mouse','80','2022-02-07','2024-10-10'),
    ('MXSP12',N'Tai nghe Sony','5','Headphone','35','2022-02-10','2024-10-10'),
    ('MXSP13',N'Tai nghe Razer','5','Headphone','30','2022-02-10','2024-10-10'),
    ('MXSP14',N'Tai nghe HyperX','5','Headphone','40','2022-02-10','2024-10-10'),
    ('MXSP15',N'RAM Desktop 4GB','6','RAM','25','2022-02-10','2024-10-10'),
    ('MXSP16',N'RAM Desktop 8GB','6','RAM','42','2022-02-10','2024-10-10'),
    ('MXSP17',N'RAM Desktop 16GB','6','RAM','80','2022-02-13','2024-10-10'),
    ('MXSP18',N'Ổ cứng HDD 512 GB','7','Disk','32','2022-02-13','2024-10-10'),
    ('MXSP19',N'Ổ cứng HDD 1 TB','7','Disk','60','2022-02-13','2024-10-10'),
    ('MXSP20',N'Ổ cứng SSD 128 GB','7','Disk','30','2022-02-16','2024-10-10'),
    ('MXSP21',N'Ổ cứng SSD 512GB','7','Disk','59','2022-02-17','2024-10-10')

INSERT INTO MX_NHANVIEN
VALUES
    ('MX001',N'Nguyễn Đình Phước','Nam','1234567','phuocnd@mxco.com',N'Nghệ An','5000',N'Tổng giám đốc','1','Head Office','2020-01-01'),
    ('MX002',N'Hoàng Hải Anh','Nam','1234568','phuocnd@mxco.com',N'Nghệ An','3500',N'Phó giám đốc','1','Head Office','2020-01-01'),
    ('MX003',N'Đỗ Đắc Hải','Nam','1234569','haidd@mxco.com',N'Hà Nội','3000',N'Trưởng phòng tài vụ','2',N'Tài chính','2020-01-01'),
    ('MX004',N'Nguyễn Lê Chí Bẻo',N'Nữ','1234570','beonlc@mxco.com',N'Quảng Bình','100',N'Bảo vệ','3',N'Nghiệp vụ','2020-01-01'),
    ('MX005',N'Lê Nhật Minh','Nam','1234571','minhln@mxco.com',N'Sài Gòn','3000',N'Trưởng phòng dữ liệu','4','Data','2020-01-01'),
    ('MX006',N'Nguyễn Hữu Đạt','Nam','1234572','datnh@mxco.com',N'Hà Nội','2999',N'Phó phòng dữ liệu','4','Data','2020-01-01'),
    ('MX007',N'Trần Đức Thuận','Nam','1234573','thuantd@mxco.com',N'Sài Gòn','3001',N'Giám đốc công nghệ','1','Head Office','2020-01-01'),
    ('MX008',N'Nguyễn Ngọc Minh','Nam','1234574','minhnn@mxco.com',N'Quảng Bình','100',N'Giữ xe','3',N'Nghiệp vụ','2020-01-01'),
    ('MX009',N'Đoàn Ngọc Thảo',N'Nữ','1234575','thaodn@mx.com',N'Long An','2000',N'Chuyên viên phân tích rủi ro','4','Data','2020-01-01'),
    ('MX010',N'Lê Thảo Mai',N'Nữ','1234576','mailt@mxco.com',N'Bình Phước','1000',N'Kế toán','5',N'Kế toán','2020-01-01'),
    ('MX011',N'Nguyễn Quốc Huy','Nam','1234577','huynq@mxco.com',N'Sài Gòn','2000',N'Kĩ sư AI','4','Data','2020-01-01'),
    ('MX012',N'Trần Đăng Khoa','Nam','1234578','khoatd@mxco.com',N'Đồng Nai','2000',N'Kĩ sư AI','4','Data','2020-01-01'),
    ('MX013',N'Nguyễn Trần Trung Hiếu','Nam','1234579','hieuntt@mxco.com',N'Quảng Nam','2000',N'Chuyên viên phân tích rủi ro','4','Data','2020-01-01'),
    ('MX014',N'Nguyễn Trung Hiếu','Nam','1234580','hieunt@mxco.com',N'Hà Nội','4999',N'Giám đốc sản phẩm','1','Head Office','2020-01-01'),
    ('MX015',N'Nguyễn Văn Cường ',N'Nữ','1234581','cuongnv@mxco.com',N'Hà Nội','100',N'Bảo vệ','3',N'Nghiệp vụ','2020-01-01'),
    ('MX016',N'Trần Ngọc Tân',N'Nữ','1234582','tantn@mxco.com',N'Hà Nội','100',N'Bảo vệ','3',N'Nghiệp vụ','2020-01-01'),
    ('MX017',N'Lê Đức Hiếu','Nam','1234583','hieuld@mxco.com',N'Hà Nội','2000',N'Giám đốc bán hàng','5','Sales','2020-01-01'),
    ('MX018',N'Lê Quỳnh Trang',N'Nữ','1234584','tranglq@mxco.com',N'Hà Nội','2000',N'Chuyên viên phân tích rủi ro','4','Data','2020-01-01'),
    ('MX019',N'Trần Đức Trung','Nam','1234585','trungtd@mxco.com',N'Hà Nội','3000',N'Trưởng phòng sản phẩm AI','4','Data','2020-01-01'),
    ('MX020',N'Nguyễn Đức Bình','Nam','1234586','binhnd@mxco.com',N'Quảng Ninh','1000',N'Nhân viên bán hàng','5','Sales','2020-01-01'),
    ('MX021',N'Đỗ Ngọc Ánh',N'Nữ','1234587','anhdn@mxco.com',N'Hà Nội','1000',N'Nhân viên bán hàng','5','Sales','2020-01-01'),
    ('MX022',N'Nguyễn Ngọc Anh ',N'Nữ','1234588','anhnn@mxco.com',N'Hà Nội','1000',N'Nhân viên bán hàng','5','Sales','2020-01-11'),
    ('MX023',N'Nguyễn Văn Đức','Nam','1234589','anlh@mxco.com',N'Hải Phòng','1000',N'Nhân viên bán hàng','5','Sales','2020-01-20'),
    ('MX024',N'Trần Hải Đăng','Nam','1234590','ducth@mxco.com',N'Hải Phòng','1000',N'Nhân viên bán hàng','5','Sales',''),
    ('MX025',N'Nguyễn Hoài Linh',N'Nữ','1234591','linhnh@mxco.com',N'Hải Phòng','1000',N'Nhân viên bán hàng','5','Sales',''),
    ('MX026',N'Nguyễn Thị Linh',N'Nữ','1234592','linhnt@mxco.com',N'Hải Phòng','1000',N'Nhân viên bán hàng','5','Sales','')

INSERT INTO MX_HOADON
VALUES
    ('HD001',1,'MX020','KH001','MXSP01','ONLINE',1,55,55,'2022-03-04','2022-03-03'),
    ('HD001',2,'MX020','KH001','MXSP02','ONLINE',1,50,50,'2022-03-04','2022-03-03'),
    ('HD001',3,'MX020','KH001','MXSP03','ONLINE',1,100,100,'2022-03-04','2022-03-03'),
    ('HD002',4,'MX023','KH004','MXSP04','OFFLINE',1,280,280,'2022-03-04','2022-03-03'),
    ('HD003',5,'MX024','KH005','MXSP05','OFFLINE',1,180,180,'2022-03-04','2022-03-03'),
    ('HD004',6,'MX025','KH006','MXSP06','OFFLINE',1,60,60,'2022-03-04','2022-03-03'),
    ('HD005',7,'MX023','KH006','MXSP07','OFFLINE',1,40,40,'2022-03-04','2022-03-03'),
    ('HD005',8,'MX023','KH006','MXSP08','OFFLINE',1,62,62,'2022-03-04','2022-03-03'),
    ('HD005',9,'MX023','KH006','MXSP09','OFFLINE',2,30,60,'2022-03-04','2022-03-03'),
    ('HD005',10,'MX023','KH006','MXSP10','OFFLINE',2,60,120,'2022-03-04','2022-03-03'),
    ('HD006',11,'MX026','KH006','MXSP11','ONLINE',2,80,160,'2022-03-04','2022-03-03'),
    ('HD007',12,'MX026','KH006','MXSP12','ONLINE',2,35,70,'2022-03-04','2022-03-03'),
    ('HD008',13,'MX020','KH006','MXSP13','ONLINE',2,30,60,'2022-03-04','2022-03-03'),
    ('HD009',14,'MX026','KH014','MXSP14','ONLINE',2,40,80,'2022-03-04','2022-03-03'),
    ('HD010',15,'MX021','KH015','MXSP15','ONLINE',2,25,50,'2022-03-04','2022-03-03'),
    ('HD011',16,'MX026','KH022','MXSP16','ONLINE',2,42,84,'2022-03-04','2022-03-03'),
    ('HD012',17,'MX023','KH015','MXSP17','ONLINE',2,80,160,'2022-03-04','2022-03-03'),
    ('HD013',18,'MX022','KH015','MXSP18','ONLINE',2,32,64,'2022-03-04','2022-03-03'),
    ('HD014',19,'MX026','KH015','MXSP19','ONLINE',2,60,120,'2022-03-04','2022-03-03'),
    ('HD015',20,'MX026','KH015','MXSP20','ONLINE',2,30,60,'2022-03-04','2022-03-03'),
    ('HD016',21,'MX026','KH021','MXSP21','ONLINE',2,59,118,'2022-03-04','2022-03-03'),
    ('HD017',22,'MX026','KH022','MXSP18','ONLINE',2,32,64,'2022-03-04','2022-03-03'),
    ('HD018',23,'MX026','KH023','MXSP19','ONLINE',2,60,120,'2022-03-04','2022-03-03'),
    ('HD019',24,'MX020','KH024','MXSP20','OFFLINE',2,30,60,'2022-03-04','2022-03-03'),
    ('HD020',25,'MX020','KH015','MXSP21','OFFLINE',2,59,118,'2022-03-04','2022-03-03'),
    ('HD021',26,'MX020','KH026','MXSP21','OFFLINE',2,59,118,'2022-03-04','2022-03-03'),
    ('HD022',27,'MX022','KH027','MXSP21','OFFLINE',2,59,118,'2022-03-04','2022-03-03'),
    ('HD023',28,'MX020','KH006','MXSP21','OFFLINE',2,59,118,'2022-03-04','2022-03-03'),
    ('HD024',29,'MX020','KH029','MXSP21','OFFLINE',2,59,118,'2022-03-04','2022-03-03')
    
--drop table MX_NHANVIEN  
    
/* Quản lý muốn bạn truy vấn, lấy ra dữ liệu của các sản phẩm thuộc loại ‘Disk’ để làm báo cáo cho BOD. 
Bạn hãy viết câu lệnh truy vấn trên CSDL đã tạo ở bài 1 để lấy ra kết quả mà quản lý mong muốn. */

SELECT *
from MX_SANPHAM s 
WHERE CategoryName = 'Disk'


/* Hiện tại các tỉnh miền Trung đang bị ảnh hưởng chung bởi bão, lũ. Nhất là 2 tỉnh Quảng Bình và Quảng Trị. 
 * BOD quyết định sẽ hỗ trợ cho các nhân viên có quê quán ở 2 tỉnh trên. Bạn hãy viết câu lệnh truy vấn để tìm ra các nhân viên có quê quán từ 2 tỉnh trên. */

SELECT *
from MX_NHANVIEN n
WHERE n.Address in (N'Quảng Bình', N'Quảng Trị')

/* BOD nhận thấy các sản phẩm ‘Ổ cứng HDD 1TB’ bán khá chậm và thị trường cũng dần sử dụng ổ cứng SSD để có hiệu quả tốt hơn, nên quyết định sẽ dừng bán sản phẩm này từ ngày 31/12/2022.
 * Bạn hãy cập nhật lại dữ liệu trong CSDL đã tạo ở trên.
 */

exec sp_columns 'SANPHAM'

SELECT *
from MX_SANPHAM s 
where ProductName like N'%HDD 1 TB%'

UPDATE MX_SANPHAM 
set SalesEndDate = '31/12/2022'
where ProductName like N'%HDD 1 TB%'

UPDATE MX_SANPHAM
set SalesEndDate = '10/10/2024'
where ProductName like N'%HDD 1 TB%'

/* Do trong quá trình làm việc, nhân viên có tên ‘Nguyễn Lê Chí Bẻo’ thể hiện tốt. 
 * Nên BOD quyết định thăng chức cho nhân viên ‘Nguyễn Lê Chí Bẻo’ từ vị trí Bảo vệ thành vị trí ‘Trưởng bộ phận an ninh’ với mức lương mới là 150$. 
 * Bạn hãy cập nhật lại chức danh và mức lương của nhân viên này trên CSDL. */

exec sp_columns 'NHANVIEN'

SELECT *
from MX_NHANVIEN n 

update MX_NHANVIEN 
set JobTitle = 'Trưởng bộ phận an ninh', Salary = 100
where EmName = 'Nguyễn Lê Chí Bẻo'

/* Do có vài sai phạm trong quá trình thực hiện báo cáo tài chính, nên nhân viên ‘Đỗ Đắc Hải’,
 * vị trí Trưởng phòng tài vụ bị giáng chức và buộc phải chuyển sang phòng Data để công tác với chức danh ‘Chuyên viên phân tích rủi ro’, mức lương là 2000$. 
 * Bạn hãy cập nhật lại chức danh, phòng ban và mức lương cho nhân viên này
 */ 

update MX_NHANVIEN 
set JobTitle = 'Chuyên viên phân tích rủi ro', Salary = 2000, DepName = 'Data'
where EmName = 'Đỗ Đắc Hải'



