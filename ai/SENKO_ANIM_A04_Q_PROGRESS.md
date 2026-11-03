# A04-Q — nguồn chạy ngang và bảo toàn đường sàn,30/10/2026

## Phạm vi
Leader tiếp tụcplan sauP. Codex tự làmart/run-tool/preview/QA,khôngsubagent/Brain/physics/motor/planner/defaultpack/lockfilechange. Fetchoriginđãchạy;khôngcommit/push/switch. Khôngđổi tốcđộthựccủaSenko.

## Nguồn và trạng thái
Built-inimagegen2lượt,khôngCLI/API: sheet18pose6×3từmodel02, sauđóeditphase9touchdown. Sources resources/characters/senko-160-source/run-side-v{1,2}-raw.png vàexactprompts cùngtên-prompt.txt;generated_imagesgốcgiữnguyên. Đãxemhainguồnvàatlasnháp. Nétchibi/hakamangắn,khôngkéo chân. Hai nguồnchưađượccôngnhậnrunloophoànchỉnh.

## Lỗi tool đã phát hiện và sửa
Lúcđầu reuse normalize::slice vốn cắt sát silhouette và thêm4pxpaddingriêng cho từngframe. Vìvậy dùngbaselinechung sauđó vẫn mấtgốc tọađộsource, sốđoclearancebanđầu khôngđángtin. Đãsửa riêngrun160 dùngfixed6×3gridgiữcell-localx/y,khôngđụngcutterchungcủawalk/turn hiệncó. Dùng1scale/1sourceaxis/1sourcebaselinechungtừsheet;khôngđặttừngframe lênsàn hoặcscale riêng. Pixelpalettehelper chỉđổivisibilitypub(super)choofflinemodule,khôngđổihànhvi.

Unit test mới kiểmtra cảgrid extraction vàrendertransform bằngsheet tổnghợp cóground/flight chênh4px: giữclearance4px,bodybob4px,kíchthước/horizontalanchor giữ. Lỗi crop-to-bounds cũ sẽlàmmấtkhoảngchênhnày.

## Kếtquả cuối và khôngtíchhợp
Sourcev2 saufixedgrid vẫnframe9clearance4px,khôngphảitouchdownđãyêucầu. Strict --run-keys160 từchốitrướckhitạo packdistance cho nguồnnày. Khônggắn sync0/9sai vàorunner. Cácfailurelogs trướcfixcrop khôngdùngchứngminhchấtlượngsource.

Có --run-review160 xuấtpreviewtime-only, khôngcliprun_side hoặcsyncdistance. Finalpreviewpack resources/characters/senko-160/run-review-only-v1,player resources/characters/senko-160/run-review-v2/index.html.18PNG khácnhau/32RGBA/hardalpha/160×160×2,18delays22/23=400ms. Referencecycle128px kếthừa packv5;320px/s chỉtốcđộthamchiếu45draw/s,khôngtốcđộmotorđãđổi. Decoded18RGBAframeước1,843,200bytes(~1.76MiB),chưabaogồmmask/GPU/overhead,khôngsốđomemoryruntime.
Clearancechuỗicuối:[0,0,0,0,0,5,7,3,5,4,3,3,3,8,3,3,3,3]. Chưađạtstance/contact/thứtựhaichân/loopseam,tuyđủ18unique. Khôngđánhđồngpixelclearancevớiphânloạingữnghĩachântrụ.

Lịch sử run-side-v1 vàrun-review-v1 dùngcuttercũ đượcREADMEđánhdấukhôngnhận. run-side-v2/v3khôngđượctạo doqualitygatefail. Khôngxóanguồncũ,khôngbáolàứngviênrunnerđạt.

## Kiểm tra thực chạy
Asset-tool20/20(1testmớicommongrid/flight),Clippyassettool-Dwarnings,scopedfmt/diffcheckđạt. Toolreview+SpriteLibrary+manifestplayer nạp thật;Pythonread-onlyaudit18unique/size/alpha/colors;clockcontract10giây30/60/120Hz/mọi45delayquavòng=1000ms đạt. Đâytiming/toolQA,khôngbrowserGPU/nativePresentartapproval.
Đãchạystrictsourcev2saufixedgridvàbịreject,giữlogrun-v3. Preview-onlykhôngdùngđườngstrictbằngcáchbỏquagateđểxuấtdistance: nóbỏhoàntoànclipdistance. Log/scripts/audit: ai/logs/SENKO-ANIM-A04-Q.
open_in_codex trảqueued,chưaxácnhậnbrowserplayback. Khôngnative/fullruntime/renderQA/releasebuild/soak30phútmới vìchỉofflinetoolkhôngproductionchange.

## Tiếp theo
Sửanguồnruntừkeyposecontact0/9vàcommonfloortrướckhilàmloopnốiactualAnimator. Cầnchia rõstance/flight/phachânvàgiữthểtích,hông/tay/đuôi. Runvẫnchưađạt;A04turnheight/pivot,arm-tail/cáchướnggaitcònmở. KhôngchuyểnA05..A09,khôngđổibảnđangchạy. CHANGELOGbỏqua:cùngtínhnăngchưapháthành. KhôngADR mới:offlinetool/previews,chưathayruntimecontract.
