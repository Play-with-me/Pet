# Rà soát PLAN v3.0 — Senko

ID: REVIEW-SENKO-V3. Ngày: 26/10/2026. Người rà soát: Codex.
Phạm vi được giao: rà soát trước, chưa triển khai. Các sửa đổi đặc tả dưới đây là đề xuất, chưa được Leader duyệt.
Nguồn kế hoạch: file `Pasted text.txt` đính kèm chat, attachment `3c5c9d55-541b-4b27-89c2-99348baf0265`.

## Kết luận

Kiến trúc tách Win32 → dữ liệu thế giới → logic thuần → renderer là hướng phù hợp với repository. Giữ người que độc lập, dùng thời gian đơn điệu và có nghiệm thu từng giai đoạn đều đúng hướng. Tuy nhiên v3.0 chưa đủ nhất quán để dùng làm hợp đồng triển khai; cần sửa các mục P1 trước khi bắt đầu phần tương ứng.

Đây là rà soát tĩnh mã và tài liệu, có đối chiếu tài liệu Microsoft. Không chạy ứng dụng, không build/test lại, không đo CPU/RAM, không kiểm định chất lượng ảnh trong lượt này. Không dùng con số test trong bàn giao Gen như kết quả kiểm tra mới.

## 1. [P1] GĐ0 chưa đáp ứng toàn bộ phạm vi ghi trong kế hoạch

Bằng chứng hiện tại:

| Hạng mục | Mã đã đọc | Kết luận giới hạn |
|---|---|---|
| Đi đúng hướng | `BongoCat/crates/bongocat-render/src/shimeji.rs`: `mirror_horizontal: !facing_right` | Đã đổi quy ước trong mã; chưa xem ảnh để chứng minh mọi frame cùng hướng gốc |
| Deadzone, không né, không leo mép màn hình | `autonomous.rs`: nhánh `AutonomousKind::Senko`, ngưỡng 28/56 | Đã có; khác ngưỡng 24/64 của v3.0; chưa chạy lại test |
| Không tự dừng sau 1 giờ | `companion.rs:323`, `companion_senko.rs` | Đã có điều kiện duration=0 chạy vô hạn; chưa soak |
| Click xuyên alpha | `companion.rs:393–405` | Chỉ kiểm tra chữ nhật x=45..135, y=40..180; chưa đọc mask alpha. Lỗi đổi click-through đang bị bỏ qua và cache vẫn cập nhật |
| Ẩn terminal | `companion_senko.rs:5`, `Chay_Pet.bat` | Chỉ đặt GUI subsystem khi release; launcher còn chọn debug khi không có release, bản thân BAT vẫn là console |
| Đồng hồ hoạt ảnh riêng | `autonomous.rs:120–155` | Frame còn phụ thuộc `age.fract()`; đổi hành vi reset age |
| Mutex, log lỗi, MessageBox | Entrypoint và runner Senko | Chưa thấy nối các cơ chế H3 vào đường chạy này; repo có helper single-instance ở platform để khảo sát tái sử dụng |

MSG-212/A-07 mô tả hoàn thành phần sửa nhanh không chứng minh toàn bộ GĐ0 v3.0 đã đạt. Cần checklist theo từng tiêu chí, không gọi chung là hoàn thành GĐ0. Không tự hoàn tác hoặc sửa mã của Gen trong lượt rà soát.

## 2. [P1] D3–D5 chưa có một hợp đồng tọa độ và điểm tựa thống nhất

`physics.rs:22–30` giữ `position` là góc trên trái, `size` riêng; `drag_to`, `step`, `constrain` đều dùng hộp đó. `companion.rs:304` tạo body bằng kích thước toàn cửa sổ 180×180. Plan chuyển sang điểm bàn chân nhưng chỉ đề xuất thêm `step_on(world)`: chưa giải quyết grab offset, drag clamp, reset, chuyển màn hình và dữ liệu snapshot.

Đề xuất đặc tả trước: đơn vị tọa độ desktop là physical pixel; sprite là pixel gốc; tên trường nêu rõ `foot_world`, `window_origin`, `anchor_local`. Không đổi ngữ nghĩa `PhysicsBody.position` của người que. Chốt adapter hoặc body riêng cho Senko trước khi triển khai. Tách vùng đỡ chân ổn định khỏi mask tương tác theo từng frame, tránh tai/đuôi chuyển động làm thay hitbox vật lý và giật vị trí.

Support cần ID ổn định, thế hệ cửa sổ, tọa độ cục bộ điểm bám, timestamp/revision snapshot. Không chỉ dùng owner HWND: handle có thể được tái sử dụng; cùng owner có nhiều gờ sau khi trừ che khuất. `landing` phải chọn bề mặt va chạm đầu tiên trên đường rơi, xét vận tốc tương đối, không chọn phần tử bất kỳ. Cần xử lý cạnh rời gờ, bề mặt đi lên, resize, support mất và màn hình bị rút.

Nghiệm thu: kéo–thả giữ đúng điểm nắm; cùng frame không teleport khi chuyển state; rơi nhanh không xuyên gờ; màn hình trái có tọa độ âm; DPI hỗn hợp; khoảng trống giữa các màn hình không thành sàn ảo. Mốc nhảy 110×90 phải cùng đơn vị với body và được kiểm chứng bằng quỹ đạo, không chỉ kiểm tra khoảng cách BFS.

## 3. [P1] Quét cửa sổ chưa bảo đảm chỉ leo lên phần nhìn thấy

D3 mới trừ che khuất của gờ ngang; chưa trừ đoạn bị che của tường dọc, chỗ mantle và đường đi. Nếu vẫn đưa cả tường vào world, Senko có thể leo cạnh bị cửa sổ khác che rồi nổi trên cửa sổ trước vì overlay topmost.

Danh sách cửa sổ che khuất phải tách khỏi danh sách bề mặt được leo. Cửa sổ maximized, fullscreen hoặc không có WS_CAPTION tuy không được leo vẫn có thể che cửa sổ phía sau. Lọc chúng trước bước occlusion sẽ tạo gờ ảo. Điều kiện WS_CAPTION cũng không đồng nghĩa “mọi cửa sổ đang hiển thị”; cần ghi giới hạn cho cửa sổ tự vẽ khung.

Đề xuất: tính cả cạnh ngang/dọc nhìn thấy, kiểm tra vùng thực hiện mantle và hiệu lực tuyến đường khi snapshot đổi. Chốt quy tắc hình học cho cửa sổ bo góc/không chữ nhật, taskbar tự ẩn và cửa sổ không hỗ trợ; không hứa nhận diện mọi vật thể trên desktop. Nghiệm thu bằng hai cửa sổ chồng nhau, đổi Z-order, che toàn bộ, maximize, minimize và đóng đúng lúc đang leo.

## 4. [P1] B4/C3 chưa cung cấp đủ tám hướng và chuyển tiếp cần dùng

Danh sách chỉ có `idle_front`, `idle_34`, `idle_side`, `idle_back`: hai hướng đối xứng front/back cộng hai cặp lật = sáu hướng. Thiếu góc 3/4 phía sau để đạt tám hướng như cam kết “5 vẽ + 3 lật”. `walk_side` cũng chưa cung cấp dáng di chuyển chính diện/quay lưng mà R13 nói còn thiếu; xoay đứng không tự tạo được chuyển động nhiều hướng.

Đếm theo bảng hiện tại: P1=100, P2=50, tổng=150; số này chưa gồm asset cần bổ sung để thực hiện đủ cam kết trên. Đồ thị chưa nêu đầy đủ run, climb_down, mantle bị ngắt, held→fall, sleep/wake, paused/resume. Phát ngược climb_up không tự chứng minh tư thế leo xuống đẹp hoặc đúng nhịp.

Đề xuất: lập ma trận hành vi × hướng × clip × chuyển tiếp; phân biệt hướng nhìn và hướng chuyển động. Leader cần duyệt cách đáp ứng R13 nếu muốn giản lược. Chỉ sản xuất số lượng lớn sau khi một vòng idle→walk→turn→climb→fall→land→held đã được xem ở tốc độ thật.

## 5. [P1] C2/C3 có nguy cơ khóa chuyển tiếp và lệch tốc độ chân

`frame=floor(distance/stride_px) mod 8` chỉ đúng khi `stride_px` là quãng đường mỗi frame. Nếu 18 px là cả một chu kỳ, công thức phải nhân số frame; đồng thời phải quy đổi scale=4. Chưa định nghĩa reset phase, tốc độ âm/đổi hướng và quãng đường đo trong hệ quy chiếu nào. Đứng trên cửa sổ đang di chuyển không được làm chân tự bước theo độ dịch desktop.

Khi vận tốc đã về 0 ở frame không thuộc sync={0,4}, animator theo quãng đường sẽ không tới sync để chuyển WalkStop. Cần hợp đồng dừng giữa body và animator: hoặc tiếp tục một đoạn để tới nhịp dừng, hoặc có chuyển tiếp tại chỗ được thiết kế và nghiệm thu; không tự chọn hành vi mới trong code.

Nghiệm thu ở từng frame trước khi dừng, tốc độ thấp/cao, đổi hướng liên tục, bị bế hoặc mất sàn giữa clip. Frame đứng yên trên cửa sổ được chở theo không tiến phase đi bộ.

## 6. [P1] Tiêu chí chống lặp mâu thuẫn với hành vi có mục đích

Test “không hành động nào >35% trong 10 phút” sẽ đánh trượt Senko ngủ khi Leader rời máy, ngồi xem khi làm việc hoặc bị bế lâu. Bộ nhớ 10 hành động và penalty không đủ bảo đảm giới hạn ấy; epsilon chưa có seed, ứng viên hợp lệ và điều kiện thất bại chưa được mô tả.

Đề xuất đánh giá theo kịch bản: loại thời gian trạng thái bắt buộc và ngủ có chủ đích khỏi chỉ số đa dạng; kiểm tra không mắc vòng hành động thất bại, không đổi ý liên tục, không lặp cùng tuyến vô ích khi có lựa chọn khả thi khác. Nhu cầu cần tốc độ thay đổi, giới hạn, trọng số, cooldown, minimum duration và RNG tái lập. `Paused`/menu/reset/đóng ứng dụng cần đứng trong quy tắc ưu tiên, không biến mất khi thay brain.

Mốc 2 phút/10 phút chưa nhất quán: F2 gợi ý ngáp ở 2 phút, ngủ ở 10 phút, QA lại nói bỏ máy 2 phút → ngáp rồi ngủ. Chốt timeline trước khi viết test. “Làm liên tục 50 phút” cần quy tắc nghỉ/reset; foreground + idle chỉ là ước lượng hoạt động, không xác định chính xác người dùng đang làm việc.

## 7. [P1] G3 thiếu dữ liệu và quy tắc tương tác để tránh bắt nhầm chuột

Mask alpha không xác định được vùng đuôi. “30% trên bounding box” có thể là tai hoặc đạo cụ; hình cúi/ngủ làm vùng này thay đổi. Cần mask/region đầu–đuôi theo clip, cùng quy tắc lật của frame thực tế. Mẫu G3 lật chỉ theo facing_right, trong khi B4 yêu cầu front/back không lật; nên dùng kết quả mirror cuối của animator. Kiểm tra biên x/y trước index và dùng origin/frame thật đã hiển thị.

Hover liên tục ≥0,5 s có thể kích hoạt headpat vô hạn hoặc làm Senko không bao giờ hoàn thành ý định. Cần quy tắc enter/exit, cooldown, reset khi đổi frame/vùng, pause và capture. Khi đang bế phải giữ capture đến release/cancel dù con trỏ ra ngoài sprite. Nghiệm thu native click vào pixel rỗng, hover sát mép, animation đổi mask, mở menu và mất capture; unit test mask chưa đủ.

## 8. [P2] WinEvent/app context cần hợp đồng vòng đời và giới hạn suy luận

Callback nên chỉ gom dấu hiệu dirty vào cấu trúc có giới hạn; quét có ngân sách ở tick và unhook đúng thứ tự khi dừng. Message loop là bắt buộc và callback có thể bị reentrancy; không quét nặng hoặc gọi lại brain ngay trong callback. [Microsoft: SetWinEventHook](https://learn.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-setwineventhook).

Quét dự phòng 500 ms không cho vận tốc cửa sổ đủ tin cậy nếu không gắn timestamp mỗi mẫu; ngưỡng 1500 px/s cần xét delta thời gian thật, event dồn và resume. SHOW/HIDE là vòng đời cửa sổ, không luôn là mở/tắt tiến trình: ứng dụng có nhiều cửa sổ hoặc thu vào tray. Cần đặt tên và nghiệm thu đúng mức quan sát được.

SHQueryUserNotificationState cung cấp trạng thái phù hợp nhận thông báo, không phải bộ phân loại game/video: QUNS_BUSY còn có thể là presentation settings. Không suy “đang chơi game” chỉ từ QUNS; kết hợp hình học foreground/monitor nếu cần phân biệt fullscreen và maximized. [Microsoft: QUERY_USER_NOTIFICATION_STATE](https://learn.microsoft.com/en-us/windows/win32/api/shellapi/ne-shellapi-query_user_notification_state).

GetLastInputInfo là dữ liệu của phiên gọi và tick trả về không bảo đảm tăng đều. Cần xử lý lỗi, tick wrap và suspend/resume, dùng clock đơn điệu riêng cho nhu cầu/cooldown. Tên tiêu đề chỉ gợi ý nội dung, không chứng minh video/nhạc đang phát. [Microsoft: GetLastInputInfo](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getlastinputinfo).

## 9. [P2] Pipeline pixel không tự bảo đảm hình đẹp hoặc nhất quán

Mã `slice_sprites.rs:94–130` hiện co theo bounding box từng frame và căn giữa; nguyên nhân lệch kích thước/neo trong plan có cơ sở mã. Sampler LINEAR được xác nhận tại `pipelines.rs:264`, bind tại `renderer.rs:446`. Nhưng rà soát này chưa kiểm chứng tuyên bố JPEG nhiễu, chiều cao hiện tại 164 px hoặc hướng nhìn của toàn bộ ảnh.

Khóa 32 màu + majority sampling có thể xóa nét nhỏ và không tự sửa sai giải phẫu/đạo cụ. Chiều cao 62 px nên là mốc pose đứng, không scale mỗi pose ngồi/ngủ lên 62 px. Anchor chân cố định chỉ hợp pose chống chân; leo/bế cần điểm tiếp xúc tay hoặc grip metadata để không trượt. 248 px đúng là +51,2% so với mốc giả định 164 px, nhưng cần đo mốc thật. Lấy mẫu nearest và lưới nguyên chỉ bảo đảm cách raster hóa, không bảo đảm nội dung “sắc nét tuyệt đối”.

Manifest cần version, danh sách file, thời lượng từng frame hoặc quy tắc rõ, điểm tiếp xúc, mirror, regions, validate số frame/sync/index/kích thước. Cần đầu ra preview riêng trước tích hợp, không ghi đè bộ đang chạy. Ghi nguồn asset trung thực: bàn giao A-05 ghi “0% AI art” trong khi plan nói asset trước do AI tạo; chưa đủ bằng chứng giải quyết nguồn gốc trong lượt này.

## 10. [P2] Lưu trí nhớ, lỗi và đóng gói còn thiếu đặc tả

Q3 hỏi lưu “thói quen” nhưng chưa định nghĩa trường nào, cập nhật khi nào, dữ liệu có giới hạn gì. Chỉ lưu trạng thái cần thiết đã duyệt; version/validation, ghi nguyên tử, lỗi/hỏng file và shutdown phải có test. Theo `BongoCat/AGENTS.md` §7, Development/Production phải tách cả dữ liệu, log và tên mutex; một đường SenkoPet/mind.json chung chưa đáp ứng.

H3 đề xuất MessageBox riêng cần giải quyết với quy tắc thông báo lỗi §8; chưa tự coi standalone runner được miễn. H2/Build_Pet.bat không nên tạo nguồn đóng gói song song với `just` + `bongocat-packaging` (§9.2); wrapper có thể gọi luồng chuẩn. D1 không nên hứa Cargo.lock “không đổi” trước metadata/kiểm tra dependency; §6 của repo yêu cầu xử lý lock khi đổi manifest.

`Chay_Pet.bat` có lỗi nhánh chưa có binary: biến EXE_PATH đổi sang debug trước :COMPILE, lệnh compile lại build release nhưng không đặt biến về release trước start. Đây là phát hiện đọc mã, chưa tái hiện bằng chạy launcher. Không sửa trong lượt review.

## 11. [P2] Tối ưu và nghiệm thu chưa đủ để kết luận ổn định

I2 chỉ Present khi trạng thái đổi phải bao gồm lần hiện đầu, resize/DPI, khôi phục occlusion/device, thay resource và lỗi Present tạm thời. Không được đánh dấu frame đã hiển thị khi Present thất bại. Di chuyển HWND không mặc nhiên cần dựng lại texture; cần đo riêng chi phí move/sync/draw.

Vòng hiện tại `draw + sleep(16ms)` không bảo đảm đúng 60 Hz vì còn thời gian xử lý. Tối ưu cần tách nhịp message/input, physics và redraw; giữ bước bù có giới hạn sau sleep. Đo CPU bằng delta processor time trên khoảng thời gian xác định; ghi rõ chuẩn hóa theo lõi, RAM private/working set, GPU/handle, số cửa sổ và phần cứng. Đo khoảng frame hiển thị và thời gian phản hồi input, không coi việc idle bỏ Present là giật.

5 phút/trạng thái là benchmark, không thay soak 8 giờ theo repo §9.3. Lệnh clippy của plan thiếu `--all-targets`, trong khi entrypoint nằm ở example và pipeline ở bin. Bổ sung native tests cho Win32/capture/occlusion, regression người que/Live2D sampler, lỗi thiếu asset, mở hai lần, đổi màn hình, khóa máy/resume và shutdown. Dùng quality gate repo phù hợp trước bàn giao; chưa khẳng định mọi gate đang xanh.

## 12. Lộ trình sửa kế hoạch được đề xuất

1. Sửa mô tả hiện trạng GĐ0 và chốt hợp đồng tọa độ, clip, mask, thời gian, support trước; phân file thực tế cho Codex/Gen, không chỉ phân theo tên chương.
2. Sau khi được giao triển khai, chứng minh một lát cắt nhỏ bằng asset đại diện: idle/walk/turn/held/fall/land và một cửa sổ thật. Mục tiêu là phát hiện lỗi hợp đồng trước khi sản xuất 150+ frame, không coi asset thử là sản phẩm đã duyệt.
3. Hoàn thiện P1 theo ma trận hướng và tiếp xúc đã kiểm chứng; duyệt hình ở kích thước thật và chuyển tiếp, rồi mới tích hợp đầy đủ.
4. Thêm nhu cầu/app context/persistence theo các lựa chọn Leader chốt; cuối cùng P2, benchmark và soak. Giữ cổng nghiệm thu của từng giai đoạn.

Các lựa chọn sản phẩm vẫn để Leader quyết định: phân công/ngoại lệ quyền file; nguồn asset; phản ứng toàn màn hình; phạm vi trí nhớ; mốc chăm sóc; phạm vi cửa sổ được leo; ý nghĩa tám hướng nếu muốn giản lược. Không yêu cầu Leader giải quyết các chi tiết kỹ thuật thông thường như timestamp, mask bounds hay schema validation.

## Bằng chứng và giới hạn bàn giao

- Đã đọc mã liên quan, tài liệu điều phối, kiểm tra Git status/branch (master) và fetch thành công; giữ toàn bộ thay đổi chưa commit có sẵn. Không commit/push/chuyển nhánh.
- Đã tra tài liệu Microsoft cho ba API nêu trên. Các ví dụ lỗi hình học/animator là phân tích đặc tả, chưa phải kết quả tái hiện native.
- Chỉ ghi báo cáo, bàn giao Codex, SYNC và danh mục tự sinh. Chưa sửa Rust/BAT/asset, chưa thay kế hoạch gốc hoặc đánh dấu chức năng mới đã duyệt.
- CHANGELOG: bỏ qua vì chỉ rà soát/tài liệu workspace cha. Không có trạng thái cần người dùng xóa. Bước tiếp theo là sửa đặc tả theo quyết định Leader, chưa tự bắt đầu triển khai.
