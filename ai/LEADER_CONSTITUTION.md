# 🛡️ HIẾN PHÁP LEADER & HỆ THỐNG RÀNG BUỘC AI (LEADER CONSTITUTION)

> **Mục đích:** Ràng buộc bất biến đối với cả **Codex** và **Antigravity (Gen)**. Ngăn chặn triệt để tình trạng AI tự ý "phóng lao", đi chệch kế hoạch, tự thêm tính năng hoặc can thiệp sai phạm vi dù đã có sơ đồ và plan.

---

## ⛔ 5 ĐIỀU RĂN BẤT BIẾN (IMMUTABLE RULES)

### ĐIỀU 1: RÀNG BUỘC PHẠM VI FILE (STRICT FILE BOUNDARY)
* **Codex chỉ được sửa:** Các file logic, runtime, platform, build, config trong `BongoCat/crates/`, `Cargo.toml`, `build.bat`, `run.bat`.
* **Antigravity chỉ được sửa:** Các file tài liệu nghiên cứu `ai/`, tài nguyên hình ảnh/sprite `assets/`, định nghĩa tư thế và manifest.
* ❌ **CẤM:** Không bên nào được tự ý sửa file thuộc quyền của bên kia. Nếu phát hiện vi phạm, công việc lượt đó lập tức bị hủy bỏ và hoàn tác.

### ĐIỀU 2: KHÓA CHỨC NĂNG CỨNG (FEATURE SCOPE LOCK)
* Chỉ được phép làm **đúng 100% các hành vi đã được Leader duyệt** trong [ai/PROJECT_MASTER_PLAN.md](PROJECT_MASTER_PLAN.md).
* ❌ **CẤM:**
  - Tuyệt đối không tự thêm tính năng mới (kể cả phím tắt, âm thanh, chat AI, nhắc deadline cũ...).
  - Tuyệt đối không tự ý "tối ưu hóa" hoặc "cải tiến" làm thay đổi hợp đồng module đã chốt.
  - Mọi ý tưởng mới bắt buộc phải lập đề xuất trình Leader duyệt trong chat và dừng lại chờ lệnh.

### ĐIỀU 3: BẰNG CHỨNG THỰC TẾ (EVIDENCE OVER CLAIMS)
* ❌ **CẤM:** Tuyệt đối không báo cáo "đã hoàn thành", "đã chạy mượt" nếu chưa thực sự chạy lệnh kiểm tra và có log bằng chứng.
* Phân biệt rành mạch:
  - `Đã nghiên cứu lý thuyết` $\neq$ `Đã code xong`.
  - `Đã code xong` $\neq$ `Đã chạy thử trên màn hình Windows`.

### ĐIỀU 4: VÉ PHÊ DUYỆT BẮT BUỘC (TICKET-FIRST WORKFLOW)
Trước khi bắt đầu gõ bất kỳ dòng code nào, AI phải in ra **"Khung Cam Kết Lượt Làm Việc"** gồm:
1. `Mã Ticket:` (Ví dụ A-01, C-01)
2. `Danh sách chính xác các file dự kiến sửa:` (Không sửa ngoài danh sách này)
3. `Hành vi duy nhất triển khai:`
4. `Lệnh kiểm tra sẽ chạy:`

### ĐIỀU 5: CƠ CHẾ DỪNG KHẨN CẤP (CIRCUIT BREAKER)
* Nếu một AI phát hiện đối phương hoặc chính mình có dấu hiệu đi chệch kế hoạch:
  - Lập tức dừng mọi thao tác ghi file.
  - Báo cáo khẩn cấp cho Leader trong chat.
  - Ghi cờ `[ALERT: SCOPE DRIFT]` vào `ai/SYNC.md`.

### ĐIỀU 6: HỖ TRỢ ĐỒNG ĐỘI & NGUYÊN TẮC CHỈ DEBUG (MUTUAL SUPPORT & STRICT DEBUGGING)
* **Hỗ trợ nhau tối đa:** Hai bên chủ động cung cấp thông tin, phân tích log, giải thích mã nguồn và cùng nhau fix lỗi (ví dụ: Antigravity hỗ trợ Codex kiểm tra tọa độ hình học/tính toán góc xoay; Codex hỗ trợ Antigravity kiểm tra đường render/pipeline).
* ⚠️ **LƯU Ý CỐT LÕI TỪ LEADER:** Chỉ tập trung **DEBUG VÀ SỬA LỖI** để làm cho các tính năng đã duyệt hoạt động trơn tru.
* ❌ **CẤM:** Tuyệt đối không được nhân danh "debug" để đẻ ra vấn đề mới, mở rộng phạm vi, thêm tính năng mới hoặc thay đổi kiến trúc ngoài duyệt.

---

## 🚦 DANH SÁCH TÍNH NĂNG ĐƯỢC DUYỆT DUY NHẤT (WHITE-LIST CHO GIAI ĐOẠN 1)

Bất kỳ dòng code nào không phục vụ các mục dưới đây đều là **VI PHẠM**:
- [ ] Người que hiển thị dạng hình học (đầu tròn, thân và tứ chi bằng đường thẳng — đang chờ spike render).
- [ ] Chịu trọng lực (rơi tự do xuống đáy vùng làm việc Windows).
- [ ] Kéo chuột trái để nhấc lên; thả chuột để rơi; lia nhanh để ném có quán tính.
- [ ] Tiếp đất nảy nhẹ (bounce 4px) và đứng dậy.
- [ ] Leo trèo khi va vào mép trái / mép phải màn hình.
- [ ] Né hoặc đuổi con trỏ chuột khi đến gần.
- [ ] Menu chuột phải: Tạm dừng / Tiếp tục, Đưa về vị trí an toàn, Thoát.
