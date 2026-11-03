# A04-V — tư thế đi bộ 3/4 trước,30/10/2026

## Phạm vi
Leader tiếp tục plan sauU. Sảnxuất hướngwalkmới trongA04,khôngsubagent/Brain/body/motor/physics/planner/defaultpack/dependency/lockfile/commit/push. Fetchoriginđãchạy. Không dùngmẫuđứngthaygait,khôngnối hướngchưacóđườngđi vàoautonomousworld.

## Nguồn và quyết định
Dùngbuilt-inimagegen2lượt,thamchiếumodelpose01,khôngCLI/API. Sources resources/characters/senko-160-source/walk-34-keys-v{1,2}-raw.png vàexactprompts -prompt.txt;generated_imagesgốcgiữnguyên.
V1layout6×2quását,đuôichạmbiên:fixedcellgatefailkey6,khôngtạooutput. V2layout3×4cómargins vàtưthếbướcnhấcchânrõhơn,đãxemrawqua view_image. Fixed-gridbaselinechungbanđầufailkey9vìhàngnguồnbốtríđộcaokhácnhau;khôngcắt taiđểđạtkhung.

Cuối dùngcuttercomponent đãcó đểgiữtrọn silhouette,chuẩnhóaneo eovàsole cho từngkeywalking đãxemcóchânđặtxuống,mộtscalechungtoànsheet,khôngperframescale. Khácvớirunairborne:khôngđemsole-groundingnàyápvàoframebay. Nhữngthayđổithửnghiệmtổngquátfixedgrid ởrun160đãgỡlại,chỉđổimessagelỗi nộibộ chođúng6column,runalgorithmsgiữcũ.

## Kết quả
Toolmới --walk34-keys160cho6×2 và --walk34-spaced160cho3×4. Final resources/characters/senko-160/walk-34-keys-v3:12PNG160/31RGBA/hardalpha/khôngcắttaiđuôi,anchor80,152/scale2. Facingthree_quarter/mirrortrue,cliptime-onlywalk_34_key_review12×100ms=1200ms (10hình/s). Khôngdistancewalk_34/sync,khônggait45FPSđãhoànthành.12drawingkhácnhauchưađủchứngminhphangữnghĩa.

Height124..130px,còn6pxdaođộngcầnràvolume/pivot/độnhúnvàphanhậnbiếthai chân,trướckhisảnxuấtinbetweens45FPS. Khảnăngmirrorchỉpreviewảnhđốidiện,khôngxácnhậndi chuyểntheođườngworldchưahợplệ.
Preview resources/characters/senko-160/walk-34-review-v1/index.html cóbanner“12key/10hình/s,chưa45FPS/chưatíchhợp”. Scriptannotate-preview.cjslưutạilogđểtáitạo. Đãxematlasfinalqua view_image. open_in_codex trảqueued,chưaxácnhậnbrowserplaybacklượtnày.

## Kiểm tra
Tool20/20,Clippyassettool-Dwarnings,scopedfmt/diffcheckđạt. ActualCLI+SpriteLibrary+manifestplayerđã nạp source/pack thật. Read-onlyaudit12unique/31palette/alpha/kíchthước/baseline/facing/mirror/time-onlyđạt. ĐâytechnicalQA,khôngcertstance/footlock/45FPShaynativePresent. Logs/scripts/auditởai/logs/SENKO-ANIM-A04-V.
Khôngproductionruntimechange nênkhôngrerunfullruntime/native/release/soak. Appgiữbảnđangchạy. KhôngclaimA04hoànthành;matrix ai/SENKO_ANIM_LOCOMOTION_STATUS.md ghiđúngcáchướngcònthiếu. A05..A09giữsaucổngnghiệmthu. CHANGELOGbỏqua:cùngtínhnăngchưapháthành. KhôngADR mới vìofflinesource/toolreviewkhôngđổiruntimecontract.
