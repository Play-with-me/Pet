# A04-K — chuyển tiếp cùng silhouette, 30/10/2026

Leader duyệt sửa J và tiếp tục plan. Phạm vi: nguồn SVG/PNG chuyển tiếp start/stop và metadata/preview riêng; không sửa runtime, Brain, body, motor, planner, defaultpack, dependency hoặc lockfile. Không subagent. Fetch origin thành công, giữ nguyên checkout đang có thay đổi.

## Kết quả
- Partial pack mới: resources/characters/senko-160/side-sequence-grounded-v8. Giữ54 ảnh đi J byte nguyên, thay idle_side bằng tư thế chân đứng riêng cùng lớp hakama; các hướng đứng khác vẫn là mẫu cũ.
- Tạo ba chuyển tiếp walk_start/walk_stop/walk_stop_sync27. SVG vẽ lại đường ankle/tabi theo vị trí từng chân, lần lượt thu chân với độ nâng thấp; không biến dạng raster. 146 hàng trên và mép hakama giữ nguồn J.
- Mỗi clip400ms. Sau rasterization phát hiện trùng tư thế do bước pixel nhỏ, đã gộp hold:14/14/18 hình riêng biệt thay18/18/18 tham chiếu. Không gọi đây là45drawing/s hoàn chỉnh. Còn cần cải thiện tư thế thân/tay/đuôi và nhịp chuẩn bị, không chỉ thêm frame.
- Endpoint alias idle→start→walk0 và walk0/27→stop→idle kiểm tra đạt. Đây là asset draft, chưa nối production Animator hoặc thay app đang chạy.
- Preview manifest chính: resources/characters/senko-160/transitions-review-v2/index.html. v1 trước gộp hold là lịch sử.

## Kiểm tra thực chạy
Audit Python/Pillow read-only: kích thước160, hardalpha,146hàng trên byte giống model, contacts trên pixel đục, endpoint alias,400ms,14/14/18 unique đạt. Công cụ Rust --manifest-player nạp pack bằng SpriteLibrary và xuất preview thành công. Đã xem montage15tư thế, giữ nét quần và không có ống chân dài; chưa xem playback browser/native Present mới, chưa đánh giá độ tự nhiên toàn chuỗi. Log/scripts/montage/audit.json trong ai/logs/SENKO-ANIM-A04-K.

Chưa build release, chưa test native, chưa soak30phút; không có thay đổi productioncode để khẳng định regression mới. A04 vẫn mở; run/các hướng/quay đầu/arm-tail và chuyển tiếp chất lượng còn lại. A05..A09 không chuyển giai đoạn. CHANGELOG bỏ qua vì cùng tính năng chưa phát hành; không commit/push.

Nguồn SVG transitions-v2; thư mục side-sequence-grounded-v7/transitions-v1 là output khởi tạo dở do sai đường dẫnSVG, không dùng. Không ghi đè hoặc xóa nguồn cũ. Công cụ author_transitions.cjs và compact_holds.cjs lưu rõ bước sản xuất; renderer Sharp hiện có, không thêm dependency.
