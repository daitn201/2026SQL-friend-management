## Nhiệm vụ 1: Thiết kế cấu trúc bảng

### I. Trả lời 4 câu hỏi gợi ý

1. **Cần những bảng nào?**
   Cần **4 bảng**:
   * `ban_be`: Lưu thông tin cá nhân cơ bản (họ tên, email, công ty, ghi chú).
   * `so_dien_thoai`: Lưu danh sách các số điện thoại của từng người.
   * `nhom_quan_he`: Lưu danh mục các nhóm quan hệ (Bạn học, Đồng nghiệp, Gia đình, Khách hàng...).
   * `ban_be_nhom`: Bảng trung gian liên kết giữa bạn bè và nhóm quan hệ tương ứng.

2. **Khóa chính (PK) của mỗi bảng là gì?**
   * Bảng `ban_be`: `ma_ban_be` (`BIGINT GENERATED ALWAYS AS IDENTITY`).
   * Bảng `so_dien_thoai`: `ma_so_dien_thoai` (`BIGINT GENERATED ALWAYS AS IDENTITY`).
   * Bảng `nhom_quan_he`: `ma_nhom` (`INT GENERATED ALWAYS AS IDENTITY`).
   * Bảng `ban_be_nhom`: Khóa chính hợp thành `(ma_ban_be, ma_nhom)`.

3. **Nếu một người có nhiều số điện thoại thì lưu thế nào?**
   * Tách số điện thoại thành một bảng riêng `so_dien_thoai`. Bảng này lưu `ma_ban_be` dưới dạng khóa ngoại (FK) trỏ tới bảng `ban_be`. Mỗi bản ghi tương ứng với 1 số điện thoại của người đó (đảm bảo chuẩn hóa 1NF).

4. **Nếu một người thuộc nhiều nhóm thì quan hệ là 1-N hay N-N?**
   * Một người có thể thuộc **nhiều nhóm** (ví dụ: vừa là Bạn học, vừa là Đồng nghiệp).
   * Một nhóm lại chứa **nhiều người**.
   * Đây là quan hệ **Nhiều - Nhiều (N-N)**. Giải quyết bằng bảng trung gian `ban_be_nhom` chứa 2 khóa ngoại (`ma_ban_be` và `ma_nhom`).

