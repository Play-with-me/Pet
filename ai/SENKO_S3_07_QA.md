# S3-07 — kết quả kiểm định GĐ3, còn mục nghiệm thu

## Cập nhật S3-07-B, 28/10/2026
Đã xử lý hồi quy topmost: HWND được tạo với WS_EX_TOPMOST khi cấu hình yêu cầu. Giữ nguyên đường placement/toggle/recovery và cờ không kích hoạt; test bổ sung xác nhận khởi tạo vẫn ẩn. Baseline cả nhóm121pass/1fail chuyển thành122pass/18ignored trong hai lượt. Session Senko11/scanner11,Clippy3crate/alltargets+assettools,fmt và just senko-build đạt. Đây là kết quả hiện tại; các phần lỗi topmost bên dưới là lịch sử trước sửa.

Release mới SHA25616ECFF57CE67F2A266D9C2457110262E9C7C796AEE92FF84F7F9A1F6E5C2DB0F chạy smoke5giây exit0; đã mởPID41452, lần kiểm tra cuối chỉ một tiến trình và Responding. Kiểm tra mở trùng chưa chạy trong lượt này vì lệnh gộp bị automatic approval review từ chối: blocked by policy. Không suy kết quả mở trùng của bản trước sang bản mới.

Monitor30phút phía dưới thuộc hashB314..., bản mới chưa có lượt30phút riêng. QA tay production, foreground/sameband và hardwaremixedDPI/unplug còn chờ; GĐ4/GĐ5 chưa bắt đầu. Không đổi asset/Gen/chính sáchWindows hoặc commit/push/chuyểnnhánh. CHANGELOG bỏ qua trong lượt tiếp tục Senko chưa phát hành; không dữ liệu cần xóa. Log ai/logs/SENKO-S3-07-B. Contract native: https://learn.microsoft.com/en-us/windows/win32/winmsg/extended-window-styles .

Ngày28/10/2026. Bản được kiểm tra: release S3-06, SHA256 B314382E61145E0BC4874EDB105CBF8C694DDEF7C3430D974A4B3A9BC8A460A1, PID29196. Lượt này chỉ bổ sung test/harness; không đổi hành vi production hoặc assetv5.

## Bằng chứng hiện có
| Hạng mục | Kết quả | Phạm vi |
|---|---|---|
| Runtime/render |188+2fixture/29 đạt| Bao gồm physics/route/Animator, gap/seam/negative/topology mô phỏng |
| Scanner native/unit |11 đạt, gồm7native| DWM window lifecycle, body/route harness, cache, resize/maximize/close while climbing, promotion/demotion Z-order |
| Companion hồi quy |18 đạt| Session v5, Nearest/gait, alpha hit routing legacy, physics/người que/pause/reset/exit; bỏ interactive QA600s cần người thao tác |
| Người que GPU |1 đạt| D3D11 DrawIndexed/readback,C02-preview.png |
| Window proc |6 đạt| DPI/resize/messages/clickthrough generic |
| Topmost regression cũ |Chưa giải quyết| Chạy riêng đạt nhưng cả nhóm overlay fail;121đạt/1fail/18ignored, xem overlay-default.log |
| Clippy |đạt| Runtime/render/overlay alltargets với assettools |
| Format |đạt| rustfmt --check file test sửa |
| Ổn định1800giây |Đạt1801,409giây| 61mẫu/0mẫu mất phản hồi, cùngPID29196, hashEXE giữ nguyên; Stopwatch từ mẫu đầu, không cộng tuổi process trước theo dõi |

## Phân biệt kết quả và giới hạn
- Scanner dùng HWND thuộc test và dữ liệu DWM thật, có cô lập khỏi các cửa sổ khác khi kiểm tra body/geometry. Không gọi đây là video hay QA tay pet production trên cửa sổ người dùng.
- Bài đổi Z-order bằng chèn giữa hai HWND cùng lớp qua3lần đơn lẻ nhưng fail trong cả nhóm. Không coi đã sửa triệt để. Ca cuối chuyển topmost/bottom ở hai chiều đã qua cả nhóm; chỉ chứng minh promotion/demotion và cập nhật che khuất. Same-band activation/foreground người dùng còn chờ. Tham khảo API: https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setwindowpos .
- Lần chạy companion đầu thiếu C03/C04/C05/SENKO_QA_OUTPUT_DIR gây5fail thiết lập; log companion-missing-env.log giữ nguyên. Lần chạy đủ env và bỏ bài interactive mới là kết quả18đạt trong companion.log. Không gọi bài interactive đã đạt.
- Kiểm tra mixed-DPI/nhiều màn hình/tọa độ âm/unplug được thực hiện bằng snapshot mô phỏng và thông điệp DPI tổng hợp; chưa QA hai màn hình vật lý hoặc tháo màn hình thật. Không tự đổi settings/khóa máy của Leader.
- Chưa fullworkspace/macOS, chưa nghiệm thu cảm giác/chuyển động của Leo/Mantle trên production bằng QA tay. Không suy mốc30phút thành soak8giờ hay benchmark tối ưuGĐ5.

## Cổng tiếp theo
Monitor đã kết thúc đạt30phút; GĐ3 còn QA tay/hardware. Lỗi topmost generic đã được xử lý trong lượt S3-07-B bên dưới. Giữ GĐ4/GĐ5 chưa bắt đầu. Bản release S3-06 đang mở để Leader thử; không cần build lại production vì lượt này chỉ thêm test/harness và tài liệu.

### Cập nhật QA mở rộng
- Overlay lib mặc định:121đạt/1fail/18ignored. Lỗi topmost cũ a_demoted_model_window_returns_to_the_topmost_band qua khi chạy riêng nhưng fail khi chạy cả nhóm (overlay-default.log); chưa xác định nguyên nhân/chưa sửa, không kết luận renderer toàn bộ xanh. Không mở rộng sửa code generic ngoài nhiệm vụ.
- Leader trả lời chưa thử các tình huống cửa sổ; không ghi nhận QA tay đã đạt. Computer-use không liệt kê overlay Senko trong list_windows/list_apps, nên không thực hiện thao tác hoặc tự thay style để ép công cụ nhìn thấy.
- Nhóm scanner cuối chuyển sang promotion/demotion thật đạt11/11, không coi chèn cùng lớp đã ổn định. Diff --check đạt sau khi bỏ dòng trống cuối tài liệu do lượt trước thêm; không thay source production.



## Chốt lượt theo dõi30phút
- soak-result.json: passed,1801.4090401giây,61mẫu,0mẫu không phản hồi; PID29196 không đổi, EXE SHA256 không đổi. Theo dõi từ18:19:09 đến18:49:11 ngày28/10/2026 giờ máy, không tăng tốc hoặc cộng thời gian chưa quan sát.
- Working set36.655.104–50.245.632bytes, private78.258.176–78.405.632bytes,handles599–607; CPU tích lũy tăng75.046875giây. Đây là thống kê của lượt theo dõi trong môi trường có chạy test khác, không là benchmark idle/walk/climb GĐ5 hoặc bằng chứng không leak dài hạn.
- Không có eventApplication1000/1001 khớp companion_senko.exe trong khoảng đọc; process vẫn còn một và Responding sau kết thúc. Process không bị khởi động lại trong lượt. Chỉ kết luận ổn định/khả năng phản hồi trong30phút, không chứng minh mọi frame được vẽ hay soak8giờ.
- Báo cáo/ADR/TASKS/master/handoff/SYNC đã ghi phần đạt và chưa đạt. Không commit/push/chuyển nhánh/sửaasset/Gen; upstream47a73ed1 giữ nguyên, không merge dirtytree. CHANGELOG bỏ qua vì tiếp tục Senko chưa phát hành; không có dữ liệu người dùng cần xóa.

