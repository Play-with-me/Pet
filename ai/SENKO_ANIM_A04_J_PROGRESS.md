# A04-J — sửa lỗi hình chân/hakama và kiểm tra browser

Ngày29/10/2026. Leader gửi screenshot bản walking-review-v5 và yêu cầu xem bằng trình duyệt.

## Lỗi và thay đổi

Đã mở đúng browser đang có bằng native CUA trong cửa sổ Codex, xem screenshot thực và xác nhận: lớp chân vector A04-I thay mất vùng hakama gốc từy131, khiến quần thành hai ống dài/góc cạnh, không còn tỷ lệ và nét trang phục đã duyệt. Test kỹ thuật A04-I không chứng nhận được tiêu chí hình này; không coi bản đó đã được leader duyệt.

Sửa authoring mask: giữ raster model02 nguyên từ hàng0đến145; thêm hai vùng mép gấu nhỏ tại146..147, loại phần tabi cũ. Chỉ lớp cổ chân/bàn chân lộ dưới gấu được thay. Tabi được tăng độ đầy phần trắng, không còn chỉ như một vạch dẹt. Không thay phase, độ dài chu kỳ, quãng đường chu kỳ, điểm chân, motor, body, Brain, planner hoặc defaultpack.

Nguồn cuối:resources/characters/senko-160-source/gait/walk-grounded-v6.
PNG cuối:resources/characters/senko-160/walk-grounded-54-v11.
Preview cuối:resources/characters/senko-160/walking-review-v7/index.html.
Trái giữ bản lỗi A04-I để đối chiếu; phải là bản đã sửa. Bản v6 là bước kiểm tra trước khi làm đầy tabi; giữ riêng, không ghi đè.

## Đã kiểm tra trực tiếp trong browser

- Dùng skill computer-use và CUA native để xem đúng in-app browser đang mở; không chỉ mở link hoặc kiểm tra DOM stub. Không cần đổi bảo mật, server hoặc vượt URL policy.
- Quan sát bản lỗi v5, sau đó điều hướng URLbar sang v6/v7. Xác nhận URL và heading bằng AX, xem screenshot thực của canvas và vùng chân phóng.
- Bản v6 ởframe0: dáng hakama đã trở lại. Bản cuối v7: scrub300ms/frame13 để rà chân khép; scrub600ms/frame27 và bật mirror để rà bước đối chân hướng trái. Xem cả canvas320và vùng chân phóng. Trong các pha đã xem không còn hai ống chân dài của lỗi báo; gấu giữ nét gốc, không thấy chân cũ dư ở các pha đó.
- Đã trả về hướng phải và phát lại preview. UI có báo user-input vài lần, đã dừng thao tác và lấy state mới trước khi tiếp tục. Có lúc capture khi cửa sổ bị che cho hình không đúng nội dung AX; đã Raise đúng cửa sổ Codex rồi lấy screenshot mới, không dùng capture sai làm bằng chứng.
- Screenshot native CUA nằm trong tool output hội thoại; không tuyên bố có file browser-capture đã lưu. Việc kiểm tra trên chỉ xác nhận lỗi hình được quan sát ở các pha đã nêu, không thay leader nghiệm thu toàn bộ chất lượng gait.

## Kiểm tra tự động thực chạy

- Audit54PNG:54RGBA khác nhau,31màu gồm alpha,alpha0/255; **146hàng trên mọi frame byte-identical với model02**, điểm contact nằm trên pixel đục.54delay22/23ms=1200ms,mọi45frame qua vòng lặp=1000ms.11hash module/manifest baselineA01 không đổi; baseline không bao phủ toàn bộ body/planner.
- Asset-tool19/19,Clippy asset-tool -Dwarnings,rustfmt phạm vi và diffcheck đạt.
- JS contract Node DOM/RAF stub:108PNGhai pack54frame,biên delay,clock10giây ở30/60/120Hz,pause/scrub/mirror/reset đạt. Bổ sung bằng browser thực nói trên; không suy thành đo cadence hardware45FPS.
- Native chuyên biệt1/1 trên partial side-sequence-grounded-v6: đủ54walk và10mapped-stop frame ởhai hướng. Replay lại bodytrace walking-world-v2 đã có vì manifestphase/distance/contact không đổi; **không** gọi đó là một lượt13caseworld mới. Không chạy lại toàn bộ runtime/native suite hoặc buildrelease vì productioncode không đổi.

Log/audit/scripts tại ai/logs/SENKO-ANIM-A04-J. Không sourceAI mới trong lượt này: sửa nguồn vector native hiện có và mask compositing, không warp ảnh. Không dependency/lockfile/subagent/commit/push. Fetch origin đã chạy; không đổi checkout hoặc merge vào cây đang có thay đổi.

## Trạng thái bàn giao

Lỗi hình dài/góc cạnh đã sửa trong ứng viên và đã xem bằng browser thực. App vẫn dùng bộ v5. Tay/đuôi và chuyển tiếp đầy đủ, run/các hướng khác còn trong A04; chưa tự đánh dấu cảgait tự nhiên/cute đã được duyệt, chưa đóngA04/A08/A09 hoặcsoak30phút.

CHANGELOG bỏ qua: sửa cùng tính năng chưa phát hành. Không cần xóa dữ liệu người dùng. Giữ bản lỗi và bản sửa riêng để đối chiếu; không ghi đè asset đang chạy.
