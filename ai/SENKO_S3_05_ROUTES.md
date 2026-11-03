# S3-05 — Tuyến đường và thực thi leo

Ngày 28/10/2026. Codex triển khai theo lệnh tiếp tục của Leader. Bản chạy đã nối planner/follower; GĐ3 chưa nghiệm thu tổng thể.

## Đã làm

- `senko_routes.rs` dựng graph từ các khoảng chân đứng liên tục và an toàn. Tìm tuyến ít lần chuyển bề mặt bằng BFS, nối walk/climb/mantle/hop/jump/drop. Giới hạn 256 khoảng và 4096 lần xét kết nối, trả lỗi rõ khi vượt ngân sách; không tạo điểm leo trên mép màn hình.
- Mục tiêu lưu theo owner/generation và tọa độ cục bộ. Tuyến đang chạy giữ cam kết; revision quét mới nhưng hình học không đổi không làm khởi động lại. World thay đổi thì kiểm lại cạnh, headroom, mục tiêu và quỹ đạo. Tuyến hỏng dừng trên điểm tựa còn hợp lệ hoặc để trọng lực xử lý; không đặt chân về điểm cũ.
- Nhảy dùng khoảng dịch chuyển điểm chân ≤110 px ngang, ≤90 px dọc; tốc độ ngang ≤280 px/s. Kiểm tra thời điểm chạm gờ đầu tiên và swept body có xét phần cong quỹ đạo. Đây là graph bảo thủ của các primitive đã kiểm định, không phải bộ giải mọi đường liên tục hoặc tối ưu thời gian.
- Cửa sổ cách sàn một khoảng nhỏ phải được bắt bằng bước nhảy thật. Bắt cạnh khi quỹ đạo đi lên cắt đoạn tường hợp lệ, kể cả trường hợp 90 px tại đỉnh quỹ đạo; không snap lên cửa sổ. Bắt xong mới chuyển sang leo.
- SenkoBody sở hữu điểm bám tường và chuyển qua góc thật. Đi trên gờ vẫn qua Animator/ease/safe budget. Cuối waypoint có tốc độ tối thiểu 12 px/s, đồng thời cap quãng đường còn lại, tránh đứng sát đích vô hạn hoặc đi quá điểm tiếp xúc.
- Khi xuống, chuyển ngược qua góc bằng các frame mantle và delay tương ứng theo thứ tự ngược; giữ wall_drop đủ thời lượng rồi mới thả bằng trọng lực. Clip chuẩn bị nhảy/chuyển góc/thả được giữ hết thời lượng ở độ phân giải frame; bế hoặc mất điểm tựa được ngắt ngay.
- Runner nhận mục tiêu trên bề mặt từ hành vi Chase GĐ2 hiện có. Không thêm Brain, phân loại ứng dụng, nhu cầu, trí nhớ hay hành vi tự khám phá ngoài kế hoạch. GĐ4 sẽ cấp các mục đích phong phú hơn. Cache lỗi dùng goal + hình học thực, không dùng timestamp/revision; có cooldown và cho phép tính lại từ vị trí thực khi thực thi bị ngắt.
- Bổ sung kiểm tra clip balance/climb/mantle/jump_prep/wall_drop phải tồn tại, là clip timed và loop đúng trước khi runner đọc thời lượng. Không panic khi thiếu clip hoặc dùng duration0 làm chuyển góc tức thì. Không đổi PNG/manifest v5, legacy hoặc vật lý người que.

## Kiểm định thực chạy

Log: `ai/logs/SENKO-S3-05/`.

- Runtime 184 unit + 2 fixture và renderer 29 unit đạt. Các ca mới chạy follower cùng Animator thật: lên cửa sổ, xuống sàn, nhảy gờ gần, hop bắt cạnh 9/90 px và từ chối 91 px, giới hạn ngang 110/111 px, từ chối đường bị che/không tới được, stale generation, world cập nhật khi đang leo, carriage chậm, bế/ngắt, pause và tiếp cận tọa độ lẻ.
- Animator kiểm tra reverse frame với delay không đều, pause, held/fall interrupt và đổi Air sang Climb khi bắt cạnh. Test loader xác nhận lỗi clip rõ trước tích hợp. Test overlay kiểm tra cache bỏ qua mẫu thời gian mới và kernel ease hoàn tất waypoint mà không đứng tiệm cận/đi quá đích.
- Nhóm scanner 8 test đạt, gồm 4 native. Native route harness dùng bounds/Z-order DWM của HWND thử được cô lập khỏi cửa sổ môi trường, nạp **bộ PNG thật và timing thật**, chạy đi→hop bắt cạnh→leo→mantle→đích→reverse mantle→drop→về sàn bằng clock điều khiển.
- `native-route-trace.csv` ghi clip/frame/điểm chân do harness điều khiển, không ghi con trỏ hay thao tác người dùng. Với tick16ms: JumpPrep13frame=208ms≥200ms; mantle/dismount44frame=704ms≥700ms; Drop8frame=128ms≥120ms. Đây **không phải video GPU hoặc QA tay pet production leo trên cửa sổ**.
- Nhóm session 11 test đạt, gồm 4 native: kéo/thả, pause/reset/exit, Present liên tục, đủ16pha đi/chạy có thân di chuyển, GPU Nearest4×4/Linear mặc định. Startup smoke cuối kiểm tra lại đường nạp/validation thật. Không suy nhịp Present thành benchmark CPU hoặc soak.
- Clippy ba crate/all-targets/asset-tools, fmt file sửa và `just senko-build` đạt. Không thêm dependency/lockfile trong lượt này. Release đã mở PID21928, SHA256 `784CDC048A5DCC1848EB7FCC83260B8D142F00D1E0C8BB50783A4F870C2357B3`; instance thứ hai exit0, còn một tiến trình responding. Chi tiết ở release.json/lifecycle.json.

## Phần còn lại

S3-06: cache monitor, thông báo display/settings, DPI hỗn hợp, màn hình tọa độ âm/khoảng trống, chuyển/tháo màn hình và phục hồi. S3-07: QA native tổng thể, nhất là đổi Z-order thực, tương tác bằng tay và bản chạy để Leader nghiệm thu GĐ3.

Chưa QA trực quan/tay đường leo production trên mọi cửa sổ, native Z-order đổi thành công, mixed-DPI/unplug, soak30phút binary mới, macOS hoặc full workspace. Giới hạn host và test topmost cũ vẫn được giữ trong báo cáo; không gọi toàn repository xanh. GĐ4/GĐ5 chưa bắt đầu.

Không commit/push/chuyển nhánh/sửa bàn giao Gen. Origin/master `47a73ed1` đã fetch, chưa merge dirty tree. CHANGELOG bỏ qua vì tiếp tục tính năng Senko chưa phát hành; không có dữ liệu người dùng cần xóa.
