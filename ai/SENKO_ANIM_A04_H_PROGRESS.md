# A04-H — sửa nhịp chân quá nhanh, 29/10/2026

## Yêu cầu và phạm vi

Leader phản ánh chân vung quá nhanh trong waist-review-v1, khó thấy chuyển động. Làm ứng viên chỉnh nhịp hoạt ảnh, không đổi tốc độ motor, body, Brain, planner, hành vi hoặc bộ mặc định. Không subagent/commit/push/dependency/lockfile. Fetch origin đã chạy, không merge checkout đang có thay đổi.

## Đã sửa

- Chu kỳ trước:800ms/96physical px ở120px/s, mỗi bước400ms. Nhịp thử mới:1200ms/144physical px ở cùng120px/s, mỗi bước600ms. Chu kỳ dài thêm50%, tần số bước giảm1/3.
- Manifest distance walk đổi stride mỗi frame từ96/36 sang144/36=4physical px. Đây là tiến độ hình theo quãng đường, không sửa lực/tốc độ body. Timed preview dùng33/34ms phân bổ đúng1200ms.
- Tool --walk-tempo160 tạo walk-tempo-36-v8 từ walk-waist-36-v7,36PNG copy byte-identical. Không tạo mới/nhân bản tranh, không giữ pose để báo đủ45FPS.
- Quan trọng:36tranh/1,2s=30tư thế mới/s. Bản chỉnh nhịp này **chưa đạt45FPS** đã duyệt; cần54tranh thực sự cho chu kỳ1,2s. Kế hoạch45FPS vẫn giữ, không coi chậm clock là hoàn tất sản xuất hình.
- So sánh tempo-review-v2: bên trái800ms, phải1200ms, cùng thời gian và quãng đường thân tham chiếu120px/s. Mỗi bên đọc delay từ manifest, không ép cùng chỉ số frame. Hai hướng, pause/scrub, phóng chân và mốc sàn.
- Partial side-sequence-tempo-v4 có clip đi cập nhật và giữ các clip vào/ra/góc đứng cũ. Các file canonical cho start/stop cùng tham chiếu ảnh walk mới. Không phải fullpack. Harness hiện tại:tempo-world-v1.

## Kiểm tra thực chạy

- Asset-tool18/18; Clippy -Dwarnings; rustfmt phạm vi và diffcheck đạt.
- Artifact:36PNG giống nguồn,12/12 điểm nối dừng khớp,13case tổng gồm quay đầu,11checksum module/manifest baselineA01 không đổi. Baseline không bao phủ mọi file body/planner.
- Harness WorldSnapshot/SenkoBody/GroundMotion/Animator production chạy12case30/60/120Hz × hai hướng × stopphase0/18 và một reversal trên sàn tổng hợp. Không dùng đây làm QA cửa sổ thật hoặc chứng nhận stance.
- Native test chuyên biệt1/1 đạt: replay hai trace body60Hz, cửa sổ di chuyển theo tọa độ trace, đủ10frame dừng sync18 đãPresent. Không đo cadence màn hình hoặc chất lượng gait.
- JS contract Node DOM/RAF stub:72PNG, mọi biên delay của hai manifest, phase độc lập800/1200ms,clock10giây tại30/60/120Hz,pause/mirror/reset đạt. Không phải browserGUI/GPUtest.
- Không build release hoặc chạy lại toàn bộ runtime/native suite vì không đổi code runtime/render/app. Không dùng số test lượt trước làm kết quả mới. App vẫn packv5.

Log/artifact-check.json tại ai/logs/SENKO-ANIM-A04-H. Preview:resources/characters/senko-160/tempo-review-v2/index.html, link trace ởtempo-world-v1/index.html. Không tạo nguồnAI mới trong lượt này.

## Chưa xong

Đây là ứng viên sửa nhịp, chưa nghiệm thu toàn bộ lỗi chuyển động. Tăng quãng đường chu kỳ với hình cũ có thể làm tiếp xúc chân chưa khớp: phải vẽ lại đường chân trụ/nhấc tương ứng, thêm18tranh trung gian thật và kiểm tra vòng lặp/stance. Không sửa vật lý để che trượt. Chưa đưa ứng viên vào defaultpack; A04/A08/A09 chưa đóng. Không yêu cầu xóa trạng thái người dùng. CHANGELOG bỏ qua: tiếp tục cùng tính năng chưa phát hành, ứng viên chưa tích hợp.
