DROP DATABASE IF EXISTS CtyMX
go

CREATE Database CtyMX
GO;

use CtyMX
GO;

/****** Object:  Table [dbo].[HOADON] ******/

CREATE TABLE [dbo].[HOADON](
	[OrderID] [nvarchar](50) NOT NULL,
	[OrderLine] [tinyint] NOT NULL,
	[SalesID] [nvarchar](50) NOT NULL,
	[CusID] [nvarchar](50) NOT NULL,
	[ProductID] [varchar](50) NULL,
	[Type] [nvarchar](50) NOT NULL,
	[QTY] [tinyint] NOT NULL,
	[Price] [smallint] NOT NULL,
	[TotalLine] [smallint] NOT NULL,
	[DateCreate] [date] NOT NULL,
	[OrderDate] [date] NOT NULL,
 CONSTRAINT [PK_HOADON] PRIMARY KEY ([OrderLine] asc)
 )
GO

/****** Object:  Table [dbo].[NHANVIEN] ******/

CREATE TABLE [dbo].[NHANVIEN](
	[EmID] [nvarchar](50) NOT NULL,
	[EmName] [nvarchar](50) NOT NULL,
	[Sex] [nvarchar](50) NOT NULL,
	[TaxCode] [int] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[Salary] [smallint] NOT NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
	[DepID] [tinyint] NOT NULL,
	[DepName] [nvarchar](50) NOT NULL,
	[StartDate] [date] NULL,
 CONSTRAINT [PK_NHANVIEN] PRIMARY KEY ([EmID] ASC)
 )
GO

/****** Object:  Table [dbo].[SANPHAM] ******/
CREATE TABLE [dbo].[SANPHAM](
	[ProductID] [varchar](50) NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[CategoryName] [varchar](50) NULL,
	[Price] [varchar](50) NULL,
	[SalesStartDate] [varchar](50) NULL,
	[SalesEndDate] [varchar](50) NULL,
 CONSTRAINT [PK_SANPHAM] PRIMARY KEY ([ProductID] ASC)
 )
GO


ALTER TABLE [HOADON] 
ADD CONSTRAINT SANPHAM_sID_FK_HOADON
FOREIGN KEY (ProductID) REFERENCES SANPHAM(ProductId)

ALTER TABLE [HOADON] 
ADD CONSTRAINT NHANVIEN_sID_FK_HOADON
FOREIGN KEY (SalesID) REFERENCES NHANVIEN(EmID)


/****** Object:  Insert [dbo].[HOADON] ******/
Insert into [dbo].[HOADON]
VALUES
(N'HD001', 1, N'MX020', N'KH001', N'MXSP01', N'ONLINE', 1, 55, 55, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD001', 2, N'MX020', N'KH001', N'MXSP02', N'ONLINE', 1, 50, 50, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD001', 3, N'MX020', N'KH001', N'MXSP03', N'ONLINE', 1, 100, 100, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD002', 4, N'MX023', N'KH004', N'MXSP04', N'OFFLINE', 1, 280, 280, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD003', 5, N'MX024', N'KH005', N'MXSP05', N'OFFLINE', 1, 180, 180, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD004', 6, N'MX025', N'KH006', N'MXSP06', N'OFFLINE', 1, 60, 60, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD005', 7, N'MX023', N'KH006', N'MXSP07', N'OFFLINE', 1, 40, 40, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD005', 8, N'MX023', N'KH006', N'MXSP08', N'OFFLINE', 1, 62, 62, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD005', 9, N'MX023', N'KH006', N'MXSP09', N'OFFLINE', 2, 30, 60, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD005', 10, N'MX023', N'KH006', N'MXSP10', N'OFFLINE', 2, 60, 120, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD006', 11, N'MX026', N'KH006', N'MXSP11', N'ONLINE', 2, 80, 160, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD007', 12, N'MX026', N'KH006', N'MXSP12', N'ONLINE', 2, 35, 70, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD008', 13, N'MX020', N'KH006', N'MXSP13', N'ONLINE', 2, 30, 60, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD009', 14, N'MX026', N'KH014', N'MXSP14', N'ONLINE', 2, 40, 80, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD010', 15, N'MX021', N'KH015', N'MXSP15', N'ONLINE', 2, 25, 50, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD011', 16, N'MX026', N'KH022', N'MXSP16', N'ONLINE', 2, 42, 84, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD012', 17, N'MX023', N'KH015', N'MXSP17', N'ONLINE', 2, 80, 160, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD013', 18, N'MX022', N'KH015', N'MXSP18', N'ONLINE', 2, 32, 64, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD014', 19, N'MX026', N'KH015', N'MXSP19', N'ONLINE', 2, 60, 120, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD015', 20, N'MX026', N'KH015', N'MXSP20', N'ONLINE', 2, 30, 60, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD016', 21, N'MX026', N'KH021', N'MXSP21', N'ONLINE', 2, 59, 118, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD017', 22, N'MX026', N'KH022', N'MXSP18', N'ONLINE', 2, 32, 64, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD018', 23, N'MX026', N'KH023', N'MXSP19', N'ONLINE', 2, 60, 120, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD019', 24, N'MX020', N'KH024', N'MXSP20', N'OFFLINE', 2, 30, 60, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD020', 25, N'MX020', N'KH015', N'MXSP21', N'OFFLINE', 2, 59, 118, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD021', 26, N'MX020', N'KH026', N'MXSP21', N'OFFLINE', 2, 59, 118, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD022', 27, N'MX022', N'KH027', N'MXSP21', N'OFFLINE', 2, 59, 118, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD023', 28, N'MX020', N'KH006', N'MXSP21', N'OFFLINE', 2, 59, 118, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date)),
(N'HD024', 29, N'MX020', N'KH029', N'MXSP21', N'OFFLINE', 2, 59, 118, CAST(N'2022-03-04' AS Date), CAST(N'2022-03-03' AS Date))
GO;

/****** Object:  Insert [dbo].[NHANVIEN] ******/
Insert into [dbo].[NHANVIEN]
VALUES
(N'MX001', N'Nguyễn Đình Phước', N'Nam', 1234567, N'phuocnd@mxco.com', N'Nghệ An', 5000, N'Tổng giám đốc', 1, N'Head Office', CAST(N'2020-01-01' AS Date)),
(N'MX002', N'Hoàng Hải Anh', N'Nam', 1234568, N'phuocnd@mxco.com', N'Nghệ An', 3500, N'Phó giám đốc', 1, N'Head Office', CAST(N'2020-01-01' AS Date)),
(N'MX003', N'Đỗ Đắc Hải', N'Nam', 1234569, N'haidd@mxco.com', N'Hà Nội', 3000, N'Trưởng phòng tài vụ', 2, N'Tài chính', CAST(N'2020-01-01' AS Date)),
(N'MX004', N'Nguyễn Lê Chí Bẻo', N'Nữ', 1234570, N'beonlc@mxco.com', N'Quảng Bình', 100, N'Bảo vệ', 3, N'Nghiệp vụ', CAST(N'2020-01-01' AS Date)),
(N'MX005', N'Lê Nhật Minh', N'Nam', 1234571, N'minhln@mxco.com', N'Sài Gòn', 3000, N'Trưởng phòng dữ liệu', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX006', N'Nguyễn Hữu Đạt', N'Nam', 1234572, N'datnh@mxco.com', N'Hà Nội', 2999, N'Phó phòng dữ liệu', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX007', N'Trần Đức Thuận', N'Nam', 1234573, N'thuantd@mxco.com', N'Sài Gòn', 3001, N'Giám đốc công nghệ', 1, N'Head Office', CAST(N'2020-01-01' AS Date)),
(N'MX008', N'Nguyễn Ngọc Minh', N'Nam', 1234574, N'minhnn@mxco.com', N'Quảng Bình', 100, N'Giữ xe', 3, N'Nghiệp vụ', CAST(N'2020-01-01' AS Date)),
(N'MX009', N'Đoàn Ngọc Thảo', N'Nữ', 1234575, N'thaodn@mx.com', N'Long An', 2000, N'Chuyên viên phân tích rủi ro', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX010', N'Lê Thảo Mai', N'Nữ', 1234576, N'mailt@mxco.com', N'Bình Phước', 1000, N'Kế toán', 5, N'Kế toán', CAST(N'2020-01-01' AS Date)),
(N'MX011', N'Nguyễn Quốc Huy', N'Nam', 1234577, N'huynq@mxco.com', N'Sài Gòn', 2000, N'Kĩ sư AI', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX012', N'Trần Đăng Khoa', N'Nam', 1234578, N'khoatd@mxco.com', N'Đồng Nai', 2000, N'Kĩ sư AI', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX013', N'Nguyễn Trần Trung Hiếu', N'Nam', 1234579, N'hieuntt@mxco.com', N'Quảng Nam', 2000, N'Chuyên viên phân tích rủi ro', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX014', N'Nguyễn Trung Hiếu', N'Nam', 1234580, N'hieunt@mxco.com', N'Hà Nội', 4999, N'Giám đốc sản phẩm', 1, N'Head Office', CAST(N'2020-01-01' AS Date)),
(N'MX015', N'Nguyễn Văn Cường ', N'Nữ', 1234581, N'cuongnv@mxco.com', N'Hà Nội', 100, N'Bảo vệ', 3, N'Nghiệp vụ', CAST(N'2020-01-01' AS Date)),
(N'MX016', N'Trần Ngọc Tân', N'Nữ', 1234582, N'tantn@mxco.com', N'Hà Nội', 100, N'Bảo vệ', 3, N'Nghiệp vụ', CAST(N'2020-01-01' AS Date)),
(N'MX017', N'Lê Đức Hiếu', N'Nam', 1234583, N'hieuld@mxco.com', N'Hà Nội', 2000, N'Giám đốc bán hàng', 5, N'Sales', CAST(N'2020-01-01' AS Date)),
(N'MX018', N'Lê Quỳnh Trang', N'Nữ', 1234584, N'tranglq@mxco.com', N'Hà Nội', 2000, N'Chuyên viên phân tích rủi ro', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX019', N'Trần Đức Trung', N'Nam', 1234585, N'trungtd@mxco.com', N'Hà Nội', 3000, N'Trưởng phòng sản phẩm AI', 4, N'Data', CAST(N'2020-01-01' AS Date)),
(N'MX020', N'Nguyễn Đức Bình', N'Nam', 1234586, N'binhnd@mxco.com', N'Quảng Ninh', 1000, N'Nhân viên bán hàng', 5, N'Sales', CAST(N'2020-01-01' AS Date)),
(N'MX021', N'Đỗ Ngọc Ánh', N'Nữ', 1234587, N'anhdn@mxco.com', N'Hà Nội', 1000, N'Nhân viên bán hàng', 5, N'Sales', CAST(N'2020-01-01' AS Date)),
(N'MX022', N'Nguyễn Ngọc Anh ', N'Nữ', 1234588, N'anhnn@mxco.com', N'Hà Nội', 1000, N'Nhân viên bán hàng', 5, N'Sales', CAST(N'2020-01-11' AS Date)),
(N'MX023', N'Nguyễn Văn Đức', N'Nam', 1234589, N'anlh@mxco.com', N'Hải Phòng', 1000, N'Nhân viên bán hàng', 5, N'Sales', CAST(N'2020-01-20' AS Date)),
(N'MX024', N'Trần Hải Đăng', N'Nam', 1234590, N'ducth@mxco.com', N'Hải Phòng', 1000, N'Nhân viên bán hàng', 5, N'Sales', NULL),
(N'MX025', N'Nguyễn Hoài Linh', N'Nữ', 1234591, N'linhnh@mxco.com', N'Hải Phòng', 1000, N'Nhân viên bán hàng', 5, N'Sales', NULL),
(N'MX026', N'Nguyễn Thị Linh', N'Nữ', 1234592, N'linhnt@mxco.com', N'Hải Phòng', 1000, N'Nhân viên bán hàng', 5, N'Sales', NULL)
GO;

/****** Object:  Insert [dbo].[SANPHAM] ******/
Insert into [dbo].[SANPHAM]
VALUES
(N'MXSP01', N'Chip máy tính Intel', N'1', N'Chip', N'55', N'02/02/2022', N'10/10/2024'),
(N'MXSP02', N'Chip máy tính Amd', N'1', N'Chip', N'50', N'02/02/2022', N'10/10/2024'),
(N'MXSP03', N'Màn hình máy tính LG', N'2', N'Monitor', N'100', N'02/02/2022', N'10/10/2024'),
(N'MXSP04', N'Màn hình máy tính Mac', N'2', N'Monitor', N'280', N'02/02/2022', N'10/10/2024'),
(N'MXSP05', N'Màn hình máy tính Sony', N'2', N'Monitor', N'180', N'02/06/2022', N'10/10/2024'),
(N'MXSP06', N'Bàn phím cơ Razer', N'3', N'Keyboard', N'60', N'02/07/2022', N'10/10/2024'),
(N'MXSP07', N'Bàn phím cơ DareU', N'3', N'Keyboard', N'40', N'02/07/2022', N'10/10/2024'),
(N'MXSP08', N'Bàn phím cơ Rapoo', N'3', N'Keyboard', N'62', N'02/07/2022', N'10/10/2024'),
(N'MXSP09', N'Chuột Logitech', N'4', N'Mouse', N'30', N'02/07/2022', N'10/10/2024'),
(N'MXSP10', N'Chuột Asus', N'4', N'Mouse', N'60', N'02/07/2022', N'10/10/2024'),
(N'MXSP11', N'Chuột HyperX', N'4', N'Mouse', N'80', N'02/07/2022', N'10/10/2024'),
(N'MXSP12', N'Tai nghe Sony', N'5', N'Headphone', N'35', N'02/10/2022', N'10/10/2024'),
(N'MXSP13', N'Tai nghe Razer', N'5', N'Headphone', N'30', N'02/10/2022', N'10/10/2024'),
(N'MXSP14', N'Tai nghe HyperX', N'5', N'Headphone', N'40', N'02/10/2022', N'10/10/2024'),
(N'MXSP15', N'RAM Desktop 4GB', N'6', N'RAM', N'25', N'02/10/2022', N'10/10/2024'),
(N'MXSP16', N'RAM Desktop 8GB', N'6', N'RAM', N'42', N'02/10/2022', N'10/10/2024'),
(N'MXSP17', N'RAM Desktop 16GB', N'6', N'RAM', N'80', N'02/13/2022', N'10/10/2024'),
(N'MXSP18', N'Ổ cứng HDD 512 GB', N'7', N'Disk', N'32', N'02/13/2022', N'10/10/2024'),
(N'MXSP19', N'Ổ cứng HDD 1 TB', N'7', N'Disk', N'60', N'02/13/2022', N'10/10/2024'),
(N'MXSP20', N'Ổ cứng SSD 128 GB', N'7', N'Disk', N'30', N'02/16/2022', N'10/10/2024'),
(N'MXSP21', N'Ổ cứng SSD 512GB', N'7', N'Disk', N'59', N'02/17/2022', N'10/10/2024')
GO;