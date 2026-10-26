# Companion — khảo sát nền, giai đoạn 0

Ngày: 24/10/2026. [Kế hoạch tương tác](diagrams/companion.html).

**Mới nhất sau MSG-016, 25/10/2026:** Codex probe linker và chạy executable exit 0.
`just dev-smoke` đã build release/chạy app gốc exit 0. `just check` qua fmt/Clippy
nhưng exit 101 ở test Windows topmost; test riêng cũng thất bại. Đọc
[BASELINE_REPORT.md](BASELINE_REPORT.md) và MSG-017. Không còn chờ cài MSVC/UAC;
quality gate chưa xanh, companion chưa được code. Các đoạn chờ cài bên dưới là lịch sử.

**Mới nhất 25/10/2026, sau MSG-012:** Đã cài Rust 1.97.1 (Cargo, rustfmt, Clippy)
và just 1.59.0 tại `%USERPROFILE%\.cargo\bin`. Các lệnh version và just --list chạy
được. Native linker probe thất bại `link.exe not found` (exit 1). Còn chờ leader
xác nhận UAC cài MSVC/Windows SDK; [hướng dẫn cụ thể](WINDOWS_BUILD_SETUP.md).
Chưa build/run baseline BongoCat. Các ghi chú thiếu Rust bên dưới là lịch sử trước
khi cài; không dùng chúng làm trạng thái hiện tại.

**Kiểm tra lại 25/10/2026:** cargo/rustc/just/cl vẫn không tìm thấy trong PATH;
vị trí toolchain/MSVC/SDK chuẩn được khảo sát chưa có kết quả. Chưa chạy baseline.
Đã hoàn thành [static review render/pose](CODEX_RENDER_REVIEW.md), trả lời Gen tại
MSG-011. Nhận định render không phải bằng chứng GPU. Fetch có một commit mới trên
origin/master so với HEAD, chưa hợp nhất hoặc thay mã.

## Đã xác định

- Người dùng đã yêu cầu triển khai kế hoạch Rust. Không quay về PyQt5.
- `rust-toolchain.toml` yêu cầu Rust **1.97.1**, clippy và rustfmt.
- Phiên shell hiện tại không tìm thấy cargo/rustc/just. Không thấy thư mục mặc định
  `.cargo`/`.rustup`, Visual Studio Build Tools hoặc Windows Kits ở các vị trí chuẩn.
  Đây là kiểm tra vị trí thường dùng, không phải quét toàn bộ ổ đĩa.
- `git status --short --branch`: master theo origin/master, không có sửa mã cục bộ.
  Fetch thành công; chưa merge/switch/commit/push.
- Chưa build hoặc chạy bản gốc, nên chưa đạt cổng nghiệm thu giai đoạn 0.

## Điểm tích hợp đã đọc

| Điểm | Chức năng và thay đổi dự kiến |
|---|---|
| app `main.rs` / `product_options.rs` | Owner khởi động và CLI; chế độ companion phải đi qua parser hiện có |
| runtime `owner.rs` | Worker owner/shutdown; logic companion cần owner rõ và snapshot không chứa OS handle |
| render `snapshot.rs` / `resources.rs` | Drawable có vertices/indices/texture; cần kiểm chứng đưa hình học người que vào pipeline |
| overlay Windows `session` / `window` / `window_proc` | D3D11, vị trí cửa sổ và input; hiện kéo kiểu caption, cần đường capture cho kéo–ném companion |

Đây là điểm ứng viên từ đọc mã, chưa phải giao diện đã triển khai. Đặc biệt cần
kiểm chứng render không phụ thuộc bootstrap model Live2D trước khi làm animation.

## Phần Codex tiếp theo

1. Có Rust toolchain theo pin, MSVC C++ x64/x86 Build Tools, Windows SDK và just.
2. Chạy baseline theo `BongoCat/AGENTS.md` và justfile; phân biệt lỗi nền với lỗi mới.
3. Chốt thay đổi API tối thiểu, ADR và danh sách file sở hữu; sau đó mới sửa mã.
4. Chứng minh render người que và điều khiển cửa sổ; rồi mới triển khai vật lý/hành vi.

Chưa cài toolchain/build tools toàn hệ thống trong lượt cài công cụ sơ đồ. Không
được coi Markmap/Node là dependency runtime mới của BongoCat.

## Bàn giao công việc hình ảnh cho Antigravity

Định hướng đã được người dùng chốt: người que hiếu động, cử chỉ không lời, vật lý
hoạt hình, không phản ứng gõ phím. Hướng Python/cat trong AGY-01 là đề xuất cũ.

Tìm tham khảo/tài nguyên bằng Google và ghi: URL nguồn, tác giả, giấy phép, định dạng,
các động tác, khả năng chỉnh sửa và sử dụng. Không dùng tài nguyên chỉ vì tải miễn phí.
Các động tác cần: nghỉ, đi, chạy, nhảy, rơi, tiếp đất, leo, bị giữ, vẫy, ngạc nhiên,
giận dỗi và hồi phục. Bản mặc định là hình học người que nguyên bản; ưu tiên tài liệu
tư thế phù hợp cách dựng bộ xương, không yêu cầu mua hoặc tạo Live2D trước.

File đề xuất Antigravity có thể tạo khi nhận việc: `ai/STICKMAN_ASSET_RESEARCH.md`.
Không sửa app/runtime/render/overlay trong nhiệm vụ nghiên cứu hình ảnh. Chưa gửi
tin trực tiếp hoặc khẳng định Antigravity đã nhận nhiệm vụ mới này.
