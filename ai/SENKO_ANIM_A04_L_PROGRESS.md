# A04-L — kiểm định chuỗi chuyển tiếp,30/10/2026

## Phạm vi
Leader cho tiếp tục plan sau K. Chỉ tool/asset metadata/test native, không Brain/body/motor/planner/defaultpack. Không subagent/dependency/lockfile/commit/push. Fetch origin đã chạy; không merge/switch checkout.

## Đã làm
- Chạy lại --walk-world160 trên partialpack side-sequence-grounded-v8, tạo transitions-world-v1:13ca Body/GroundMotion/Animator thật trên sàn tổng hợp, gồm30/60/120Hz ×hai hướng ×hai sync và một đổi hướng.
- Audit cả13ca: mọi clip/frame tồn tại và trong giới hạn, tọa độ hữu hạn;12/12mối nối dừng có canonical texture đúng. Không coi các ca inputphase khác nhau là chứng nhận vật lý bất biến tuyệt đối theo FPS.
- Test native ban đầu chỉ phủ sync0 cảhai hướng. Đã sửa duy nhất bộ lọc test và số ca kỳ vọng trong companion_sprites.rs để bao cả sync27, không thay production renderer/runtime.
- Chạy bản test đã sửa:1/1đạt, bốn trace60Hz (hai sync×hai hướng), tất cả54framewalk và tất cả14/18framestop tương ứng đã Present; HWND di chuyển theo bodytrace, gồm chiếu tọa độ âm vào viewport thử. Đây là trace mới K, không tái dùng trace J/I.
- Sửa sequence-report.json của partialpack: loại sốframe9/10 và nguồn sheet cũ được copy từ pack trước; ghi lại frame/duration thực và giới hạn. Không thay PNG/timing của K trong lượt này.
- rustfmt file test và git diff --check đạt (chỉ cảnh báo CRLF sẵn có ở file khác).

## Bằng chứng
ai/logs/SENKO-ANIM-A04-L/native-four.log,world-audit.json,audit-world.cjs.
Preview:resources/characters/senko-160/transitions-world-v1/index.html đọc trace actualAnimator/body. Các điểm chú thích là contact visual, không sửa hình học vật lý.
Lệnh open_in_codex trả queued, chưa xác nhận tab hiển thị. Inventory CUA đầu lượt không có tab IAB. Không tuyên bố đã xem playback browser hoặc kiểm tra cadence màn hình trong lượt này. Native test thực có Present, không phải bằng chứng thẩm mỹ toàn chuỗi.

## Còn lại
A04 chưa xong: thân/tay/đuôi, quay đầu có tư thế trung gian thật, run và các hướng khác. Chuyển tiếp K14/14/18hình400ms vẫn draft, chưa45drawing/s toàn bộ. Mẫu upper146rows tĩnh không đủ để nghiệm thu toàn thân. Chưa releasebuild/defaultswitch/soak30phút; chưa toàn bộ native/runtime regression. Bản chạy hiện hữu không bị thay.
CHANGELOG bỏ qua: tiếp tục cùng tính năng chưa phát hành. Không dùng kết quả QA kỹ thuật để đánh dấu art tự nhiên/cute đã hoàn thành.
