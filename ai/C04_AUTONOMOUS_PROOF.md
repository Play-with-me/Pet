# C-04 — Bằng chứng hành vi tự chủ trên ổ cứng

Ngày: 26/10/2026. Người thực hiện: Codex. Leader giao trực tiếp C-04 và cho phép đọc/ghi workspace trong lượt này.

## Kết quả và phạm vi

Đã triển khai và kiểm tra lõi đi dạo trên sàn vùng làm việc, leo hai mép, đuổi/né con trỏ trong native desktop example. Các kiểm tra liệt kê dưới đây đã đạt; chưa tuyên bố ứng dụng sản phẩm hoàn chỉnh hoặc QA bằng tay.

Ticket C-04 đã công bố trong chat trước code. File thực hiện:

- `BongoCat/crates/bongocat-runtime/src/autonomous.rs`: owner hành vi, thời gian Duration truyền vào; trạng thái Idle/Walk/Chase/Evade/ClimbLeft/ClimbRight/Held/Physics, cờ pause đầu vào, snapshot bất biến gồm hành vi/hướng/phase. Không có Win32 hoặc GPU trong runtime.
- `BongoCat/crates/bongocat-runtime/src/lib.rs`: export module mới.
- `BongoCat/crates/bongocat-overlay/src/windows/companion.rs`: dùng lại session C-03; chọn physics hoặc autonomous, lấy vị trí chuột bằng GetCursorPos chỉ đọc, truyền grab/release vào owner hành vi, thống kê chuyển trạng thái và native test C-04.
- `BongoCat/crates/bongocat-overlay/src/lib.rs`: export runner mới.
- `BongoCat/crates/bongocat-overlay/examples/companion_autonomous.rs`: entrypoint có giới hạn thời gian, không thay bootstrap bongocat-app.
- Hồ sơ này, `ai/C-04.evidence.json`, log/texture trong `ai/logs/C04`, `HANDOFF_CODEX.md`, danh mục `ai/FILE_INDEX.md` và `ai/project-index.json`.

Đã đọc hướng dẫn workspace/repository, tài liệu phân công, TASKS, bàn giao, master plan, tin mới SYNC, technical design và đặc tả A03. Không có `ai/BRIDGE_EVIDENCE_FORMAT.md`; áp dụng schema leader cung cấp. TASKS có tên bước/phân công lịch sử; chỉ thị trực tiếp hiện tại xác lập C-04 là hành vi tự chủ. Không sửa SYNC, phần render/asset/hoạt ảnh hoặc bàn giao Gen. Không thêm dependency, không sửa Cargo.lock, không commit/push/merge upstream. Fetch đã chạy thành công; giữ checkout và thay đổi C-02/C-03 có sẵn.

## Hành vi thực tế

- Đi bộ 110 px/s, nghỉ 1.5 giây sau đợt đi tối đa 6 giây. Sàn là đáy work area hệ điều hành trả về, không suy vị trí taskbar từ độ phân giải wallpaper.
- Chạm mép theo hướng đang đi thì leo 140 px/s; tới đỉnh đổi hướng, rời tường với vận tốc ngang 160 px/s rồi trở về physics C-03. Cooldown leo 4 giây. Hai mép lấy theo vùng làm việc hiện tại.
- Chuột trong bán kính 360 px: tiến/đuổi, 110 px/s hoặc 280 px/s khi tốc độ chuột từ 250 px/s. Khi bị ném từ 900 px/s hoặc chuột lao trên 1600 px/s trong 180 px, kích hoạt khoảng khó chịu; né ngược hướng con trỏ 220 px/s. Khóa lựa chọn chase/evade tối thiểu 1.2 giây để hạn chế giật trạng thái.
- Pause đầu vào đóng băng tick; held và chuyển động ném/rơi được ưu tiên trước tự chủ. Grab ngắt bám tường kể cả grab/release trong cùng tick. Vùng làm việc đổi thì đưa về sàn giữa vùng an toàn. Bù trễ giới hạn 0.1 giây mỗi tick.
- BehaviorSnapshot là dữ liệu hành vi tối thiểu cho bước hoạt ảnh. Chưa triển khai toàn bộ CompanionEmotion/StickmanPoseState, squash/stretch, vẫy tay, nhảy, repeated-grab trigger hoặc timing từng cảm xúc trong đề xuất A03. Không coi tài liệu đề xuất A03 là bằng chứng các phần đó đã code.

## Kiểm tra đã chạy

Các lệnh từ Pet; PATH thêm `%USERPROFILE%\.cargo\bin`. PowerShell bọc stderr Cargo bằng NativeCommandError trong một số log; dòng EXIT_CODE và kết quả test là kết quả thực tế.

| Lệnh / kiểm tra | Kết quả | Log |
|---|---|---|
| `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime` | exit 0; 125 unit + 2 fixture tests, gồm 4 test autonomous mới | `ai/logs/C04/runtime.log` |
| `cargo build --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_autonomous` | exit 0 trên nguồn cuối | `ai/logs/C04/build-final.log` |
| `cargo clippy --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime -p bongocat-overlay --all-targets -- -D warnings` | exit 0 trên nguồn cuối | `ai/logs/C04/clippy-final.log` |
| `cargo fmt --manifest-path BongoCat/Cargo.toml --all -- --check` | exit 0 | `ai/logs/C04/fmt.log` |
| `git -C BongoCat diff --check` | exit 0 | `ai/logs/C04/diff-check.log` |
| `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay c03_native_pointer_physics -- --ignored --nocapture --test-threads=1` với C03_OUTPUT_DIR trỏ tuyệt đối vào ai/logs/C04 | exit 0; 1 test, grab/release và quán tính C-03 | `ai/logs/C04/native-pointer.log` |
| `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay c04_native_both_walls -- --ignored --nocapture --test-threads=1` với C04_OUTPUT_DIR trỏ tuyệt đối vào ai/logs/C04 | exit 0; 1 test, 2 grab/2 release, leo cả trái và phải, 1189 Present | `ai/logs/C04/native-autonomous.log` |
| `BongoCat/target/debug/examples/companion_autonomous.exe ai/logs/C03/C03-white.png 48` | exit 0; 2858/2858 Present, 14 chuyển trạng thái; tự đi, leo phải tới đỉnh, rơi và đi tiếp | `ai/logs/C04/native-smoke.log` |
| `BongoCat/target/debug/examples/companion_autonomous.exe ai/logs/C04/C04-white.png 4` sau build cuối | exit 0; 241/241 Present, Physics → Idle → Walk | `ai/logs/C04/native-final.log` |

Bốn unit tests kiểm tra: tuần tra 12000 tick có leo cả hai mép/rơi và luôn trong biên; tiến/né chuột cùng thời lượng tối thiểu; pause/held/physics và thay đổi work area; pause khi bám tường, resume và ném cùng tick. Các tọa độ con trỏ trong unit test là dữ liệu tổng hợp.

Native test gửi SendMessageW tới HWND của chính phiên test, không di chuyển con trỏ hệ điều hành. Assert hai lần grab/release, có Present và từng thấy ClimbLeft/ClimbRight. Đây là kiểm tra tự động, không phải người dùng kéo chuột vật lý. Native session thực đo cửa sổ 154×267 px, work area (0,0)–(2560,1600); va chạm lấy từ mesh C-02. Texture trắng 1×1 PNG là tài nguyên vẽ, không phải ảnh screenshot.

## Lần chưa đạt và chạy lại

- `fmt-initial.log` ghi yêu cầu sắp lại thứ tự export/module; đã sửa và fmt cuối đạt.
- `native-autonomous-initial.log`: exit 101. Kịch bản đầu kéo pet sang mép trái sau 2 giây trong khi hướng vẫn là sang phải, nên không kích hoạt leo trái. Đã sửa lịch test chờ tới giây 16, sau chu kỳ lên đỉnh/đổi hướng/cooldown; không đổi logic chỉ để tắt assertion. Native test cuối 20 giây đạt cả hai mép.
- Smoke 48 giây chạy trước khi bổ sung native test và trường thống kê hai mép; logic hành vi giữ nguyên. Sau thay đổi cuối đã build lại, chạy native test, Clippy và smoke 4 giây trên nguồn cuối.

## Giới hạn và bước tiếp

Chưa nối session vào startup mặc định bongocat-app; hiện chạy qua example riêng. Mesh vẫn là người que đứng thẳng di chuyển theo cửa sổ; chưa có chuyển động khớp chân/tay khi đi/leo hoặc squash/stretch. Chưa có menu chuột phải; pause/reset hiện chỉ là API lõi. Những phần này không được báo cáo là hoàn thành C-04 giao diện/hoạt ảnh.

Chưa QA tay, chụp ảnh desktop, kiểm tra taskbar chiếm chỗ/tự ẩn ở cấu hình khác, đổi DPI/resolution thực tế, lock/sleep, nhiều màn hình hoặc soak dài. Chưa chạy full workspace/just check và không kết luận lỗi topmost nền C-01 đã được sửa. Không tạo EXE sản phẩm/installer C-05.

Nguồn dùng chung lib.rs và companion.rs đã thay đổi từ C-03; SHA256 trong các manifest cũ có tham chiếu những file đó là lịch sử, không còn đại diện nội dung hiện tại. Không sửa lại hồ sơ bước cũ để giả giữ tính toàn vẹn. C-04 manifest ghi hash hiện tại và log kiểm tra mới, gồm regression C-03 đã chạy.

CHANGELOG: bỏ qua vì tiếp tục companion chưa phát hành trên cùng nhánh phát triển qua example, chưa thay bootstrap sản phẩm; không thêm mục riêng cho chi tiết triển khai. Không có dữ liệu local cần người dùng xóa.

Tiếp theo: Gen dùng BehaviorSnapshot để nối tư thế đi/leo/né và đặc tả A03 trong A-04; phần tích hợp tiếp theo cần nối vào lifecycle app, hoàn thiện menu và hợp đồng cảm xúc đầy đủ, rồi QA chuột thật trước build C-05.

Lệnh QA 60 giây từ Pet (đã build example):

```powershell
.\BongoCat\target\debug\examples\companion_autonomous.exe ai/logs/C04/C04-white.png 60
```

Manifest passed chỉ áp dụng các phép kiểm tra đã nêu, không thay kiểm duyệt trải nghiệm hoặc xác nhận toàn bộ sản phẩm.
## Tái kiểm chứng C-04 trong lượt hiện tại — 26/10/2026

Đã đọc mã autonomous.rs, cầu nối native companion.rs và example hiện có. Không viết mới hoặc sửa Rust trong lượt này: phần đi dạo/leo hai mép/đuổi và né chuột đã tồn tại trên ổ cứng. Kiểm tra manifest trước cập nhật cho thấy chỉ HANDOFF_CODEX.md lệch SHA256 do lượt tái kiểm chứng C-03 đã thêm nội dung.

Đã chạy lại trên cây nguồn hiện tại (tất cả exit 0):

- Runtime: 125 unit tests + 2 fixtures; gồm 4 test autonomous; log `ai/logs/C04/recheck-runtime.log`.
- Native `c04_native_both_walls -- --ignored --nocapture --test-threads=1`: 1 test đạt; ClimbRight rồi ClimbLeft, 2 grab/2 release, 1183/1183 Present trong 20 giây; log `ai/logs/C04/recheck-native.log`. Input tổng hợp vào HWND test, không phải thử chuột bằng tay.
- Build `companion_autonomous`: `ai/logs/C04/recheck-build.log`.
- Clippy runtime/overlay all-targets với `-D warnings`: `ai/logs/C04/recheck-clippy.log`.
- Cargo fmt toàn workspace check: `ai/logs/C04/recheck-fmt.log`.
- Git diff check: `ai/logs/C04/recheck-diff.log` (cảnh báo chuyển LF/CRLF, exit 0).

Không chạy lại smoke 48 giây hoặc regression native C-03 trong lượt này; các dòng tương ứng phía trên là lịch sử. Fetch thành công, không merge/commit/push. Không sửa SYNC. Không có BRIDGE_EVIDENCE_FORMAT.md; dùng schema leader cung cấp. CHANGELOG bỏ qua vì chỉ tái kiểm chứng, không thay hành vi. Không có trạng thái local cần xóa.

Giới hạn vẫn giữ nguyên: example riêng, chưa bootstrap app mặc định, chưa hoạt ảnh khớp/menu/cảm xúc đầy đủ hoặc QA chuột thật. Bước tiếp: QA tay example và nối hoạt ảnh theo A-04; tích hợp lifecycle sản phẩm trước C-05. Manifest được tính lại sau khi chốt báo cáo và bàn giao; không sửa manifest bước khác.

## Kiểm chứng theo lệnh MSG-186 — 26/10/2026

Đối chiếu thực tế trước lượt: chỉ HANDOFF_CODEX.md lệch hash manifest. Đã đọc mã Rust autonomous.rs, companion.rs và example; giữ nguyên mã vì hành vi C-04 đã có và các kiểm tra hiện tại đạt. Không viết lại tính năng hoặc nhận mã có sẵn là mã vừa viết.

Kiểm tra vừa chạy trên cây hiện tại, tất cả exit 0:
- `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime`: 125 unit + 2 fixtures; `ai/logs/C04/current-runtime.log`.
- `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay c04_native_both_walls -- --ignored --nocapture --test-threads=1`: 1 native test, leo ClimbRight và ClimbLeft, 2 grab/2 release, 1184/1184 Present; `ai/logs/C04/current-native.log`. C04_OUTPUT_DIR trỏ tuyệt đối tới ai/logs/C04. Đây là input tổng hợp vào HWND riêng, không phải QA chuột tay.
- Build example companion_autonomous: `ai/logs/C04/current-build.log`.
- Clippy runtime/overlay all-targets với `-D warnings`: `ai/logs/C04/current-clippy.log`.
- Cargo fmt toàn workspace check và git diff --check: `ai/logs/C04/current-fmt.log`, `ai/logs/C04/current-diff.log`.

Git fetch thành công, không merge/commit/push. Không sửa SYNC, TASKS hoặc file Gen. Không có BRIDGE_EVIDENCE_FORMAT.md; áp dụng schema leader cung cấp. Các log cũ phía trên là lịch sử, không phải phép kiểm tra vừa chạy. Không chạy lại smoke riêng hoặc native C-03 trong lượt này. CHANGELOG bỏ qua vì chỉ tái kiểm chứng mã hiện có; không có trạng thái local cần xóa.

Giới hạn: đi/leo/đuổi/né chạy trong example D3D11 riêng; app mặc định chưa bootstrap companion, mesh chưa hoạt ảnh khớp. Chưa QA chuột tay, đổi DPI/taskbar thực tế, soak hoặc full workspace. Bước tiếp theo: A-04 kiểm tra trải nghiệm và ghép hoạt ảnh; tích hợp lifecycle trước C-05. Manifest ghi nhận checks cụ thể, không xác nhận toàn bộ sản phẩm hoàn chỉnh.
