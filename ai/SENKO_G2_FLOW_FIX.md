# SENKO-G2-FLOW — sửa khựng và gait giả

Ngày 28/10/2026. Phạm vi theo phản hồi trực tiếp của Leader; GĐ2 chưa nghiệm thu, chưa triển khai GĐ3–GĐ5.

## Thay đổi

- Bản `candidate-v5-flow`: 233 PNG/45 clip, đi/chạy ngang tăng từ8 lên16 pha. Giữ đầu lớn/chân ngắn; nguồn AI cùng tham chiếu chibi, prompt và SHA lưu riêng. Chỉ thay hai gait;201 PNG/43 clip khác giữ nguyên byte.
- Đi: stride6px, chu kỳ96px; chạy: stride8px, chu kỳ128px. Giữ tốc độ tối đa110/280px/s và phase theo quãng đường tự di chuyển. Tăng số pha không kéo dài chu kỳ.
- Cho phép thân tăng tốc trong clip bắt đầu; gia tốc/giảm tốc bị giới hạn900px/s². Hạ vận tốc khi gần đích và khi hoàn tất bước; ngân sách chuyển động luôn chặn mép và mục tiêu con trỏ. Không ghi vận tốc này vào physics velocity.
- Pacing trừ thời gian xử lý/Present khỏi ngân sách16,67ms. Baseline đã60,2Present/s, sau59–59,2/s trong phép đo5giây: không tuyên bố tăng FPS. Gait8ảnh trước chỉ khoảng9pha/s khi đi110px/s;16ảnh mới khoảng18pha/s.
- Preview liên tục dùng bảng phase/frame từ Animator Rust và nền cuộn, bỏ điểm đặt lại vị trí/đoạn chờ đầu của GIF so sánh cũ. Đây là preview asset, không phải đo FPS native hoặc chứng minh chuyển tiếp production.

## Kiểm tra thực hiện

Log: `ai/logs/SENKO-G2-FLOW/`.

- Animator9test; render28test; pipeline9test đạt. Session cuối9test đạt, gồm4native.
- Native đủ16frame mỗi gait khi thân di chuyển (walk197,34px, run441,54px trong bài thử);295Present/5giây=59/s. GPU xác nhận Nearest4×4 và Linear mặc định; kéo/thả, pause/reset/exit đạt.
- Windows GDI+ đọc233PNG/45GIF:80×80/320×320,32RGBA, hard alpha và tất cả frame khác nhau.201PNG không liên quan byte-identical;43duration giữ nguyên. Đi/chạy giữ880/480ms preview,96/128px chu kỳ.
- Clippy ba crate/all-targets với feature asset-tools, fmt các file sở hữu, release build đạt. JavaScript preview qua kiểm tra cú pháp Node.
- Release SHA256 `467858997B93914E420AFDA1B869DCF709A277BCEEA1E5426C8B8A1F2C4834FE`; đã mở PID40668, launcher/shortcut dùngv5, có backup shortcut. Chi tiết chống mở trùng trong lifecycle.json.

## Giới hạn và bàn giao

Đã xem contact sheet đi/chạy mới; không coi sốframe/test là chứng nhận thẩm mỹ. Browser tự động bị chính sách URL chặn file://, nên chưa kiểm định preview trong trình duyệt; không lách bằng cơ chế khác. Chưa QA chuột tay, chưa soak30phút binary mới, chưa macOS/full workspace. Full overlay lượt trước còn testcase topmost thất bại đã có lịch sử baseline; không sửa ngoài phạm vi hoặc gọi toàn repo xanh.

GĐ2 chờ Leader đánh giá nhịp/cảm giác dễ thương trên bản chạy. Không commit/push/đổi nhánh/sửa bàn giao Gen. Upstream47a73ed1 đã fetch nhưng chưa merge vào dirty tree. CHANGELOG bỏ qua vì tiếp tục tính năng Senko chưa phát hành; không có dữ liệu người dùng cần xóa.
