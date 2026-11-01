-- ==========================================
-- BÀI TẬP MINI TEST: QUẢN LÝ DANH BẠ BẠN BÈ
-- ==========================================

---------------------------------------------
-- 1. TẠO BẢNG (DDL)
---------------------------------------------

-- Bảng 1: Bạn Bè
CREATE TABLE ban_be (
    ma_ban_be BIGINT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_ban_be PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    cong_ty VARCHAR(100),
    ghi_chu TEXT
);

-- Bảng 2: Số Điện Thoại
CREATE TABLE so_dien_thoai (
    ma_so_dien_thoai BIGINT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_so_dien_thoai PRIMARY KEY,
    ma_ban_be BIGINT NOT NULL,
    so_dien_thoai VARCHAR(20) NOT NULL,
    loai_sdt VARCHAR(50) DEFAULT 'Di động',
    CONSTRAINT fk_sdt_banbe FOREIGN KEY (ma_ban_be) 
        REFERENCES ban_be(ma_ban_be) ON DELETE CASCADE
);

-- Bảng 3: Nhóm Quan Hệ
CREATE TABLE nhom_quan_he (
    ma_nhom INT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_nhom_quan_he PRIMARY KEY,
    ten_nhom VARCHAR(50) NOT NULL UNIQUE,
    mo_ta VARCHAR(255)
);

-- Bảng 4: Bảng Trung Gian Bạn Bè - Nhóm Quan Hệ
CREATE TABLE ban_be_nhom (
    ma_ban_be BIGINT NOT NULL,
    ma_nhom INT NOT NULL,
    CONSTRAINT pk_ban_be_nhom PRIMARY KEY (ma_ban_be, ma_nhom),
    CONSTRAINT fk_bbn_banbe FOREIGN KEY (ma_ban_be) 
        REFERENCES ban_be(ma_ban_be) ON DELETE CASCADE,
    CONSTRAINT fk_bbn_nhom FOREIGN KEY (ma_nhom) 
        REFERENCES nhom_quan_he(ma_nhom) ON DELETE CASCADE
);


---------------------------------------------
-- 2. NẠP VÀ THAO TÁC DỮ LIỆU (DML)
---------------------------------------------

-- 2.1. Thêm 2 nhóm: 'Bạn học' và 'Đồng nghiệp'
INSERT INTO nhom_quan_he (ten_nhom, mo_ta) 
VALUES 
    ('Bạn học', 'Nhóm bạn học phổ thông, đại học'),
    ('Đồng nghiệp', 'Nhóm đồng nghiệp làm cùng công ty');

-- 2.2. Thêm 1 người bạn: 'Nguyễn Bá Công', SĐT '0382905999', Công ty 'VTI', thuộc nhóm 'Đồng nghiệp'
-- Thêm thông tin bạn
INSERT INTO ban_be (ho_ten, email, cong_ty, ghi_chu) 
VALUES ('Nguyễn Bá Công', 'cong.nguyen@vti.com.vn', 'VTI', 'Lập trình viên');

-- Thêm số điện thoại cho Nguyễn Bá Công
INSERT INTO so_dien_thoai (ma_ban_be, so_dien_thoai, loai_sdt)
VALUES (
    (SELECT ma_ban_be FROM ban_be WHERE ho_ten = 'Nguyễn Bá Công' LIMIT 1),
    '0382905999',
    'Di động'
);

-- Gán nhóm 'Đồng nghiệp' cho Nguyễn Bá Công
INSERT INTO ban_be_nhom (ma_ban_be, ma_nhom)
VALUES (
    (SELECT ma_ban_be FROM ban_be WHERE ho_ten = 'Nguyễn Bá Công' LIMIT 1),
    (SELECT ma_nhom FROM nhom_quan_he WHERE ten_nhom = 'Đồng nghiệp' LIMIT 1)
);

-- 2.3. Sửa người bạn Nguyễn Bá Công => Lê Việt Anh, 0382905999 => 0123456789
-- Cập nhật tên trong bảng ban_be
UPDATE ban_be
SET ho_ten = 'Lê Việt Anh'
WHERE ho_ten = 'Nguyễn Bá Công';

-- Cập nhật số điện thoại trong bảng so_dien_thoai
UPDATE so_dien_thoai
SET so_dien_thoai = '0123456789'
WHERE so_dien_thoai = '0382905999';

-- 2.4. Xóa 1 người bạn (Ví dụ xóa bạn 'Lê Việt Anh')
-- Nhờ ràng buộc ON DELETE CASCADE, dữ liệu liên quan ở bảng so_dien_thoai và ban_be_nhom sẽ tự động bị xóa theo.
DELETE FROM ban_be
WHERE ho_ten = 'Lê Việt Anh';


---------------------------------------------
-- 3. TRUY VẤN DỮ LIỆU (SELECT)
---------------------------------------------

-- Câu a: Lấy danh sách bạn bè làm ở công ty 'VTI', sắp xếp tên từ A-Z.
SELECT ma_ban_be, ho_ten, email, cong_ty, ghi_chu
FROM ban_be
WHERE cong_ty = 'VTI'
ORDER BY ho_ten ASC;

-- Câu b (JOIN): Lấy ra Họ tên, Số điện thoại và Tên nhóm của tất cả bạn bè thuộc nhóm 'Đồng nghiệp'.
SELECT 
    bb.ho_ten,
    sdt.so_dien_thoai,
    nqh.ten_nhom
FROM ban_be bb
JOIN so_dien_thoai sdt ON bb.ma_ban_be = sdt.ma_ban_be
JOIN ban_be_nhom bbn ON bb.ma_ban_be = bbn.ma_ban_be
JOIN nhom_quan_he nqh ON bbn.ma_nhom = nqh.ma_nhom
WHERE nqh.ten_nhom = 'Đồng nghiệp';

-- Câu c (GROUP BY): Đếm số lượng bạn bè trong từng nhóm quan hệ.
SELECT 
    nqh.ten_nhom,
    COUNT(bbn.ma_ban_be) AS so_luong_ban_be
FROM nhom_quan_he nqh
LEFT JOIN ban_be_nhom bbn ON nqh.ma_nhom = bbn.ma_nhom
GROUP BY nqh.ma_nhom, nqh.ten_nhom
ORDER BY so_luong_ban_be DESC;