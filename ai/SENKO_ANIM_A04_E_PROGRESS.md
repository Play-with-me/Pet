# SENKO-ANIM-A04-E — start/stop và chuỗi Animator thật (29/10/2026)

Leader chấp nhận A04-D và yêu cầu tiếp tục theo plan. Codex tự làm; không subagent.

## Đã làm
- Imagegen vẽ12tư thế trung gian cho start/stop theo source keyposes và model A02.
  Chọn3pose cho start,4pose cho stop; các cell khác không dùng, không tính vào framecount.
- Start9frame khác nhau/200ms. Stop10frame khác nhau/240ms:9frame chuyển động200ms
  và40ms giữ canonical idle ở cuối. Thời lượng giốngv5, không đổi timer hành vi.
- Endpoint tham chiếu trực tiếp file canonical: Idle→Start0; Start8→Walk0;
  Walk0→Stop0; Stop9→Idle. Không nhân bản ảnh để báo đủ45FPS. Library52textures/56refs.
- Partial side pack bốn clip, canvas160/scale2/anchor80,152. Giữ ảnh walk36 và metadata
  contact mẫu6frame đã có; không tự đoán contact cho cácframe còn lại.
- Harness offline dùng Animator production, cảRight/Left,240tick/4s danh định,
  yêu cầu tựdịch chuyển120px/s khi đi và pause15tick. Cótrace stage/clip/frame/distance.
  Chuỗi có Idle/Starting/Moving/Settling/Stopping/Idle và kếtthúcđúngIdle.

## Kiểm tra thực chạy
- CLI tạo pack/review chạythànhcông. Kiểm tra artifact: start9/9RGBA khác nhau,
  walk36/36, stop10/10; sumtiming200/240; canonical seams cùngfile; pause giữpose15tick.
- Test native chuyên biệt1/1 đạt: actualart qua Animator và NativeOverlay/Present,
  thấyđủ9/36/10frame ở cảphải/trái, trởvềIdle; khoảng4.096s/4.070s mỗi hướng.
- Assettool16/16; Clippy render/runtime/overlay all-targets+assettools; fmt/diffcheck đạt.
  Không sửa runtime production hoặc renderer trong lượt này nên không chạy lại toàn
  runtime/native regression haybuildrelease; không dùng kếtquả cũ làm kếtquả mới.
- NativecaptureGIF60sample/3730ms sau lượngtửdelay, không dùngđểchứngnhận45FPS.
  Playertrace4s/manifest làchuẩnclock.15tickpause0.25s ở giữa làcóchủđích.
- Checksum protectedbehavior modules và v5manifests soA01 khôngđổi. Appvẫnpackv5.

## Preview và dữ liệu
Candidate resources/characters/senko-160/side-sequence-v1 chỉcóbốnclip, khôngphải
fullpetpack. index.html dẫntraceplayer vànativecapture; sequence-report.json ghi
sourceorder/provenance; animator-trace.json cóhaihướng. Source/prompt ởgait/
STARTSTOP_INBETWEENS_V1.md; rawimagecopykhôngghiđènguồncũ.

## Giới hạn / phần tiếp
Đây lànativeactual-art trongcửasổcốđịnh; khôngmôphỏngbody/world, chưađứngtrêngờ thật,
chưaQA chuộttay hoặc cadencehardware45FPS.60Hz làclocktestđưa vào Animator, không
phải claim60tưthếvẽmỗi giây. Hình/framecount/timing khôngthayduyệt chấtlượng.
Còncontact toànchu kỳ, sync/entry cảphase0/18 vàharnessdi chuyểnthựctế/đổihướng,
rồi run vàcáchướngcònlại. A04 chưa hoànthành, chưaA08defaultswitch/A09soak30phút.
KhôngBrain/body/planner/cooldown/media/storage/defaultpack/dependency/branch/commit/push.
CHANGELOGskip: hoànthiện cùngfeaturechưapháthành. Khôngcầnxóa dữliệu người dùng.
