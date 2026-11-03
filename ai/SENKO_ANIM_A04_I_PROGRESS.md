# A04-I — sửa dáng đi bộ, 29/10/2026

## Kết quả chính

Leader nhấn mạnh cần đi bộ; đổi800→1200ms của H chỉ sửa nhịp, chưa sửa động tác. Lượt này tạo ứng viên đi54khung mới/1200ms, thay phần chân bằng nguồn vẽ vector có tiếp xúc rõ, giữ ảnh đầu/thân trên đã duyệt. Không sửa Brain/body/motor/planner/nhu cầu/timer/defaultpack. Không subagent, commit/push, dependency hoặc lockfile. Fetch đã chạy, không merge hay đổi checkout đang có thay đổi.

**Ứng viên cuối:** resources/characters/senko-160/walk-grounded-54-v7.
**Preview chính:** resources/characters/senko-160/walking-review-v5/index.html.
Trái là36ảnh cũ đã làm chậm; phải là54tư thế chân mới. Cùng1,2giây và120physical px/s tham chiếu để đối chiếu động tác, không đánh tráo bằng giảm tốc thân. Đi theo quãng đường vẫn là144px/chu kỳ; tốc độ khác thì phase thay theo quãng đường như hợp đồng cũ.

## Cách sửa hình

- Mỗi chân chịu lực60%chu kỳ; có khoảng20%thời gian hai chân cùng chạm sàn, không có pha bay. Ở54mẫu rời rạc có12frame double support.
- Chân trụ đi ngược tương đối với thân đúng bằng quãng đường thân; chân bước qua nhấc tối đa3,5pixel gốc. Không co chân cao, kéo dài chân hoặc làm đầu nhún để giả chuyển động.
- Đây là nguồn **SVG vẽ phần chân mới**, tính điểm khớp cho từng tư thế rồi vẽ lại đường bao/nếp quần/bàn chân. Không phải54ảnh AI vẽ tay; không biến dạng/nội suy ảnh raster, không thêm mô phỏng khớp vào body hoặc runtime.
- Hai đoạn chân trong nguồn vẽ giữ độ dài18pixel; khớp hông ẩn dưới áo. Dựng khớp là công cụ tạo hình offline, không phải ragdoll/vật lý sản phẩm. Hông đặt dưới thân, không nhầm với mép tay áo đang rủ. V1 thấp quá làm dáng gập gối; đã sửa trước bàn giao.
- Nguồn chuẩn hóa cuối: senko-160-source/gait/walk-grounded-v4,54SVG độc lập có ảnh thân nhúng. Raster SVG bằng Sharp có sẵn trong runtime authoring, sau đó asset-tool Rust đưa về palette31màu/alpha cứng. Không đưa Node/Sharp/SVG renderer vào ứng dụng hoặc thêm dependency.
- 131hàng trên của mọi PNG cuối byte-identical với model-v1/pose-02.png; phần tay áo và đuôi dưới mép này dùng mask nguồn được chỉ rõ. Không scale riêng từngframe. Tay/đuôi đang giữ tĩnh trong phép sửa chân cô lập này.
- Manifest54frame,delay22/23ms,total1200ms. Mọi cửa sổ45frame liên tiếp kể cả qua vòng lặp đều1000ms.54RGBA khác nhau, không padding ảnh giống nhau.
- Có foot_left/right cho đủ54frame, trỏ vào pixel thực được vẽ. Metadata chỉ phục vụ hình/QA, không thay hình học va chạm.

## Nguồn AI không nhận

Đã dùng built-in imagegen: một sheet4key, bốn sheet12inbetween và ba sheet18phần chân. Các sheet nối vẫn lặp sai pha/không giữ chuyển động chân trụ hoặc sai góc quần; không dùng chúng để ghép54frame giả. Nguồn giữ riêng cùng exact prompts/reference/lý do loại trong senko-160-source/gait/A04_I_PROVENANCE.json. Bốn key được chuẩn hóa để xem riêng, không coi là bộ đi hoàn chỉnh.

## Kiểm tra thực chạy

- Asset-tool19/19 test đạt, gồm invariant nguồn vẽ: không bay, double support, chân không đổi chiều dài và điểm trụ cố định trong world liên tục trước lượng tử pixel.
- Clippy overlay all-targets với senko-asset-tools/-Dwarnings, rustfmt phạm vi và diffcheck đạt.
- Audit cuối:54RGBA khác nhau,31màu gồm alpha, toàn bộ alpha0/255, canvas160,131hàng trên giữ nguyên, mọi contact nằm trên pixel đục; sai số chiều dài đoạn khớp tối đa2,14e-14pixel.11hash module/manifest baselineA01 không đổi; baseline này không bao phủ mọi filebody/planner.
- Player contract Node DOM/RAF stub:90PNG, mọi biên delay36/54,clock10giây tại30/60/120Hz,pause/scrub/mirror/reset đạt. Clock không chạy trước khi ảnh nạp xong, không bỏ frame đầu do thời gian nạp. Không phải browserGUI hoặc số đo cadence phần cứng; CUA đọc fileURL bị URL policy chặn, không vượt chặn.
- Harness production WorldSnapshot/SenkoBody/GroundMotion/Animator trên sàn tổng hợp:13case gồm12dừng30/60/120Hz/hai hướng/pha0 và27, một quay đầu.12/12canonical stopseam đúng, metadata54/54frame có hai chân. Điểm pixel chân trong Moving ổn định dịch tối đa2px/tick ở30/60Hz,3px ở120Hz; đây là số đo metadata/rời rạc, không chứng nhận hoàn toàn hết trượt hay so trực tiếp với bộ cũ chỉ có6framecontact.
- Native test chuyên biệt1/1 đạt trên đúng PNG cuối: cảhai hướng hiển thị đủ54frame walk và đủ10frame clip dừng được map, cửa sổ đi theo trace body. Test được tổng quát khỏi hardcode36/sync18 thành số frame/sync thực của pack.
- Không chạy lại toàn bộ runtime/native suite hoặc build release mới vì code production runtime/render/app không đổi; thay đổi Win32 ở test-only. Không dùng số test lượt cũ làm kết quả mới. App vẫn packv5.

Raw SVG render ban đầu có alpha mềm, loader đã từ chối đúng; đã thêm bước palette/hardalpha và kiểm định lại. Audit từng pixel bắt được1pixel quần vẽ vượt lên thân; đã clip lớp chân dưới y131 rồi kiểm lại cả54frame. Không nới loader để hợp thức hóa dữ liệu lỗi.

## Artifact và giới hạn

Partial side-sequence-grounded-v5 dùng ảnh đi cuối; trace hiện tại walking-world-v2. Các start/stop/turn còn nguồn trước, chỉ nối canonical đầu/cuối để thử runner, chưa hoàn thiện diễn xuất chuyển tiếp theo dáng đi mới. Không mở partialpack như fullapp.

Đây là bản sửa dáng đi để leader xem, chưa tự đánh dấu tự nhiên/dễ thương đã đạt. Còn phối chuyển động phụ tay/đuôi, mối nối start/stop đầy đủ, chạy và các hướng khác. Không đóng A04/A08/A09, không đổi mặc định, chưa soak30phút hoặc đo45FPS phần cứng. Không cần xóa dữ liệu người dùng. CHANGELOG bỏ qua: cùng tính năng chưa phát hành.

Log/QA/scripts:ai/logs/SENKO-ANIM-A04-I. ADR0121 ghi rõ ranh giới nguồn vẽ và runtime.
