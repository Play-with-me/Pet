# A04-U — bắt đầu và dừng chạy riêng,30/10/2026

## Phạm vi và nguồn
Leader tiếp tục sau T. Built-in imagegen tạo18tư thế nội bộ cho3clip: bắt đầu chạy, dừng từ tiếp đất0, dừng từ tiếp đất12. Tham chiếu idle thật của partialpack, runframe0/12. Nguồn resources/characters/senko-160-source/run-transitions-v1-raw.png và exactprompt run-transitions-v1-prompt.txt; giữ bản generated_images gốc. Đã xem raw và atlas sau chuẩn hóa; chưa coi đó là nghiệm thu tự nhiên/cute.

Chỉ asset/tool/loader/Animator/test liên quan. Khôngsubagent/Brain/body/motor/physics/planner/defaultpack/dependency/lockfile/commit/push. Fetchorigin đã chạy. Không dùng quyền hoạt ảnh để sửa hành vi ngoài plan.

## Tích hợp
Tool --run-transitions160 chuẩn hóa18drawing bằngmột scalechung, neo eo/sole cho tư thế grounded; không cóflightởcácclipnày,khôngground lại vòngrun24. Thêmrun_start/run_stop/run_stop_sync12, mỗi8frame177ms,6drawingmới +2canonicalendpointreferences. Copy24PNG run byte-identical từT. Candidate resources/characters/senko-160/run-integration-v3,khôngfullpet.

Animator chọn optionalrun_start khi pack có,giữ đườngwalk_startcũ cho packkhôngkhai báo. ĐổigiaitgiữaStartinggiữtỷlệclock theođộdàiclip,khôngreset. Loaderrejectrun_startloop/distance/wrongcanonicalentryexit;run_stop/syncstopphảicócanonicalidleexit,mappedentry dùngcontractstop_clips đãcó. ADR0123.

## Kiểm tra thực chạy
- Runtime300pass+1ignored/render33/sharedfixtures2;tool20/20. Clippyruntime/renderalltargets vàassettool-Dwarnings,scopedfmt/diffcheckđạt.
- Test mớicórun_startngắn100ms so walk_start200ms: đổiRun→Walk→Run giữ25%progress, pause đóngbăng, Held/Fallngắt, malformedloopbịreject. Legacytests khôngoptionalclipvẫngiữkếtquả.
- Body/GroundMotion/Animator12ca30/60/120Hz×2hướng×2pha: canonicalstart12/12 vàstop12/12đạt, so với0/12 ởS/T.78switchphasechecksđạt. Chỉkhẳngđịnhcanonicalboundary,khôngtựchứngnhậnnộiseam.
- Native1/1pass13.06s trên4trace60Hz haihướng/haiphadừng, đủ8frameRunStart/24Run/8mappedStopPresented. Mởrộngtestchọnmotion bằngenvSENKO_160_REPLAY_MOTION, mặcđịnhwalkgiữcũ. Khôngphépđocadence/hardware/liênhệliveDWM/QAthẩmmỹ.
- Audit18newunique/32RGBA/hardalpha/160/khôngclipping,3clip8refs177ms,24runPNGbytegiữ,12/12startstop,78checksđạt. Traceworld-v5 đãnative chạy giốngbyte vớiworld-v6 (chỉcaptionHTMLsửađểkhôngbáosai“vẫndùngwalkclip”).
- Walk13casehồi quy dùngpackcũ:mọirowtrace giống chínhxácwalk-regression-s trướcoptionalrun_start. KhôngsuythànhtoànbộlegacyGPUQA.
- Loader saugateRunStopcuối đượckiểmtra trực tiếp qua --manifest-player trêncandidate thànhcông. Khôngbuildrelease/soak30phút; appđangchạy/binary/defaultgiữnguyên.

Previewchính resources/characters/senko-160/run-world-v6/index.html. Player xemriêngclip:run-startstop-review-v1/index.html. open_in_codex trảqueued,chưaxácnhậnbrowserplaybacklượtnày. Logs/audit tại ai/logs/SENKO-ANIM-A04-U.

## Còn lại
Leaderduyệtđộtựnhiênnộibộclip,volume/legidentity/stance/worldfootlock vàloopjoin. Runchưađượcnghiệmthuđầyđủ chỉvìcanonicalaliases/nativegreen. A04cònarmtail/cáchướnggait/turnpivot;chưaA05..A09. CHANGELOGbỏqua:cùngtínhnăngchưapháthành. Giữcácnguồn/packcũriêng,khôngxóadữliệu.
