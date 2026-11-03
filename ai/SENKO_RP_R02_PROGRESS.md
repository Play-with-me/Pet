# SENKO-RP / R-02 — nền cảm xúc và reaction episode
Bàn giao29/10/2026. Phạm vi là core runtime và emotion observation; chưa có biểu cảm mới hiển thị.

## Đã thực hiện
- Emotions gồm joy/excitement/embarrassment/irritation/startle, tách khỏi Needs/affection và Intention của Brain. Các event hợp lệ thay đổi bounded0..1, có exponentialdecay; một tác động không tự nhảy tới cực trị. Bộ nhớ chỉRAM, không serialize/history/phím/title/cursortrace.
- ReactionDirector có kind/cause/priority/episodeID, bốn giai đoạn Noticing/Preparing/Performing/Settling. Seed quyết định delay lúc bắt đầu100..220ms và kết thúc200..350ms; khôngrandom mỗi tick. Preparing chờ ready vật lý, timeout5s; Performing chờ actualpresented(ID,kind), timeout10s. Frame cũ/khácID không được hoàn tất lượt mới. Cooldown2s, không queue replay sau interruption.
- Gate held/air/menu hủy ngay; pause giữ clock/emotion/cooldown, không nhận event mới. Catchup mỗiadvance<=100ms sau suspend. Thiếu art trả MissingAsset và giữ trạng thái hiện có, không thay clip.
- Runner đã quan sát acceptedheadpat/acceptedtailstroke, pickup và hardimpact bằng eventedge hiện có. Nativehook chứng minh mood joy/startle thay đổi theo tương tác. Không sửa quyền đón nhận/từ chối hoặc utility; không thay cơ chế HeadpatGesture hiện tại bằng episode ở lượt này. Episode lifecycle là harness, chưa điều khiển clip thật.

## Kiểm định đã thực chạy
- 6test mới đạt: bounded/decay/reassure; pause/suspend; giai đoạn/ready/actualdisplayed/cooldown; missingasset/priority/interrupt/no-replay; timeout; seedreproducible. Test renderedID khác không kết thúc episode hiện tại.
- Full runtime243pass/1ignored(export)+2fixture, renderer30pass trên mã cuối (runtime-render.log); Clippy3crate/alltargets/assettools, scopedfmt/diffcheck đạt.
- Session16/16 đạt (session.log), gồm nativeheadpat/grab/capturecancel có assert moodjoy/pickupstartle và hồi quy actualpack/gait/DPI/pause/reset/Nearest. Native5s295Present; walk/run đủ16phase, selftravel194.30/480.44px. Không gọi đây là nativeepisodeactor QA; metadata correlationID cuối được kiểm tra lại bằng runtimefull+Clippy.
- justsenko-build và smoke releasecuối5s exit0 đạt. ReleaseCD59AA1E5F87E102B7C23B29D41A0A38E4BE159A1C1F85F72AF89E56947C685B mởPID33680; release.json/build.log. Đóng đúngPID/path bảntrước khi link. Không soak30phút hashmới, fullworkspace/macOS/hardware, benchmark hoặc QAchuộttay; không chạy lại scanner tronglượt này vì không đổi scanner/worldphysics.

## Live và harness
Live: state cảm xúc nhận event đã hợp lệ và tự dịu; visual/actor/ýđịnh vẫn như trước.
Harness: requestepisode/priority/phases/ready/renderedID/missingart/timeout/cooldown. R03/R04 sẽ nối lựa chọn ý định và actorfeedback theo thiết kế mới, chỉ khi có art đúng.
TiếpR03 chú ý/lời mời/lưu luyến, sau đóR04 tương tác theo tâm trạng. R05..07 chưa làm theođặctảmới; quiet-app/idlefixed cũ vẫn còn. R08/Gen chưa xác nhậnMSG238, không tự sửaasset. S4-06/phần mới chưa mở. P04 còn nghiệmthuvisual/contact/hardware theobáocáoriêng.
Không commit/push/branch/dependency/PNG/manifest/Gen hoặc chínhsáchWindows. CHANGELOG bỏqua: tiếp tục tính năng chưa phát hành; khônguserdata cầnxóa.
