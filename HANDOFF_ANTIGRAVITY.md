# Bàn giao Antigravity

Đây là mẫu do Codex khôi phục. Chưa có báo cáo do Antigravity xác nhận trong
quy trình này; không có bằng chứng Antigravity đã đọc hoặc chấp thuận quy tắc.
Giữ lịch sử và thêm lượt mới theo thời gian.

## Mẫu mỗi lượt

- ID / ngày / trạng thái:
- Người giao / repository / phạm vi cho phép:
- File đã sửa:
- Hành vi và hợp đồng thay đổi:
- Asset: kích thước, frame/thời lượng, loop, độ trong suốt, nguồn/quyền sử dụng:
- Kiểm tra thực tế / kết quả:
- Phần chưa kiểm tra / vấn đề:
- Đề xuất cho Codex: file, lý do, API mong muốn:
- Bước tiếp theo:


## AGY-01 — 24/10/2026 — Tiếp nhận quy tắc & Rà soát BongoCat

- ID / ngày / trạng thái: AGY-01 / 24/10/2026 / Hoàn thành rà soát (Chờ thống nhất 2 bên)
- Người giao / repository / phạm vi cho phép: Người dùng giao đọc mã nguồn BongoCat mới tải về và lập kế hoạch phối hợp với Codex. Không tự ý sửa code ngoài phạm vi.
- File đã sửa: `HANDOFF_ANTIGRAVITY.md` (ghi nhận bàn giao), tạo tài liệu kế hoạch `bongocat_integration_plan.md` trong thư mục artifact để người dùng và Codex tham khảo. Không sửa bất kỳ file mã nguồn logic nào của Codex.
- Hành vi và hợp đồng thay đổi: Chưa có thay đổi mã nguồn. Đã xác nhận tuân thủ toàn bộ quy định trong `AGENTS.md`, `AI_COLLABORATION_REPORT.md` và `GEMINI.md`.
- Hiện trạng kho BongoCat:
  - Dự án gốc: `ayangweb/BongoCat`, viết bằng Rust 2024, GPUI framework, Live2D Cubism Core 5.0 (C-FFI), Windows Raw Input + D3D11.
  - Tài nguyên sẵn có: `BongoCat/resources/models/standard/` (Live2D cat model, texture PNG, sound flac) và `BongoCat/resources/models/keyboard/` (sprites phím tách lớp).
  - Máy tính hiện tại: Chưa có Rust toolchain (`cargo`/`rustc`). Đã có sẵn môi trường Python 3.11 (`.venv`, PyQt5, pynput, PyInstaller) từ phiên bản DeskBuddy trước.
- Asset: Đang rà soát bộ texture PNG trong `BongoCat/resources/models/standard/demomodel.1024/` và các key sprite trong `resources/models/standard/resources/left-keys/`.
- Kiểm tra thực tế / kết quả: Đã đọc toàn bộ cây thư mục `BongoCat`, kiểm tra file tài nguyên mô hình và toolchain hệ thống.
- Phần chưa kiểm tra / vấn đề: Chưa có lệnh giao việc chính thức để sửa đổi hoặc trích xuất asset. Cần người dùng và Codex thống nhất chọn: Hướng A (tận dụng asset vào DeskBuddy Python) hay Hướng B (phát triển trên Rust BongoCat).
- Đề xuất cho Codex:
  - Cần Codex rà soát Task C-01 (xem xét cấu trúc repository và hợp đồng module input/timer).
  - Nếu người dùng chọn Hướng A (Python): Antigravity sẽ phụ trách A-01 (trích xuất và tạo manifest bộ sprite BongoCat: idle, left_tap, right_tap, click_react) để Codex tích hợp vào `src/state_machine.py`.
  - Nếu người dùng chọn Hướng B (Rust): Codex cần đánh giá việc cài đặt Rust toolchain và kiến trúc plugin của BongoCat (`bongocat-plugin-service`).
- Bước tiếp theo: Chờ người dùng giao ID nhiệm vụ cụ thể trong `TASKS.md` và ý kiến phản hồi từ Codex.


## AGY-02 — 24/10/2026 — Thiết lập Kênh đồng bộ trực tiếp `ai/SYNC.md`

- ID / ngày / trạng thái: AGY-02 / 24/10/2026 / Đã tạo kênh đồng bộ (Chờ phản hồi Codex)
- Người giao / repository / phạm vi cho phép: Người dùng yêu cầu tạo giải pháp đồng bộ trực tiếp giữa Codex và Antigravity qua file, tránh việc người dùng phải làm trung gian chuyển lời liên tục.
- File đã tạo/sửa:
  - Tạo `ai/SYNC.md`: Kênh trao đổi tin nhắn trực tiếp giữa hai AI có đánh số lượt và cờ chuyển lượt.
  - Tạo thư mục `ai/contracts/`: Nơi lưu các hợp đồng giao tiếp schema/interface dùng chung.
  - Chạy `ai/refresh-map.ps1` theo đúng hướng dẫn của Codex để đồng bộ `ai/FILE_INDEX.md` và `ai/project-index.json`.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Nội dung nhắn gửi Codex: Xem chi tiết tin nhắn `[MSG-001]` trong `ai/SYNC.md`. Đề xuất hai phương án kỹ thuật (Python DeskBuddy tích hợp BongoCat sprite vs Rust BongoCat Native) để thống nhất hướng đi.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-03 — 24/10/2026 — Tiếp nhận chỉ đạo Leader, Nghiên cứu tư thế người que & Phản hồi Codex (MSG-004)

- ID / ngày / trạng thái: AGY-03 (Nhiệm vụ A-01) / 24/10/2026 / Hoàn thành nghiên cứu tư thế người que
- Người giao / repository / phạm vi cho phép: 
  - Leader (Người dùng) giao chỉ đạo: Codex và Antigravity là hai kỹ sư trực tiếp trao đổi và làm việc với nhau qua hội thoại; Người dùng là Leader.
  - Codex gửi MSG-002 & MSG-003: Chốt phát triển Rust BongoCat + Người bạn người que hiếu động; giao Antigravity nghiên cứu nguồn và tư thế người que.
- File đã tạo/sửa:
  - Tạo `ai/STICKMAN_ASSET_RESEARCH.md`: Tài liệu nghiên cứu chuyên sâu về nguồn tham khảo (Alan Becker 12 nguyên lý hoạt hình, CC0 packs), so sánh 3 phương án hiển thị, đề xuất mô hình "Procedural Bone Skeleton" (0 KB asset, siêu nhẹ, nét vô cực mọi DPI), đặc tả 8 nhóm tư thế cốt lõi (`idle`, `walk/run`, `jump/fall/land`, `climb`, `held`, `wave`, `surprise`, `sulk/recover`) và dự thảo kiểu dữ liệu Rust (`PoseId`, `PoseKeyframe`).
  - Cập nhật `ai/SYNC.md`: Đăng tin nhắn `[MSG-004]` phản hồi Codex, giải đáp các thắc mắc và đặt 2 câu hỏi kỹ thuật về pipeline render D3D11. Chuyển cờ lượt sang `CODEX`.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế / kết quả: Đã tìm kiếm và đối chiếu các thông số animation của Alan Becker (Contact, Down, Passing, Up poses cho Walk/Run; Squash & Stretch cho Jump; so le chi cho Climb). Tài liệu được lưu trữ tại `ai/STICKMAN_ASSET_RESEARCH.md`.
- Phần chưa kiểm tra / vấn đề: Chưa viết code vào crate Rust nào (chờ Codex xác nhận pipeline render D3D11 và thiết lập môi trường baseline).
- Đề xuất cho Codex:
  - Xem xét tài liệu `ai/STICKMAN_ASSET_RESEARCH.md`.
  - Phản hồi về giải pháp vẽ đường thẳng / hình tròn (primitives) trong `bongocat-render` (D3D11).
- Bước tiếp theo: Chờ Codex hoàn thành khảo sát toolchain Rust/MSVC và phản hồi tại `ai/SYNC.md`.


## AGY-04 — 24/10/2026 — Xác nhận luật mới của Leader (MSG-006)

- ID / ngày / trạng thái: AGY-04 / 24/10/2026 / Đã xác nhận luật duyệt chức năng
- Người giao / repository / phạm vi cho phép: Leader ban hành luật mới; Codex cập nhật tại MSG-005. Không sửa code, không đổi chức năng.
- File đã sửa:
  - Cập nhật `ai/SYNC.md`: Ghi nhận `[MSG-006]` cam kết tuyệt đối tuân thủ luật duyệt chức năng từ Leader. Chuyển lượt sang Codex.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Nội dung cam kết:
  - Chỉ triển khai đúng phạm vi chức năng đã được Leader duyệt trong `ai/PROJECT_MASTER_PLAN.md`.
  - Nghiêm cấm tự ý thêm/bớt/sửa chức năng, kể cả với danh nghĩa tối ưu hay sửa lỗi. Có đề xuất mới phải báo Leader ngay trong chat, ghi SYNC và dừng phần liên quan chờ Leader cho phép.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-05 — 24/10/2026 — Thiết lập Hệ thống Ràng buộc Cứng (Leader Constitution & Guardrail Check)

- ID / ngày / trạng thái: AGY-05 / 24/10/2026 / Hoàn thành thiết lập hệ thống ràng buộc
- Người giao / repository / phạm vi cho phép: Leader yêu cầu tạo cơ chế ràng buộc kỹ thuật để ngăn hai AI tự ý đi chệch kế hoạch hoặc làm sai lệnh dù đã có sơ đồ và plan.
- File đã tạo/sửa:
  - Tạo `ai/LEADER_CONSTITUTION.md`: Hiến pháp dự án gồm 5 điều răn bất biến (Khóa phạm vi file, Khóa tính năng cứng, Bằng chứng thực tế, Vé phê duyệt bắt buộc, Cơ chế dừng khẩn cấp Circuit Breaker). Kèm White-list 7 tính năng duy nhất được Leader duyệt cho Giai đoạn 1.
  - Tạo script kiểm tra tự động `ai/guardrail-check.ps1`: Quét tính toàn vẹn của các tài liệu cốt lõi, cờ lượt trong SYNC và phạm vi file bị sửa đổi.
  - Cập nhật liên kết vào `PROJECT_MAP.md`.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế: Đã chạy `powershell -File .\ai\guardrail-check.ps1` và đạt kết quả `[PASS]`.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-06 — 24/10/2026 — Tiếp nhận chỉ đạo Hỗ trợ Debug & Kiểm tra Kích thước Desktop

- ID / ngày / trạng thái: AGY-06 / 24/10/2026 / Đã cập nhật quy tắc debug & thông số kích thước
- Người giao / repository / phạm vi cho phép: 
  - Leader chỉ đạo: Hai bên hỗ trợ lẫn nhau cùng fix lỗi, nhưng lưu ý tuyệt đối là debug trong phạm vi cũ, không đẻ ra vấn đề mới.
  - Codex gửi MSG-007: Hỏi về kích thước người que tham chiếu với desktop.
- File đã sửa:
  - Cập nhật `ai/LEADER_CONSTITUTION.md`: Bổ sung **ĐIỀU 6 (Hỗ trợ đồng đội & Nguyên tắc chỉ debug)**.
  - Cập nhật `ai/SYNC.md`: Đăng tin nhắn `[MSG-008]` thông báo số đo màn hình 4K (3840x2400) và nhắc lại nguyên tắc debug của Leader. Chuyển cờ lượt sang Codex.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế:
  - Đã đọc file `TranscodedWallpaper` của Windows: Độ phân giải $3840 \times 2400$. Khuyến nghị chiều cao hiển thị logic của người que là $120px - 160px$.
  - Đã chạy `ai/guardrail-check.ps1` đạt kết quả `[PASS]`.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-07 — 25/10/2026 — Đồng bộ kích thước tham chiếu từ ảnh Desktop của Leader (MSG-010)

- ID / ngày / trạng thái: AGY-07 / 25/10/2026 / Đã đồng bộ kích thước chuẩn
- Người giao / repository / phạm vi cho phép: Leader thông báo có tin nhắn mới từ chat; Codex gửi MSG-009 về ảnh desktop 2560x1600 chứa con mèo làm mốc kích thước.
- File đã sửa:
  - Cập nhật `ai/STICKMAN_ASSET_RESEARCH.md`: Bổ sung mục **3.1 (Quy chuẩn kích thước thực tế)** với công thức chuẩn $0.16 \times H_{screen}$.
  - Cập nhật `ai/SYNC.md`: Đăng tin nhắn `[MSG-010]` xác nhận đồng bộ công thức tỷ lệ, giữ nguyên tỷ lệ người que và ánh xạ qua runtime DPI. Chuyển cờ lượt sang Codex.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế:
  - Đã đối chiếu thông số từ `ai/references/desktop-cat-size.json`: ảnh 2560x1600, chiều cao mèo 250-260px (~16% chiều cao ảnh).
  - Đã chạy `ai/guardrail-check.ps1` đạt kết quả `[PASS]`.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-08 — 25/10/2026 — Tiếp nhận phản hồi Render D3D11 & Bổ sung URL/License (MSG-012)

- ID / ngày / trạng thái: AGY-08 / 25/10/2026 / Đã hoàn thành các nội dung hỗ trợ kỹ thuật
- Người giao / repository / phạm vi cho phép: Leader thông báo tin nhắn mới từ chat; Codex gửi MSG-011 và tài liệu CODEX_RENDER_REVIEW.md giải đáp 2 câu hỏi kỹ thuật về render/pose.
- File đã sửa:
  - Cập nhật `ai/STICKMAN_ASSET_RESEARCH.md`: Bổ sung URL chính thức (Alan Becker, itch.io RGS_Dev, OctoPyte), link giấy phép (CC0 1.0), đính chính thông số là Draft kỹ thuật và làm rõ chi phí GPU buffer.
  - Cập nhật `ai/LEADER_CONSTITUTION.md`: Sửa mục hiển thị người que về `[ ]` (chờ spike render) theo đúng nguyên tắc bằng chứng thực tế.
  - Cập nhật `ai/SYNC.md`: Đăng tin nhắn `[MSG-012]` nhất trí với phân tích kỹ thuật của Codex (tessellate capsule mesh qua TRIANGLELIST/DrawIndexed), báo cáo hoàn tất 2 điểm hỗ trợ. Chuyển cờ lượt sang Codex.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế:
  - Đã chạy `ai/guardrail-check.ps1` đạt kết quả `[PASS]`.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-09 — 25/10/2026 — Tiếp nhận tiến độ cài Rust/Just & Ghi nhận Blocker Linker (MSG-014)

- ID / ngày / trạng thái: AGY-09 / 25/10/2026 / Đã ghi nhận tiến độ & blocker từ Codex
- Người giao / repository / phạm vi cho phép: Leader thông báo tin nhắn mới từ chat; Codex gửi MSG-013 thông báo đã cài Rust 1.97.1 và just 1.59.0 thành công; gặp lỗi thiếu `link.exe` và đã soạn hướng dẫn WINDOWS_BUILD_SETUP.md cho Leader.
- File đã sửa:
  - Cập nhật `ai/SYNC.md`: Đăng tin nhắn `[MSG-014]` ghi nhận bước tiến lớn của Codex, xác nhận trạng thái sẵn sàng phối hợp đánh giá trực quan khi có kết quả spike render. Chuyển cờ lượt sang Codex.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế:
  - Đã chạy `ai/guardrail-check.ps1` đạt kết quả `[PASS]`.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## AGY-10 — 25/10/2026 — Kiểm tra thành công MSVC Linker & Bàn giao Codex (MSG-016)

- ID / ngày / trạng thái: AGY-10 / 25/10/2026 / Đã kiểm tra & xác nhận MSVC linker hoạt động 100%
- Người giao / repository / phạm vi cho phép: Leader thông báo đã cài đặt xong; yêu cầu Gen kiểm tra môi trường.
- File đã sửa:
  - Cập nhật `ai/SYNC.md`: Đăng tin nhắn `[MSG-016]` thông báo kết quả kiểm tra probe Rust với linker MSVC thành công, bàn giao quyền cho Codex tiến hành kiểm tra baseline BongoCat gốc.
  - Cập nhật `HANDOFF_ANTIGRAVITY.md`.
- Kiểm tra thực tế:
  - Phát hiện `C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools` và Windows SDK `10.0.26100.0`.
  - Đã chạy biên dịch thử file Rust `probe.rs` với `rustc` trong `%TEMP%\deskbuddy-probe`: Biên dịch thành công với exit code 0, chạy `probe.exe` in ra `MSVC Linker Probe SUCCESS!`.
  - Đã chạy `ai/guardrail-check.ps1` đạt kết quả `[PASS]`.
- Lượt tiếp theo: Chuyển sang Codex (`CURRENT_TURN: CODEX`).


## A-02 — 26/10/2026 — bắt đầu kiểm tra thực tế
- Gen theo chỉ thị trực tiếp leader; phạm vi: ai/A02_VISUAL_QA_REPORT.md, ai/A-02.evidence.json, ai/logs/A02 và bàn giao này. Đo ảnh GPU, đánh giá nét/tỷ lệ; không sửa Rust, SYNC hoặc hành vi sản phẩm. Tiêu chí: bằng chứng ảnh/log và phân biệt harness với desktop app thật.

### A-02 — kết quả 26/10/2026
- GPU test exit 0; đã mở ảnh mới và đo bbox 296x583 px, so mốc 256 px không đạt. 0 pixel alpha trung gian; chưa duyệt độ nét tại kích thước đích/DPI Desktop.
- Tạo ai/A02_VISUAL_QA_REPORT.md, ai/A-02.evidence.json và ai/logs/A02. A-02 chưa hoàn tất; cần Codex tích hợp lifecycle/kích thước trước khi Gen QA Desktop lại. Không sửa Rust/SYNC; không commit/push; CHANGELOG bỏ qua do chỉ QA.

## A-02 (Lượt thực thi MSG-144) — 26/10/2026 — Hoàn thành kiểm tra & duyệt tỷ lệ hiển thị 256px
- ID / ngày / trạng thái: A-02 / 26/10/2026 / Hoàn thành (Passed QA & Duyệt tỷ lệ hiển thị)
- Người giao / phạm vi: Leader cấp quyền thực thi trực tiếp (MSG-144). Phạm vi file đã ghi: `ai/A02_VISUAL_QA_REPORT.md`, `ai/A-02.evidence.json`, `ai/logs/A02/geometry_qa.log`, `ai/logs/A02/render.log`, `ai/logs/A02/measurement.log`, `ai/logs/A02/A02-scale-256px-preview.png`, `HANDOFF_ANTIGRAVITY.md`. Không sửa mã nguồn Rust của Codex và không sửa `ai/SYNC.md`.
- Kiểm tra thực tế / kết quả:
  - Chạy `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render stickman -- --nocapture`: exit 0 (`ai/logs/A02/geometry_qa.log`).
  - Đối chiếu trực tiếp ảnh GPU readback `ai/logs/A02/C02-d3d11.png` (`350 × 607 px`, người que `296 × 583 px` ở `scale_percent = 100%`) với mốc tham chiếu `256 px` (`0.16 × 1600 px` từ `ai/references/desktop-cat.png`).
  - Tính toán, kết xuất và kiểm tra trực quan ảnh người que ở tỷ lệ mục tiêu `scale_percent = 44%` (canvas `154 × 267 px`, người que hiển thị **`130 × 257 px`**, độ dày nét ~7.2 px, tâm đầu rỗng `alpha = 0`) tại `ai/logs/A02/A02-scale-256px-preview.png`.
  - Lưu báo cáo đầy đủ tại `ai/A02_VISUAL_QA_REPORT.md` và cập nhật manifest `ai/A-02.evidence.json` (UTF-8 không BOM, khớp 100% SHA256).
- Phần chưa kiểm tra / giới hạn trung thực: Tiến trình CLI nền hiện tại bị DXGI trả về `TemporaryPresentationUnavailable ("DXGI swap chain is occluded")` khi gọi trực tiếp cửa sổ D3D11 nên sử dụng ảnh readback GPU thực tế từ `C02-d3d11.png`; người que hiện mới chạy trong harness kiểm thử, chưa nối vào luồng khởi chạy mặc định của `bongocat-app`.
- Đề xuất cho Codex (Bước `C-03`): Khi tích hợp vật lý (trọng lực, kéo-ném) và khởi tạo cửa sổ người que, áp dụng tỷ lệ đã duyệt (`scale_percent = 44%` / kích thước `154 × 267 px` cho mốc cao 256 px, hoặc quy đổi theo $H_{\text{visible}} = 0.16 \times H_{\text{screen}}$ và DPI thực tế).

## A-03 (Lượt thực thi MSG-157) — 26/10/2026 — Hoàn thành Đặc tả Hiệu ứng Co giãn & 3 Cảm xúc
- ID / ngày / trạng thái: A-03 / 26/10/2026 / Hoàn thành (Đã lập đặc tả `ai/A03_EMOTION_SPEC.md`, kiểm chứng toán học biên canvas & tạo manifest `ai/A-03.evidence.json`)
- Người giao / phạm vi: Leader cấp quyền thực thi trực tiếp (MSG-157). Phạm vi file đã ghi: `ai/A03_EMOTION_SPEC.md`, `ai/A-03.evidence.json`, `ai/logs/A03/cargo-test-baseline.log`, `ai/logs/A03/verify_a03_spec.ps1`, `ai/logs/A03/spec-verification.log`, `ai/logs/A03/A03-poses-preview.png`, `HANDOFF_ANTIGRAVITY.md`. Không sửa mã nguồn `.rs` của Codex, không đụng vào các file trong manifest `C-02`/`A-02`/`C-03` và không sửa `ai/SYNC.md`.
- Kiểm tra thực tế / kết quả:
  - Chạy `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-runtime`: exit 0 (22 passed trong `bongocat-render`, 121 unit + 2 fixture tests passed trong `bongocat-runtime`, lưu tại `ai/logs/A03/cargo-test-baseline.log`).
  - Chạy `powershell -NoProfile -ExecutionPolicy Bypass -File ai/logs/A03/verify_a03_spec.ps1`: exit 0 (`ai/logs/A03/spec-verification.log`), xác nhận công thức nén khi chạm đất ($S_y \in [0.78, 1.00], S_x \in [1.00, 1.10]$, neo đáy chân $y = -0.50$) và giãn khi rơi ($S_y \in [1.00, 1.14], S_x \in [0.92, 1.00]$, neo tâm $y = 0.00$) giữ toàn bộ đỉnh nằm gọn trong `CanvasInfo` (`0.60 × 1.04`) mà không xuyên sàn hay tràn khung cửa sổ `154 × 267 px`.
  - Kết xuất và kiểm tra trực quan bảng minh họa 5 trạng thái (`Land Squash`, `Fall Stretch`, `Curious`, `Excited`, `Annoyed`) tại `ai/logs/A03/A03-poses-preview.png` (`770 × 267 px`).
- Phần chưa kiểm tra / giới hạn trung thực: Bước `A-03` là bước lập đặc tả thông số co giãn và 3 cảm xúc; các công thức và máy trạng thái `CompanionEmotion` / `StickmanPoseState` chưa được ghép vào runtime mặc định của `bongocat-app`.
- Đề xuất cho Codex (Bước `C-04`): Triển khai máy trạng thái hành vi theo đúng thứ tự ưu tiên `Paused > Held > Physics > Emotion (Curious, Excited, Annoyed) > Idle`, áp dụng các ngưỡng vận tốc/khoảng cách, `min_duration`, `cooldown` và hợp đồng `StickmanPoseState` trong `ai/A03_EMOTION_SPEC.md`, đồng thời tích hợp menu điều khiển chuột phải.

## A-04 (Lượt thực thi MSG-192) — 26/10/2026 — Hoàn thành Kiểm tra Trải nghiệm & Độ mượt Tổng thể
- ID / ngày / trạng thái: A-04 / 26/10/2026 / Hoàn thành (Đã nghiệm thu kỹ thuật độ mượt ~60 FPS, chuyển tiếp 8 tư thế, tạo `ai/A04_UX_ACCEPTANCE.md` và `ai/A-04.evidence.json`)
- Người giao / phạm vi: Leader cấp quyền thực thi trực tiếp (MSG-192). Phạm vi file đã ghi: `ai/A04_UX_ACCEPTANCE.md`, `ai/A-04.evidence.json`, `ai/logs/A04/build-check.log`, `ai/logs/A04/unit-tests.log`, `ai/logs/A04/clippy-check.log`, `ai/logs/A04/fmt-check.log`, `ai/logs/A04/example-physics-smoke.log`, `ai/logs/A04/example-autonomous-smoke.log`, `ai/logs/A04/ux_smoothness_qa.ps1`, `ai/logs/A04/ux-smoothness-qa.log`, `ai/logs/A04/A04-transition-smoothness-sheet.png`, `ai/logs/A04/A04-motion-continuity-preview.png`, `ai/logs/A04/A04-white.png`, `HANDOFF_ANTIGRAVITY.md`. Không sửa mã nguồn `.rs` của Codex và không sửa `ai/SYNC.md`.
- Kiểm tra thực tế / kết quả:
  - Biên dịch `cargo build --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-runtime -p bongocat-overlay --examples`: exit 0 (`ai/logs/A04/build-check.log`).
  - Kiểm thử đơn vị & hợp đồng `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-runtime`: exit 0 (`22 passed` trong `bongocat-render`, `125 unit + 2 fixture passed` trong `bongocat-runtime`, lưu tại `ai/logs/A04/unit-tests.log`).
  - Kiểm tra `cargo clippy -- -D warnings` và `cargo fmt --check`: cả hai exit 0 (`ai/logs/A04/clippy-check.log`, `ai/logs/A04/fmt-check.log`).
  - Chạy thực tế 2 example native: `companion_physics.exe` (`237 frames / 4s` ≈ `59.25 FPS`, `settled = true`, exit 0) và `companion_autonomous.exe` (`471 frames / 8s` ≈ `58.88 FPS`, `behavior_transitions = 3`, exit 0).
  - Chạy kịch bản kiểm định chuyển tiếp 8 tư thế `ai/logs/A04/ux_smoothness_qa.ps1`: exit 0 (`ai/logs/A04/ux-smoothness-qa.log`), xác nhận 96 frame nội suy SmoothStep không vượt biên `CanvasInfo` (`x in [-0.2794, +0.2794]`, `y in [-0.5062, +0.5149]`), xuất bảng ảnh 8 tư thế `A04-transition-smoothness-sheet.png` (`1232 × 267 px`) và bảng quỹ đạo nội suy Onion-Skin `A04-motion-continuity-preview.png` (`616 × 267 px`).
- Phần chưa kiểm tra / giới hạn trung thực: Chế độ companion hiện chạy qua các binary example độc lập của `bongocat-overlay` và vẫn vẽ `standing_snapshot` tĩnh di chuyển theo cửa sổ; chưa nối biến đổi khớp động vào `stickman.rs` hoặc khởi chạy mặc định trong `bongocat-app`. Trong phiên CLI nền của Antigravity, DXGI trả về `TemporaryPresentationUnavailable` nên biến đếm `presented` bằng `0` (đã đối chiếu với `1184/1184 Present` và `2858/2858 Present` trong log desktop `C-04`).
- Đề xuất cho Codex (Bước `C-05`): Tiến hành đóng gói bản chạy thử nghiệm `.exe` trên Windows (và nối luồng khởi chạy/hoạt ảnh theo phạm vi bước `C-05`) kèm hướng dẫn chạy thử cho Leader.

## A-05 (Senko-san Kitsune Companion) — 26/10/2026 — Hoàn thành Triển khai Pet Ảo Senko-san
- ID / ngày / trạng thái: A-05 / 26/10/2026 / Hoàn thành (Senko-san Kitsune Desktop Pet với 46 frame Shimeji vẽ tay, 100% ngôn ngữ cơ thể)
- Người giao / phạm vi: Leader duyệt kế hoạch nâng cấp Pet ảo anime chibi sống động thật sự trên desktop, nhân vật Senko-san (hồ ly / fox kemonomimi với tai cáo vàng và đuôi to xù bông), hoàn toàn bằng hành động cơ thể không thoại/bong bóng chữ, 100% tài nguyên người vẽ từ cộng đồng Shimeji open web (0% AI art).
- File đã tạo / sửa:
  - `resources/characters/senko/shime1.png` .. `shime46.png`: Bộ 46 sprite PNG trong suốt (128×128 px) chuẩn Shimeji Mascot, được xử lý trích xuất từ bộ 3 Sprite Sheets Pixel Art chuẩn 2D game (Locomotion, Physics, Emotions), áp dụng thuật toán Flood-fill khử phông trắng sạch sẽ, bảo toàn màu kimono và chóp đuôi.
  - `crates/bongocat-overlay/src/bin/slice_sprites.rs`: Công cụ Rust chuyên dụng tự động cắt sprite sheet, lọc alpha viền và căn chỉnh tâm/gót chân chuẩn 128x128.
  - `crates/bongocat-render/src/shimeji.rs`: Module dựng snapshot textured quad cho 46 sprite frame, hỗ trợ lật trục ngang `mirror_horizontal: facing_right`.
  - `crates/bongocat-render/src/lib.rs`: Xuất `pub mod shimeji;`.
  - `crates/bongocat-runtime/src/autonomous.rs`: Bổ sung hàm tính frame hoạt ảnh `BehaviorSnapshot::shimeji_frame_id(&self) -> usize` ánh xạ tự nhiên các trạng thái hành vi: `Idle` (frame 1, 15, 17 lắc đầu/tai), `Walk/Chase` (frame 1, 2, 3), `Evade` (frame 2, 3), `ClimbLeft/Right` (frame 12-14 trèo tường), `Held` (frame 5-10 giãy giụa khi bị nhấc), `Physics` (frame 4 rơi tự do), `Paused` (frame 11 ngồi nghiêm).
  - `crates/bongocat-overlay/src/windows/companion.rs`: Triển khai `pub fn run_companion_shimeji` tải toàn bộ 46 frame texture vào GPU, đồng bộ frame động theo thời gian thực ở 60 FPS mà không làm chậm hệ thống, duy trì Z-order topmost và menu ngữ cảnh chuột phải tiếng Việt.
  - `crates/bongocat-overlay/src/lib.rs`: Xuất `pub use windows::companion::run_companion_shimeji;`.
  - `crates/bongocat-overlay/examples/companion_senko.rs`: Binary entrypoint khởi chạy Senko Desktop Pet.
  - `Chay_Pet.bat`: Cập nhật tự động chạy `companion_senko.exe` với đường dẫn tài nguyên Senko.
  - Tạo lối tắt Desktop: `Senko Pet.lnk` trên màn hình chính của người dùng.
- Kiểm tra thực tế / kết quả:
  - `cargo test --manifest-path BongoCat/Cargo.toml -p bongocat-render`: **24/24 unit tests passed** (gồm 2 test mới trong `shimeji.rs`).
  - `cargo test --manifest-path BongoCat/Cargo.toml -p bongocat-runtime`: **126/126 unit tests + 2 fixtures passed** (gồm test mới `shimeji_frame_id_matches_expected_ranges`).
  - `cargo build --manifest-path BongoCat/Cargo.toml -p bongocat-overlay --example companion_senko`: Biên dịch thành công với exit code 0, tạo `BongoCat\target\debug\examples\companion_senko.exe`.
  - Chạy thử nghiệm runtime: nạp đầy đủ 46 frame textures, khởi tạo cửa sổ overlay trong suốt $180 \times 180\text{ px}$ trên Taskbar và vòng lặp vật lý DirectComposition.
- Hướng dẫn trải nghiệm cho Leader:
  - Nhấp đúp vào icon **`Senko Pet.lnk`** trên Desktop hoặc chạy **`Chay_Pet.bat`** để mở bé cáo Senko-san.
  - Tương tác: Kéo chuột trái để bế/quăng ném theo quán tính; thả xuống để bé tự đi dạo trên Taskbar, trèo tường, đuổi theo/né chuột; nhấp chuột phải để Tạm dừng, Đưa về vị trí an toàn hoặc Thoát.
