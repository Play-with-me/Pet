# Senko v3.0 — triển khai GĐ0

ID: SENKO-V3-G0. Hoàn tất phần mã và kiểm tra ghi dưới đây ngày 27/10/2026; chờ nghiệm thu trải nghiệm GĐ0. Không phải hoàn thành toàn bộ plan v3.0.

Leader giao: “Bám sát vào plan và code đi”. Q1 đã chọn **AI tạo và chuẩn hóa pixel** cho GĐ1. Phân công hiện có giữ nguyên: Codex logic/tích hợp/build; Gen asset/hoạt ảnh. Chưa sản xuất hoặc thay asset trong lượt này.

## Đã thay đổi

| Mục plan | Thực hiện |
|---|---|
| GĐ0: tách đồng hồ hoạt ảnh | Thêm clock riêng cho Senko, không reset khi đổi hành vi; pause dừng clock; giữ phase người que theo logic cũ |
| G1: trễ hai ngưỡng | Senko dùng ngưỡng <24 px dừng, >64 px đuổi theo đúng plan; giữ nhánh không né và không leo mép màn hình đã có |
| GĐ0: click xuyên alpha | Load mask CPU từ 46 frame hiện có; dùng frame đã Present thành công và hướng mirror thực tế; kiểm tra tọa độ/scale/biên; giữ capture khi đang bế; lỗi đổi style không còn bị nuốt |
| H1 | GUI subsystem cho cả debug/release của runner, không chỉ release |
| H2 | Shortcut Desktop trỏ trực tiếp release EXE, đường asset tuyệt đối và thời lượng 0; BAT chạy chỉ chọn release; build tách vào Build_Pet.bat qua just → bongocat-packaging |
| H3 | Mutex riêng của Senko, trả về thành công khi mở trùng, đóng handle bằng RAII; log lỗi kỹ thuật có giới hạn/backup; lỗi nghiêm trọng hiện MessageBox trong runner standalone theo plan |

Giữ scale/canvas/asset hiện có ở GĐ0. Chưa thêm Turn 8 hướng, khoảng cách bước theo quãng đường, world cửa sổ, brain, xoa đầu/đuôi hoặc phóng to: các mục này thuộc giai đoạn sau trong plan. Alpha cũ có thể không hoàn toàn 0/255 nên pixel alpha khác 0 được xem là có hình; asset mới sẽ chuẩn hóa theo Q1.

Development dùng `SenkoPet/Development` và mutex riêng; release dùng `%LOCALAPPDATA%/SenkoPet/senko.log`. Log chính giới hạn khoảng 64 KiB, tối đa một backup, cắt mỗi lỗi ở 4096 ký tự. Không bổ sung thu thập phím/tiêu đề hay truy cập mạng. Không thay thông báo của app GPUI chính.

## File mã và launcher

- `BongoCat/crates/bongocat-runtime/src/autonomous.rs`.
- `BongoCat/crates/bongocat-overlay/src/windows/companion.rs`.
- `BongoCat/crates/bongocat-overlay/examples/companion_senko.rs` và `examples/support/senko_lifecycle.rs`.
- `BongoCat/crates/bongocat-packaging/src/main.rs`, `senko_build.rs`, `BongoCat/justfile`.
- `Chay_Pet.bat`, `Build_Pet.bat`, Desktop `Senko Pet.lnk`.

Không sửa ảnh, shimeji renderer, mã physics người que hoặc bàn giao Gen. Có bản sao shortcut trước sửa tại `ai/logs/SENKO-G0/Senko-Pet-before.lnk`. Không tạo commit/push/đổi nhánh; giữ thay đổi chưa commit có sẵn.

## Kiểm tra đã chạy thật

Log tại `ai/logs/SENKO-G0/`.

| Kiểm tra | Kết quả | Log |
|---|---|---|
| `cargo test --locked -p bongocat-render -p bongocat-runtime` | 24 render +129 runtime +2 fixture đạt | runtime-render.log |
| `cargo test --locked -p bongocat-overlay --example companion_senko` | 2 test mutex/log đạt | lifecycle.log |
| `cargo test --locked -p bongocat-overlay senko_mask_tests` | 1 test alpha/mirror/scale/tọa độ âm/biên đạt | alpha.log |
| Native Senko smoke, opt-in ignored test | 4 giây vòng chạy, 238 lần Present, test đạt | native-smoke.log |
| Clippy render/runtime/overlay/packaging, `--all-targets -- -D warnings` | exit 0 | clippy.log |
| `Build_Pet.bat` → `just senko-build` → packaging | release build exit 0 | release-build.log |
| Mở EXE release, mở lần hai | Lần hai exit 0, vẫn chỉ một tiến trình release; primary responding=true | release-process-check.json |
| Đọc PE binary | Subsystem=2 (Windows GUI) | release-process-check.json |
| Đọc lại shortcut | Trỏ thẳng release, asset tuyệt đối, tham số 0 | shortcut.json |
| rustfmt các file Rust đã sửa | exit 0 | fmt-changed.log |
| `cargo fmt --all -- --check` | **exit 1**, còn định dạng ở `slice_sprites.rs` và `bongocat-render/src/lib.rs` ngoài phần sửa lượt này | fmt.log |

Các lệnh cargo dùng `--manifest-path BongoCat/Cargo.toml` và đường dẫn đầy đủ tới cargo khi cần. Chưa chạy full workspace `just check`; không gọi toàn bộ repository là xanh. Test runtime giữ cả hồi quy người que; không dùng số test cũ của Gen thay cho lần chạy này.

## Bản chạy thử

EXE: `BongoCat/target/release/examples/companion_senko.exe`.

SHA256: `1603D004FF77E043C7279418080E04105DA0A00FD3279368DC62C92F48545E65`.

Đã mở release trên máy và để lại cho Leader thử; shortcut mới mở lại cũng không nhân đôi Senko. Muốn build lại hãy thoát Senko qua menu trước để Windows không khóa EXE.

## Giới hạn nghiệm thu và bước tiếp

- Công cụ computer-use đã thử mở và tìm cửa sổ nhưng không trả overlay thành cửa sổ có thể điều khiển; không dùng kết quả này để khẳng định QA kéo/thả hoặc click xuyên bằng chuột thật. Native smoke chứng minh Present thành công; kiểm tra tiến trình chứng minh release đang sống và mutex làm việc.
- Chưa chạy hơn một giờ/soak 8 giờ; chưa kiểm chứng hộp lỗi qua thao tác trực quan; chưa đo hiệu năng 5 phút/trạng thái. Không tuyên bố đã hết mọi lỗi hình ảnh của asset cũ.
- Theo mục 7 plan: “mỗi giai đoạn có cổng duyệt của Leader”. GĐ0 đã có bản cụ thể để thử: con trỏ đứng trên thân, click vùng trong suốt, kéo/thả, menu pause/reset/exit, mở shortcut hai lần. Chưa tự chuyển GĐ1 trước nghiệm thu GĐ0.
- Q1 đã chốt; Q2–Q5 còn mở cho các giai đoạn tương ứng. GĐ1 dùng AI + chuẩn hóa pixel và preview để Leader duyệt trước tích hợp.
- CHANGELOG: bỏ qua vì đây là bổ sung chức năng Senko đang phát triển, chưa phát hành; chi tiết nằm trong báo cáo này. Không có dữ liệu cũ cần người dùng xóa.

## Cập nhật kiểm định ngày 27/10/2026

Đã tiếp tục kiểm định, phát hiện và sửa lỗi menu chuột phải bị resize chung nuốt. Chi tiết và giới hạn harness tại [SENKO_V3_G0_QA.md](SENKO_V3_G0_QA.md). Bản release mới có SHA256 EDB563E5392F2BA3F8BCAD7225A67663B70228D8940E4367F82240364B24409B.

Theo chỉ đạo trực tiếp mới của Leader, đổi mốc61phút sang30phút; đã đo1801.34giây cùng PID và phản hồi tốt, không báo đã kiểm tra hơn1giờ. Đã kiểm tra native click-through hai hướng, kéo/thả và menu qua harness dùng cùng vòng chạy; hồi quy overlay/C03/C04/C05 đạt. Báo cáo cũ phía trên là kết quả tại thời điểm GĐ0 ban đầu, không phải trạng thái QA mới nhất.
