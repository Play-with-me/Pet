# SENKO-ANIM-A04-F — bàn giao 29/10/2026

Tiếp A04 theo phê duyệt của leader. Chỉ sửa tầng hoạt ảnh, metadata và công cụ kiểm định; không sửa Brain, body, vật lý, planner hoặc pack mặc định. Không subagent, commit/push hay thay dependency. CHANGELOG bỏ qua vì cùng tính năng chưa phát hành.

## Kết quả

- Harness dùng WorldSnapshot, SenkoBody, GroundMotion và Animator production trên sàn tổng hợp. Có 12 trường hợp dừng: 30/60/120 Hz × phải/trái × yêu cầu pha 0/18, gồm tọa độ âm.
- Phát hiện 6/12 trường hợp kết thúc ở sync18 nhưng vào ảnh dừng sync0. Thêm `stop_clips` ánh xạ sync sang clip dừng; loader kiểm tra sync, clip đích timed/non-loop, hướng và file ảnh đầu canonical. Pack cũ không khai báo vẫn giữ đường chọn cũ.
- Sau sửa, 12/12 điểm nối khớp. So trước/sau ở cùng kịch bản, toàn bộ tọa độ và vận tốc body giống nhau; không sửa vật lý để che lỗi ảnh.
- Thêm trường hợp thứ 13: phanh rồi quay đầu qua FrontRight/Front/FrontLeft, đi trái và về Idle. Góc quay dùng các mẫu đứng đã duyệt, chưa phải hoạt ảnh quay đầu 45 FPS hoàn chỉnh.
- Pack partial `side-sequence-v3` có 9 clip; không phải bộ đầy đủ. Preview cuối: `resources/characters/senko-160/moving-world-v5/index.html`. Các bản nguồn trước giữ riêng.

## Kiểm tra thực chạy

- Render 33 test; runtime 298 test và 2 fixture dùng chung đạt (1 export bị ignore); asset tool 17 test đạt.
- Native 33/33 đạt. Test mới phát lại trace body qua cửa sổ thật, kiểm tra vị trí và đủ 10 frame dừng sync18 ở hai hướng. Đây là replay trace sàn tổng hợp, không phải thử DWM/gờ cửa sổ trực tiếp.
- Clippy phạm vi render/runtime/overlay và asset tools đạt; fmt/diff check đạt. Lỗi Clippy range đã sửa. Harness ban đầu chờ đúng chỉ số frame nên có thể bỏ lỡ ở Hz thấp; đã đổi sang nhận giao cắt pha và thêm test.
- JavaScript player xuất cuối đã kiểm tra bằng Node DOM/RAF stub: 13 trường hợp, pause/scrub, tọa độ âm và diagnostic null. Chưa kiểm tra hình trực tiếp trong browser hoặc cadence phần cứng.
- `just senko-build` thành công; smoke 5 giây exit0. SHA256 release: `0515931BD749D3275EACE9A02B9EECBACDA7438EE4BDC0193093A2EF93AD6450`. PID13000 còn Responding khi bàn giao; vẫn dùng candidate-v5-flow.
- Log, world-check.json và release.json tại `ai/logs/SENKO-ANIM-A04-F/`. Checksum các module hành vi có trong baseline A01 và manifest v5 không đổi; baseline này không bao phủ mọi file body/planner.

## Giới hạn và phần tiếp

Contact chỉ có mẫu 6/36 frame. Điểm chân được đánh dấu vẫn dịch khoảng 4–7 physical px giữa các mẫu trong Moving; tối đa tổng thể 8 px có cả Settling. Chưa chứng nhận chân đứng yên trên sàn hoặc toàn chu kỳ tự nhiên. Không có số đo contact cho reversal: để null thay vì 0.

Các lần yêu cầu dừng phụ thuộc pha quan sát, nên thời điểm đầu vào khác giữa 30/60/120 Hz; không dùng phép thử này làm chứng nhận vật lý độc lập nhịp frame. Preview mặc định 60 Hz; trường hợp 30 Hz là kiểm thử, không phải minh chứng hiển thị đủ 45 FPS.

Tiếp theo: chỉnh hình/contact toàn chu kỳ, quay đầu đủ tư thế thực, chạy và các hướng còn lại. A04 chưa đóng; chưa A08 đổi mặc định, chưa A09 QA phần cứng/30 phút. Không tạo ảnh mới trong lượt này, chỉ tái sử dụng mẫu đã duyệt và bổ sung metadata/harness.
