# S4-03 — nhận biết hành động con trỏ

Ngày28/10/2026. Giữ plan: con trỏ là nguồn chú ý/tương tác; không liên tục đuổi theo, không sợ hoặc văng khi lướt nhanh. Không triển khai vùng đầu/đuôi, app reactions hoặc lưu đĩa trong lượt này.

## Phần đã nối vào bản chạy
- PointerTracker thuần runtime phân biệt đứng gần, trên thân, tiến lại, rời xa, lướt nhanh, đang di chuyển và dữ liệu thiếu. Tối đa16mẫu/600ms trong RAM, lấy mẫu tối đa20Hz và một last-reading để bắt fly-by; không serialize/log tọa độ. Chẩn đoán chỉ in trạng thái, không in vị trí.
- Bù chuyển động pet/window bằng cách dùng bodycenter hiện tại để so cả hai mẫu; có hysteresis và deadzone/core để pointer đứng trên thân không làm bé rung hoặc liên tục quay đầu. Click xuyên vẫn theo alpha thật, không dùng core để bắt click.
- Mục tiêu Approach chỉ được đưa vào utility khi tín hiệu phù hợp, không phải mọi con trỏ di chuyển đều làm bé chạy. Utility S4-02 giữ trọng số/nhu cầu/cam kết/cooldown. Fly-by/receding/on-body không cấp mục tiêu mới; route đang làm vẫn giữ goal owner-local. Kết thúc Approach xóa tọa độ mục tiêu khỏi history, chỉ giữ loại/kết quả hành động.
- Cue chú ý tối đa một lần mỗi entry, cooldown2,5giây. Chỉ lúc Watch an toàn, không route/carriage/leo/bế/rơi/pause. Có thể ngước nhìn bằng look_up nếu pointer ở trên; ngoài ra chỉ liếc hướng trong600ms. Look_up chạy một chu kỳ; pending quá750ms bỏ. Không ngắt nghỉ/khám phá/tiếp cận đang cam kết.
- Menu/reset/held/mất dữ liệu/suspend gap/recovery xóa perception cũ. Giữ body/physics, legacy/người que, v5asset và gait; không thêm ảnh/đè Gen. Utility nhận tín hiệu qua lọc lựa chọn khả thi, không thêm trọng số tùy tiện.

## Kết quả kiểm định
-9test pointer đạt: tín hiệu, jitter, buffer≤16/TTL600ms, bù bodymoving, pause/lỗi/timegap, hysteresis/privacy, Glance một lần qua Animator và ngắt ngay khi Held.
-2test policy trong runner đạt: nhu cầu mệt chọn Rest dù có pointer tiến lại; social cao có thể Approach; fly-by sau đó không đổi goal đã cam kết. Trên thân không có Approach và giữ hướng. Các test dùng tọa độ tiêm, không ghi thao tác chuột của Leader.
- Runtime208+2fixture/render29 đạt. Overlaydefault128đạt/20ignored. Native session hồi quy13test gồm4native đạt, có bế/thả/pause/reset/exit, smoke, GPU pixel và đủ16pha đi/chạy. Gait probe cung cấp choice để cô lập kiểm tra chân; không coi đó là QA người dùng rê chuột thật hoặc utility tự phát.
- Clippy3crate/alltargets/assettools và scopedfmt/diffcheck đạt. Một cảnh báo unnecessary_unwrap trong test ban đầu đã sửa, log cuối đạt.
- just senko-build đạt; startup release5giây exit0. SHA256469E4E354397BDD895A8911282E2DF3C6812A4CD45EE67A68250D13ABEBB6F14, đã mởPID35508, read-onlycheck một tiến trình Responding. Chưa test mở trùng hoặc monitor30phút riêng cho hash này; không suy bằng chứng hash trước sang bản mới. Xem release.json/lifecycle.json.

## Tiếp theo và giới hạn
Tiếp S4-04 vùng đầu/đuôi theo frame/mirror/ảnh thực hiển thị, hover500ms và capture khi bế. S4-05 phản ứng app/idle/chăm sóc, S4-06memory, S4-07QA đầy đủ và GĐ5 chưa làm. Các ngưỡng chuyển động là giá trị khởi đầu cần nghiệm thu cảm giác; chưa QA tay mọi cử chỉ, hardwaremixedDPI/unplug, fullscreen exclusive/macOS/fullworkspace hoặc soak30phút riêng bản mới.

Không commit/push/chuyểnnhánh, không thêm dependency/lockfile hoặc sửa chính sáchWindows/Gen. CHANGELOG bỏ qua trong phần Senko chưa phát hành đang tiếp tục phát triển; không dữ liệu người dùng cần xóa.
