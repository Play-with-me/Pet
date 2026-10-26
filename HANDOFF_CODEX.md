# Bàn giao Codex

## DOC-02 — 24/10/2026 — Hoàn thành

- Người dùng yêu cầu tạo lại tài liệu vừa xóa.
- Đã kiểm tra thư mục Pet: sáu tài liệu không còn; có thư mục BongoCat.
- Khôi phục: `AI_COLLABORATION_REPORT.md`, `AGENTS.md`, `GEMINI.md`, `TASKS.md`,
  `HANDOFF_CODEX.md`, `HANDOFF_ANTIGRAVITY.md`.
- Giữ nguyên BongoCat và hướng dẫn của repository đó. Không sửa mã hoặc build.
- Tài liệu khôi phục giữ phân công logic/giao diện và bổ sung ghi chú về hiện trạng;
  không phải bản sao từng byte của tài liệu đã xóa.
- Chưa khôi phục mã DeskBuddy, chưa kiểm tra ứng dụng hoặc EXE trong lượt này.
- Cần đọc mã hiện tại trước nhiệm vụ kỹ thuật tiếp theo; không dùng kiểm tra MVP
  cũ làm bằng chứng cho mã BongoCat.
- Chờ người dùng chọn nhiệm vụ tiếp theo.

## DOC-03 — 24/10/2026 — Hoàn thành

- Người dùng giao: cấu trúc toàn bộ dự án thành cây/sơ đồ liên kết để AI đọc.
- Đã tạo `PROJECT_MAP.md`, `ai/MODULE_MAP.md`, `ai/refresh-map.ps1`,
  `ai/FILE_INDEX.md`, `ai/project-index.json`.
- Cập nhật điểm vào trong `AGENTS.md`, `GEMINI.md` và tiến độ `TASKS.md` theo yêu
  cầu điều hướng lần này; không thay quyền sở hữu hoặc quy tắc phân công.
- Đọc đầy đủ hướng dẫn BongoCat, thiết kế phần tổng quan, danh sách src và manifest.
  Bản đồ mô tả 23 crate; tách luồng kiến trúc khỏi dependency khai báo trong manifest.
- Chạy script sinh danh mục thành công: 1.185 file, 218 thư mục; 69 khai báo dependency.
  Hai file output tự sinh và các thư mục Git/cache/build được loại khỏi danh mục.
- Kiểm tra: toàn bộ link local trong ba tài liệu bản đồ tồn tại; JSON parse thành
  công; số manifest crate trong index là 23. PowerShell script dùng UTF-8 BOM để
  tương thích Windows PowerShell với tiếng Việt.
- `git -C BongoCat fetch` thành công; status sau công việc sạch. Không sửa mã nguồn
  hoặc tài liệu bên trong BongoCat, không commit/push.
- Chưa chạy ứng dụng/build/test Rust; nhiệm vụ chỉ tạo tài liệu. Sơ đồ không phải
  bằng chứng xác minh hành vi. CHANGELOG: bỏ qua vì chỉ có bản đồ ở workspace cha.
- Khi đổi cấu trúc/dependency, chạy lại script; cập nhật mô tả module nếu cần.

## DOC-04 / COMP-01 — 24/10/2026

- DOC-04 hoàn thành: cài `markmap-cli` 0.18.12 qua registry npm bằng pnpm, khóa phiên
  bản và dependency tại `ai/diagrams`. Repository nguồn là markmap/markmap, MIT.
- Tạo hai sơ đồ offline: kế hoạch companion và kiến trúc BongoCat; có Markdown nguồn,
  HTML, ảnh PNG, script build, server preview cục bộ, giấy phép và hướng dẫn dùng chung.
- Cập nhật PROJECT_MAP và TASKS; không sửa bàn giao Antigravity hoặc mã BongoCat.
- Kiểm tra thực tế bằng Edge headless: chặn HTTP/HTTPS, cả hai HTML render không
  có lỗi JavaScript; mở nhánh tăng số node 9→13 và 9→15; nút fit hoạt động. Đã xem
  ảnh render và chỉnh phần điều khiển. Không tuyên bố đây là kiểm tra ứng dụng pet.
- COMP-01 đang chờ phụ thuộc ở giai đoạn 0: shell chưa có Rust/cargo/just và chưa
  thấy MSVC/Windows SDK ở vị trí chuẩn. Chi tiết và điểm tích hợp ở
  `ai/COMPANION_READINESS.md`. Chưa build/chạy BongoCat, chưa triển khai physics.
- Định hướng đã chốt là Rust companion người que, không phải hướng Python/cat trong
  AGY-01. Đã chuẩn bị nội dung nghiên cứu hình ảnh cho Antigravity, chưa gửi trực tiếp.
- CHANGELOG: bỏ qua; lượt này sửa công cụ/tài liệu workspace cha, chưa thay đổi sản phẩm.

## DOC-05 — 24/10/2026 — Hoàn thành

- Người dùng yêu cầu tổng hợp plan cho Gen và cho biết Gen đã để lời nhắn trong dự án.
- Đọc đầy đủ AGY-01, AGY-02, MSG-001 và hướng dẫn contracts.
- Tạo `ai/PROJECT_MASTER_PLAN.md`: mục tiêu, quyết định đã chốt, hành vi, vật lý,
  kiến trúc, phân công, các giai đoạn, nghiệm thu, hiện trạng và hướng dẫn Gen tiếp nhận.
- Trả lời MSG-001 bằng MSG-002 trong `ai/SYNC.md`, giữ nguyên nội dung tin cũ;
  chuyển cờ lượt sang ANTIGRAVITY. Xác nhận Rust đã chốt, không Python/mèo gõ phím;
  không tự mặc định triển khai companion qua plugin hoặc JSON business protocol.
- Bổ sung link đầu mối ở AGENTS, GEMINI, PROJECT_MAP, báo cáo phân công và nguồn
  hai sơ đồ. Không thay đổi quyền sở hữu; cập nhật hướng theo kế hoạch người dùng
  đã duyệt. Không sửa bàn giao Gen, mã ứng dụng hoặc hợp đồng API chưa được chứng minh.
- Build lại hai HTML Markmap thành công. Kiểm tra 111 link local hợp lệ và lịch sử
  SYNC giữ MSG-001, bổ sung MSG-002. Không chạy test Rust vì đây là nhiệm vụ tài liệu.
- Bản tổng hợp ghi rõ phase 0 chưa qua, chưa có physics/render companion được triển
  khai; kết quả preflight cần được xác minh lại khi bắt đầu sửa mã.
- Ghi file chung theo yêu cầu người dùng; chưa có xác nhận Gen đã đọc. SYNC không
  tự đánh thức AI. Để Gen tiếp tục, mở phiên Gen và yêu cầu đọc bản tổng hợp/MSG-002.
- CHANGELOG: bỏ qua vì không thay đổi hành vi sản phẩm BongoCat.

## DOC-06 — 24/10/2026 — Hoàn thành

- Leader yêu cầu Codex và Gen trực tiếp làm việc với nhau qua hội thoại.
- Tạo `ai/TEAM_PROTOCOL.md`; liên kết quy ước ở AGENTS/GEMINI, master plan và báo
  cáo phân công. Hai bên tự phối hợp chi tiết trong kế hoạch, giữ quyền sở hữu file.
- Thêm MSG-003 vào SYNC, giữ lịch sử và chuyển cờ hội thoại sang Gen; không giả định
  đã nhận phản hồi hoặc có cơ chế tự đánh thức. Không nhắn qua connector bên ngoài.
- Không sửa mã BongoCat hoặc bàn giao của Gen. Chưa có xác nhận Gen đọc MSG-003.
- Đây là nhiệm vụ tài liệu; không chạy kiểm tra ứng dụng. Không thay đổi CHANGELOG.

## DOC-07 — 24/10/2026 — Hoàn thành

- Leader yêu cầu thêm luật không tự ý thêm/sửa chức năng và báo ngay nếu phát sinh.
- Đồng bộ luật tại TEAM_PROTOCOL, AGENTS, GEMINI, PROJECT_MASTER_PLAN và báo cáo
  phân công. Phải báo trong chat leader, ghi SYNC và dừng thay đổi chờ duyệt; không
  coi sự đồng ý của AI kia hoặc sự im lặng là phê duyệt.
- Ghi MSG-005, giữ lịch sử gồm MSG-004 của Gen. Đã đọc MSG-004; câu hỏi kỹ thuật
  render/pose chưa được giải quyết trong lượt cập nhật luật này.
- Không sửa chức năng hoặc mã ứng dụng. Không sửa bàn giao của Gen; chưa có xác
  nhận Gen đọc luật mới. Cập nhật TASKS và danh mục file.
- Không chạy test ứng dụng; đây là thay đổi tài liệu. Không thay CHANGELOG.

## Hình ảnh tham chiếu — 24/10/2026

- Leader chấp nhận đề xuất ngoại hình và yêu cầu người que to tương đương mèo đang
  hiện trên desktop làm wallpaper. Ghi vào master plan và MSG-007; chưa đổi code.
- Đã đọc MSG-006: Gen xác nhận luật mới. Chưa giải quyết câu hỏi render/pose.
- Đọc wallpaper từ cấu hình Windows và xem ảnh img19.jpg: nền Windows mặc định,
  không có mèo. Không phải ảnh chụp màn hình; không xác định được kích thước mèo.
- Chờ ảnh desktop chứa mèo hoặc chiều cao hiển thị; không tự gán px hay màu duy nhất
  khi hai lựa chọn đen/cam trước đó chưa được phân biệt rõ.

## DOC-08 — 24/10/2026 — Hoàn thành

- Leader gửi ảnh desktop để lấy kích thước mèo làm mốc. Đã xem ảnh, đọc metadata
  bằng sharp: 2560×1600. Sao chép nguyên ảnh vào `ai/references/desktop-cat.png`.
- Ước lượng trực quan mèo cao khoảng 250–260 pixel, tương đương 16% chiều cao ảnh;
  mốc đứng của người que 256 px trong ảnh tham chiếu. Không coi là đo tự động hoặc
  DIP đã biết, không suy cm/DPI từ file wallpaper. Metadata tại desktop-cat-size.json.
- Cập nhật master plan, TASKS và MSG-009 cho Gen, giữ lịch sử MSG-008. Không sửa
  hiến pháp/bàn giao Gen hoặc mã BongoCat; không thay đổi chức năng ứng dụng.
- Kiểm tra metadata và file tham chiếu; không chạy test pet vì chỉ cập nhật mốc thiết kế.

## C-01 — 25/10/2026 — Static review và MSG-011

- Leader thông báo Gen đã gửi. Đã đọc MSG-010, nghiên cứu tư thế cập nhật, bàn giao
  và quy tắc liên quan; trả lời cả hai câu hỏi Gen còn chờ từ MSG-004.
- Tạo `ai/CODEX_RENDER_REVIEW.md` với bằng chứng mã: triangle-list/DrawIndexed,
  vertex position/uv, mesh cần texture; đề xuất thử hình capsule/ring bằng triangle
  mesh. AA và bootstrap companion chưa kiểm chứng; không chốt API hay thêm framework.
- Đề xuất pose/state runtime concrete owner + immutable snapshot, chưa cần trait
  nhiều implementation. Chưa code hoặc thử GPU; không xác nhận render hoàn thành.
- Ghi MSG-011 giữ lịch sử, chuyển cờ Gen. Cập nhật TASKS và COMPANION_READINESS;
  không sửa mã BongoCat hoặc tài liệu của Gen.
- Kiểm tra lại Get-Command: cargo/rustc/just/cl không có trong PATH; đường dẫn chuẩn
  chưa có kết quả. Git fetch thành công, working tree sạch, origin/master hơn HEAD
  một commit. Không merge/switch/commit/push. Baseline chưa chạy.
- Đề nghị Gen bổ sung URL/giấy phép và làm rõ checkbox render chưa có bằng chứng.
  Không coi PASS script guardrail là chứng minh toàn bộ phạm vi hoặc chức năng.
- CHANGELOG: bỏ qua, chỉ static review/tài liệu. Chưa chạy test Rust do thiếu công cụ.

## C-01 / MSG-013 — 25/10/2026 — Đã cài Rust/just, tái hiện lỗi linker

- Đọc đầy đủ MSG-012; Gen thống nhất hướng mesh và sửa báo cáo/checkbox về trạng
  thái có bằng chứng. Không sửa tài liệu hoặc code thuộc Gen.
- Tải rustup-init từ static.rust-lang.org, đối chiếu SHA-256 chính thức; cài Rust
  1.97.1 minimal với clippy/rustfmt, không sửa PATH vĩnh viễn. Rustc/Cargo version
  và component list đã chạy thành công.
- Tải just 1.59.0 x64 MSVC từ casey/just, đối chiếu SHA-256 release API; cài just.exe
  vào .cargo/bin. Just --version và --list trong BongoCat đã qua.
- Viết và compile chương trình Rust tối thiểu trong TEMP: thất bại exit 1, linker
  link.exe not found. Đã có bằng chứng blocker MSVC, không chỉ suy từ PATH.
- Kiểm tra phiên elevated=false. Tải bootstrapper Build Tools từ Microsoft, chữ ký
  Valid/Microsoft Corporation. Chưa chạy cài hoặc yêu cầu tự nâng quyền trong tool.
- Tạo WINDOWS_BUILD_SETUP.md với bước leader xác nhận UAC; cập nhật readiness,
  master plan, TASKS và MSG-013. Baseline/spike chưa chạy, chưa sửa mã/chức năng.
- Nguồn chính thức Rust/Microsoft/GitHub đã kiểm tra. Chưa phân phối build, không
  đổi CHANGELOG vì chưa thay đổi sản phẩm. Sau MSVC/SDK cần kiểm tra lại linker.

## Tiếp nhận MSG-014 — 25/10/2026

- Gen chỉ xác nhận Rust/just đã cài và sẵn sàng đánh giá hình ảnh khi có spike.
- Đã chạy lại Rust linker probe: exit 1, link.exe not found; vswhere chưa thấy ở
  đường dẫn chuẩn. Chưa có bằng chứng MSVC/SDK hoàn tất, baseline chưa thể chạy.
- Ghi MSG-015; đề nghị không gửi vòng lặp xác nhận trạng thái chưa đổi. Chờ bước
  UAC cài Build Tools/SDK; khi có kết quả thực tế Codex sẽ phối hợp Gen tiếp.
- Không sửa mã/chức năng hoặc bàn giao Gen; không chạy test ứng dụng.

## C-01 baseline gốc — 25/10/2026 — Đã có kết quả thực tế

- Leader yêu cầu chạy baseline ngay sau MSG-016. Codex kiểm tra lại linker bằng
  compile/chạy probe exit 0. Rust/Cargo 1.97.1, just1.59.0 và VS Build Tools đã có.
- Giữ HEAD 4f76289d, fetch nhưng không merge commit upstream mới; không sửa nguồn.
- Chạy just check: fmt và ba lượt Clippy qua; workspace test dừng ở 1 assertion
  topmost, tổng nhóm đã chạy 650 passed/1 failed/2 ignored. Exit101, chưa chạy các
  nhóm phía sau và gate workspace release cuối recipe.
- Chạy exact test topmost riêng, vẫn lỗi window.is_topmost ở window.rs242, exit101.
  Không tự kết luận lỗi do hệ điều hành hoặc sửa/tắt test. Đã báo leader trong chat.
- Chạy just dev-smoke qua entrypoint chuẩn. Dùng Python3.12.14 có sẵn bằng shim TEMP
  và PATH riêng vì python3 mặc định là Windows Store alias. Helper checkout plugin
  đúng revision 89971f44e7d73af8c1aaf38f49aa723589457d8d, build catalog và chạy app.
- App release build xong (7m07s trong log), thực thi --run-seconds4/settings-window-smoke
  và exit0; không còn tiến trình sau smoke. Đây là harness CLI, chưa QA trực quan.
- Tạo ai/BASELINE_REPORT.md và log tại ai/logs; cập nhật MSG-017, task/readiness,
  master plan và hướng dẫn setup để bỏ trạng thái cài đặt đang chờ lỗi thời.
- Git status BongoCat sạch, Cargo.toml/Cargo.lock không đổi. Không sửa Gen handoff.
  Không thêm tính năng hoặc triển khai spike người que trong lượt baseline này.
- CHANGELOG bỏ qua vì chỉ kiểm tra và ghi tài liệu. Chất lượng baseline chưa hoàn
  toàn đạt do lỗi nền topmost; cần xử lý theo quy tắc trước khi tuyên bố mọi gate qua.

## AUDIT-01 — 25/10/2026 — Tiến độ mã thật chưa có companion

- Leader hỏi dự án đã được làm chưa. Đọc SYNC mới tới MSG-096 và đối chiếu repo.
- HEAD vẫn 4f76289d; working tree/untracked sạch; diff code/manifest/lockfile/justfile
  so baseline exit0. Hash EXE trùng đúng hash baseline C-01. Chưa có code companion
  trong repo hoặc nguồn workspace ngoài repo được kiểm tra.
- MSG-096 báo “8/9 đã xong” (render/physics/behavior/build companion) không khớp bằng
  chứng. Đã báo leader, tạo ai/PROJECT_AUDIT.md và ghi MSG-097 đề nghị Gen đính chính
  hoặc cung cấp vị trí implementation khác nếu có. Không suy báo cáo là code đã làm.
- Giữ lịch sử, không sửa bàn giao Gen. Cập nhật TASKS và tóm tắt SYNC đúng tiến độ.
  Không sửa mã/chức năng, không chạy lại test không cần thiết; chưa xử lý lỗi nền.
- CHANGELOG bỏ qua vì chỉ audit/tài liệu. Nguồn chuẩn bị và baseline có thật,
  nghiên cứu tư thế có tài liệu, nhưng chức năng người que chưa được triển khai.

## Mẫu cho lượt mới

- ID / ngày / trạng thái:
- Người giao / repository / phạm vi cho phép:
- File đã sửa:
- Hành vi và hợp đồng thay đổi:
- Lệnh kiểm tra / kết quả thực tế:
- Phần chưa kiểm tra / vấn đề:
- Đề xuất cho Antigravity:
- Bước tiếp theo:

## C-02 — 25/10/2026 — Đang làm: kiểm tra điểm ghép trên ổ cứng

- Người giao: leader trong chat hiện tại; phạm vi lượt này: phân tích điểm ghép C-02, chưa triển khai Rust. File ghi: HANDOFF_CODEX.md, ai/SYNC.md. Không sửa báo cáo Gen.
- Đã đọc hướng dẫn, TASKS và bàn giao; C-02 trong TASKS là tên/phạm vi lịch sử. Chỉ đạo hiện tại giao Codex vẽ khung xương người que, ưu tiên hơn dòng “Chưa giao” cũ; không cần xin giao lại.
- Kiểm tra thật: git status --short sạch; HEAD 4f76289d; git diff --exit-code 4f76289d -- '*.rs' exit 0; ls-files --others --exclude-standard không có output. Fetch thành công, không merge upstream hoặc thay baseline.
- Đã đọc crates/bongocat-render/src/snapshot.rs: DrawableSnapshot nhận vertices/indices, texture_id, màu/opacity; RenderSnapshot chứa canvas/bounds/drawables. geometry.rs: Vertex chỉ chứa position/uv, indices là u16 ở snapshot.
- Đã kiểm tra crates/bongocat-overlay/src/windows/renderer.rs: TRIANGLELIST tại dòng 438; bind_mesh tại dòng 740 bắt buộc tìm texture (749–753), DrawIndexed tại 783. Điểm ghép phù hợp để thử capsule cho xương và vòng tam giác cho đầu rỗng; không giả định có DrawLine/DrawCircle hoặc coverage theo vertex.
- Chưa thêm/sửa file .rs, chưa compile/test/smoke C-02, chưa có người que trên desktop, chưa chuyển A-02. Test topmost đỏ là bằng chứng lịch sử C-01, không chạy lại hoặc tự sửa/tắt trong lượt này. Không coi nó là lý do cấm phân tích độc lập.
- Bước kế: ghi ticket triển khai với danh sách file cụ thể; xác định bootstrap RenderFrame/texture không phụ thuộc model Live2D, sau đó tạo mesh Rust có contract hình học, ghép overlay và kiểm tra Windows/DPI. Chưa chốt danh sách file tích hợp vì còn phải đọc producer RenderFrame/lifecycle.
- CHANGELOG: bỏ qua, chỉ phân tích và bàn giao; không thay sản phẩm. Không commit/push, không phát hành.

## C-02 — 2026-10-25 — Bắt đầu thực thi
- Chủ sở hữu: Codex. Leader giao trực tiếp viết Rust người que và báo cáo thật.
- Phạm vi: module hình học trong bongocat-render; cầu nối chạy thử D3D11 trong bongocat-overlay; example; ai/C02_STICKMAN_RENDER_PROOF.md.
- Điều kiện: đầu tròn, thân, bốn chi; build/kiểm tra và ghi rõ mức bằng chứng thực tế.
- Ngoại lệ theo chỉ thị mới: không đọc lại các tài liệu .md leader đã liệt kê; C-02 được giao trực tiếp cho Codex dù liên quan hình học nhân vật.

## C-02 — bắt đầu 25/10/2026
Codex được leader giao trực tiếp code hình học người que Rust. Phạm vi: bongocat-render/src/stickman.rs, lib.rs; smoke D3D11 trong bongocat-overlay/src/windows/tests; ai/C02_STICKMAN_RENDER_PROOF.md và log/ảnh. Tiêu chí: đầu rỗng, thân, bốn chi; compile/test và báo rõ bằng chứng GPU. Ngoại lệ: không đọc lại các markdown leader đã cấm; không sửa asset/pose của Gen.


## C-02 — 26/10/2026 — tiếp tục thực thi
Codex: kiểm tra và hoàn thiện stickman.rs cùng test overlay D3D11 hiện có; tạo báo cáo, log, ảnh GPU và C-02.evidence.json. Chỉ đạo trực tiếp hiện tại cho phép phần Rust hình học; không sửa SYNC.md hoặc asset/pose Gen. Không coi mã có sẵn là đã chạy đạt.


### C-02 — 26/10/2026 — kết quả kiểm tra thực tế
Hoàn thiện harness D3D11 có kiểm tra đầu rỗng/thân/bốn chi, xuất readback và preview. Build lib exit 0, 22 render tests qua, GPU test qua, Clippy -D warnings qua. Báo cáo: ai/C02_STICKMAN_RENDER_PROOF.md; manifest ai/C-02.evidence.json. Chưa bootstrap vào app chính, chưa QA DPI/kích thước 16%, không chạy lại full workspace. CHANGELOG bỏ qua vì render harness chưa đưa vào sản phẩm. Không sửa SYNC theo leader; không commit/push.


## C-02 — 26/10/2026 — tái kiểm chứng và sửa manifest BOM
- Codex; leader giao trực tiếp. Phạm vi: báo cáo C02, manifest, log/ảnh C02 và bàn giao này; giữ mã Rust có sẵn nếu kiểm tra đạt. Chạy build, geometry test, GPU readback, Clippy và xác minh hash/JSON UTF-8 không BOM. Không sửa SYNC.md. Không mở rộng lifecycle.

- Kết quả lượt này: build 0, 22 tests qua, GPU 1 test qua (350x607; 23822 pixel), Clippy 0, rustfmt/diff check 0; đã mở ảnh mới. Giữ nguyên Rust đã có. Cập nhật báo cáo và manifest UTF-8 không BOM/hash mới. Chưa tích hợp app/DPI, chưa chạy full workspace. CHANGELOG bỏ qua; không sửa SYNC, không commit/push.

## C-03 — 26/10/2026 — Vật lý và native desktop example
- Leader giao trực tiếp trọng lực, kéo/nhấc/ném và sàn, ưu tiên hơn tên C-03 lịch sử trong TASKS. Ticket và danh sách file đã công bố trong chat trước code. Không sửa SYNC theo chỉ thị mới; không sửa phần Gen.
- File mới: runtime/src/physics.rs, overlay/src/windows/companion.rs, overlay/examples/companion_physics.rs. Ghép runtime/lib.rs, overlay/lib.rs, windows/mod.rs, window.rs, window_proc.rs. Báo cáo ai/C03_PHYSICS_PROOF.md, manifest ai/C-03.evidence.json, log ai/logs/C03; làm mới hai danh mục FILE_INDEX/project-index.
- Lõi vật lý có thời gian truyền vào, giữ điểm nắm, quán tính giới hạn 2400 px/s, stale release/capture loss, trọng lực 1800 px/s², nảy tối đa 4 px, ma sát và clamp vùng làm việc. Collision theo min/max vertex mesh C-02. Native session dùng physical pixels/DPI context, cửa sổ thật 154x267 trên 2560x1600; mesh C-02 giữ nguyên.
- Kiểm tra: runtime 121 unit + 2 fixtures qua; native test 1 qua, input SendMessage vào HWND thật, 302 Present; smoke example 241 Present và settle; build example/Clippy/fmt/diff check exit 0. Lần đầu Clippy range assertion và fmt chưa qua đã sửa; smoke đầu DPI ảo hóa đã sửa và chạy lại. Chi tiết/log trong báo cáo.
- Chưa QA chuột bằng tay hoặc ảnh desktop; chưa bootstrap vào bongocat-app mặc định, chưa hoạt ảnh giữ/đứng dậy/menu, chưa full workspace/soak/taskbar/DPI đổi lúc chạy; không khẳng định topmost C-01 đã sửa. Native test tổng hợp không phải thao tác chuột vật lý. Không có installer/EXE sản phẩm C-05.
- Giữ thay đổi C-02 có sẵn, không đổi dependency/lockfile; fetch thành công nhưng không merge/commit/push. CHANGELOG bỏ qua: companion chưa phát hành, tiếp tục implementation example. Không có dữ liệu local cần xóa.
- Tiếp: QA tay example theo lệnh trong báo cáo; tích hợp session vào lifecycle app và phối hợp Gen hoạt ảnh ở bước tiếp. Manifest chỉ xác nhận checks cụ thể đã chạy, không toàn bộ sản phẩm.

## C-04 — 26/10/2026 — Bắt đầu thực thi
Leader giao trực tiếp đi dạo, leo hai cạnh, đuổi/né chuột. Phạm vi: runtime/autonomous.rs và lib.rs; overlay/windows/companion.rs và lib.rs; example companion_autonomous.rs; hồ sơ ai/C04_AUTONOMOUS_PROOF.md, ai/C-04.evidence.json, ai/logs/C04, danh mục file. Giữ thay đổi C-02/C-03 có sẵn, không sửa SYNC hoặc phần hoạt ảnh Gen. Kiểm tra runtime/build/Clippy/native smoke; không coi đề xuất A03 là quyền mở rộng phạm vi.


### C-04 — kết quả thực tế 26/10/2026
- Đã thêm autonomous.rs (owner đi/nghỉ, leo trái/phải, đuổi/né; ưu tiên pause/held/physics; reset vùng làm việc), export runtime; ghép runner vào companion.rs, export overlay và example companion_autonomous.rs. Không sửa render/asset Gen hoặc SYNC; giữ thay đổi C-02/C-03 có sẵn.
- Runtime 125 unit + 2 fixtures qua; build example, Clippy all-targets cho runtime/overlay, fmt và diff check exit0. Native regression C-03 qua; native C-04 20 giây qua 2 grab/release, leo cả hai mép, 1189 Present. Smoke tự nhiên 48 giây 2858 Present, leo phải/rơi; final smoke 4 giây 241 Present. Test native ban đầu sai lịch chờ đổi hướng chưa qua, đã giữ log và sửa lịch rồi chạy lại.
- Báo cáo ai/C04_AUTONOMOUS_PROOF.md; manifest ai/C-04.evidence.json hash nguồn/log hiện tại. Manifest cũ chứa lib.rs/companion.rs bị thay đổi không còn khớp cây hiện tại; không giả giữ hash cũ. Không commit/push/merge, dependency/lockfile không đổi; CHANGELOG bỏ qua do tiếp tục companion chưa phát hành/example; không cần xóa dữ liệu local.
- Chưa app bootstrap/menu/hoạt ảnh/đầy đủ cảm xúc A03; BehaviorSnapshot hiện là hợp đồng hành vi tối thiểu. Chưa QA tay, taskbar/DPI đổi thực, full workspace/soak hay EXE sản phẩm. Tiếp: Gen nối hoạt ảnh A-04, phần tích hợp hoàn thiện lifecycle/menu/cảm xúc trước C-05. Chỉ thị leader hiện tại ưu tiên tên TASKS lịch sử; báo cáo/log được leader cho phép ghi; không sửa SYNC theo yêu cầu trực tiếp.

## C-03 — 26/10/2026 — Tái kiểm chứng theo yêu cầu Bridge
Codex; phạm vi: kiểm tra mã physics/native example hiện có, cập nhật ai/C03_PHYSICS_PROOF.md, ai/C-03.evidence.json và log kiểm tra. Giữ mã C-04 đã có; không mở rộng chức năng, không sửa SYNC. Điều kiện: chạy lại runtime/native/build/lint trên cây hiện tại và xác minh SHA256; không coi log cũ là kết quả lượt này.

### C-03 — kết quả tái kiểm chứng
Giữ nguyên Rust đã có; chạy lại runtime 125 unit + 2 fixtures, native nắm/kéo/ném 1 test (301 Present), smoke rơi 241 Present, build example, Clippy, fmt và diff check: tất cả exit 0. Cập nhật báo cáo C03 và manifest hash cây hiện tại/log recheck. Chưa QA tay hoặc bootstrap app; không chạy full workspace. Không sửa SYNC; CHANGELOG bỏ qua vì chỉ tái kiểm chứng; không commit/push, không dữ liệu cần xóa. Bước tiếp: QA tay example và tích hợp lifecycle theo phạm vi được giao.

## C-04 — 26/10/2026 — Tái kiểm chứng hồ sơ Bridge
Codex; phạm vi: kiểm tra mã autonomous/native example hiện có, chạy lại runtime/build/lint/native hai mép và cập nhật báo cáo C04/manifest/log. Mã Rust đã có; chỉ sửa nếu kiểm tra cho thấy cần thiết trong C-04. Không sửa SYNC hoặc phần Gen. Điều kiện: kết quả thực tế và SHA256 khớp toàn bộ artifact cuối lượt.


### C-04 — kết quả tái kiểm chứng
Giữ nguyên mã Rust. Runtime 125 unit + 2 fixtures, native hai mép 1 test/1183 Present/2 grab-release, build example, Clippy, fmt và diff check đều exit 0; log recheck-* tại ai/logs/C04. Cập nhật C04_AUTONOMOUS_PROOF.md và C-04.evidence.json với SHA256 cuối lượt; không sửa SYNC. Chưa QA tay hoặc bootstrap app/hoạt ảnh/menu. CHANGELOG bỏ qua: chỉ kiểm chứng; không commit/push hoặc xóa dữ liệu. Tiếp: QA tay example, A-04 hoạt ảnh và tích hợp lifecycle trước C-05.


## C-03 — lượt hiện tại 26/10/2026 — bắt đầu kiểm chứng cuối
Codex theo lệnh leader: giữ Rust physics/native đã có; chạy lại runtime, native pointer, build, smoke, lint; cập nhật báo cáo C03 và manifest sau bàn giao cuối. Không sửa SYNC; tên C-03 vật lý theo chỉ thị hiện tại ưu tiên TASKS lịch sử.


### C-03 — kết quả lượt kiểm chứng cuối 26/10/2026
Giữ nguyên Rust physics/native example. Runtime 125 unit (6 physics) + 2 fixtures; native 1 test/300 Present/1 grab-release/tốc độ ném 2186.948886308334 px/s; smoke 240 Present, settled=true. Build/Clippy/fmt/diff đều exit 0. Log current-* tại ai/logs/C03; báo cáo ai/C03_PHYSICS_PROOF.md cập nhật. Manifest C-03 tạo sau mục bàn giao này và xác minh mọi hash. Chưa QA tay, app bootstrap, full workspace, live DPI/taskbar/soak. Không sửa SYNC/Gen/TASKS; không commit/push; CHANGELOG bỏ qua vì chỉ kiểm chứng; không dữ liệu cần xóa. Bước tiếp: QA tay example rồi tích hợp lifecycle theo nhiệm vụ được giao. Chỉ thị hiện tại ưu tiên tên C-03 lịch sử trong TASKS.
## C-04 — lượt MSG-186 — phạm vi trước kiểm tra
Codex: đọc và kiểm chứng autonomous.rs, companion.rs, example hiện có; chạy runtime/native/build/lint; cập nhật C04_AUTONOMOUS_PROOF.md, log current-* và C-04.evidence.json. Giữ mã nếu kiểm tra đạt; không sửa SYNC/Gen; manifest chốt sau bàn giao. Chỉ thị C-04 hiện tại ưu tiên TASKS lịch sử.


### C-04 — kết quả MSG-186
Giữ nguyên Rust hiện có. Chạy thật: 125 unit + 2 fixtures; native hai mép 1 test, 1184 Present, 2 grab/release; build example/Clippy/fmt/diff exit 0. Log current-* tại ai/logs/C04, báo cáo C04 cập nhật; manifest tính hash sau bàn giao. Chưa QA tay, bootstrap app hoặc hoạt ảnh khớp/full workspace. Không sửa SYNC/Gen; không commit/push; CHANGELOG bỏ qua vì chỉ kiểm chứng; không trạng thái cần xóa. Tiếp: A-04 QA/hoạt ảnh, tích hợp lifecycle trước C-05.


## C-05 — 26/10/2026 — bắt đầu
Codex theo chỉ thị trực tiếp leader: tạo binary trial Windows độc lập dùng runner hiện có, menu đã duyệt, đóng gói qua just/bongocat-packaging; không sửa pose/asset Gen hoặc SYNC. Phạm vi và kiểm tra đã nêu trong chat; hồ sơ C05/log/manifest và danh mục file. Chỉ thị hiện tại cho phép ghi báo cáo trong ai và ưu tiên TASKS lịch sử. Không coi bản thử là phát hành chính thức hoặc hoàn tất hoạt ảnh.


## C-03 — MSG-200 — phạm vi tái kiểm chứng
Codex theo chỉ thị leader: đọc mã physics/Win32 hiện tại, chạy runtime/native/build/lint, cập nhật ai/C03_PHYSICS_PROOF.md và ai/C-03.evidence.json cùng log msg200-*. Giữ mã hiện có nếu kiểm tra đạt; không sửa SYNC/Gen hoặc triển khai C-05. Manifest sẽ chốt sau bàn giao; tên nhiệm vụ theo chỉ thị hiện tại ưu tiên TASKS lịch sử.

### C-03 — MSG-200 — kết quả
Giữ nguyên Rust hiện có; cập nhật C03_PHYSICS_PROOF.md, C-03.evidence.json và log msg200-*. Runtime 125 unit + 2 fixtures; native 1 test, 302/302 Present, 1 grab/release, ném 2197.3403435802716 px/s; smoke 242/242 Present, settled=true; build/Clippy/fmt/diff exit 0. Manifest cũ lệch window_proc.rs được tính lại từ cây đã kiểm tra. Chưa QA tay, bootstrap app mặc định, live DPI/taskbar, full workspace hoặc soak. Không sửa SYNC/Gen, không commit/push; CHANGELOG bỏ qua vì chỉ kiểm chứng, không dữ liệu cần xóa. Tiếp: QA tay example. Chỉ thị C-03 vật lý hiện tại ưu tiên tên lịch sử trong TASKS.
## C-03 — MSG-207 — phạm vi trước thực thi
Codex: kiểm chứng mã physics/Win32 có sẵn, chạy runtime/native/build/smoke; cập nhật báo cáo, log msg207-* và manifest đúng kind smoke với SHA256 thực tế. Không sửa SYNC, Gen hoặc C-04/C-05; chỉ sửa Rust nếu kiểm tra phát hiện lỗi C-03. Chỉ thị hiện tại ưu tiên TASKS lịch sử.


### C-03 — MSG-207 — kết quả
Giữ nguyên Rust có sẵn. Runtime 125 unit + 2 fixture, native 1 test/301 Present/1 grab-release, smoke 241 Present settled=true, build và fmt đều exit 0; log msg207-* UTF-8. Cập nhật C03_PHYSICS_PROOF.md và manifest với kind=smoke, SHA256 hiện tại. Chưa QA tay hoặc bootstrap app/full workspace/Clippy lại; không sửa SYNC, Gen, C-04/C-05; không commit/push. CHANGELOG bỏ qua vì chỉ kiểm chứng; không dữ liệu cần xóa. Bước tiếp: QA tay example bằng đường dẫn cargo.exe đầy đủ. Tên C-03 vật lý theo chỉ thị hiện tại ưu tiên TASKS lịch sử.

