use CtyMX

-- BT1:

ALTER TABLE HOADON 
ADD CONSTRAINT PK_HOADON PRIMARY KEY (OrderLine)

ALTER TABLE SANPHAM  
ADD CONSTRAINT PK_SANPHAM PRIMARY KEY (ProductId)

ALTER TABLE NHANVIEN  
ADD CONSTRAINT PK_NHANVIEN PRIMARY KEY (EmID)

ALTER TABLE HOADON  
ALTER COLUMN ProductID varchar(50)

ALTER TABLE HOADON 
ADD CONSTRAINT SANPHAM_sID_FK_HOADON
FOREIGN KEY (ProductID) REFERENCES SANPHAM(ProductId)

ALTER TABLE HOADON 
ADD CONSTRAINT NHANVIEN_sID_FK_HOADON
FOREIGN KEY (SalesID) REFERENCES NHANVIEN(EmID)

-- BT2: Bạn hãy chuẩn bị dữ liệu bằng cách lấy ra các đơn hàng có ngày lập hoá đơn trước ngày 3/4/2022 (MM/DD/YYYY)

select *
FROM  HOADON h 
WHERE h.DateCreate < '2022-03-04'

select *
from HOADON h 
WHERE h.DateCreate  < DATEFROMPARTS(2022,3,4) 

-- BT3: 
-- BT3.1:

select *
from NHANVIEN n 
where n.Address in (N'Quảng Bình', N'Quảng Trị')

-- BT3.2:

select *
from NHANVIEN n 
where n.Address in (N'Nghệ An', N'Hà Tĩnh', N'Quảng Bình', N'Quảng Trị', N'Thừa Thiên Huế')

select *
from NHANVIEN n 
where n.Address not in (N'Nghệ An', N'Hà Tĩnh', N'Quảng Bình', N'Quảng Trị', N'Thừa Thiên Huế')

-- BT4:

select *, isnull(StartDate,'2020-01-01')
from NHANVIEN n 

