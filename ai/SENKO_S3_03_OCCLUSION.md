# S3-03 — Gờ, tường và che khuất

Ngày 28/10/2026. Codex thực hiện theo lệnh tiếp tục của Leader. GĐ2 đã được duyệt; lượt này chỉ triển khai hình học của GĐ3, chưa nối vật lý hoặc tuyến đường.

## Đã triển khai

- `runtime/world_geometry.rs` sinh gờ trên và hai tường cho cửa sổ được leo. Trừ tất cả vùng cửa sổ phía trước theo Z-order, kể cả cửa sổ không được leo. Các cạnh trùng nhau được xử lý thận trọng như cạnh bị che.
- Cắt cạnh theo hợp các vùng display thực tế, không lấy hình chữ nhật bao toàn desktop. Không tạo cạnh trong khoảng trống giữa màn hình hoặc tường leo ở mép màn hình. Mỗi monitor có sàn tại đáy work-area riêng; cửa sổ fullscreen không làm mất ranh giới vật lý này.
- Phân biệt cạnh nhìn thấy và chỗ đủ cho thân 104×248: `standing_ranges` kiểm tra chiều rộng và khoảng trống phía trên; `climbing_ranges` kiểm tra cả thân bên ngoài tường. Cho phép tiếp xúc biên mà không xuyên vào vật che, kể cả chỗ rộng đúng bằng thân.
- `mantle_for` yêu cầu đỉnh thật của cửa sổ, đoạn tường tới được đỉnh, điểm đặt chân nằm trong vùng đứng hợp lệ và khoảng thân quét qua không giao cửa sổ phía trước. Không coi đầu một đoạn tường bị cắt giữa chừng là góc để trèo lên.
- Rebuild có tính giao dịch: kiểm tra nguồn, dựng trong bản tạm, validate rồi publish. Giữ revision/timestamp và ID có generation; loại fragment cũ khi truy vấn. Scanner đã gọi rebuild mỗi lần có mẫu mới; không dựng lại hình học trên mỗi frame nếu không quét.

Không sửa asset v5, Animator, vật lý người que hoặc hành vi di chuyển đã duyệt. Body đang chạy chưa dùng các mặt mới; S3-04 sẽ nối va chạm và điểm tựa.

## Kiểm tra thực chạy

Log: `ai/logs/SENKO-S3-03/`.

- Thêm 12 unit test hình học: gờ/tường thật, cắt ngang/dọc, vật che không leo được, headroom, cả hai phía mantle, tiếp xúc biên, Z-order đổi trong dữ liệu, khoảng trống màn hình ngang/dọc, tọa độ âm, chỗ hẹp, fullscreen, stale generation, rebuild lỗi và idempotence.
- Một test đối chiếu 120 bố trí với bộ kiểm tra điểm độc lập: 43.200 mẫu cạnh, không chỉ kiểm tra số fragment.
- Runtime 160 unit + 2 fixture và renderer 28 unit đạt. Nhóm scanner 6 test đạt, gồm 2 native; session 9 test đạt, gồm 4 native. Walk/run đủ 16 pha khi thân di chuyển; kéo/thả, pause/reset/exit, Nearest 4×4 và Linear mặc định đạt. Số Present cụ thể trong session.log.
- Native đọc DWM và Z-order thật của hai HWND thử, tạo cặp snapshot cô lập để kiểm tra cắt gờ, cắt tường và khôi phục khi đóng blocker. Snapshot desktop đầy đủ cũng xác nhận cửa sổ thử bị che hoàn toàn không còn gờ.
- Host có cửa sổ toàn màn hình nằm trước một fixture, nên không thể giả định hai fixture là toàn bộ vật che. Log thử đầu giữ lại. Native fixture nay dùng PER_MONITOR_AWARE_V2 như production để tránh trộn monitor/DWM physical pixels với tọa độ bị DPI virtualize; đây không phải chứng nhận mixed-DPI.
- Thử raise/demote topmost fixture không làm thay đổi thứ tự EnumWindows trong host, dẫn tới timeout. Không sửa code để bỏ qua vật che hoặc giả lập đổi Z-order trong production. Ca đổi thứ tự được kiểm định bằng unit input; **đổi Z-order bằng thao tác native/người dùng vẫn chưa xác nhận**, dành cho S3-07. Các log native-order*.log giữ kết quả thất bại, không coi bộ native cắt cạnh đã đạt là chứng cứ cho ca này.
- Clippy ba crate/all-targets/asset-tools và fmt file sở hữu đạt. Build qua `just senko-build`; hash/PID và trạng thái instance ở release.json/lifecycle.json.

## Còn lại

S3-04: phát hiện bề mặt đầu tiên khi rơi, điểm tựa, chở theo cửa sổ chậm, thả khi mất điểm tựa hoặc cửa sổ dịch nhanh, trọng lực 1800 px/s². S3-05 mới thực thi tuyến đi/leo/mantle/nhảy/thả; S3-06 xử lý monitor/DPI/recovery; S3-07 nghiệm thu native đầy đủ.

Chưa QA tay, đổi Z-order native thành công, mixed-DPI/tháo màn hình, soak 30 phút binary mới, macOS hoặc toàn workspace. Lỗi topmost của full overlay từ lượt trước vẫn ngoài phạm vi; chưa xác định nó có cùng nguyên nhân với hạn chế đổi thứ tự fixture hay không.

Không commit/push/chuyển nhánh/sửa bàn giao Gen. Origin/master `47a73ed1` đã fetch, chưa merge dirty tree. CHANGELOG bỏ qua vì tiếp tục tính năng Senko chưa phát hành; không có dữ liệu người dùng cần xóa. GĐ3 chưa nghiệm thu tổng thể; GĐ4/GĐ5 chưa bắt đầu.
