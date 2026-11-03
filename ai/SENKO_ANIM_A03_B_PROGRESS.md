# SENKO-ANIM-A03-B — contacts, manifest player và full-session160 (29/10/2026)

## Đã triển khai
- Clip.contacts theo từng frame với tên typed:foot_left/right,hand_left/right,grip,prop.
  Kiểm tra count/finite/canvas; mirror liên tụcwidth-x, giữ tên chi cơ thể. Chỉvisual,
  không thay gripinput/Body/motion. Audit xuất contacts.
- Texture dùng lại theo canonical file path; không nạp trùng texture cho các reference
  cùng file. Giữ8192frame reference và8192uniquetexture, palette32 và1024frame/clip.
  Chưa dedup nội dungRGBA của các file khác nhau hoặc triển khaiLRU/streaming.
- --manifest-player xuất HTML/PNG mới ở ngoài pack, khôngoverwrite/ghi nguồn. Metadata
  inline, khôngfetch filemanifest; phát theo performanceclock, time/distance, pause,
  frame scrub, mirror và markercontacts. Distance dùng strideperframe như Animator.
- Thêm Animator160 test tại30/60/120Hz: walk, pause thực, Held→Fall→Landing→Idle.
- Native160 fullsession đủ45tênclip/233framereference nhưng5PNGmodeltĩnh, masks/contacts
  synthetic. Chỉfixtureintegration, không được dùng làm bộnhânvật thật hoặc gọi45FPSart.

## Kiểm tra đã chạy
- Render32pass; runtime296pass/1ignored export +2sharedfixtures; assettool13pass.
- Native toànnhóm31/31; full160runner295Presents/7.348s gồm khởi tạo vàshutdown,
  không suy thànhFPSbenchmark. Test riêng grab/pause/reset/exit trên fixture160:1/1đạt.
- ExportedJS contract(Node/DOM-RAFstubs):10s30/60/120Hz, pause, distance, scrub,
  one-shot vàcontacts mirrorđạt. Chưa có kiểmtraUItrìnhduyệtthủcông hoặc45FPScadencehardware.
- Clippy all-targets assettools, scopedfmt/diffcheckđạt. Sau bổ sung frame-refcap đã
  rerunrender32/Clippy vàbuild cuối; native/runtime logs trước thay đổi cap nhỏ này.
- Lần đầu Animatorfixture pause=true ở đoạn đợiLanding làmtestkhôngthoát; sửa fixture,
  không sửa productionAnimator đểphục vụ kỳvọng sai. Log tests.log giữlầnfail,
  tests-final.log/render-final.log làkếtquảcuối.
- Protected Brain/motion/routes/rest/care/environment/context vàv5manifests checksum
  so A01 khôngđổi. ChỉAnimator testđược thêm; không đổi quyết định hànhvi/vậtlý.

## Trạng thái plan
A03 đã có nền160/contact/hitmapping/timing/player/fullsessionfixtures đểtiếpA04.
Chưa chứngnhậncadence màn hình45FPS, fullpackbudget hoặc tiếp xúc trên art thực.
Các kiểmtra đó tiếp tục cùng clip A04..A08 và nghiệmthuhiệunăngA09, không bịbỏqua.
Bản chạy vẫn dùngv5; cácfixturetronglogs cóREADME cảnhbáo. Không thay defaultpack.

A04 đã bắt đầu: nguồn imagegen12keypose walkside mới, cóprovenance/prompt ở
resources/characters/senko-160-source/gait/GENERATION.md. Chưa tách/chuẩn hóa/gaitQA,
cần kiểm tra pha chân/cửđộngtay/volume trước tạo45FPSinbetweens. Chưađạt45FPS/fullgait,
không tíchhợp nguồnnháp hoặc dùng12frame đểnhậnđãđủmượt. Khôngcầnduyệtlại modelA02.

## Tài liệu và giới hạn
Playerclock45 trong logs/SENKO-ANIM-A03-B/player-clock45/index.html dùng45reference
lặp cùng1pose đểtestclock; hình tĩnh làcóchủđích, không minh họa độmượt. Player160 đầu
đượcxuấttrướcsửacôngthứcdistance; chỉplayer-clock45làartifactđãtestcuối.
KhôngA09soak30phút/QA tay/mixedDPI/macOS/fullproductionbudget. Khôngsubagent/commit/push/
dependency/branch. CHANGELOGskip vì tiếp tục cùngtínhnăngchưa phát hành.


Bảnrelease cuối: hash4951CCE04D2931103BAAADD480ED316A5CB38934E23D509BE640746D04E028BA, smoke5giây exit0; mởPID45492 với packv5. Đây lànền160 đãbuild, chưathayhìnhnhânvật bằngfullpack160.

