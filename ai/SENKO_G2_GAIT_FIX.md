# Sửa bước đi/chạy và giữ nét chibi

Leader báo chỉ nhúc nhích chân, sau đó yêu cầu giữ vẻ dễ thương. Đã sửa trong
GĐ2; không triển khai world/brain hoặc đổi tốc độ di chuyển đã có.

## Những lỗi đã sửa

1. Runner dùng `body.velocity.x` chọn đi/chạy, trong khi Autonomous đổi thẳng vị
   trí và vận tốc vật lý vẫn0. Nay tính tốc độ từ quãng đường thực trên mỗi tick.
   Test tái hiện đúng trường hợp Chase280px/s nhưng physics velocity0.
2. Animator phát WalkStop/WalkStart mỗi lần tốc độ đổi lớp đi↔chạy. Nay tiếp tục
   chuyển động và đổi clip tại contact, giữ pha chân chịu lực kể cả hai clip có
   stride khác nhau. Đổi tốc độ trong start cũng chọn gait mới nhất khi bắt đầu.
3. Bộ đi có nhiều tư thế quá giống nhau; thử sải dài lại làm mất tỷ lệ chibi.
   Đã loại candidate-v3-gait. Bản chọn có đầu lớn/thân chân ngắn hơn, bước vừa,
   tay giảm gồng, chân chống và chân hồi rõ. Neo theo eo thay vì cả hai ống quần
   đỏ để chân vung không kéo trục thân. Run flight3/7 chỉ nâng1pixel trong canvas.

## Bản đang dùng

`resources/characters/senko-v3-g2/candidate-v4-cute-gait`:217PNG/45clip.
Chỉ thay `walk_side`, `run_side`;201PNG của43clip khác giữ nguyên SHA256.
Mỗi gait mới8keypose thật; không lặp ảnh để duy trì số16. Cycle đi96px/chạy128px,
stride12/16px mỗi frame, tốc độ body vẫn110/280px/s. Giữ scale4/canvas320 và bộ
ảnh cũ để đối chiếu. Các hướng khác chưa được vẽ lại trong bản chọn này.

Nguồn/prompt/provenance trong `senko-v3-gait-cute-source`. Hai thử nghiệm quá tĩnh
không dùng; nguồn sải dài giữ riêng làm QA. Không gọi mọi thử nghiệm là ảnh đạt.
Nguồn AI và pipeline pixel không tự bảo đảm cảm nhận tự nhiên: vẫn cần Leader
đánh giá bản chạy. Không đánh dấu Leader nghiệm thu GĐ2 chỉ vì test đạt.

Release đã build và mở lại với bộ v4; launcher và shortcut đã đổi.
SHA256 EXE `35531C994DD32A3B840659DC4D734E026A023CA69F02FFCDA00A39FBE2780CFF`.
Lần kiểm tra khởi động:PID31352,Responding=true; mở lần2 exit0,còn1instance.
Chi tiết ở `ai/logs/SENKO-G2-GAIT/release-process.json`.

## Kiểm tra và giới hạn

- 28render +138runtime +2fixture đạt;9test pipeline đạt. Hai test mới ở overlay
  xác nhận phân loại từ displacement và Chase thật với physics velocity0.
- 4native đạt: grab/drop/pause/reset/exit bằng thông điệp Win32; sustained Present;
  GPU4×4pixel/alpha/mirror; ghi gait từ GPU khi thân thực sự di chuyển. Đi và chạy
  đều quan sát đủ8phase đã Present. Bản ghi ở `native-proof/index.html` trong bộ v4.
- Bộ lấy mẫu GIF từng gây alias coverage; đã đếm phase ở mọi tick Present,
  tách khỏi nhịp chụp GIF chậm hơn. Không dùng GIF sampling làm bằng chứng bỏ frame.
- GDI+ độc lập217PNG/45GIF,32RGBA,alpha cứng,không trùng pixel trong từng clip đạt.
  201PNG và43thời lượng clip không liên quan giữ nguyên. Hai gait đổi nhịp có chủ
  đích; không khẳng định45thời lượng cũ đều giữ nguyên.
- Clippy all-targets ba crate +asset-tools, fmt file sửa và release build đạt.
- **Full overlay suite chưa xanh:**113đạt/1thất bại/11ignored khi chạy serial.
  Test `a_demoted_model_window_returns_to_the_topmost_band` thất bại ở assertion
  demote. Cùng testcase có lịch sử lỗi trong BASELINE_REPORT.md; chưa sửa hoặc
  khẳng định đã xác định đủ nguyên nhân trong lượt gait này. Mã window không đổi.
- Native input là giả lập, không phải lượt chuột tay mới. Chưa soak30phút binary
  mới, chưa benchmark/fullworkspace/macOS; không suy kết quả GĐ0 sang binary này.

Log lỗi thử trước được giữ riêng; chỉ native-cute-final.log và bộ v4 là kết quả
chọn cuối. Không commit/push/đổi nhánh, không sửa bàn giao Gen. CHANGELOG bỏ qua
vì tiếp tục phát triển Senko chưa phát hành; không trạng thái người dùng cần xóa.
