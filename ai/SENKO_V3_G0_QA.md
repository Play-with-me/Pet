# Senko — kiểm định bổ sung GĐ0

ID: SENKO-V3-G0-QA. Ngày 27/10/2026. Leader giao tiếp tục phần còn thiếu, giữ nguyên plan v3.0. Phạm vi: sửa lỗi phát hiện trong GĐ0 và kiểm định, chưa tích hợp GĐ2.

## Lỗi thật đã phát hiện và sửa

Nhấp chuột phải trên Senko không mở menu vì message `WM_RBUTTONDOWN/UP` rơi xuống nhánh resize chung của overlay. Test cũ gửi `WM_COMMAND` trực tiếp nên không phát hiện mất đường nhận chuột phải này.

`companion.rs::handle_message` nay nhận hai message chuột phải của companion: chặn down khỏi resize chung và dùng up để yêu cầu menu. `WM_CONTEXTMENU` vẫn được hỗ trợ. Nhánh resize của model Live2D không đổi; đây là sửa chức năng menu đã có trong plan, không thêm chức năng.

Đã build release qua `Build_Pet.bat` → just → packaging. Đường dẫn shortcut giữ nguyên nên mở đúng EXE vừa build. SHA256 bản đang đo nằm trong `ai/logs/SENKO-G0-QA/soak-2/soak-start.json`.

## Kiểm tra tương tác đã thực hiện

Công cụ computer-use không nhận diện overlay production TOOLWINDOW/NOACTIVATE. Đã tạo **harness chỉ có khi cfg(test)** dùng chính `run_senko_session`, cho hiện taskbar/title QA, bỏ NOACTIVATE và tạm bật khả năng nhận chuột đến lần grab đầu để công cụ có thể bắt đầu. Sau grab đầu, alpha/capture dùng logic thật của vòng chạy. Release không chứa harness hoặc các thay đổi style này.

| Kiểm tra | Bằng chứng và kết quả |
|---|---|
| Nắm, kéo lên, thả, rơi về sàn | Sky gửi thao tác chuột thật qua Windows vào cửa sổ QA; log có 1 grab/1 release, điểm cao nhất y=1344.015 so với sàn y=1420, tức nâng khoảng76px; rơi rồi trở lại sàn |
| Đứng gần con trỏ không rung | Khoảng quan sát30.918giây,270 mẫu, một hướng và một vị trí duy nhất; không có thêm input được công cụ phát trong khoảng đó; log hover-30s.json thuộc lượt QA trước sửa nhận chuột phải, cùng logic chuột/animation |
| Tạm dừng và kéo khi pause | Chọn menu bằng chuột; trạng thái paused=true, không có held trong khoảng quan sát, vị trí đứng yên hơn299giây trước reset; thao tác kéo trong pause không làm đổi vị trí |
| Reset khi đang pause | Chọn “Đưa về vị trí an toàn” từ menu; x chuyển về1190, y1420, vẫn paused=true |
| Tiếp tục | Chọn “Tiếp tục”; paused=false; có hai lần pause-toggle tổng cộng |
| Thoát | Chọn “Thoát” bằng chuột; log exit_commands=1; test kết thúc trước timeout600giây, inventory xác nhận cửa sổ QA đã biến mất |
| Tính sống của vòng render khi QA | 29.299 lần Present, lượt tương tác594.241giây, test đạt |
| Click xuyên và lật mask | Native test tạo hai HWND thật, dùng `WindowFromPoint`: opaque đi vào pet, pixel trong suốt đi vào HWND phía dưới, kiểm tra cả hướng phải/trái; cả4 trường hợp đạt; cửa sổ pet của test này **giữ NOACTIVATE production**, không dùng style mở khóa của harness tương tác |
| Mở lần hai | EXE thứ hai exit0, còn đúng một release instance; log duplicate-release.json |
| Thiếu asset: log/hộp lỗi | Debug runner riêng nhận thư mục ảnh trống của test; đã ghi lỗi thiếu shime1.png vào Development/senko.log; inventory thấy dialog “Senko Pet”; Leader xác nhận có đóng ứng dụng/hộp lỗi trong lượt này. Hộp đóng trước khi chụp nên không có screenshot nội dung hoặc exit code của case này |

Không gọi thao tác Sky là người dùng nghiệm thu trực tiếp trên release nguyên style. Hạn chế activation của công cụ được ghi rõ; test native hit-routing riêng giữ nguyên style production bổ sung bằng chứng cho click-through. Leader vẫn là người nghiệm thu cuối.

## Kiểm tra hồi quy và chất lượng

- Unit/native library overlay:111 test đạt,6 ignored ở lần chạy bộ suite; sau đó bổ sung native-alpha test opt-in và chạy riêng đạt.
- Native C03:302/302 Present,1 grab/1 release, throw_speed2138.58px/s, test đạt.
- Native C04:1200/1200 Present,2 grab/2 release, đi/leo được cả hai mép của người que, test đạt.
- Native C05:pause/reset/resume/exit đạt,163 Present, vị trí pause đứng yên.
- Interactive Senko:1 test đạt; native alpha routing:1 test đạt; có thêm test hồi quy nhận chuột phải trước resize chung.
- Clippy render/runtime/overlay/packaging all-targets, gồm feature asset-tools:exit0. rustfmt file sửa:exit0. Các log nằm tại `ai/logs/SENKO-G0-QA/`.
- Chưa chạy lại fullworkspace just check; full fmt từng báo lỗi ở slice_sprites.rs và render/lib.rs ngoài phần sửa GĐ0, không tự format đè các file đó. Không tuyên bố mọi gate toàn repository đã xanh.

## Kiểm tra 30 phút theo chỉ đạo mới — ĐẠT

Lượt đầu kết thúc trước hạn sau khoảng275.59giây, không tính đạt. Không có crash event Application1000/1001 khớp trong khoảng kiểm tra. Leader trả lời “Có, tôi đã đóng” khi được hỏi về đóng Senko/hộp lỗi; ghi nhận có tác động đóng thủ công, không suy kết luận crash hoặc coi lượt đó đạt.

Lượt2 chạy **bản release đã sửa menu**, tham số0. Mục tiêu ban đầu3660giây được Leader đổi trực tiếp thành **1800giây (30phút)**: “Kiểm tra đủ 30 thôi không cần đến 61 đâu”. Đây là ngoại lệ nghiệm thu thời lượng theo chỉ đạo mới, không phải đã chứng minh hơn một giờ. Giữ cùng PID và không khởi động lại pet khi đổi mốc; chỉ thay monitor. Bản cấu hình61phút ban đầu được lưu riêng.

Theo dõi PID, Responding, CPU/working set/private bytes/handles mỗi30giây; không thay đồng hồ hệ thống hoặc tăng tốc mô phỏng. Monitor dùng tuổi process tại lúc bắt đầu cộng Stopwatch đơn điệu và kiểm tra EXE SHA256 không thay ở cuối.

Kết quả chính thức trong `ai/logs/SENKO-G0-QA/soak-2/soak-result.json`: **status=passed, 1801.3417113giây (30phút1.34giây), PID26680, Responding=true**. Không khởi động lại process khi đổi mốc; EXE SHA256 không đổi: `EDB563E5392F2BA3F8BCAD7225A67663B70228D8940E4367F82240364B24409B`. Đã đọc lại kết quả và kiểm tra process còn chạy sau khi monitor kết thúc.

Đạt mốc30phút Leader yêu cầu, **không kết luận đã kiểm tra hơn một giờ**. Thời gian chạy này chỉ kiểm tra không tự thoát/khả năng phản hồi, không thay benchmark GĐ5 hoặc soak8giờ của toàn sản phẩm. Monitor đã dừng sau khi ghi kết quả; để lại bản release cho Leader sử dụng.

## Phạm vi và phần tiếp theo

- Sửa production chỉ ở đường nhận chuột phải trong `companion.rs`. `companion_qa.rs` và các hook cfg(test) là công cụ kiểm định; không sửa asset, brain hoặc physics. Không triển khai GĐ2.
- Bộ GĐ1 candidate-v2 vẫn chờ Leader duyệt hình/nhịp riêng; kiểm định GĐ0 không tự duyệt bộ ảnh.
- Chưa kiểm chứng mọi trường hợp môi trường như khóa máy/DPI/nhiều màn hình hoặc đo hiệu năng5phút/trạng thái; các mục tương ứng vẫn theo giai đoạn trong plan.
- Không commit/push/chuyển nhánh. CHANGELOG bỏ qua vì sửa chức năng Senko chưa phát hành trong cùng công việc đang phát triển. Không có dữ liệu cũ cần người dùng xóa.
