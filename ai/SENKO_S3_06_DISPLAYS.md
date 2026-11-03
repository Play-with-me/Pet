# S3-06 — nhiều màn hình và DPI

Ngày 28/10/2026. Trạng thái: mã và kiểm định tự động/native trong phạm vi dưới đây đã đạt; nghiệm thu phần cứng nhiều màn hình thuộc S3-07 còn chờ.

## Phạm vi
Cache monitor làm mới khi có display/settings/DPI; quét lỗi giữ snapshot hợp lệ và thử lại sau100ms. Riêng Senko giữ physical canvas320×320/source80×80×4 khi DPI thay đổi; đường DPI generic giữ nguyên. Sàn cùng cao độ tiếp giáp nối được, chuyển owner không tăng phase do carriage; gap không thành sàn. Runtime và planner hiểu floor liền nhau. Khi topology mất màn hình chứa pet, phục hồi về sàn thật gần nhất; bế giữ grip/capture và hoãn đến lúc thả. Recovery giữ pause/animation state.

Không đổi assetv5, Gen, PhysicsBody/người que hoặc luật Brain/GĐ4.

## Kết quả thực chạy
- Cargo/rustc1.97.1 đã chạy lại sau khi Leader tự tắt Smart App Control. Codex không thay đổi chính sách Windows. Lỗi E0463 trước đó không tái hiện; không khẳng định nguyên nhân.
- Runtime188 +2fixture và render29 test đạt (runtime-render-retry.log).
- Scanner9 test gồm5native đạt: lifecycle, occlusion/body/route harness và cache invalidation/error/retry. Native query thực, các thông điệp display/settings/DPI và lỗi monitor được tổng hợp/inject; không thay cấu hình màn hình hệ thống.
- Session11 test gồm4native đạt: grab/drop/pause/reset/exit kèm DPI96/144/192/96 và suggested RECT480×480 vẫn giữ origin/320×320; smoke, gait16pha có thân dịch chuyển, GPU Nearest4×4 và Linear mặc định. session.log là lần chạy đúng module companion::sprites::tests; lần lọc companion_sprites::tests trước đó chọn0test, không tính là bằng chứng.
- Generic window_sizing_normalizes_programmatic_native_and_dpi_geometry1test đạt, legacy-dpi.log.
- Clippy3crate/all-targets/asset-tools và rustfmt --check file thuộc phạm vi đạt. just senko-build đạt.
- Release smoke5giây exit0; SHA256 B314382E61145E0BC4874EDB105CBF8C694DDEF7C3430D974A4B3A9BC8A460A1. Mở bản mới PID29196. Chi tiết release.json/lifecycle.json.

## Giới hạn và tiếp theo
Bố trí tọa độ âm, floor seam/gap, route và tháo màn hình khi pause/bế được kiểm tra bằng snapshot mô phỏng. Chưa có QA hai màn hình vật lý mixed-DPI/unplug thực, native Z-order đầy đủ hoặc video/QA tay pet production trên mọi bố trí. Chưa chạy soak30phút mới; không suy thành8giờ. Chưa chạy toàn workspace/macOS, lỗi topmost cũ ngoài phạm vi không coi đã sửa.

Tiếp theo S3-07 QA tổng thể GĐ3, báo cáo đạt/chưa đạt và nghiệm thu trước GĐ4. Không commit/push/chuyển nhánh; upstream47a73ed1 không merge vào dirtytree. Nhật ký blocker lịch sử giữ trong toolchain-status.log/code-integrity.log, không còn là trạng thái hiện tại.
