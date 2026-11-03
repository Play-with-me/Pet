# SENKO-ANIM-A04-Y — 31/10/2026

## Phạm vi và bàn giao
Tiếp A04-X theo Leader: công cụ rà chân đi3/4 trước trên vạch sàn. CLI mới `--walk34-contact160 <pack> <NEW-output>`, dùng chung writer/copy nguồn với preview lớp đầu. Pack nguồn, PNG, runtime, Brain, vật lý và default không đổi; không subagent.

Preview: resources/characters/senko-160/walk-34-contact-review-v2/index.html. Hai bên raw/lớp đầu, cửa sổ xem chân, tiến/lùi từng frame (có wrap), scrub, mirror, pause, chọn tự đi0/60/120/180px-s, bộ đếm chở80px-s tách khỏi phase. Camera giữ nhân vật, vạch sàn chạy theo quãng đường tương đối. Chở chỉ là tín hiệu mô phỏng/bộ đếm trong harness, không phải thử cửa sổ OS hoặc Body thật.

Frame khoảng cách dùng 54 bước đều trong144px đọc từ stride*framecount của walk_34. 120px-s→1,2s/chu kỳ→45tư thế/s. Không dùng delay timed để bóp méo quãng đường. Kiểm tra đầu vào yêu cầu timed/distance clip cùng54texture/thứ tự, stride dương. Gặp sai trả lỗi trước khi tạo output. Nhịp0 đóng băng phase kể cả bật chở; suspend giới hạn bước100ms trong preview.

## Kiểm tra thực hiện
- Chạy JavaScript thật của HTML bằng offline napi Canvas:54frame, bước53→0/0→53, scrub, mirror, bỏ lớp đầu hai bên giống pixel, pause, chở không tăng phase, suspend clamp, PNGcopy giống byte nguồn.
- 12 ca 30/60/120Hz ×0/60/120/180px-s, mỗi ca10s; quãng đường tự đi bằng tốc độ×10, chở800px, sai số số học<1e-7. Đây không phải đo clock browser10giây thực hoặc GPU cadence.
- Asset tool20/20, Clippy-Dwarnings đạt. Sau chỉnh vùng crop cuối, chạy lại generator và audit đạt. Các log ở ai/logs/SENKO-ANIM-A04-Y.
- Đã xem diagnostic frame40 và chân frame13; phát hiện cropv1 cắt bàn chân, sửa v2 lấy toàn chiều rộng actor. Đã xem lại chânv2 đủ phần hiển thị.
- Lệnh mở preview được gửi (queued), chưa xác nhận playbackbrowser/native; không thao tác cửa sổ khác.

## Giới hạn và bước kế tiếp
Đây là công cụ nghiệm thu, không thêm tư thế hoặc sửa nguồn đi chưa đạt. Baselinealpha không chứng nhận stance/foot-lock, legidentity, vòng nối hoặc thể tích. Cần sửa/duyệt art đi3/4 và nối đầu–cổ, sau đó các hướng còn thiếu; A04 vẫn mở, chưa A05. Không release/soak30phút/default/commit/push. CHANGELOG bỏ qua: cùng tính năng chưa phát hành. Không yêu cầu xóa trạng thái cục bộ.
