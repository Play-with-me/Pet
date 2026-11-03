# SENKO-RP / R-03 — chú ý, lời mời và lưu luyến có giới hạn
Bàn giao29/10/2026. Đã nối logic và P1Look; chưa có artPlay/farewell mới.

## Đã làm
- SocialAttention tách khỏi PointerTracker. Hai lần đổi chiều đủ16px, tốc độ<=450px/s trong1.5s ở gần ngoài thân là lời mời; sampling50ms cho30/60/144Hz. Latch/cooldown và rearm theo pointer rời thật, không dùng petmotion để giả invite. Jitter/flyby/onbody không mời.
- Gần bé: cue chú ý một lượt; offerApproach chờ600ms. Invite chờ250ms, snapshot target cố định và expires5s; tiêu thụ khi Brain thực chọn routeApproach, cooldown6s. Không retarget khi cursor đổi mỗi tick, không tự hủy routecamkết. Earlydeparture rút offer chưa được nhận.
- Offer còn cân needsenergy>=0.15/irritation<0.65 và utility/route của Brain. Không thêm force hoặc ép chọn Approach. Các threshold là tuning nội bộ cần đánh giá trải nghiệm.
- Sau acceptedtouch hoặc acceptedinvitation giữ một interactionanchor tối đa8sRAM. Pointer rời thật mới farewell một lần; offer350ms/TTL2s, target±64px và lọc samelevel/walkonly. Nếu không có đường phù hợp thì nhìn hoặc tự sinh hoạt; không chạy đuổi xa/leo nhảy theo lời tạm biệt.
- R02Look lần đầu điều khiển clip P1look_up thật: 4phase, readyvật lý/pose, actualpresentedID. Attention không hủy route đã camkết; requestchưa diễn quá750ms bị hủy. Headpat/bế/rơi/menu/reset/recovery ngắt theo ưu tiên; target/cue không lưu rađĩa. Quay hướng giữ phía hiện tại nếu cue không có hướng trái/phải.
- Invite/farewell phát emotionaledge hiện có. Chưa ghép clipPlay hoặc biểu cảm lưu luyến vì art mới chưa có; không thay sai nghĩa. P1Look chỉ thể hiện nhìn lên; cue ngang dùng quay hướng hiện có.

## Kiểm định thực chạy
- 8test attention đạt: gentleinvite/fixedtarget/latch, 30/60/144Hz, jitter/expiry, petmotionstationarycursor, earlydepart/nochase, farewelltrueinteraction/64px, tired/irritated, onbody/flyby/missinginput/clear.
- Fullruntime251pass/1ignored(export)+2fixture, render30pass (runtime-render.log). Clippy3crate/alltargets/assettools, scopedfmt/diffcheck đạt; một linttest manualis_multiple_of đã sửa theo toolchain.
- Session18/18 đạt (session.log): mới nativeLook 4phase/1ID/1completion/no-bodymovement với pointertiêm; unitfilter không nhận routeApproach xa hoặc sensorcandidate chưa được socialcho phép. Các nativeheadpat/grab/capturecancel/pause/reset/DPI/exit/Nearest/actualpack/gait tiếp tục đạt. Native5s295Present; walk/run đủ16phase, selftravel191.66/487.80px.
- Các lời mời/farewell đã nối runner nhưng chỉ có sensor/harness và routefilter proof; chưa QA người dùng rêchuột/thấyfarewell trongproduction hoặc video nhân vật cho các nhánh đó. NativeLook không thay QA chuột thật.
- justsenko-build và startuprelease5s exit0 đạt; đóng đúngPID/path33680 trướcbuild. Release78093347CE9A5C37916245CAF6679464AFF347359C4583ABB78132C30F0E29ED mởPID30976. Xem release.json/build.log; chưasoak30phúthashmới/fullworkspace/macOS/hardware/benchmark. Không chạy lại scanner vì không đổi world/physics.

## Còn lại
R03 art nhận lời/từ chối chơi và farewell cảm xúc chờGen/R08 theoMSG238; chưa có xác nhậnGen. TiếpR04: đónnhận/từchối headtail/dỗi/làm hòa theo tâm trạng, actorhandover chỉ dùng artđúng. R05..07 mới chưa làm; quiet-app/idlefixed cũ vẫn còn. S4-06/phần mới chưa mở, P04 visual/contact/hardware còn nghiệmthu riêng.
Không sửaPNG/manifest/Gen/dependency/chínhsáchWindows/branch hoặc commit/push. CHANGELOG bỏqua tiếp tục Senko chưa phát hành; khônguserdata cầnxóa.
