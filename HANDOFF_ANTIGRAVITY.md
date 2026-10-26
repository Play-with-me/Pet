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
