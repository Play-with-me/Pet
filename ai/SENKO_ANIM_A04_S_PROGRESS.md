# A04-S — kiểm tra chạy trên Body và chuyển gait,30/10/2026

## Phạm vi
Leader cho tiếp tụcA04 sauR. Chỉofflineharness/preview/candidateassembly/QA,khôngproductionAnimator/Brain/body/motor/physics/planner/defaultpackchange. Khôngsubagent/dependency/lock/commit/push. Fetchoriginđãchạy.

## Đã làm
Thêm --run-world160 vào walk_world160 tool. ChạyactualSenkoBody/GroundMotion/Animator trênsàntổnghợp, tốcđộmax lấySENKO_MOTION.max_speed=280, khôngnângspeedđểbùảnh.12ca:30/60/120Hz×Right/Left×yêucầudừng0/9. Hàmscenario chungđượcparametermotion,đường--walk-world160 cũvẫngiữWalk/120px/s. Đãchạylại13cawalkregression trênpackP.

Candidatechẩnđoán run-integration-v1 chỉghéppackP+runR;khôngđổiart/default. Tracepreview cuối resources/characters/senko-160/run-world-v2/index.html;captionghiđúnggiớihạntốcđộ/art/metadata. run-world-v1làtracekhảosátđầu.

Thêm72phasechecks vớiassetthật (54Walk→Run+18Run→Walk):Animator tiếp tụcMoving/budget, đợisync rồiđổigait, giữphasechuẩn. Harnessbanđầu nhầmtưởngđổingaymọiphase,nênfailởwalkphase1vìAnimatorđúngthiếtkếgiữWalkđếnsync. Đãsửaharnessđợicontactvàđốichiếuphaseởlúccommit,khôngsửaAnimatorđểtestpass.

## Kết quả cần sửa tiếp
-12/12cahoànthànhrun/brake/idle trênfloor;60Hz4cađềuđủ18frameRun. ĐâykhôngnativePresenthoặcstancecertification.
-Canonicalstart0/12khớp,stop0/12khớp:existingwalk_start/walk_stopdẫnvàoraảnhRunmới chưađúngtexturepose. Khôngnétestbằngaliasrunvớiwalkhoặcdùngclipkhácsai nghĩa; cầnảnhchuyểntiếprunriêngvàoptionalAnimatorwiringtươngứng.
-18drawings/128px ở280px/s = **39.375drawings/s**,không45. 45ở320px/s chỉclockpreviewthamchiếuvượtmaxmotor. Điều này đínhchínhgiớihạnbáocáoR/Q,khôngchứngnhận45FPSthựctrongrunner.
-Runchưacómetadatafootidentity/stanceđủ. Drift=0vì0mẫuannotatedkhôngcónghĩalàkhôngtrượt. Khôngthểnghiệmthufoot-locktừsố0này.

## Kiểm tra thực chạy
Tool20/20,Clippyassettool-Dwarnings,scopedfmt/diffcheckđạt. Audit12cases/72phasechecks,maxspeed280,full18Runframes4case60Hz;start/stopseamsfailnhưtrên,khôngbáoallgreenart. Regeneratewalk13casevìsharedtoolscenariođổi;productionphysicskhôngđổi. Script/logs/auditởai/logs/SENKO-ANIM-A04-S.
open_in_codex trảqueued,chưaxácnhậnbrowserplaybacklượtnày;khôngnativeQA/hardwarecadence/releasebuild/soak30phút mới. Appkhôngđổibinary/defaultpack.

## Bước tiếp trong phạm vi A04
1. Bổsung6tưthếtrunggiangốc đểlên24drawings/cycle128px:reference240px/s→45drawings/s,280→52.5drawings/s (gaittheoquãngđường,khôngép45mọitốcđộ). Khôngduplicatepad/đổimotor.
2. Ảnhstart/brake/stopRunriêngvớiđúng0/12sync saukhiđổicount,khôngdùngwalkclipgiảmquality. Kiểmtralegidentity/per-legcontact/footlock/loopjoin cùnglúc.
3. ChỉsauđónốicandidatechuyểntiếpvànghiệmthuA04;turnheight/pivot/cáchướng/armtailvẫncòn. KhôngsangA05..A09.
CHANGELOGbỏqua:cùngtínhnăngchưapháthành;khôngADR mới vìofflinetestharness,khôngđổiruntimecontract.
