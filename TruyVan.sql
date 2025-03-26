USE QUANLIDETAI
GO

----------------------------------------------TRUY VẤN-------------------------------------------------
--1.Cho biết họ tên và mức lương của các giáo viên nữ.
SELECT HOTEN, LUONG
FROM GIAOVIEN
WHERE PHAI = N'Nữ'

--2.Cho biết họ tên của các giáo viên và lương của họ sau khi tăng 10%.
SELECT HOTEN, LUONG, LUONG*1.1 AS '10%'
FROM GIAOVIEN

--3.Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 hoặc, giáo viên là trưởng bộ môn nhận chức sau năm 1995.
SELECT MAGV
FROM GIAOVIEN JOIN BOMON
ON GIAOVIEN.MABM = BOMON.MABM
WHERE (HOTEN LIKE N'Nguyễn%' AND LUONG > 2000) OR DATEDIFF(Year, YEAR(NGAYNHANCHUC), 1995) > 0

--4.Cho biết tên những giáo viên khoa Công nghệ thông tin.
SELECT MAGV, HOTEN
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MABM = BM.MABM
JOIN KHOA AS K ON BM.MAKHOA = K.MAKHOA
WHERE TENKHOA = N'Công nghệ thông tin'

--5.Cho biết thông tin của bộ môn cùng thông tin giảng viên làm trưởng bộ môn đó.
SELECT BM.*
FROM BOMON AS BM JOIN GIAOVIEN AS GV
ON BM.MABM = GV.MABM
WHERE BM.TRUONGBM = GV.MAGV

--6.Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
SELECT GV.MAGV, GV.HOTEN, BM.*
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MABM = BM.MABM

--7.Cho biết tên đề tài và giáo viên chủ nhiệm đề tài.
SELECT DT.TENDT, DT.GVCNDT, GV.HOTEN
FROM DETAI AS DT JOIN GIAOVIEN AS GV
ON DT.GVCNDT = GV.MAGV

--8.Với mỗi khoa cho biết thông tin trưởng khoa.
SELECT GV.*
FROM KHOA AS K JOIN GIAOVIEN AS GV
ON K.TRUONGKHOA = GV.MAGV
WHERE K.TRUONGKHOA = GV.MAGV

--9.Cho biết các giáo viên của bộ môn “Vi sinh” có tham gia đề tài 006.
SELECT DISTINCT GV.*
FROM BOMON AS BM JOIN GIAOVIEN AS GV
ON BM.MABM = GV.MABM
JOIN THAMGIADT AS TGDT
ON GV.MAGV = TGDT.MAGV
WHERE BM.TENBM = N'Vi sinh' AND TGDT.MADT = '006'

SELECT GV.*
FROM BOMON AS BM JOIN GIAOVIEN AS GV
ON BM.MABM = GV.MABM
JOIN DETAI AS DT
ON GV.MAGV = DT.GVCNDT
WHERE BM.TENBM = N'Vi sinh' AND DT.MADT = '006'

--10.Với những đề tài thuộc cấp quản lý “Thành phố”, cho biết mã đề tài, đề tài thuộc về chủ đề nào, họ tên người chủ nghiệm đề tài cùng với ngày sinh và địa chỉ của người ấy.
SELECT DT.MADT, DT.TENDT, CD.TENCHD, GV.HOTEN, GV.NGSINH, GV.DIACHI, DT.GVCNDT, DT.CAPQL
FROM DETAI AS DT JOIN GIAOVIEN AS GV
ON DT.GVCNDT = GV.MAGV
JOIN CHUDE AS CD
ON DT.MACD = CD.MACD
WHERE DT.CAPQL = N'Thành phố' AND DT.GVCNDT = GV.MAGV 
-- RỖNG DO KHÔNG CÓ CẤP QL THÀNH PHỐ

--11.Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó.
SELECT GV1.HOTEN, GV2.HOTEN
FROM GIAOVIEN AS GV1 JOIN GIAOVIEN AS GV2
ON GV1.MAGV = GV2.GVQLCM


--12.Tìm họ tên của những giáo viên được “Nguyễn Thanh Tùng” phụ trách trực tiếp.
SELECT GV1.HOTEN
FROM GIAOVIEN AS GV1 JOIN GIAOVIEN AS GV2
ON GV1.MAGV = GV2.GVQLCM
WHERE GV2.HOTEN = N'Nguyễn Thanh Tùng' 
--RỖNG DO KHÔNG CÓ AI ĐC PHỤ TRÁCH BỞI Nguyễn Thanh Tùng


--13.Cho biết tên giáo viên là trưởng bộ môn “Hệ thống thông tin”.
SELECT GV.HOTEN
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MABM = BM.MABM
WHERE BM.TENBM = N'Hệ thống thông tin' AND BM.TRUONGBM = GV.MAGV


--14.Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
SELECT GV.HOTEN
FROM GIAOVIEN AS GV JOIN DETAI AS DT
ON DT.GVCNDT = GV.MAGV
JOIN CHUDE AS CD
ON DT.MACD = CD.MACD
WHERE DT.GVCNDT = GV.MAGV AND CD.TENCHD = N'Quản lý giáo dục'

--15.Cho biết tên các công việc của đề tài HTTT quản lý các trường ĐH có thời gian bắt đầu trong tháng 3/2008
SELECT CV.TENCV
FROM CONGVIEC AS CV JOIN DETAI AS DT
ON CV.MADT = DT.MADT
WHERE DT.TENDT = N'HTTT quản lý các trường ĐH' AND (DT.NGAYBD BETWEEN '3/1/2008' AND '3/31/2008')


--16.Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
SELECT GV1.HOTEN, GV2.HOTEN
FROM GIAOVIEN AS GV1 JOIN GIAOVIEN AS GV2
ON GV1.MAGV = GV2.GVQLCM
--- GIỐNG CÂU 11

--17.Cho các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007
SELECT * 
FROM CONGVIEC AS CV
WHERE CV.NGAYBD BETWEEN '01/01/2007' AND '01/08/2007'


--18.Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”.
SELECT GV_EXTRA.HOTEN
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MABM = BM.MABM
JOIN GIAOVIEN AS GV_EXTRA
ON GV_EXTRA.MABM = BM.MABM
WHERE GV.HOTEN = N'Trần Trà Hương' AND GV_EXTRA.HOTEN <> N'Trần Trà Hương'

--19 Tìm những giáo viên vừa là trưởng bộ môn vừa chủ nhiệm đề tài.
SELECT DISTINCT GV.*
FROM BOMON AS BM JOIN GIAOVIEN AS GV
ON BM.MABM = GV.MABM
JOIN DETAI AS DT
ON GV.MAGV = DT.GVCNDT
WHERE BM.TRUONGBM = GV.MAGV AND GV.MAGV = DT.GVCNDT

SELECT GV.*
FROM GIAOVIEN GV JOIN BOMON BM ON BM.TRUONGBM=GV.MAGV
--INTERSECT -- TỰ ĐỘNG BỎ CÁC DÒNG GIỐNG(DISTINCT)
SELECT GV.*
FROM GIAOVIEN GV JOIN DETAI DT ON DT.GVCNDT=GV.MAGV

--UNION	Hợp hai tập kết quả, loại bỏ dòng trùng
--UNION ALL	Hợp hai tập kết quả, giữ lại tất cả dòng, kể cả dòng trùng
--INTERSECT	Lấy phần giao giữa hai tập kết quả (chỉ các dòng xuất hiện ở cả hai)
--EXCEPT / MINUS	Lấy phần chênh lệch: dòng có ở truy vấn 1 mà không có ở truy vấn 2

--20.Cho biết tên những giáo viên vừa là trưởng khoa vừa là trưởng bộ môn
SELECT GV.HOTEN
FROM GIAOVIEN AS GV JOIN KHOA AS K
ON GV.MAGV = K.TRUONGKHOA
INTERSECT
SELECT GV.HOTEN
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MABM = BM.MABM

--21. Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài
SELECT GV.HOTEN
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MAGV = BM.TRUONGBM
INTERSECT
SELECT GV.HOTEN
FROM GIAOVIEN AS GV JOIN DETAI AS DT
ON GV.MAGV = DT.GVCNDT

--22. Cho biết mã số các trưởng khoa có chủ nhiệm đề tài
SELECT GV.MAGV
FROM KHOA AS K JOIN GIAOVIEN AS GV
ON K.TRUONGKHOA = GV.MAGV
INTERSECT
SELECT GV.MAGV
FROM GIAOVIEN AS GV JOIN DETAI AS DT
ON GV.MAGV = DT.GVCNDT

--23.Cho biết mã số các giáo viên thuộc bộ môn “HTTT” hoặc có tham gia đề tài mã “001”.
SELECT GV.MAGV
FROM GIAOVIEN AS GV 
WHERE GV.MABM = 'HTTT'
UNION
SELECT GV.MAGV
FROM GIAOVIEN AS GV JOIN DETAI AS DT
ON GV.MAGV = DT.GVCNDT
WHERE DT.MADT = '001'

--24.Cho biết giáo viên làm việc cùng bộ môn với giáo viên 002.
SELECT GV_EXTRA.*
FROM GIAOVIEN AS GV JOIN BOMON AS BM
ON GV.MABM = BM.MABM
JOIN GIAOVIEN AS GV_EXTRA
ON BM.MABM = GV_EXTRA.MABM
WHERE GV.MAGV = '002' AND GV_EXTRA.MAGV != '002'


--25.Tìm những giáo viên là trưởng bộ môn.
--SELECT *
--FROM GIAOVIEN AS GV JOIN BOMON AS BM
--ON GV.MABM = BM.MABM
--WHERE GV.MAGV = BM.TRUONGBM
-- BỎ SÓT GV TRƯỞNG KHOA VÌ CỘT MABM TRONG BẢNG GV KHONG CÓ ĐỦ(MỞ BẢNG LÊN ĐỂ CHECK) 
SELECT *
FROM GIAOVIEN GV JOIN BOMON BM ON GV.MAGV = BM.TRUONGBM


--26.Cho biết họ tên và mức lương của các giáo viên.
SELECT HOTEN, LUONG
FROM GIAOVIEN

