# SENKO-ANIM-A04-W — bàn giao 31/10/2026

## Phạm vi và kết quả
Tiếp A04: nguồn đi bộ 3/4 trước, công cụ chia sheet và preview riêng. Không đổi Brain, vật lý, motor, pack mặc định hoặc bản chạy.

Sáu lượt imagegen được giữ cùng prompt trong `resources/characters/senko-160-source`: dense-keys-v1, third-v1, two-thirds-v1, third-v2, two-thirds-v2, single54-v1. Bộ 18 key `walk-34-dense-keys-v1` có preview `walk-34-phase-review-v1`: 1200 ms/chu kỳ, 15 hình/s, chưa phải 45 FPS.

Hai thử nghiệm `walk-34-54-v1` và `walk-34-54-v2` có 54 hình riêng, 22/23 ms, tổng 1200 ms, stride 144 px; KHÔNG được chấp nhận về hình ảnh vì mặt/đầu đổi giữa nhóm nguồn. v2 dùng cùng scale từ key sheet, không scale riêng từng sheet. Không coi audit đạt là nét vẽ đạt. Thử single54 thiếu tư thế bị tool từ chối trước khi xuất pack; không có pack v3 và không nhân bản để lấp thiếu.

## Kiểm tra thực hiện
- Asset tool 20/20 và Clippy -D warnings đạt; log cuối dùng chung tại SENKO-ANIM-A04-X/tests-final.log và clippy-final.log.
- Audit v1/v2: 54 ảnh unique, giữ 18 key, canvas160, hard alpha, palette32, baseline152, timing1200ms; chiều cao v1 121..128, v2 123..129. Không chứng minh ổn định thể tích/khuôn mặt.
- Native test v1 đạt 1/1, 108 Present cho 54 frame/hai mirror. Không chạy native v2; kết quả không chứng nhận cadence45FPS hoặc chất lượng gait.
- Single54 bị từ chối vì thiếu pose; không coi RGB của pixel alpha0 là nền đục.

## Còn lại
Đầu/mặt nhất quán, chân chịu lực, thể tích, vòng nối và các hướng khác còn phải hoàn thiện. A04 chưa hoàn thành. Không build release, không đổi default, không chạy soak30phút. Không subagent/commit/push. CHANGELOG chưa cập nhật vì vẫn trong cùng tính năng chưa phát hành.
