# SENKO-RP / R-04 — tương tác theo tâm trạng
Bàn giao 29/10/2026. Lõi logic và tích hợp P1 có kiểm định; chưa hoàn tất biểu cảm mới.

## Phân công và review
Leader yêu cầu Luna và Max viết mã, Codex quản lý và kiểm tra cuối. Luna viết `senko_touch_policy.rs`/10 test; Max nối runner và hai test tích hợp. Codex đọc mã, yêu cầu sửa token thưởng một lần và điều kiện mất dữ liệu con trỏ, kiểm tra lại kết quả cuối. Không sửa art/manifest/Gen hoặc mở persistence.

## Thay đổi
- Headpat cân năng lượng, khó chịu, giật mình; tail xét thêm thân thiết. Trạng thái bình thường vẫn nhận xoa đầu.
- Ba lần chạm hợp lệ dồn trong khoảng3s có thể bị từ chối; Teased giới hạn mỗi2s, không cập nhật theo hover mỗi tick.
- Thưởng chung cách8s active time, token dùng một lần; từ chối/bận/thiếu actor không tăng affection/social hoặc phát AcceptedTouch. Token cũ không commit sau một quyết định từ chối.
- Được để yên liên tục12s active time phát Reassured một lần; pause đóng băng, suspend cap100ms; cần cursor hợp lệ và không chạm đầu/đuôi, không bế/rơi/leo/trượt, không đang headpat. Không thưởng affection cho việc nguôi.
- Chỉ P1 headpat có actor được dùng. TailCare/Decline/ProtectTail/Sulk/Reconcile bị gate MissingAsset; không thay bằng clip sai. Logic khó chịu/dịu lại vẫn hoạt động trong RAM, chưa có biểu cảm tương ứng.
- Giữ alpha theo frame thực/mirror, pointgrip/capture, phanh và ưu tiên bế/rơi. Phản ứng không gán vị trí/vận tốc.

## Kiểm định thực chạy
- Runtime261pass/1ignored(export),2fixture; renderer30pass.10testpolicy gồm mood/energy/tailtrust, chống thưởng/lặp, token, thiếu actor, pause/suspend/rollback, quiet reset và dịu lại để nhận headpat.
- Session20/20 đạt với bộ233PNG/45clip: mới native từ chối khi inject khó chịu, không headpat/thưởng; test thiếu/bậnactor không tác dụng tích cực. Native acceptedheadpat/grab/capturecancel, Look4phase, pause/reset/DPI/exit/Nearest/alpha/gait tiếp tục đạt. Native pointer/mood được tiêm trong fixture; không phải QA tay chuột thật.
- Clippy3crate/alltargets/assettools, scopedrustfmt và gitdiffcheck đạt. Logs tại `ai/logs/SENKO-RP-R04/`.

## Giới hạn và phần tiếp theo
Headpat vẫn dùng HeadpatGesture P1; thưởng lúc actor nhận yêu cầu hợp lệ, trước khi phanh/hiển thị, chưa dùng episode/renderedID để quyết định thưởng. Chưa chuyển Headpat sang lifecycle4phase. Refusal/protect/sulk/reconcile và tailaccept chưa nghiệm thu trực quan, cần Gen làm art/preview được Leader duyệt theo MSG238. Vì vậy không gọi toàn bộ R04 hoàn tất.
R05..07 chưa triển khai theo plan mới; quiet-app và idlefixed cũ còn trong runner cho đến đúng phần thay thế. S4-06/phần mới giữ lại. Chưa chạy30phút bản mới, QA tay/mixedDPI/unplug/macOS/fullworkspace/benchmark; không suy bằng chứng hash cũ. Không sửaPNG/manifest/Gen/dependency/Windowssecurity/branch; không commit/push. CHANGELOG bỏ qua vì tiếp tục chức năng Senko chưa phát hành, không cần xóa dữ liệu người dùng.

## Bản chạy
`just senko-build` đạt; startup release5s exit0, mở bản mới PID46140. SHA256 D2C3A11565905279FA08FB70EF5D3A63EED28424725195BF39DB9511939592CE. Không có tiến trình Senko cũ ở lúc trước build. Đây là smoke ngắn, chưa soak30phút.
