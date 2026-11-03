# SENKO-RP / P-04-B — bám cửa sổ chuyển động và đồng bộ tiếp xúc
Bàn giao29/10/2026. Không đánh dấu toàn bộ kế hoạch phản ứng đã hoàn thành.

## Đã sửa
- Hop-to-wall dùng vận tốc tường ở takeoff; điểm bắt lưu tương đối với owner thay cho độ cao desktop cũ. Khi bắt, tính crossing theo vận tốc tương đối, chở qua phần thời gian còn lại, kiểm tra cạnh hiện đang nhìn thấy. Attach nhận velocity tường để không bị false-acceleration làm tuột ngay frame kế.
- Mantle/dismount đổi dịch ngang tuyến tính sang quintic, velocity/acceleration bằng0 tại hai đầu; duration tối thiểu theo maxspeed280/gripacceleration3600. Body quyết định tiến độ; Animator sync đúng delayframe và chiều đảo, không đợi clip hoàn tất để teleport thân. Chưa thay hình nguồn hoặc vị trí tay/chân trong sprite.
- Soft/hard contact có motor recovery80/240ms (tuning nguyên mẫu), đặt nhẹ0ms. Tính phần thời gian còn lại sau impact; pause đóng băng timer, bế/mất điểm tựa hủy gate. Không cho input tự động/touch/launch sớm; passive slip vẫn chạy theo vật lý. Không phát clip P2 sai nghĩa.

## Kiểm định thực chạy
- Runtime234pass/1ignored(export)+2fixture, render30pass; runtime-render.log. Test mới moving-wall hop ngang/chéo30/60/144Hz và giữ bám thêm200ms; recovery/pause/grab/slip; force-bounded mantle và frame theo body hai chiều30/60/144Hz.
- Session16/16 opt-in/assettools: native đầu/bế/capturecancel/pause/reset/DPI/exit/Nearest và đủ16pha đi/chạy; selftravel195.46/483.76px. session.log, GIFGPU trong thư mục bằng chứng. Harness đảo hướng/gesture của P04-A vẫn đạt.
- Scanner12/12 gồm native DWM fixtures: real-clock slowtransport rồi close giữ đà vàgravity, route floor/hop/climb/mantle/drop dùng PNG thật, geometry/resize/minimize/close/Zorder/hooks. Đây là scanner+body/Animator harness cô lập, không quay video production thực với mọi cửa sổ người dùng.
- Lần scanner đầu11pass1fail: test cũ yêu cầu foot+=6px cho cú dịch6px/~30ms, bỏ qua slip do gia tốc. Đã thay bằng bảo toàn displacement=carried+slid, không nới vật lý; vẫn kiểm tra carried6px và slipngược. Lần chạy lại thiếu envSENKO_G2_ASSETS gây unwrap; giữ logscanner-missing-env.log, bổ sung env đúng và chạy lại scanner12/12 đạt (scanner-final.log).
- Clippy3crate/alltargets/assettools, scopedfmt/diffcheck, justsenko-build đạt. Đóng đúngPID/path21892 trước build để tránhEXElock. Smoke5s exit0, mởPID31508. HashF97E98E6184D9F16F0793DEDAF32ABF77C182A79D7BEABEC05DE1A22E2B2B215, release.json/build.log. Chưasoak30phúthashmới/fullworkspace/macOS/hardware hoặc QA chuột thật.

## Trạng thái và còn lại
P04-B đã nối các luồng trên và có bản review. Nghiệm thu thị giác vật lý, vị trí tay/chân theo artGen, gia tốc leo dọc và bảo toàn thành phần vận tốc chủ động khi tuột giữa leo/mantle vẫn cần hoàn thiện; không gọi mọi chuyển động ngoài đời đã mô phỏng xong. R02..07 mới chưa mở; quiet-app/idlefixed cũ vẫn còn trong bản hiện tại. Gen/R08 chưa xác nhậnMSG238; không dùng thiếu ảnh làm cớ thay clip sai.
Không sửaPNG/manifest/Gen/dependency/chínhsáchWindows/branch hoặc commit/push. CHANGELOG bỏqua: tiếp tục tính năng Senko chưa phát hành. Không localuserdata cần xóa.
