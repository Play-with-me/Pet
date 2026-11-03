# SENKO-RP / P-04-A — nối motor, planner và Animator
Ngày bàn giao29/10/2026 (lượt bắt đầu28/10). Chưa đóng toàn bộ P-04 hoặc phần phản ứng.

## Đã thay đổi
- Runner giữ signedvelocity của motor khi phanh; giữ hướng/tư thế di chuyển theo đà thật, không reset vận tốc chỉ vì muốn quay/ngồi/xoa đầu. Khi về0 thì đặt chân tại chỗ rồi cho Animator quay/diễn; tránh deadlock chờ sync mà motor không còn đi. NavFeedback chỉ cho bước leo/nhảy tiếp khi idle và motor/slip đã dừng.
- Body nhận activegroundspeed mỗi tick; mất điểm tựa chuyển đà chủ động cùng surface/slip sang rơi. Bế/mấtcapture vẫn ưu tiên, không ép point nắm trễ. Walking trên support đang chở vẫn có selftravel riêng.
- SurfaceMotion cache đúng hai mẫu hình học gần nhất theo WindowId/generation, không giữ danh tính app/title. Loại dữ liệu resize, rollback/zero-time, gap>750ms hoặc tốc độ>=1500; same-snapshot giữ estimate. Impact nhận normal/tangent relative với bề mặt được quan sát, detach giữ đà bề mặt.
- Runtime flight forecast tính intercept của gờ dịch chuyển, giới hạn active thrust so với nguồn; swept first-impact dự báo gờ và kiểm tra vùng chắn dịch chuyển bảo thủ. Graph static vẫn là đề xuất; trước launch tính lại bằng geometry/motion hiện tại. Không bẻ vận tốc trong flight theo goal.

## Kiểm tra đã thực chạy
- Runtime231đạt/1ignored(exportprototype)+2fixtures; renderer30đạt. Log runtime-render.log.
- Test mới: cachemotion generation/timegap; mất sàn mang signedactivevelocity/landing relativevelocity; ballisticintercept gờđích20px/s và từ chối đích1000px/s.
- Actualpack motor/Animator harness30/60/144Hz: đi phải -> phanh -> quay -> đi trái -> phanh -> headpat, không giữ tốc độ khi pose turning/gesture, không deadlock, gia tốc trong giới hạn. Đây là harness dùng art thật, không phải video quay đầu từ cửa sổ native.
- Session16/16 gồm harness trên, actual233frameregions và nativewindowtests. GPUwalk/run đều đủ16frame, selftravel189.57/495.26px; headpat/grab/capturecancel/pause/reset/DPI/exit vàNearest đạt. Native smoke295Present/5s. Tọa độ tiêm không thay QA chuột vật lý.
- Clippy runtime/render/overlay alltargets+senko-asset-tools đạt; scopedfmt/diffcheck đạt. Không chạy lại toàn overlaydefault/fullworkspace/macOS/hardware hoặc soak30phút trong lượt này.
- just senko-build đạt. Sau kiểm tra đúng path, đã đóng releasecũPID13856 để linker không bị EXElock. Smoke release5s exit0; releaseA45682B8FE454D32A216E9FFE7B7B30274B2B9DBB6F1353B2E00EA6B16A15931 mởPID21892. Xem release.json; chưa có soak30phút cho hash này.

## Phạm vi còn lại
- Chưa nghiệm thu chuyển động/cảm xúc với Leader. Art nguồn v5 không sửa; R08/Gen chưa xác nhận MSG238.
- P04 cần kiểm tra dynamic-world end-to-end với cửa sổ thật di chuyển; moving-wall hop/catch, force/phasecoordination leo-mantle và impact settling/hysteresis còn mở. Cache dự báo vận tốc đều từ geometry quan sát, không dự báo gia tốc tương lai.
- R02..07 theo thiết kế mới chưa triển khai, quiet-app/idlefixed cũ vẫn còn; không gọi toàn bộ plan đã hoàn thành. S4-06/phần mới giữ nguyên chưa mở.
- Không commit/push/đổibranch/dependency/asset/Gen/chínhsáchWindows. CHANGELOG bỏ qua: tiếp tục tính năng Senko chưa phát hành. Không có localuserdata cần xóa.
