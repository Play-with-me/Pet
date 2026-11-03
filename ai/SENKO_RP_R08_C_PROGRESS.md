# SENKO-RP-R08-C — công cụ tiếp nhận asset (29/10/2026)

## Đã làm
Codex tự làm, không subagent. Chưa thấy bàn giao P2 mới hoặc xác nhận Gen sau MSG251.
Thêm `--audit <assets> <NEW-external-report-directory>` vào senko_asset_pipeline.
Công cụ dùng SpriteLibrary production để đọc/kiểm định pack, không chuẩn hóa hay sửa ảnh.

Báo cáo JSON có số clip/frame; từng clip có hướng, mirror, loop, stride, sync,
clock time/distance; từng frame có delay (null với clip quãng đường), bounds alpha
half-open và số pixel alpha khác0. Có số RGBA frame khác nhau, không coi con số đó
là chứng nhận chuyển động tự nhiên. Tách structural validation, runner-required
clips validation, visual approval và P2 completeness. Một pack biểu cảm riêng có
thể hợp lệ về cấu trúc nhưng chưa đủ để chạy runner; không báo thành đã tích hợp.

Output phải mới và ở ngoài pack, kiểm định xong mới tạo output. Không sửa hoặc ghi
đè nguồn/manifest/report đã có. Không chọn clip P2 chỉ từ tên; không bật thêm phản ứng.

## Kiểm tra thực chạy
- Asset pipeline12/12 test đạt, gồm ba test audit mới: timing/quãng đường; fragment
  không suy thành runner/visual approval và nguồn không đổi; chặn ghi trong pack,
  chặn đè output và đầu vào lỗi không tạo report.
- Chạy lệnh audit trên bộ v5:45clip/233frame, runner_required_clips_valid=true.
- Clippy asset-tool/tests, scoped rustfmt và git diff --check đạt.
- Lần audit đầu gặp panic vì đọc delay của clip quãng đường; đã sửa dùng clock riêng,
  null timing và thêm test hồi quy. Log ban đầu audit-run.log vẫn giữ, lần cuối audit-final.log.
- Không sửa mã runner/runtime/renderer hoặc asset nên không build lại release,
  không chạy lại native/physics suite; không nhận kết quả lượt trước là test mới.

Lệnh đã chạy (từ BongoCat):
```
cargo run --locked -p bongocat-overlay --features senko-asset-tools --bin senko_asset_pipeline -- --audit ../resources/characters/senko-v3-g2/candidate-v5-flow ../ai/logs/SENKO-RP-R08-C/v5-audit
```
Báo cáo máy đọc: logs/SENKO-RP-R08-C/v5-audit/audit.json.
Nguồn: crates/bongocat-overlay/src/bin/senko_asset_pipeline/audit.rs trong BongoCat.

## Còn lại
Gen bàn giao các clip theo ma trận SENKO_RP_R08_PROGRESS.md, preview được duyệt
rồi Codex dùng audit tiếp nhận và nối actor/contact thực tế. Công cụ này chưa xác
minh đúng nghĩa biểu cảm, vùng tương tác hoặc điểm tiếp xúc tay/chân/đồ vật mới.
Không thay thế nghiệm thu hình ảnh. R08 tổng thể/R09/30phút/S4-06 còn chưa hoàn thành.
Không sửa asset/manifest/Gen, không dependency/branch/commit/push. CHANGELOG bỏ qua:
chỉ bổ sung công cụ kiểm định cho tính năng chưa phát hành. Không cần xóa dữ liệu cục bộ.
