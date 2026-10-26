# C-03 — Vật lý người que: bằng chứng thực thi

Ngày: 26/10/2026. Codex thực hiện theo chỉ thị trực tiếp của leader trong lượt này.
Kết luận: đã triển khai và kiểm tra lõi vật lý cùng đường chạy desktop D3D11 riêng. Chưa tích hợp vào bootstrap mặc định `bongocat-app`; chưa nghiệm thu chuột thật bằng tay. Không coi kết quả này là hoàn tất toàn bộ companion.

## Phạm vi và mã thực tế

- `BongoCat/crates/bongocat-runtime/src/physics.rs`: PhysicsBody, Point, WorkArea; thời gian Duration được truyền vào, không dùng đồng hồ lịch. Trọng lực 1800 px/s², bước con tối đa 1/240 giây, giới hạn catch-up 100 ms sau frame dài. Nắm giữ offset tại điểm bấm; vận tốc con trỏ gần lúc thả tạo quán tính, giới hạn tổng tốc độ 2400 px/s. Thả sau hơn 100 ms không di chuyển thì bỏ vận tốc cũ. Mất capture hủy nắm và lực ném.
- Va chạm sàn/cạnh theo hộp bao mesh, không theo padding cửa sổ. Sàn là đáy vùng làm việc Windows. Nảy tối đa 4 px; lực nảy nhỏ thì dừng, có ma sát trên sàn. Clamp lại khi vùng làm việc đổi. Chưa ragdoll hoặc tư thế hoạt ảnh bị giữ/đứng dậy; hình học C-02 được giữ nguyên.
- `bongocat-runtime/src/lib.rs`: xuất module physics.
- `bongocat-overlay/src/windows/companion.rs`: owner native session, nhận thông điệp Win32 nắm/di chuyển/thả/mất capture, gọi physics và di chuyển cửa sổ D3D11. Không hook toàn cục, không đọc nội dung phím, không điều khiển con trỏ thật. DPI context theo pixel vật lý được khôi phục khi thoát; GPU/window/COM hủy trên thread sở hữu. WM_CLOSE dừng session.
- `bongocat-overlay/src/windows/window.rs`, `window_proc.rs`, `mod.rs`, `src/lib.rs`: ghép đường companion riêng; state mặc định None giữ đường Live2D hiện có. Renderer tiếp tục tiêu thụ snapshot bất biến.
- `bongocat-overlay/examples/companion_physics.rs`: entrypoint desktop chạy có giới hạn thời gian. Kích thước tính từ chiều cao màn hình chính và tỷ lệ 16%; máy kiểm tra trả về màn hình vật lý 2560×1600, cửa sổ 154×267 px. Hộp va chạm lấy min/max từng đỉnh của mesh hiện tại, xấp xỉ 130×257 px. Sàn phiên này Windows báo y=1600; chưa kiểm tra cấu hình taskbar chiếm chỗ khác.

Các sửa C-02 và file chưa commit đã có khi bắt đầu được giữ nguyên. Không sửa asset/pose hoặc bàn giao Gen, dependency/lockfile, TASKS hoặc SYNC. Không commit/push/merge upstream. `git fetch` thành công, không đổi checkout nền. Chỉ thị trực tiếp mới ưu tiên hơn dòng C-03 “build Windows/chưa giao” lịch sử trong TASKS. Không có `ai/BRIDGE_EVIDENCE_FORMAT.md` trên ổ cứng; áp dụng schema leader đưa trong chat.

## Kiểm tra thực sự đã chạy

Các lệnh từ Pet, PATH có `%USERPROFILE%\.cargo\bin`:

| Kiểm tra | Kết quả | Log |
|---|---|---|
| `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime` | exit 0; 121 unit tests (gồm 6 physics), 2 fixture tests | `ai/logs/C03/runtime.log` |
| `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay c03_native_pointer_physics -- --ignored --nocapture --test-threads=1` với C03_OUTPUT_DIR trỏ tuyệt đối tới ai/logs/C03 | exit 0; 1 native test passed | `ai/logs/C03/native-pointer.log` |
| `cargo build --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_physics` | exit 0 | `ai/logs/C03/build.log` |
| `cargo run --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_physics -- ai/logs/C03/C03-white.png 4` | exit 0; rơi tự do và settle | `ai/logs/C03/native-smoke.log` |
| `cargo clippy --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime -p bongocat-overlay --all-targets -- -D warnings` | exit 0 | `ai/logs/C03/clippy.log` |
| `cargo fmt --manifest-path BongoCat/Cargo.toml --all -- --check` | exit 0 | `ai/logs/C03/fmt.log` |
| `git -C BongoCat diff --check` | exit 0 | `ai/logs/C03/diff-check.log` |

Test physics đối chiếu quỹ đạo rơi giải tích, offset nắm không nhảy, treo khi giữ, giới hạn tốc độ ném, ném hướng lên, thả sau khi ngừng kéo, mất capture, sàn/cạnh qua 3000 frame, settle, nảy không quá 4 px, vùng làm việc đổi và timestamp kéo cũ.

Native test tạo HWND/D3D11 thật, gửi thông điệp chuột tổng hợp bằng SendMessageW vào chính HWND đó (không di chuyển con trỏ máy). Kết quả: 1 grab, 1 release; tốc độ ném 2181.186799519021 px/s; 302/302 frame trình bày thành công; vận tốc cuối (0,0), vị trí y=1343.274232871 tương ứng đáy mesh ở sàn 1600. Test assert số grab/release, vận tốc ném có giới hạn, có frame trình bày và settle. Smoke example riêng: 241/241 frame, không có input tổng hợp, vận tốc cuối (0,0), cùng vị trí sàn.

Đây là bằng chứng tự động qua message routing và native Present, không phải kiểm duyệt ảnh hoặc thao tác tay. Không tạo ảnh giả làm bằng chứng. `C03-white.png` chỉ là texture trắng 1×1 cho renderer, không phải screenshot.

## Lần đầu chưa đạt và cách sửa

- `fmt-initial.log` ghi diff định dạng trước rustfmt; lần kiểm tra cuối đã qua. Module companion cũng được sắp đúng thứ tự rustfmt yêu cầu.
- `clippy-initial.log`: exit 101 do assertion viết khoảng thủ công; đã đổi thành Range::contains, Clippy cuối exit 0.
- `native-smoke-initial.log`: exit 0 nhưng cửa sổ 103×179 do tọa độ bị DPI virtualization; không dùng lần này để nghiệm thu tỷ lệ. Đã đặt DPI context trên thread session và chạy lại ra 154×267 pixel vật lý.
- Log PowerShell có NativeCommandError do Cargo ghi tiến độ ra stderr; exit code thực tế được lưu bằng dòng EXIT_CODE, không suy lỗi build từ tên wrapper này.

## Giới hạn và bàn giao

- Chưa đưa người que vào luồng khởi chạy mặc định `bongocat-app`. Đường example là phần C-03 chạy độc lập có thật, không thay thế app cuối cùng. Chưa triển khai hành vi tự chủ, hoạt ảnh hoặc menu các bước sau.
- Chưa QA chuột bằng tay, taskbar hiện/ẩn, đổi resolution/DPI trong khi chạy, lock/sleep, cấu hình màn hình khác hay soak dài. Kiểm tra vùng làm việc đổi mới ở mức unit test. Không chạy lại full workspace/just check hoặc test topmost lỗi lịch sử C-01; không khẳng định đã sửa lỗi đó. Không build installer hay EXE sản phẩm C-05.
- CHANGELOG: bỏ qua vì tiếp tục chức năng companion chưa phát hành qua đường example, chưa giao thay đổi bootstrap sản phẩm. Không có dữ liệu người dùng cần xóa.
- Bước tiếp: QA chuột thật trên example bên dưới, sau đó nối session/physics vào lifecycle app mặc định ở phần tích hợp và phối hợp hoạt ảnh theo phân công.

Lệnh mở để QA 60 giây từ Pet:

```powershell
cargo run --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_physics -- ai/logs/C03/C03-white.png 60
```

Manifest `ai/C-03.evidence.json` ghi SHA256 nguồn/log/texture/báo cáo thật. Status passed áp dụng những kiểm tra tự động được liệt kê; không xác nhận QA tay hoặc toàn bộ ứng dụng hoàn tất.

## Tái kiểm chứng cây mã hiện tại — 26/10/2026

Mục này cập nhật kết luận và thay thế số liệu kiểm tra lịch sử phía trên. Lượt này không viết lại Rust: physics.rs và native runner đã có đầy đủ đường trọng lực/nắm/kéo/ném/sàn, kiểm tra lại đều qua. lib.rs hiện xuất thêm autonomous của C-04; companion.rs cũng có nhánh C-04 có sẵn. Giữ nguyên các thay đổi đó, chỉ kiểm tra đường C-03 với autonomous=false; không xác nhận C-04 trong hồ sơ này.

| Lệnh đã chạy lại | Kết quả | Log mới |
|---|---|---|
| cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime | exit 0; 125 unit (gồm 6 physics), 2 fixtures | ai/logs/C03/recheck-runtime.log |
| cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay c03_native_pointer_physics -- --ignored --nocapture --test-threads=1 | exit 0; 1 native test; C03_OUTPUT_DIR trỏ tuyệt đối ai/logs/C03 | ai/logs/C03/recheck-native.log |
| cargo build --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_physics | exit 0 | ai/logs/C03/recheck-build.log |
| cargo run --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_physics -- ai/logs/C03/C03-white.png 4 | exit 0 | ai/logs/C03/recheck-smoke.log |
| cargo clippy --manifest-path BongoCat/Cargo.toml --locked -p bongocat-runtime -p bongocat-overlay --all-targets -- -D warnings | exit 0 | ai/logs/C03/recheck-clippy.log |
| cargo fmt --manifest-path BongoCat/Cargo.toml --all -- --check | exit 0 | ai/logs/C03/recheck-fmt.log |
| git -C BongoCat diff --check | exit 0 | ai/logs/C03/recheck-diff.log |

Native test: cửa sổ 154x267; work area (0,0)-(2560,1600); 301/301 Present; 1 grab, 1 release; tốc độ ném 2205.055629223977 px/s; cuối y=1343.274232871, vận tốc (0,0). Smoke: 241/241 Present; settled=true, cùng y sàn. Có thông điệp chuột tổng hợp vào HWND thật, chưa thử chuột vật lý bằng tay hoặc chụp/duyệt ảnh desktop. Texture trắng không phải ảnh nghiệm thu.

Đã fetch thành công; không merge/commit/push, không sửa SYNC hoặc phần Gen. CHANGELOG bỏ qua vì lượt này tái kiểm chứng và cập nhật hồ sơ, không đổi hành vi. Không cần xóa dữ liệu cục bộ. Chưa chạy full workspace/just check, soak, đổi DPI/taskbar trực tiếp; app mặc định vẫn chưa bootstrap companion. Bước tiếp: QA chuột thật trên example và nối lifecycle app trong phạm vi tích hợp được giao.

Manifest được tạo lại từ SHA256 hiện tại, chỉ liệt kê checks vừa chạy và log recheck; không dùng kết quả lịch sử để chứng nhận cây mới. passed là kết quả kiểm tra tự động C-03, không thay nghiệm thu tay/toàn bộ sản phẩm.

## Kiểm chứng cuối theo yêu cầu hiện tại — 26/10/2026

Đã đọc hướng dẫn workspace/repository, phân công, TASKS, hai bàn giao, master plan và tin mới SYNC. ID C-03, Codex; phạm vi ghi nhận trước kiểm tra tại HANDOFF_CODEX.md. Tên nhiệm vụ vật lý theo chỉ thị trực tiếp ưu tiên bảng TASKS lịch sử. Không có ai/BRIDGE_EVIDENCE_FORMAT.md; áp dụng quy cách Bridge trong yêu cầu. Không sửa SYNC.

Lượt này giữ nguyên Rust trên ổ đĩa vì mã và kiểm tra đã đáp ứng đường C-03: physics.rs có trọng lực 1800 px/s², giữ offset nắm, giới hạn ném 2400 px/s, hủy capture, clamp sàn/cạnh và nảy tối đa 4 px; companion.rs ghép input Win32 với owner physics và D3D11. Example companion_physics chạy nhánh autonomous=false; không thay đổi C-04 có sẵn.

Kết quả mới nhất, thay thế số liệu các lượt trước:

| Kiểm tra | Kết quả | Log |
|---|---|---|
| Runtime tests | exit 0; 125 unit gồm 6 physics, 2 fixtures | ai/logs/C03/current-runtime.log |
| Native pointer test | exit 0; 1 test; 300/300 Present; 1 grab, 1 release; ném 2186.948886308334 px/s | ai/logs/C03/current-native.log |
| Build example companion_physics | exit 0 | ai/logs/C03/current-build.log |
| Smoke example 4 giây | exit 0; 240/240 Present; settled=true | ai/logs/C03/current-smoke.log |
| Clippy runtime/overlay all-targets, -D warnings | exit 0 | ai/logs/C03/current-clippy.log |
| cargo fmt --all -- --check | exit 0 | ai/logs/C03/current-fmt.log |
| git diff --check | exit 0 | ai/logs/C03/current-diff.log |

Mỗi log lưu lệnh và EXIT_CODE thực tế (diff log lưu exit code); các lệnh Cargo đầy đủ xem đầu log. Native test gửi thông điệp tổng hợp vào HWND thật, không phải chuột vật lý. Cả native và smoke: cửa sổ 154×267, work area (0,0)-(2560,1600), vị trí cuối y=1343.274232871 và vận tốc (0,0). C03-white.png là texture trắng, không phải ảnh desktop nghiệm thu.

Đã fetch thành công, giữ toàn bộ thay đổi có sẵn, không merge/commit/push. Chưa chạy full workspace, QA tay, taskbar/DPI thay đổi, lock/sleep hoặc soak; chưa nối companion vào app mặc định. CHANGELOG bỏ qua vì chỉ tái kiểm chứng, không đổi hành vi; không có dữ liệu cục bộ cần xóa. Tiếp theo: QA tay example bằng lệnh 60 giây ở trên, rồi tích hợp lifecycle trong nhiệm vụ được giao.

Đã xác định lệch hash trước lượt ở HANDOFF_CODEX.md. Manifest C-03 được cập nhật sau khi ghi xong báo cáo và bàn giao, dùng hash hiện tại cùng log current-* vừa chạy. Status passed chỉ áp dụng các kiểm tra tự động được liệt kê; không tuyên bố toàn bộ sản phẩm hoặc QA tay đã hoàn tất. HANDOFF_CODEX.md là file dùng chung giữa các lượt: thay đổi tiếp theo sẽ buộc kiểm chứng/cập nhật manifest lại.
## C-03 — kiểm chứng MSG-200 ngày 26/10/2026 (kết quả mới nhất)

Phạm vi Codex đã ghi trước kiểm tra trong HANDOFF_CODEX.md. Đã đọc hướng dẫn, mã physics.rs, companion.rs và đường định tuyến window_proc.rs. Không cần sửa Rust: trọng lực, giữ offset điểm nắm, kéo, vận tốc ném giới hạn 2400 px/s, hủy capture và chặn sàn đã tồn tại. Không nhận công viết lại mã có sẵn. Thay đổi window_proc.rs hiện tại định tuyến companion trước hành vi cửa sổ cũ; hồ sơ cũ lệch hash, cần kiểm tra lại và tính hash mới.

Các kết quả dưới đây thay thế số liệu lịch sử cho cây mã hiện tại. Mỗi log msg200-* lưu lệnh và EXIT_CODE thực tế:

| Kiểm tra | Kết quả | Log |
|---|---|---|
| Runtime | exit 0; 125 unit (gồm 6 physics) + 2 fixture | ai/logs/C03/msg200-runtime.log |
| Native pointer physics | exit 0; 1 native test passed; 302/302 Present | ai/logs/C03/msg200-native.log |
| Build companion_physics example | exit 0 | ai/logs/C03/msg200-build.log |
| Smoke example 4 giây | exit 0; 242/242 Present; settled=true | ai/logs/C03/msg200-smoke.log |
| Clippy runtime/overlay all-targets -D warnings | exit 0 | ai/logs/C03/msg200-clippy.log |
| cargo fmt --all -- --check | exit 0 | ai/logs/C03/msg200-fmt.log |
| git diff --check | exit 0 | ai/logs/C03/msg200-diff.log |

Native test gửi thông điệp chuột tổng hợp vào HWND thật: 1 grab, 1 release; tốc độ ném 2197.3403435802716 px/s. Native và smoke đều dùng cửa sổ 154×267, vùng làm việc (0,0)-(2560,1600), kết thúc y=1343.274232871 và vận tốc (0,0); đáy mesh tại sàn y=1600. Test lõi kiểm tra rơi theo quỹ đạo giải tích, điểm nắm, ném, sàn/cạnh qua 3000 frame, settle, mất capture và vùng làm việc đổi. Texture trắng 1×1 chỉ là đầu vào renderer, không phải screenshot nghiệm thu.

Giữ nguyên các sửa có sẵn C-04/C-05, không kiểm chứng các chức năng đó trong hồ sơ này. Companion hiện có đường example độc lập; chưa bootstrap vào bongocat-app mặc định. Chưa QA chuột vật lý bằng tay, ảnh desktop, đổi DPI/taskbar thực tế, lock/sleep, full workspace/just check hoặc soak. Không tuyên bố hoàn tất ứng dụng hay nghiệm thu tay. git fetch đã chạy exit 0; không merge/commit/push. Không sửa SYNC theo chỉ thị trực tiếp; không có ai/BRIDGE_EVIDENCE_FORMAT.md nên dùng quy cách Bridge trong chat. CHANGELOG bỏ qua vì chỉ tái kiểm chứng; không có dữ liệu người dùng cần xóa.

Bước tiếp: QA kéo/nhấc/ném bằng chuột thật với example 60 giây theo lệnh phía trên. Manifest C-03 chốt SHA256 hiện tại sau khi ghi báo cáo và bàn giao; status passed chỉ xác nhận các kiểm tra tự động vừa chạy.
## C-03 — MSG-207 — kiểm chứng thực tế ngày 26/10/2026 (mới nhất)

Đã kiểm tra mã trên ổ cứng: `BongoCat/crates/bongocat-runtime/src/physics.rs` có trọng lực 1800 px/s², giữ offset điểm nắm, kéo và ném giới hạn 2400 px/s, hủy capture, chặn sàn/cạnh, nảy tối đa 4 px và ổn định tại sàn. `BongoCat/crates/bongocat-overlay/src/windows/companion.rs` nối thông điệp chuột Win32 với physics owner, tính biên va chạm theo mesh thực và di chuyển cửa sổ D3D11. Example `companion_physics.rs` chạy nhánh autonomous=false. Lượt này giữ nguyên Rust có sẵn vì kiểm tra đạt; không nhận công viết mới mã đó, không sửa C-04/C-05 hoặc phần Gen.

Đã chạy lại bằng cargo.exe tại C:\Users\kyuu4\.cargo\bin (không đổi PATH hệ thống). Các log UTF-8 msg207-* chứa lệnh và EXIT_CODE thực tế; tất cả exit 0:

| Kiểm tra | Kết quả | Log |
|---|---|---|
| Runtime | 125 unit, gồm 6 physics, và 2 fixture passed | ai/logs/C03/msg207-runtime.log |
| Native pointer physics | 1 test passed, 301/301 Present, 1 grab/1 release; ném 2108.4104039663152 px/s | ai/logs/C03/msg207-native.log |
| Build example | thành công | ai/logs/C03/msg207-build.log |
| Smoke example 4 giây | 241/241 Present; settled=true | ai/logs/C03/msg207-smoke.log |
| cargo fmt --all -- --check | thành công | ai/logs/C03/msg207-fmt.log |

Native và smoke: cửa sổ 154×267 pixel, work area (0,0)-(2560,1600), vị trí cuối y=1343.274232871, vận tốc (0,0); biên đáy mesh được đặt tại sàn y=1600. Native test gửi chuột tổng hợp vào HWND thật; không thay cho QA tay. C03-white.png là texture trắng 1×1, không phải screenshot. Đã chạy hai lượt runtime/native/build/smoke; log cuối được ghi lại UTF-8 thống nhất để tránh trộn encoding từ chuyển hướng PowerShell.

Đã xác nhận manifest trước lượt ghi sai smoke thành kind=test. Manifest mới chỉ dùng checks vừa chạy, có kind=smoke đúng loại và SHA256 tính sau khi ghi báo cáo. Không chỉ đổi nhãn dựa vào log lịch sử. Không có ai/BRIDGE_EVIDENCE_FORMAT.md; áp dụng định dạng Bridge leader cung cấp. Đã git fetch exit 0, giữ nguyên thay đổi đang có, không merge/commit/push, không sửa SYNC theo chỉ thị hiện tại. CHANGELOG bỏ qua vì chỉ tái kiểm chứng/cập nhật hồ sơ, không đổi hành vi; không có dữ liệu người dùng cần xóa.

Giới hạn: chưa QA chuột vật lý bằng tay, ảnh desktop, live DPI/taskbar, lock/sleep, soak, full workspace/just check hoặc Clippy lại trong lượt này. Companion vẫn là example độc lập, chưa bootstrap trong bongocat-app mặc định. Status passed xác nhận các kiểm tra tự động liệt kê, không chứng nhận toàn bộ sản phẩm. Bước tiếp theo là QA tay kéo/nhấc/ném bằng lệnh sau (đường dẫn cargo đầy đủ khắc phục lỗi cargo không được nhận diện):

```powershell
& "$env:USERPROFILE\.cargo\bin\cargo.exe" run --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_physics -- ai/logs/C03/C03-white.png 60
```
