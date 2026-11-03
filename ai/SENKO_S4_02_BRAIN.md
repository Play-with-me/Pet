# S4-02 — bộ não, nhu cầu và ý định

Ngày28/10/2026. Phạm vi Leader giao: nhu cầu4Hz, utility chọn hành động khả thi, cam kết/cooldown/bộ nhớ10hànhđộng; không triển khai phản ứng app, phân tích chuyển động con trỏ, xoa đầu/đuôi hoặc lưu đĩa trong lượt này.

## Mã đã nối
- SenkoBrain thuần runtime, seed và elapsed time tiêm; năm nhu cầu0..1, nghỉ hồi energy, ban đêm/vận động tiêu hao, curiosity theo world thay đổi, concern ước lượng idle và affection giảm một lần khi ném mạnh. Giờ máy lấy cùng context RAM; không ghi title/phím/cursor/history.
- Explore/Watch/Sit/Rest/Approach được cân bằng bằng utility, novelty, phạt0.6*exp(-t/120s), cooldown và FIFO10. Mục tiêu owner-local cố định trong ý định, không sửa đích theo con trỏ mỗi tick. Chỉ phục hồi social khi đến gần và con trỏ hiện tại vẫn gần.
- Mỗi quyết định chỉ tối đa5lần plan bounded và kiểm tra trước route. Đứng xem/ngồi/nghỉ dùng clip đúng đang có. Watch dùng idle; chưa có ngủ theo idle hoặc hành động P2. Movement có watchdog30giây, dừng quan sát tối thiểu2giây sau đến; stationary4..20giây. Không tính thời gian pause/menu.
- Runner manifest thay controller cũ bằng Brain, giữ route/physics/Animator làm chủ chuyển động. Bế/rơi không theo route được ngắt; planned jump vẫn giữ route và ưu tiên ảnh trên không. Cache thất bại có thời hạn và điểm bắt đầu, tránh vòng retry hoặc cấm mục tiêu mãi. Giữ easing, sync chân và Nearest; không đổi assetv5/Gen/PhysicsBody/người que/legacy.

## Kiểm định thực chạy
-9test Brain đạt. Mô phỏng seed/clock cố định600giây có Explore/Approach/Watch/Sit, không đổi ý mỗi tick. Mô phỏng tích hợp16.000tick×16ms=256giây qua Brain/RouteFollower/body/Animator, có khoảngpause4,992giây, đến nhiều mục tiêu và giữ ngồi không trượt. Đây là thời gian mô phỏng, không phải soak thực.
- Runtime199+2fixture/render29 đạt. Overlay default126đạt/20ignored; context6gồm2native đạt. Clippy ba crate/alltargets/assettools,fmt và diffcheck đạt trong phạm vi thay đổi.
- Session manifest11 gồm4native đạt sau tích hợp và sửa cache: grab/drop/pause/reset/exit, smoke, GPU pixel và16pha đi/chạy có thân di chuyển. Gait test cung cấp một lựa chọn route khả thi để kiểm định nhịp chân; không gọi đó là bằng chứng utility tự chọn đa dạng ngoài đời. Các logclippy đầu có2cảnhbáo collapsible_if đã sửa; logcuối đạt.
- just senko-build đạt; startup release5giây exit0. SHA2569154C86D405DC10A89565E2F25E5375DA459BFAE36403D421A7098025ABD715E, đã mởPID5800 và read-onlycheck còn một tiến trình Responding. Không kiểm tra mở trùng hoặc monitor30phút riêng cho hash này; không dùng bằng chứng của hash trước cho bản mới. Xem release.json/lifecycle.json trong logsSENKO-S4-02.

## Phần còn lại
Tiếp S4-03 nhận biết chuyển động con trỏ, rồi S4-04 vùng đầu/đuôi và S4-05 phản ứng app/idle/chăm sóc. Hiện pointer chỉ là một nguồn mục tiêu lấy mẫu lúc quyết định, chưa phân tích tốc độ/tiếp cận/rời xa. Concern chưa là bộ đếm nhắc50phút; chưa có memory cục bộ S4-06 hoặc QA toàn GĐ4 S4-07. Không chọn clip sai nghĩa cho P2 chưa có.

Giới hạn QA tay/hardware GĐ3 vẫn giữ; chưa benchmark/soak30phút mới/fullworkspace/macOS. Không commit/push/chuyểnnhánh/sửaGen/chính sáchWindows hoặc thêm dependency. CHANGELOG bỏ qua trong phần Senko chưa phát hành đang phát triển; không có dữ liệu người dùng cần xóa.
