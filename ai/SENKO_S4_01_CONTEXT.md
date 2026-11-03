# S4-01 — ngữ cảnh đầu vào

Ngày28/10/2026. Leader đồng ý tiếp tục sau báo cáo S3-07-B; Codex bắt đầu phần nền GĐ4. Những giới hạn QA tay/hardware của GĐ3 vẫn giữ nguyên trong báo cáo, không coi đã kiểm tra hoặc tự thay yêu cầu plan.

## Mã đã làm
- Runtime có SenkoContext/ForegroundApp thuần dữ liệu và freshness750ms. Không Serialize; Debug không in title/exe/identity.
- Windows có InputContext lấy mẫu250ms, giữ đúng một snapshot, thay mẫu lỗi bằng dữ liệu thiếu và kiểm tra lại HWND/PID/TID sau đọc. Không suy app mở/tắt từ foreground hoặc lifecycleworld.
- Đọc foreground EXE basename qua quyền querylimited, caption512UTF16 tạm RAM, idle timestampước lượng và fullscreen theo DWM/displayphysical. Process handle có RAII; không ghi phím/title/cursor/screenshot/history/file hoặc gửi mạng.
- Runner manifest đã gọi source cùng worldmonitorcache, cả khi pause; fullscreen không tự ẩn/ngủ. Chưa có Brain nên context chưa điều khiển hành động. Assetv5/gait/physics/người que/legacy không thay.

## Kết quả kiểm định
- Runtime190+2fixture/render29 đạt; gồm2contexttest về freshness và chẩn đoán không lộ nội dung.
- Contextoverlay6test gồm2native đạt: cadence/reset/error, idlewrap/future, basename/titlebound/UTF16, fullscreenworkarea vs display, query PID/HWND lỗi,100lần đọcprocess không tănghandle ngoài ngưỡng1, DWMfixture resize/minimize/destroy. Nativefullscreenfixture dùngdisplaymôphỏng, không gọi QA phần cứng thật.
- Overlaydefault126đạt/19ignored trước khi thêm nativefixture thứ hai; fixture bổ sung đã chạy trong nhómcontext6/6. Session manifest11/11 có4native đạt sau tích hợp source. Clippy3crate/alltargets+assettools và fmtfile thuộcphạmvi/diffcheck đạt.
- just senko-build đạt; startup smoke5giây exit0. Release SHA2563497EF45EAA6714D2AE6D6837401BF4D8FB67AED2FC7E4420DA64D9629F45B30 đã mởPID1944; lifecycle.json xác nhận Responding và read-onlycheck chỉ một Senko. Chưa chạy riêng kiểm tra mở trùng hoặc monitor30phút cho hash này; không dùng bằng chứng của hash trước cho bản mới.

## Giới hạn và tiếp theo
Titlecủa ownprocess bị bỏ qua để tránh WM_GETTEXT đồng bộ chặn GUI. Idle trên nửa chu kỳDWORD hoặc timestamp tương lai trảunknown; không tính là người dùng nghỉ nhiều tuần. Query thiếuquyền/deadwindow trảNone; native chưa ép được protectedprocess/race ởmọithờiđiểm. Fullscreen là phân loại hình học, không chứng minh overlay hiển thị trên exclusivefullscreen.

Tiếp S4-02 SenkoBrain: nhu cầu/utility/camkết/cooldown/bộnhớ10hànhđộng, chỉ chọn hành động khả thi theo world. S4-03..07/GĐ5 chưa làm; không dùng clip sai nghĩa cho phản ứng P2. QA hardware GĐ3,fullworkspace/macOS và soak30phút mới chưa thực hiện trong lượt này. Không commit/push/chuyểnnhánh/sửaGen hoặc thay chính sáchWindows; không dữ liệu cần xóa. CHANGELOG bỏ qua trong phần Senko chưa phát hành đang tiếp tục phát triển.
