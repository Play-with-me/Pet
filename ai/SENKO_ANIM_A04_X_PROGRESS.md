# SENKO-ANIM-A04-X — bàn giao 31/10/2026

## Phạm vi
Thử lớp đầu ổn định trong renderer preview, dùng nguồn W chưa đạt làm đối chứng. Thêm CLI --head-stability160 và template Canvas; không sửa PNG nguồn, manifest production, runtime, mask tương tác, Brain hoặc vật lý.

## Kết quả
Preview cuối: resources/characters/senko-160/head-stability-review-v3/index.html. Trái là frame gốc, phải dùng đầu frame0 trong polygon chữ L và giữ phần còn lại theo frame gốc. Hai bên dùng chung clock54frame/1200ms; có pause, scrub, mirror, tắt lớp giữ đầu và xem biên ghép. v1 còn tóc bóng kép; v2 cắt phần đuôi trên; v3 loại góc đuôi khỏi vùng giữ đầu.

Đã xem diagnostic frame1/frame27 của v3: mặt ổn định hơn đối chứng; chưa kết luận đường tóc–cổ, dáng và mối nối đạt nghiệm thu. Lớp này đóng băng biểu cảm/chi tiết trong polygon, không phải giải pháp cuối cho mọi clip.

## Kiểm tra thực hiện
- Asset tool 20/20; Clippy -D warnings đạt trên trạng thái cuối.
- Offline chạy chính JavaScript preview bằng napi Canvas: đủ54frame, vùng đầu1hash, toàn hình54hash, mọi pixel ngoài polygon giống đối chứng, mọi PNG copy giống byte nguồn. Kiểm tra load gate, timeline, lock off, mirror, guide, reset, play/pause đạt. Log: ai/logs/SENKO-ANIM-A04-X/v3/canvas-audit.json.
- Đây là offline Canvas, không phải xác minh browser/GPU/native Present. Cửa sổ game đang foreground nên không đưa app lên trước hoặc thao tác lên game. Lệnh mở preview được gửi, chưa xác nhận playback trực tiếp trong browser.

## Còn lại
Duyệt chất lượng vùng nối và phương pháp lớp đầu trước khi áp dụng vào pack. Chưa đổi ứng dụng/default/release; chưa nghiệm thu45FPS, chân tiếp xúc hay A04. Không subagent/commit/push; CHANGELOG để khi phát hành.
