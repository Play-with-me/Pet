# C-02 — Bằng chứng render người que Rust

Ngày kiểm tra: 26/10/2026. Chủ sở hữu: Codex. Phạm vi được leader giao trực tiếp: code khung xương 2D trong BongoCat và bằng chứng build/render. Không sửa SYNC.md theo chỉ thị lượt này.

## Mã thực tế
- `BongoCat/crates/bongocat-render/src/stickman.rs`: `standing_snapshot(TextureId)` sinh mesh tam giác cho đầu vòng tròn 64 đoạn, thân và bốn chi capsule; một drawable đen, texture trắng 1x1, không cần Cubism. Model cao 1 đơn vị, canvas 0.6 x 1.04.
- `BongoCat/crates/bongocat-render/src/lib.rs`: xuất module stickman.
- `BongoCat/crates/bongocat-overlay/src/windows/tests/stickman.rs` và `tests/mod.rs`: harness opt-in tạo NativeOverlay, draw/present D3D11, readback staging texture, ghi PNG và kiểm tra alpha.
- Các file trên đã có trong working tree khi bắt đầu lượt này; Codex đọc và tiếp tục hoàn thiện harness, không nhận là toàn bộ mã mới viết trong lượt này. Chưa có báo cáo nghiệm thu lúc bắt đầu.

## Kiểm tra đã chạy
Từ thư mục Pet (PATH có `%USERPROFILE%\.cargo\bin`):

1. `cargo build --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-overlay --lib`: exit 0, `ai/logs/C02/build.log`. Đây là build thư viện, không phải build sản phẩm/installer.
2. `cargo test --manifest-path BongoCat/Cargo.toml -p bongocat-render --locked`: exit 0, 22 passed, `ai/logs/C02/geometry.log`.
3. Đặt `C02_OUTPUT_DIR` tới `ai/logs/C02` tuyệt đối; chạy `cargo test --manifest-path BongoCat/Cargo.toml -p bongocat-overlay c02_stickman_d3d11_proof -- --ignored --nocapture --test-threads=1`: exit 0, 1 passed, `ai/logs/C02/render.log`.
4. `cargo clippy --manifest-path BongoCat/Cargo.toml -p bongocat-render -p bongocat-overlay --all-targets --locked -- -D warnings`: exit 0, `ai/logs/C02/clippy.log`.
5. `git -C BongoCat diff --check`: exit 0. rustfmt chạy trên hai file stickman.rs.

GPU readback: 350 x 607, 23822 pixel alpha >128. Assertions kiểm tra nền trong suốt, tâm đầu rỗng, nét đầu/thân và từng chi hiện diện. `C02-d3d11.png` giữ RGBA readback; `C02-preview.png` ghép chính readback lên trắng để xem. Codex đã mở ảnh preview và đối chiếu thấy đầu rỗng, thân, hai tay, hai chân nối đúng; đây không phải ảnh chụp desktop.

Lần chạy đầu thất bại vì verifier chung yêu cầu biến thiên màu cho model texture, trong khi người que đen đơn sắc. Harness đã dùng alpha assertions riêng thay verifier đó; renderer sản phẩm không bị sửa. Các log PowerShell có NativeCommandError do cargo ghi tiến độ ra stderr; kết quả và exit code thực tế nêu trên.

## Giới hạn và bước tiếp
- Đạt kiểm tra C-02 ở mức mesh Rust + render D3D11 qua harness native overlay; chưa tích hợp bootstrap người que làm nhân vật mặc định trong ứng dụng chính, chưa có vòng chạy companion liên tục.
- Chưa kiểm tra kéo/ném, vật lý, hoạt ảnh, DPI nhiều màn hình hoặc kích thước mục tiêu 16% màn hình. Harness dùng kích thước mặc định overlay 350 x 607; không coi đây là nghiệm thu kích thước sản phẩm.
- Không chạy lại full workspace/just check; lỗi topmost C-01 là lịch sử, không khẳng định đã sửa. Không build EXE/installer mới trong lượt này.
- Fetch upstream thành công; giữ nguyên checkout nền và mọi sửa có sẵn, không merge/commit/push. Không đổi dependency/lockfile hoặc asset/pose Gen.
- CHANGELOG: bỏ qua vì đây là implementation render thử chưa đưa vào luồng sản phẩm. Không có trạng thái local cần người dùng xóa.
- Bước kế: nghiệm thu trực quan của leader/Gen trên ảnh GPU; khi được giao phần tích hợp tiếp theo, nối snapshot này vào lifecycle ứng dụng và xác minh kích thước/DPI.

Manifest: `ai/C-02.evidence.json` ghi hash thật của nguồn, ảnh và log. Status passed chỉ áp dụng các kiểm tra cụ thể ở trên, không xác nhận toàn bộ companion hoàn tất.

## Tái kiểm chứng theo chỉ thị hiện tại — 26/10/2026
- Lượt này mã Rust/harness và báo cáo đã tồn tại ngay khi bắt đầu; không viết lại hoặc nhận là mã mới. Đã đọc lại `standing_snapshot`, mesh capsule/vòng đầu và harness draw/readback. Không cần sửa Rust vì các kiểm tra sau đạt trên mã hiện tại.
- Chạy lại build hai thư viện với `--locked`: exit 0; render tests: 22 passed, exit 0; GPU test opt-in với `--locked`: 1 passed, exit 0; Clippy hai crate/all-targets: exit 0. Các log build.log, geometry.log, render.log, clippy.log đã được thay bằng kết quả lượt này và có EXIT_CODE=0.
- `rustfmt --check` trên hai file stickman.rs và `git -C BongoCat diff --check`: exit 0. Không chạy lại full workspace/just check vì phạm vi lượt này là xác minh C-02; lỗi topmost C-01 chưa được đánh giá lại.
- Ảnh GPU vừa tái tạo: 350×607, 23822 pixel alpha >128. Đã mở C02-preview.png và thấy đầu tròn rỗng, thân, hai tay và hai chân; assertions GPU cũng kiểm tra từng phần. Không coi ảnh readback là ảnh chụp desktop hoặc bằng chứng app chính đã bootstrap người que.
- Sửa lỗi hồ sơ: ghi lại C-02.evidence.json bằng UTF-8 không BOM và tính lại SHA256 mọi artifact sau khi cập nhật báo cáo/log. Kiểm tra decode UTF-8 nghiêm ngặt, parse JSON, trường task/status/checks, đường dẫn trong workspace, file không rỗng và hash khớp; kết quả xác minh được in ra tool output.
- Không có ai/BRIDGE_EVIDENCE_FORMAT.md trên ổ đĩa; áp dụng schema leader cung cấp trực tiếp trong lượt này. Không sửa SYNC.md theo chỉ thị mới nhất. Fetch thành công; không merge/commit/push, không đổi dependency, asset hoặc hành vi ngoài C-02.
- CHANGELOG: bỏ qua vì chỉ tái kiểm chứng render harness chưa tích hợp sản phẩm. Không có trạng thái local cần xóa. Bước tiếp: leader/Bridge kiểm tra hồ sơ và ảnh; phần tích hợp app/lifecycle và DPI vẫn chưa thực hiện, không tự chuyển bước.