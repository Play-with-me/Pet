# S4-05-A — context ứng dụng và idle/care policy
Ngày 28/10/2026. Đây là phần đầu S4-05, chưa đóng nghiệm thu toàn mã.

## Phạm vi và mã
- senko_care.rs thuần runtime: phân loại exe, chỉ đọc YouTube/Netflix từ caption trình duyệt trong RAM; không lưu tên/caption hoặc lịch sử. Work/Media thiên về ý định yên hơn (+0.2 quiet/-0.2 moving), Chat thiên Watch (+0.2), không bỏ lựa chọn di chuyển hoặc hủy cam kết đang chạy.
- Idle120s ngáp một lần rồi ngồi; idle600s ngủ; hoạt động lại Animator dùng wake thật. Runner chỉ tiếp quản khi có sàn, không leo/chở/đang theo tuyến; bế/rơi/xoa đầu ưu tiên cao hơn. Không lấy fullscreen làm điều kiện ngủ/ẩn.
- Policy đếm ước lượng hoạt động khi input gần hơn2giây, sau50phút phát Care; cooldown30phút, nghỉ liên tục5phút reset accumulated activity. Không đếm pause/stale/unknown/suspendgap>750ms. Greet/Care là event P2, chưa có hiển thị wave/tea/stretch; không thay clip sai.

## Kiểm định thực chạy
- Test mới: care5 + appbias1 đạt. Mô phỏng biên120/600s, returnedge, 50/30/5phút, pause/stale/suspend, category và Animator sleep/wake/held.
- Runtime toàn bộ219+2fixture đạt trước khi thêm2test cuối; sau cùng nhóm senko66 đạt. Không gọi toàn221 đã chạy đầy đủ.
- Overlay sprites14 gồm opt-in native và actualpack đạt sau sửa cuối; Clippy runtime/overlay alltargets, scopedfmt, diffcheck đạt. Native chưa tiêm idle120/600s, nên chuyển idle toànrunner vẫn cần ca kiểm tra riêng. Không QA chuột thật/mixedDPI/hardware hoặc30phút hashmới.
- just senko-build lần đầu LNK1104 do EXE cũ đang mở. Đã kiểm tra đúngPID/path rồi đóng PID44380, build lại đạt. Smoke release5giây exit0, mởPID13856. SHA25613CB98A16D2C81D4AA0616DA904E49F6C6C8D90AC3B7EF5B3CBA3E4BCC88D0D7.

## Còn lại S4-05
- Phản ứng sự kiện world mới và liên hệ nhu cầu concern; không suy foreground đổi thành app mở/tắt.
- Kiểm tra end-to-end idle/yawn/sleep/wake với context tiêm; kiểm tra energy phục hồi khi policy ép nghỉ và ngắt theo ưu tiên.
- P2 sit_back_watch/music_bob/wave/tea/stretch/dust chỉ hiển thị sau ảnh đúng GĐ5; chưa coi đầy đủ trải nghiệm app/care đã hoàn thành.
- S4-06 persistence chưa mở. Không đổi PNG/manifest/Gen/dependency/chính sáchWindows hoặc commit/push. CHANGELOG bỏqua vì tiếp tục chức năng Senko chưa phát hành.
