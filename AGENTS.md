# Quy tắc phối hợp trong workspace Pet

Bản đồ điều hướng: [PROJECT_MAP.md](PROJECT_MAP.md). Dùng bản đồ để tìm module,
nguồn tài liệu và file kiểm tra; sau đó thực hiện thứ tự đọc bắt buộc dưới đây.

Ngữ cảnh sản phẩm đã chốt: [ai/PROJECT_MASTER_PLAN.md](ai/PROJECT_MASTER_PLAN.md).
Đọc thêm tin mới trong [ai/SYNC.md](ai/SYNC.md) khi bắt đầu/tiếp tục lượt.

Người dùng là leader; Codex và Gen được trực tiếp trao đổi, chia nhỏ việc và phối
hợp kỹ thuật trong kế hoạch đã giao theo [ai/TEAM_PROTOCOL.md](ai/TEAM_PROTOCOL.md).
Không yêu cầu leader chuyển lời. Cờ lượt SYNC không chặn phần việc độc lập đã giao.

**Luật duyệt chức năng:** Không tự ý thêm/bớt/sửa chức năng hoặc hành vi khác nội
dung leader đã duyệt, kể cả hai AI đồng ý. Có nhu cầu/đề xuất hoặc phát hiện đã thay
đổi ngoài duyệt phải báo leader ngay trong chat, ghi SYNC và dừng phần liên quan;
chỉ sửa sau khi leader cho phép rõ ràng. Xem TEAM_PROTOCOL. Chỉ triển khai đúng phần
đã được duyệt; quyền chia nhỏ việc không phải quyền tự đổi chức năng.

Trước khi sửa, đọc:
1. `AI_COLLABORATION_REPORT.md`.
2. `TASKS.md`.
3. `HANDOFF_CODEX.md` và `HANDOFF_ANTIGRAVITY.md`.
4. Hướng dẫn riêng của repository và mã liên quan đến nhiệm vụ.

Tuân thủ phân công trong báo cáo. Chỉ dẫn trực tiếp mới nhất của người dùng có thể
thay đổi phạm vi; ghi ngoại lệ khi bàn giao. Không tự sửa quy tắc để mở rộng quyền.

- Codex: logic, cấu hình, tích hợp, kiểm tra, build.
- Antigravity: giao diện, nhân vật, asset và hoạt ảnh.
- Không sửa chéo phạm vi hoặc ghi đè công việc đang có.
- Kế hoạch đề xuất không phải lệnh tự bắt đầu.
- Ghi ID và phạm vi trước khi làm; bàn giao vào file riêng cuối lượt.
- Báo cáo tiếng Việt; chỉ khẳng định kiểm tra đã thực hiện.
- Không lưu nội dung phím, không chặn GUI, giữ ứng dụng nhẹ và cục bộ theo yêu cầu.

Hiện có repository BongoCat, còn mã Python DeskBuddy cũ không thấy ở thư mục gốc.
Phân công đường dẫn Python trong báo cáo là lịch sử; phải xác định quyền sở hữu
theo mã thực tế trước khi sửa BongoCat. Giữ và đọc `BongoCat/AGENTS.md` cùng các
hướng dẫn liên quan; nếu xung đột chưa giải quyết được, báo rõ trước khi sửa phần đó.

Tài liệu không tạo khóa file hoặc tự điều phối AI.
