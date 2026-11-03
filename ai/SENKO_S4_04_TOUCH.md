# S4-04 — xoa đầu và nhận diện vuốt đuôi

Ngày28/10/2026. Đã nối P1 xoa đầu vào runner. TailStroke/HeadOverwhelmed có nhận diện và kiểm định logic; ảnh tail_fluff/flustered thuộc P2 chưa có nên chưa phát hoạt ảnh đó. Không dùng clip sai để thay.

## Phần đã làm
- SpriteFrame có Head/Tail/Body theo alpha từng frame. Đầu là top30% bbox; tail core bảo thủ ở46frame idle/sit/headpat/look_up đã xem bản tô vùng QA. Các pose chưa chắc không đánh dấu Tail. Gen được nhắn rà vùng/P2 trong MSG-234; Codex không sửa PNG hoặc manifest nguồn.
- Hit-test dùng pose đã Present thành công, mirror thực và HWNDorigin thực/scale4. Pixel trong suốt luônNone, mọiopaque vẫnhit, nên click xuyên không đổi. Có kiểm tra negative desktoporigin và toàn233frame.
- HoverHead500ms hoặc hai lần đảo chiều đủ12px kích hoạt Headpat; Tail cần rê12px sau khi vào vùng. Latch không cho lặp theo frame hoặc do pose tự đổi dưới pointer; phải ra vùng thật150ms với pointerdịch12px để rearm. Chăm đầu liên tục8giây phát requestHeadOverwhelmed một lần.
- Reward affection/social một lần mỗi episode hợp lệ, không mỗi tick. Xoa đầu ưu tiên hơn ý định/glance, hủy route an toàn, dừng chân tại chỗ, đứng lên nếu đang ngồi, xoay qua hướng trung gian rồi dùng headpatP1. Bế/mất sàn ngắt ngay. Không xóa nhu cầu khi reset vị trí.
- Hover không capture; click-bế vẫn giữcapture, kể cả pointer ở nền trong suốt, đến mouseup/cancel. Pause/menu/reset/held/lỗi/timegap/recovery xóa touchstate. Không lưu phím/title/cursorpath hoặc gửi mạng.

## Kiểm định thực chạy
-7test touch đạt: hover/reversal/latch/pose-exit/re-entry, Tail/longHeadP2 requests, lỗi/gap/pause, rewardbounded, Animator3/4turn/oneshot/held/fall và dừng bước không vượt mép.
- Renderregiontest bảo đảm alpha/mirror/framebbox đúng; runtime215+2fixture/render30 đạt. Overlaydefault128đạt/22ignored; session15/15 đạt, gồm5native cửa sổ và1audit bộ ảnh opt-in.
- Auditbộ thật233frame: alpha⇔region.is_some và mirror cho từngpixel, Head mọiframe, Tail46frame bảo thủ. Kiểm tra originâm và mirror thực qua helper dùng trong runner.
- Nativeheadpatproof dùng tọa độ tiêm theo frame đã hiển thị: một Headpat, không đổi foot để kết thúc bước, clickbế ngắt sangHeld, capturethật và ReleaseCapturehủyđúng. Test mouseup cũ thêmassert captuređượcgiải phóng. Lưu GPUảnh native-headpat.png chỉ cópet; không chụp desktop/người dùng.
- Nativehồi quy vẫnđủ16pha đi/chạy, maskNearest4×4, pause/reset/DPI/exit và Present. Clippyba crate/alltargets/assettools và fmt/diffcheck đạt. Không gọi đây làQA tay rêchuột thật hoặc anatomicalmaskđầyđủ cho mọi pose.
- just senko-build đạt; startup release5giây exit0. SHA2569343463A07D100DCFA383E17419146FE485FCECECF67FD4F1F2963BE29248E28, mởPID44380 và kiểm tra Responding. Chưa monitor30phút riêng hoặc mở trùng trên hash này; không suy bằng chứng hash cũ sang bản mới. Xem release.json/lifecycle.json.

## Còn lại
P2 tail_fluff/flustered và phản ứng lùi bước chỉ hiển thị sau khi có art đúng ởGĐ5. Vùngđuôi hiện bảo thủ, chưa phủ toàn bộ đuôi/poseđộng; Gen cần rà/bổ sung nhãn khi tích hợpP2. TiếpS4-05 phản ứng ứng dụng/idle/chăm sóc; chưa memoryS4-06,QAđầyđủS4-07/GĐ5,hardwaremixedDPI/unplug/fullworkspace/macOS hoặc soak30phút riênghashmới.

Không commit/push/chuyểnnhánh/sửaGen/chínhsáchWindows;không thêmdependency/lockfile. CHANGELOG bỏqua tiếp tụcSenko chưa phát hành;không dữliệungười dùng cầnxóa.

## Rà soát lại theo yêu cầu Leader — 28/10/2026
Phạm vi S4-04-R1: kiểm tra mã và chạy lại touch/region/session, không mở S4-05, không sửa nguồn hoặc asset. Touch 7/7, render sprite_anim 6/6, overlay sprites 14/14 đạt (include-ignored, tuần tự; không bật senko-asset-tools nên không chạy lại ghi hình gait). Audit bộ thật 233 frame/46 tail core đạt; native hover/headpat/held/capture-cancel, grab/pause/reset/exit và GPU Nearest đạt. Smoke 294 Present/5 giây. Lệnh đầu dùng nhầm tên feature asset-tools bị Cargo từ chối; đã chạy lại bằng cấu hình mặc định hợp lệ. Không phát hiện lỗi mới trong phạm vi đã kiểm tra. Chưa QA chuột vật lý, vùng đuôi chưa đầy đủ và P2 vẫn chờ. EXE hash 9343463A... giữ nguyên, PID44380 Responding. Không build lại/commit/push; CHANGELOG bỏ qua vì chỉ rà soát tính năng chưa phát hành.
