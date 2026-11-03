# SENKO-RP / P-04-C — gia tốc leo và đà traversal
Bàn giao29/10/2026. Tiếp nối P04-B; chưa nghiệm thu toàn bộ hình ảnh/vật lý hoặc phần phản ứng.

## Thay đổi thực hiện
- Motor leo dùng cùng profile gia tốc900/phanh1400, nominalspeed140physicalpx/s và khoảng phanh tới điểm chuyển mép. climb_by là primitive hình học, follower dùng climb_toward có elapsed.
- Active traversal velocity tách khỏi groundmotor: climb lưu vận tốc dọc; mantle/dismount lưu đạo hàm quintic ngang. Mất support cộng đúng surfacevelocity+activevelocity vào flight; feedback groundmotor0 không xóa đà traversal. Bế/cancel/attach mới xóa trạng thái đúng.
- Climb clip lấy phase từ quãng leo thực tế, dùng delay gốc quy đổi ở nominal140px/s. Không cộng carriage, không bước khi thân đứng yên; Held bỏ qua syncclimb. Native route harness cũng nối syncclimb/mantle như runner.

## Kiểm định thực chạy
- Runtime237pass/1ignored(export)+2fixture, render30pass (runtime-render.log). Test mới climbaccel/brake/loss/pause30/60/144Hz, mantle hai chiều bị ngắt giữvx, contactphase đứngyên/realframedelays/Held.
- Session16/16 đạt (session-final.log), gồm actualpack motor30/60/144 và native capture/mouseup/cancel/hold/pause/reset/DPI/exit/Nearest. Nativewalk/run đủ16phase, selftravel190.02/480.90px; smoke295Present/5s. Test bộ ảnh/harness không được gọi là video đầy đủ của leo hay QA chuột thật.
- Session đầu15pass1fail: assert cũ đòi foot đứng im ngay lúc nhận headpat, trong khi physicalmotor đang110px/s nên phanh thêm4.3214px. Đã sửa test để giới hạn dịch chuyển theo min(v²/2a,safeedge), sau khi clipHeadpat bắt đầu phải đứng im tuyệt đối. Không sửa vật lý để vượt test; log session.log giữ lỗi gốc, session-final.log là kết quả sau.
- Scanner12/12 đạt (scanner.log). Native fixture close lúc poweredclimb xác nhận đà lên còn lại rồigravityđảochiều; assert cũ rơi xuống ngay được thay bằng phương trìnhvelocity. Native route dùng actualPNG/delay và syncprogress, DWMrealclock/lifecycle/geometry/Zorder đạt trong harness cô lập.
- Clippy3crate/alltargets/assettools, scopedfmt/diffcheck và justsenko-build đạt. Đóng đúngPID/path31508 trước build. Smoke release5s exit0; release6BFDB5BDF4A10911F175767778604E2BDD2B16188E2C1EF76C29F1051CBA0FD3 mởPID35820, release.json/build.log.

## Trạng thái hiện tại
Lõi motor/physics/traversal P04 đã có mã và kiểm định trong phạm vi trên. Nghiệm thu cảm giác sức nặng/điểm tiếp xúc taychân theoart và các giới hạnQA phầncứng vẫn mở. Không gọi mọi tình huống desktop/nativeproduction đã nghiệm thu. Chưa soak30phút trênhashmới/fullworkspace/macOS hoặc benchmark.
Tiếp theo trong cùng đợt nâng cấp là R02: needs/emotion/intention tách biệt và reactionepisode có nguyên nhân/giai đoạn/interrupt. R03..07 theo đặc tả mới chưa triển khai; quiet-app/idlefixed cũ vẫn còn. R08 nhờGen theoMSG238, chưa phản hồi; không sửaPNG/manifest/Gen hoặc bật clip sai. S4-06/phần mới giữ nguyên.
Không commit/push/chuyểnbranch/dependency/chínhsáchWindows; CHANGELOG bỏqua tiếp tục tính năng Senko chưa phát hành. Không userdata cần xóa.
