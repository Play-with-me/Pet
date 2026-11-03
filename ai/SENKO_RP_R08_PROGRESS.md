# SENKO-RP-R08-A — kiểm kê và tái sử dụng clip (29/10/2026)

## Phạm vi
Codex tự thực hiện, không subagent. Không sửa PNG/manifest hoặc công việc Gen.
Bộ v5 hiện có 45 clip/233 PNG. `surprise` có ba frame 150 ms, không lặp,
đã tồn tại nhưng chưa được nối. Đính chính nhận định thiếu ảnh surprise trong
báo cáo R06: thiếu actor tích hợp; không thiếu clip P1 này.

## Đã sửa
- Animator có hành động Surprise hữu hạn, ngắt được khi Held/Fall.
- Sự kiện cửa sổ mới đã gom có thể yêu cầu Surprise; foreground và con trỏ vẫn Look.
- Dùng ưu tiên, chờ an toàn, hết hạn chuẩn bị 750 ms và feedback episode/frame
  thực sự Present của director hiện có. Không hủy tuyến đang đi để chạy theo cửa sổ.
- Clip surprise tùy chọn phải theo thời gian, không lặp, không stride; dữ liệu sai báo lỗi.
- Không thay đổi lực, vận tốc, gait, ảnh hoặc quy tắc media/care.

## Ma trận bàn giao hình cho Gen — R08 chưa hoàn thành
| Nhóm | Có thể dùng hiện tại | Còn thiếu để đạt đặc tả |
|---|---|---|
| Chú ý/cửa sổ | look_up, surprise | Ngoảnh nhìn, nghiêng đầu, nhận lời chơi, lưu luyến |
| Xoa đầu | headpat | Từ chối nhẹ, ngượng, né theo tâm trạng |
| Đuôi/cảm xúc | Chưa có actor đúng | Nhìn lại, ôm/che đuôi, cho vuốt, chăm đuôi, dỗi, nguôi, làm hòa |
| Bế/tiếp xúc | held_happy, land, balance_wobble | Nhấc bất ngờ, held guarded, đặt nhẹ/rơi mạnh, trượt, phủi bụi/chóng mặt |
| Leo/di chuyển | climb_up, hang, mantle, walk/run/start/stop | Duyệt tiếp xúc tay/chân và chuyển trọng tâm; không tự kết luận cần thay mọi clip |
| Sinh hoạt/media | sit/sleep/wake/yawn | Quan sát/chải chuốt/đung đưa đúng nghĩa |
| Quay lại/chăm sóc | Logic có harness, chưa bật clip | Chào, trà/vươn vai, offer/wait/withdraw và đồ vật |

Hợp đồng: giữ canvas80, scale4, anchor chân40/76 và nét v5; manifest ghi delay
thực từng frame, hướng/mirror, loop, sync. Clip phản ứng một lần phải hữu hạn.
Gen cung cấp preview tốc độ thật trước–trong–sau, cả tình huống ngắt; cung cấp vùng
đầu/đuôi và điểm tiếp xúc/đồ vật theo frame khi cần. Codex kiểm định và tích hợp
sau duyệt, không dùng clip sai nghĩa thay ảnh thiếu. Không ép số frame theo bảng P2 cũ.

## Giới hạn
Chưa có bộ P2 mới hoặc xác nhận bàn giao Gen. Chưa nghiệm thu R08 toàn bộ,
chưa R09/soak30phút trên bản mới, chưa QA tay hoặc mixedDPI/unplug/macOS.
Không mở S4-06. Không commit/push. CHANGELOG bỏ qua vì tiếp tục tính năng chưa phát hành.

## Kiểm định và bản chạy
- Runtime295 passed/1ignored export; shared fixtures2; renderer30; overlay action-priority contract1; native session27/27 đạt sau khi tạo đúng thư mục bằng chứng.
- Clippy all-targets với senko-asset-tools, scoped rustfmt, git diff --check đạt.
- just senko-build đạt; smoke5giây exit0; mở bản mới PID44224, SHA256 500C41148AB9456DD99D6C417CA508519210E7D10F04AFF907CD5FC9B2248DAB.
- Test mới xác minh Surprise kết thúc và Held/Fall ngắt; contract xác minh không chen tuyến đang chạy. Bộ native là hồi quy hiện có, chưa có bằng chứng native chuyên biệt cho toàn chuỗi cửa sổ mới→Surprise. Không suy test thành nghiệm thu cảm xúc bằng mắt.
- Log gốc lần native lỗi đường dẫn vẫn giữ SENKO-RP-R08-native.log; lần đạt ở SENKO-RP-R08/native-final.log.
