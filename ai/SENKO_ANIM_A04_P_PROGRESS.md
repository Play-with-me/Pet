# A04-P — quay qua hướng sau và tour tám hướng,30/10/2026

## Phạm vi
TiếpA04 theoLeader sauO; Codexsảnxuấtart bằngbuilt-inimagegenvàtool/loader/Animator/QA liênquan. Khôngsubagent/Brain/body/motor/physics/planner/defaultpack/lockfilechange. Fetchoriginđãchạy,khôngmerge/switch/commit/push. Height/pivotfrontvẫnmở,khôngchuyểnA05.

## Nguồn và chỉnh art
Hai lượtimagegen (khôngCLI/API):
1. Sheet12pose6×2 ngang→3/4sau→lưng theo model02/03/04. Xem nguồn thấyđuôi nằmtráiđếnframe9rồi đổi sangphảiởframe10:khôngnhậnv1 làmcliptíchhợp.
2. Editgiữđầu/thân/quầnvàphase, yêu cầuđuôiquavịtrítrung gian. Sheetv2 cóđuôigiữaởframe8vàsangphảitừframe9, đỡbỏqua trunggian; chưachứngnhận mọi pha liên tục hoặc đủ45drawings/schấtlượng.
Nguồn/prompt giữ tại resources/characters/senko-160-source/turn-side-back-v{1,2}-raw.png và -prompt.txt; generated_images originals giữnguyên. Đãxem hai nguồn và atlasv2 trực tiếp qua view_image.

Tool--back-turn-keys160 dùngchungnormalizationmộtscale,khôngresizetừngframe. v2:12hìnhkhácnhau,31RGBAincltransparent,alpha0/255,baseline152,canvas160,scale2,height124..125px. Khôngsuyrange này thànhsửaheightfrontM124..127. Metadataanchor80,152 khôngtựchứngminh điểm xoay ngữ nghĩa.

## Tích hợp ứng viên
Partialpack side-sequence-turn-v2 thêm4edgeback vào4edgefrontN. Tổng8edge, mỗi8thamchiếu/177ms từ24tranhnguồnfront+back vàcanonicalidlealiases/đảo thứtự. Không64tranhmới. Loaderstrict kiểmtra8tên:timed/nonloop/mirror/endpoints;canonicalBackđầucuốikhôngmirror,nhưFront. Testruntime mởrộngLeft→Backđểkiểmtra frame cuối lưngkhôngbịlật;logicđiềukhiểnkhácgiữnguyên. ADR0122cậpnhật.

Tool--turn-tour160 tạoactualAnimatorfixedroot120Hz12giây theoRight→Back→Left→Front→Right, cóđoạngiữpose vàrespectcooldowncũ. assertđủmọiframecủa8edge. Preview resources/characters/senko-160/turn-tour-v1/index.html;JSONtracecùngfolder. TourkhôngdùngBrain/body/desktop;khôngđổimốcchờproductionđểđạtart.

## Kiểm tra thực chạy
- Render33/runtime299pass+1ignored/sharedfixtures2. Assettool19/19. Clippyassettoolvàruntime/renderalltargets-Dwarnings,scopedfmt/diffcheckđạt.
- Auditartv2 hardalpha/size/baseline/12unique/31colors/height124..125;pack8edgecanonicalendpoints/8refs177msđạt.
- NodeDOM/RAFstubplayer:64refs8edge cóimagefiles;readygate/pause/scrub/resetđạt. Đâyteststub,khôngbrowserGPU/cadence.
- Native test opt-in SENKO_160_REPLAY_TOUR=1 đọc tour120Hzsamplexuống60Hz, fixedHWND:1/1pass13.82s, cả8frame×8edgeđãPresent,Front/Backcanonicalunmirrored. Khôngsuy64framevisitslà64artdrawingshoặcthayQAthẩmmỹ.
- Test đầu thấtbại doassertwalk54framescũ áp vào tourđứngyên(0walk). Đãsửa riêngmode-tourkhôngđòiwalkcoverage,giữassertcũchomodetraceđi;chạylạifinalpass. Khôngsửaproductionđểchetest.
- Source normalization/player/candidateloaderthựcchạy;logs/scriptsởai/logs/SENKO-ANIM-A04-P. open_in_codex trảqueued,chưaxácnhậnbrowserplaybacklượtnày. KhôngQAliveDWM/hardwarecadence/releasebuild/soak30phút.

## Còn lại
Candidatecầnleaderxemfulltour,yaw/nộiseam/pivot/volumechưađóng. Heightfrontvẫnmở;arm-tailwalk/run/startstop/cáchướnggaitcònA04. Khôngtuyênbốđủtámhướngđi/chạy chỉvìđủtámđoạnquay. Appđangchạykhôngđổibinary/defaultpack. CHANGELOGbỏqua:cùngtínhnăngchưapháthành. Khôngxóanguồncũ.
