# S3-01 — hợp đồng thế giới và tọa độ

Ngày28/10/2026. Leader đã duyệt chuyển động GĐ2 bằng “Ổn rồi, bạn tiếp tục dự án đi”.
Lượt này hoàn thành mã nền S3-01 theo vòng triển khai nhỏ; chưa gọi cảGĐ3 hoàn thành.

## Phần đã làm

- `runtime/senko_body.rs`: body riêng của Senko, điểm chân và điểm nắm dùng physical pixels; sprite dùng source pixels×4, anchor(40,76). Body104×248 và HWND320×320 có gốc riêng. Không đổi `PhysicsBody` của người que.
- Grab tách điểm tựa nhưng giữ chân; kéo giữ offset qua tọa độ âm/màn hình khác; release/cancel không teleport. Bỏ mẫu cũ, giữ cap ném2400px/s và quy tắc100ms đã có. Từ chối tọa độ không hữu hạn trước khi làm hỏng trạng thái.
- `runtime/world.rs`: snapshot dữ liệu thuần gồm revision/thời điểm mẫu đơn điệu, từng monitor display/work, cửa sổ theoZ-order, gờ/tường và ID owner/edge/generation. Cửa sổ không leo được vẫn có thể che. Validator từ chối mẫu hỏng, owner lặp hoặc surface ngoài owner; không cho tạo sàn nối khoảng trống giữa màn hình.
- Token cửa sổ giống nhau nhưng generation khác không khôi phục điểm tựa cũ. Scanner tương lai phải đổi generation khi destroy/reuse; S3-01 chưa cung cấp WinEvent hay chứng minh nhận diện native.
- Runner dùng chung phép đổi điểm chân→gốc HWND và desktop→sprite cho alpha hit-test. Hành vi và công thức đặt hình giữ nguyên; nguồn v5 đã duyệt không sửa. Body mới chưa thay body điều khiển đang chạy: nối cùng vật lý world ởS3-04, tránh bật nửa bộ collision.
- ADR0099 và technical-design ghi hợp đồng và các cổng còn lại.

## Kiểm tra thực chạy

Log `ai/logs/SENKO-S3-01/`:

- Runtime148unit +2fixture và renderer28unit đạt; gồm10test mới cho body/world.
- Session9test đạt, gồm4native: kéo/thả/pause/reset/exit;296Present/5giây≈59,2/s; đủ16pha đi/chạy cùng thân di chuyển; GPU4×4pixel và Linear mặc định.
- Clippy ba crate/all-targets/asset-tools, fmt file sửa và `just senko-build` đạt. Release được mở lại bằng asset v5; hash/PID ởrelease.json, kiểm tra instance ởlifecycle.json.

Chưa test cửa sổ thật/đa màn hình hỗn hợpDPI/tháo màn hình; đó làS3-02..07 chưa triển khai. Chưa QA chuột tay, soak30phút binary mới, macOS hoặc toànworkspace. Test topmost của full overlay lượt trước vẫn là giới hạn đã biết; không sửa ngoài phạm vi.

## Tiếp theo

S3-02: adapterDWM/Win32, lọc cửa sổ theo plan, WinEvent chỉ đánh dấu dirty, gom sự kiện trongtick, quét dự phòng500ms và gỡhook khi thoát. Sau đó mới trừ che khuấtS3-03, nối physicsS3-04, tuyếnS3-05, đa màn hìnhS3-06 và nghiệm thuS3-07.

Không commit/push/chuyển nhánh/sửa bàn giaoGen. Origin/master47a73ed1 đã fetch, chưa merge vào dirty tree. CHANGELOG bỏ qua vì tiếp tục tính năngSenko chưa phát hành; không có dữ liệu người dùng phải xóa. GĐ4/GĐ5 chưa bắt đầu.
