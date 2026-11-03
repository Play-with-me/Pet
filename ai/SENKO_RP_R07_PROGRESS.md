# SENKO-RP / R-07 — nghỉ theo năng lượng, chào và chăm sóc
Bàn giao29/10/2026. Codex tự làm, không subagent. Lõi và P1rest được kiểm định; P2greet/care còn chờ ảnh.

## Thay đổi
- Xóa IdleMode ép ngồi120s/ngủ600s. RestPolicy dùng năng lượng, ý định của Brain, giờ trong ngày, inputidle và playback có nguồn thật. Idle lâu tự nó không ép nghỉ. Work/fullscreen không thêm quy tắc yên hơn.
- Nghỉ hồi sức có cam kết/hysteresis: thresholdsleep0.16; ban đêm yên0.32; ngồi hồi sức khiRestenergy<0.35. Kết thúc hồi sức ở0.7(ngồi)/0.8(ngủ), có tuổi tối thiểu5s và thời gian tránh ngủ lại10s. Ngáp có cooldown60s, không chọn lại mỗi tick. Các giá trị là tuning nội bộ, chưa nghiệmthu cảm giác bằng người dùng.
- Chỉ ngồi thực (SitLoop) hoặc ngủ thực (Sleeping), có điểm tựa ổn định/không tự đi/trượt/bế/leo mới hồi năng lượng. Ngồi hồi1/240 mỗi giây, ngủ1/120; ý định nghỉ hoặc pose cũ trong khiRun không hồi giả. Pause đóng băng, bước bù bị giới hạn; bế/rơi/ngắt được ưu tiên.
- Bỏ nhánh Sit theo ý định cũ để tránh vàoSitEnter rồi phải đứng dậy mới ngáp. Các tư thếP1nghỉ được quay qua hướng3/4 phù hợp bằng Animator, không đổi ảnh/foot position. Wake trở lạiIdle thật.
- Away30s -> inputrecent<2s là một cạnh quay lại, không phải mỗi lần rê chuột. Thức dùng cạnh returned riêng, không phụ thuộc cooldown chào30s. Greet có cảm xúc và MissingAsset gate; không thay bằngHeadpat hoặc gọi Wake là clip chào mới.
- Care lấy inputrecency<30s làm ước lượng hoạt động, không phải đo thời gian làm việc thật. Đủ50phút mới eligible; activecounter bão hòa50phút. Chỉ offer thật đúng token/phase đã presented mới commit cooldown30phút, nên thiếu ảnh không tính là đã mời. Sampleidle liên tục>=300s resetactive, giữ cooldown; paused/unknown/suspend/rollback không cộng công việc giả. Sourceidle tươi>=5phút vẫn chứng minh nghỉ kể cả khi apppaused.
- Invitation có Approaching/Offering/Waiting/Withdrawing, giới hạn8s/5s/3s/1s, pause và ngắt. Chờ người dùng ngắn rồi rút; wrong/unpresented token không ack. Latch tránh requestMissingAsset mỗi tick; không thưởng affection cho lời mời hoặc chào.
- Care route dùng planner hiện có tới vị trí đủ chỗ canvas80pxx4 quanh footanchor, kiểm tra bề mặt/đường đi thật, tối đa8plannerattempt từ64ledge. Không có đích phù hợp thì hủy, không teleport. Nếu đã đủ chỗ thì không đi thêm. Tuyến/offer chỉ được bắt đầu khi có actor đúng được duyệt; pack hiện tại thiếu ảnh nên nhánh sống chưa tự di chuyển để giả mời. P2props/contact bounds phải kiểm lại ởR08.

## Kiểm định
- Runtime294pass/1ignored(export)+2fixture, renderer30pass. Tests: không ép nghỉ theoidle, sleep/sitcommit/hysteresis/return/pause/held/fall, actualenergyvsintent/motion, care50/80phút bằngclockmôphỏng, boundary299/300s, nofakework, missingartnocooldown, token/wait/withdraw/interrupt, greetingcooldownkhôngchặnthức.
- Care route thực bằng SenkoBody+RouteFollower: đi từ chânx60 tới160 để đủ chỗ, lặp lại trên màn hình tọa độ âm; màn quá hẹp trảNone và không đổi vị trí. Đây là môphỏngmodule, không phải actorP2 đã tích hợp trongproduction.
- Native với context/energy/intention tiêm: healthy+idle600s khôngépSleep; tiredP1ngáp1lần -> Sleep -> inputreturn -> Wake -> Idle, greetedge1lần. Năng lượng vẫn<0.2, nên thức là doquaylại, khôngdoresetenergygiả. Không gọi đây làQA tay hoặc đo hồi sức80giây.
- GIF native và contact sheet tại logs/SENKO-RP-R07; đã xemkhung mẫu, phát hiện và sửa nhịpSit/Stand thừa trướcYawn. Preview hiện hành dùng thời gian capture thật, không vẽ lại/biến dạng sprite.

## Còn lại
Greet/tea/stretch và diễn xuất offer/wait/withdraw cầnartGen/R08, chưaGenxácnhận MSG238; không sửaPNG/manifest. P2actualpresented feedback cònchờactor, các chuỗi đó hiệnkiểmđịnhharness. R04..06art/visual cònmở; chưa nghiệmthu toàn đợt hoặc mởS4-06/phầnmới.
ChưaQA tay, mixedDPI/unplug, macOS/fullworkspace/benchmark hoặc30phút hashmới. Khôngdependency/branch/security/commit/push/subagent. CHANGELOG bỏqua tiếp tụcSenko chưa phát hành; không dữ liệu người dùng cần xóa.

## Kết quả cuối
Session cuối27/27 đạt, gồm hai ca native nghỉ/thức mới và hồi quy trước đó. Walk/run đủ16pha, selftravel193.21/489.14px. Finalrestframe ghi nhận idle_side/0/Idle/Right; có PNGcapture cuối và contact sheet đã kiểm tra. GIF29frame/1840ms là một ca native với return được tiêm sớm, không phải chu kỳ ngủ thực tế lặp2giây.
Clippy3crate/alltargets/assettools, scopedfmt/diffcheck đạt. Preview tại logs/SENKO-RP-R07/index.html đã tạo; yêu cầu mở panel trảqueued nên không khẳng định panel đã hiện. KhôngsửaảnhP1/PNG/manifest hoặc tốcđộclip để giả preview.

## Bản chạy
`just senko-build` và startuprelease5s exit0 đạt. Đã đóng đúngPID13352/path trướcbuild; bản mớiPID12400/responding. SHA2564800A871BEB876BF3A9E7ED178C5920824128D2ED334E95DE9207853F49C7DE2. Xem build.log/release.json. Đây là bản phát triển để thử, không phải nghiệmthu tổng thể hoặc kiểm tra30phút.
