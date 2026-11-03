# A04-T — bổ sung 6 hình chạy, 30/10/2026

## Thay đổi và phạm vi
Leader cho tiếp tục sau S. Codex dùng built-in imagegen tạo 6 tư thế trung gian riêng, tham chiếu atlas run-contact-v1, chèn sau frame gốc2/4/7/11/13/16. Nguồn và exact prompt: resources/characters/senko-160-source/run-between-v1-raw.png / run-between-v1-prompt.txt. Bản generated_images gốc giữ nguyên. Không CLI/API fallback, subagent, Brain, physics, motor, planner, defaultpack, dependency/lockfile, commit/push. Fetch origin đã chạy.

Thêm --run-inbetweens160: giữ byte của18hình R, nạp6hình mới bằng fixed6×1 grid, một scale chung và một baseline nguồn chung. Bản run-24-v1 bị lệch ngang do ô nguồn không căn cùng tâm; run-24-v2 đăng ký neo eo từng hình mới chỉ theo x, không scale riêng hoặc đặt frame bay xuống sàn. Đã xem raw và hai atlas qua view_image. Đây là chuẩn hóa nguồn/neo, không điều khiển vị trí body.

Candidate cuối resources/characters/senko-160/run-24-v2:24PNG khác nhau/32RGBA/hardalpha/160×160×2, cycle128px, sync0/12, pha bay7/19. Giữ contactclearance0/0 và flight5/3px của R. Mapping nguồn ghi trong run-report.json. Thay đổi số phase không tự chứng nhận chân trái/phải hoặc động tác trung gian đúng nghĩa.

## Timing và thực chạy trong harness
Distance phase cho45drawings/s tại240px/s,52.5 tại max280px/s hiện có; không đổi motor. Clock preview dùng24delay22/23 tổng533ms, so với lý tưởng533.333ms. Đây là xấp xỉ theo millisecond, không tuyên bố clock lặp533ms chính xác45Hz vô hạn. Audit10s ở30/60/120Hz cho sai pha tối đa1frame. Distance-driven run không chịu sai số clock này.

Candidate ghép chẩn đoán run-integration-v2, actual Body/GroundMotion/Animator12ca mới trên sàn tổng hợp.78phép chuyển phase (54Walk→Run+24Run→Walk) đạt, giữ Moving và đợi sync.4ca60Hz đều dùng đủ24frameRun. Tool20/20,Clippy asset-tool-Dwarnings,scopedfmt/diffcheck đạt. Đã mở rộng test phase gate cho contact12 ở24frame thay vì9; test floatingcontact phải reject. Audit24unique/18base byte-identical/6new/alpha/palette/128px/phase đạt.

Preview chính: resources/characters/senko-160/run-world-v4/index.html (actual body trace). Player ảnh: run-review-v5. run-world-v3 vẫn dùng caption cũ18frame/39.4; không dùng làm bản bàn giao. Caption tool cuối đọc số frame/rate từ dữ liệu thay vì hardcode. run-review-v4/run-24-v1 là bước trước sửa neo.

Log/script/audit: ai/logs/SENKO-ANIM-A04-T. open_in_codex trảqueued; chưa xác nhận browserplayback, nativePresent/hardwarecadence hoặc release/soak mới. Chỉ tool/asset thay đổi, không production runtime. App đang chạy giữ nguyên.

## Chưa hoàn thành
Start/stop vẫn dùng ảnh đi bộ và chưa khớp, như S; cần art/chuyển tiếp run riêng. Foot metadata/stance/worldfootlock, ý nghĩa từng inbetween, volume và loop joins vẫn chưa được nghiệm thu. 24unique và số đo timing không thay visual acceptance. A04 còn các hướng gait, arm/tail, turn pivot; chưa sang A05..A09. CHANGELOG bỏ qua vì cùng tính năng chưa phát hành. Không ADR mới vì chỉ authoring/preview, không đổi runtime contract.
