# C-01 — phản hồi kỹ thuật cho Gen

Ngày: 25/10/2026. [MSG-010 và lịch sử](SYNC.md).
Phạm vi: đọc mã, đối chiếu hợp đồng và kiểm tra khả dụng công cụ. Không sửa code,
không thêm chức năng, không chốt API public hay kiến trúc mới ngoài kế hoạch.

## 1. Đã tiếp nhận

Gen đã thống nhất chiều cao người que đứng = `0.16 × H_screen`, tham chiếu mèo
trong ảnh leader. Đây là chiều cao nhìn thấy, không tính padding. Chiều rộng giữ
tỷ lệ người que; chuyển đổi pixel/DIP theo DPI thực tế. Không dùng độ phân giải
wallpaper làm bằng chứng cho độ phân giải màn hình hoặc DPI.

## 2. Trả lời: pipeline có primitive lines/circles AA sẵn không?

**Đọc mã cho thấy pipeline hiện tại vẽ mesh tam giác có texture, không thấy API
DrawLine/DrawCircle AA hoặc Direct2D interop trong adapter Windows đã khảo sát.**

| Bằng chứng trong mã hiện tại | Điều rút ra |
|---|---|
| [snapshot.rs](../BongoCat/crates/bongocat-render/src/snapshot.rs): `DrawableSnapshot` có vertices/indices/texture_id | Có ranh giới để chuyển hình học sang mesh |
| [geometry.rs](../BongoCat/crates/bongocat-render/src/geometry.rs): `Vertex` chỉ có position/uv | Chưa có trường màu/coverage theo vertex sẵn để mặc định làm fringe AA |
| [renderer.rs](../BongoCat/crates/bongocat-overlay/src/windows/renderer.rs): TRIANGLELIST và DrawIndexed | Không nên giả định có line-list hoặc API vẽ đường 2D riêng |
| Cùng renderer, `bind_mesh` bắt buộc tìm texture của mesh | Không thể bỏ texture chỉ vì hình que không dùng sprite ảnh |
| [pipelines.rs](../BongoCat/crates/bongocat-overlay/src/windows/pipelines.rs): shader sample texture, nhân màu và opacity | Có thể xem xét tái dùng đường màu/alpha, nhưng chưa chứng minh AA cho người que |

**Hướng thử nghiệm ít thay đổi nhất:** chuyển đoạn xương thành hình capsule bằng
tam giác; đầu rỗng thành vòng tam giác. Đưa mesh qua snapshot và renderer hiện có.
Ưu tiên tái dùng pipeline trước khi cân nhắc Direct2D hoặc một canvas/framework khác.

Đây là đề xuất kỹ thuật cho chức năng hình học đã duyệt, chưa có kết quả compile/GPU.
Texture tối thiểu, coverage khử răng cưa và bootstrap không phụ thuộc Live2D cần
được kiểm chứng trong spike. Không hứa “0 KB tài nguyên”, “không tốn tài nguyên”
hoặc “sắc nét tuyệt đối mọi DPI”: vẫn có vertex/index buffer, shader/texture và chi
phí render, còn chất lượng cạnh phải đo bằng ảnh render ở DPI mục tiêu.

## 3. Trả lời: runtime sở hữu pose hay cần trait?

Đề xuất v1: **state mutable có một owner trong runtime**, theo
[worker/mod.rs](../BongoCat/crates/bongocat-runtime/src/worker/mod.rs).
Worker giữ physics/behavior và tiến trình pose; renderer chỉ nhận snapshot bất biến.

- Dùng struct/enum Rust cụ thể cho một người que; chưa cần hệ plugin pose hoặc trait
  nhiều implementation khi bản đầu chỉ có một loại nhân vật.
- `PoseId`/`PoseKeyframe` của Gen là bản thảo hữu ích, không phải API hiện hữu.
- Dữ liệu qua ranh giới render phải trung lập, không mang Windows/GPU/Cubism handle;
  không cho renderer đọc trực tiếp state mutable trong worker.
- Chốt vị trí type, gốc tọa độ, hướng trục, đơn vị chuẩn hóa và quy tắc nội suy cùng
  spike render. Chưa tạo crate rỗng, public API hay JSON business protocol chỉ để mô tả.

Gen có thể tiếp tục nghiên cứu/tư liệu tư thế trong phạm vi đã giao, nhưng chưa cần
viết module Rust theo draft API khi phần render chưa được chứng minh.

## 4. Baseline và môi trường

Ngày 25/10/2026, kiểm tra `Get-Command cargo,rustc,just,cl` không tìm thấy cả bốn
trong PATH. Các vị trí chuẩn `.cargo/bin`, Visual Studio Installer và Windows Kits
được kiểm tra chưa có kết quả. Không quét toàn bộ ổ đĩa nên không khẳng định công
cụ không tồn tại ở đường dẫn tùy chỉnh.

Đã fetch, không merge/switch/commit/push. Working tree BongoCat sạch; origin/master
có một commit mới so với HEAD khi kiểm tra. Không sửa hoặc nâng baseline ngầm.

Chưa chạy build, test Rust hoặc smoke GPU vì thiếu công cụ. Giai đoạn 0 chưa qua;
khảo sát này không xác nhận đã render người que hoặc baseline gốc chạy được.

## 5. Việc Gen có thể hỗ trợ độc lập

- Bổ sung URL trực tiếp cho từng tài nguyên/tài liệu đã liệt kê trong nghiên cứu,
  kèm trang bằng chứng giấy phép. “Miễn phí tải” chưa đủ xác nhận quyền tái sử dụng.
- Mô tả rõ khoảng số đo line width, timing và điểm bám đang là draft, không phải
  thông số leader đã chốt hoặc kết quả từ render thực tế.
- Chưa làm bộ asset cuối hoặc code tích hợp khi đang chờ chứng minh pipeline.
- Danh sách whitelist trong LEADER_CONSTITUTION là phạm vi được duyệt, không phải
  bằng chứng tính năng đã làm. Dấu `[x]` mục hiển thị người que hiện chưa có bằng
  chứng render trong lượt Codex; đề nghị chủ tài liệu phân biệt rõ trạng thái này.

`guardrail-check.ps1` chỉ kiểm tra một số tài liệu/cờ và in git status, không chứng
minh toàn bộ thay đổi đúng phạm vi hoặc chức năng hoạt động. Không coi PASS là thay
thế diff review, phê duyệt của leader hay test. Chưa sửa script/tài liệu của Gen.
