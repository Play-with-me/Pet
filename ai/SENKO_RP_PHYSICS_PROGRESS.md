# SENKO-RP — báo cáo nguyên mẫu vật lý đầu tiên
Ngày 28/10/2026. Đặc tả: SENKO_REACTION_PHYSICS_PLAN.md. Đây là bàn giao nguyên mẫu R-01/P-01/P-02 và một phần P-03, không phải hoàn tất toàn kế hoạch.

## Đã thực hiện
- R-01: lưu đặc tả thay thế theo Leader; gửi yêu cầu R-08 cho Gen qua MSG-238, chưa có xác nhận. Không sửa PNG/manifest/Gen.
- P-01: senko_motion.rs tập trung gravity1800/acceleration900/braking1400/slidingfriction990/maxdrive280/maxthrow2400/maxsurface1500/gripacceleration3600/impact100,600/maxstep0.1. Gravity route/body dùng cùng nguồn. Các giá trị là tuning nguyên mẫu, chưa nghiệm thu thị giác.
- P-02: GroundMotion tích phân tăng tốc/phanh/quay đầu qua zero, stoppingdistance; kiểm tra30/60/144Hz. Runner dùng sharedmotion cho easing+brakingreserve, nhưng vẫn còn stage/reset logic cũ; signedvelocity end-to-end chưa hoàn tất P-04.
- P-03 phần grip: regression slope trên tối đa16mẫu/100ms RAM, dữ liệu gap>100ms xóa trace; điểm nắm chính xác; heldstill giảm throwvelocity, cap2400, cancelzero. Không serialize/log pointertrace.
- P-03 phần tiếp đất: swept impact phát một lần, normal/tangentspeed và Placed/Soft/Hard; giữ tangentialslip, friction làm giảm đà, trượt qua gờ chuyển sang rơi và tích phân phần thời gian còn lại. Passive slip tách khỏi gait và tạm chặn route/touch trong runner. Dùng balance_wobble đúng ngữ nghĩa mất thăng bằng hiện có, không tạo/sửa clip slide.
- P-03 phần support: snapshotvelocity, acceleration có thể gây slip/detach; detach kế thừa surfacevelocity hợp lệ. Jumpdiscontinuity vẫn giữ guard1500. Test cũ tên slowtransport đổi100ms thành1000ms vì fixture50x/20y trong100ms gây gia tốc dọc2000>gravity, không còn là chở chậm theo mô hình mới.

## Kiểm định thực chạy
- Runtime228+2fixture, render30 đạt. Motion3test30/60/144, grip1testnhiềutầnsố, landing/slip2test, platform1test mới đạt. Các kiểm tra hình học/tuyến cũ vẫn đạt.
- Overlaydefault128đạt/21ignored. Session senko-asset-tools15/15 gồm opt-in native/actualpack; native5s295Present; walk/run đủ16phase, selftravel193.21/481.65px; headpat/held/capturecancel, grab/pause/reset/DPI/exit và GPUmask đạt.
- Export prototype ignored test opt-in1 đạt. physics-traces.json gồm4scenario/300sample60Hz được xuất trực tiếp Rust; index.html hiển thị dot là foot, không giả đây là fullcharacterphysics QA. GIFnativewalk/run lấyGPU thật; không chụp desktop.
- Clippy3crate/alltargets/assettools, scopedfmt và diffcheck đạt (cảnh báoLF/CRLF có sẵn). Không chạy fullworkspace/macOS/hardware/soak30phút hoặc releasebuild trong lượt nguyên mẫu này. Bản release cũ chưa được thay bằng nguyên mẫu.

## Chưa hoàn tất và bước tiếp
P-01 chưa quét gom hết mọi limit cũ; P-02 chưa signedvelocity end-to-end; P-03 chưa motionhistory của mọi bề mặt để landing relativevelocity đầy đủ, hysteresis/settling và kiểm định acceleration/slip theo nhiềutầnsố; P-04 planner cần dự báo launch/landing trên movingplatform, leo/mantle và cách Animator chịu motorfeedback. Các công thức/tuning prototype cần duyệt cảm giác sức nặng bằng hình nhân vật. R-02..R-07 chưa triển khai theo đặc tả mới, nên quiet-app/idlefixed cũ vẫn còn trên release hiện tại. R-08 đang chờ Gen/duyệt art, R-09 chưa mở.

Không commit/push/đổi branch/dependency hoặc chính sáchWindows. CHANGELOG bỏqua: tiếp tục tính năng Senko chưa phát hành. Preview: logs/SENKO-RP-PHYSICS/index.html. Yêu cầu mở preview đã queued trong app, không khẳng định đã render màn hình. Những kết quả mới không thay nghiệm thu người dùng.

## Cập nhật P-04-A (29/10/2026)
Signedmotor/relativeimpact/translatingflight đã nối và kiểm định thêm; releaseA45682B8... đã mở. Những dòng chưa làm ở báo cáo ban đầu phía trên là lịch sử; đọc ai/SENKO_RP_P04_PROGRESS.md cho trạng thái mới. Toàn P04 và R02..R09 vẫn chưa đóng.

