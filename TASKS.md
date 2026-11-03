# Bảng nhiệm vụ

Cập nhật: 25/10/2026.

| ID | Bên | Phạm vi | Trạng thái | Cho phép |
|---|---|---|---|---|
| DOC-01 | Codex | Tạo bộ phân công ban đầu | Hoàn thành trước đây | Người dùng giao trong chat |
| DOC-02 | Codex | Khôi phục sáu tài liệu bị xóa; không sửa ứng dụng | Hoàn thành | Người dùng giao trong chat |
| DOC-03 | Codex | Tạo bản đồ cây, module, liên kết tài liệu/mã và danh mục tự sinh trong workspace Pet | Hoàn thành | Người dùng giao trong chat; được cập nhật hướng dẫn điều hướng |
| DOC-04 | Codex | Cài công cụ sơ đồ miễn phí và tạo sơ đồ dùng chung với Antigravity | Hoàn thành | Người dùng giao trong chat |
| DOC-05 | Codex | Tổng hợp kế hoạch cho Gen; đọc MSG-001 và phản hồi tại SYNC theo yêu cầu người dùng | Hoàn thành | Người dùng giao trong chat |
| DOC-06 | Codex | Ghi vai trò leader và quy ước Codex–Gen trực tiếp phối hợp; thông báo Gen qua SYNC | Hoàn thành | Leader chỉ đạo trực tiếp trong chat |
| DOC-07 | Codex | Thêm luật không tự ý đổi chức năng, phải báo leader ngay và chờ duyệt; nhắn Gen | Hoàn thành | Leader chỉ đạo trực tiếp trong chat |
| DOC-08 | Codex | Lưu ảnh desktop leader cung cấp, xác định mốc chiều cao pet theo mèo và báo Gen | Hoàn thành | Leader yêu cầu kích thước bằng mèo và gửi ảnh tham chiếu |
| AUDIT-01 | Codex | Kiểm tra tiến độ dựa trên Git, mã nguồn, EXE và lời nhắn | Hoàn thành; companion chưa triển khai, MSG-096 báo tiến độ không khớp bằng chứng | Leader yêu cầu kiểm tra dự án đã làm chưa |
| COMP-01 | Codex | Triển khai kế hoạch companion Rust, khảo sát nền và kiểm tra điều kiện build trước | App gốc chạy smoke exit 0; quality gate còn lỗi test topmost; companion chưa code | Người dùng yêu cầu triển khai kế hoạch đã duyệt |
| C-01 | Codex | Rà soát repository, hợp đồng và quyền file; chạy baseline BongoCat gốc | Đã có kết quả: dev-smoke 0, just check 101; xem ai/BASELINE_REPORT.md | Leader yêu cầu chạy baseline ngay sau MSG-016 |
| A-01 | Antigravity | Rà soát asset, lập manifest | Chưa bắt đầu | Chưa giao |
| C-02 | Codex | Tích hợp và kiểm tra logic/fallback | Chưa bắt đầu | Chưa giao |
| A-02 | Antigravity | Hoàn thiện hình ảnh theo hợp đồng | Chưa bắt đầu | Chưa giao |
| C-03 | Codex | Build và thử bản Windows | Chưa bắt đầu | Chưa giao |

Trước nhiệm vụ mới ghi: người giao, repo mục tiêu, ID, bên thực hiện, file được sửa
và điều kiện hoàn thành. Chỉ sửa bảng tuần tự; song song thì ghi tiến độ vào bàn giao
riêng. Không tự bắt đầu mục “Chưa giao”. Phân công file phải dựa trên mã hiện có.

## Senko v3 — kế hoạch S2–S5 Leader giao 27/10/2026

| ID | Chủ sở hữu lượt | Trạng thái | Kết quả/phụ thuộc |
|---|---|---|---|
| S2-01 | Codex, ngoại lệ asset theo lệnh trực tiếp | Có bộ ứng viên, chờ nghiệm thu hình |233PNG/45clip, đủ ma trận8hướng; giữ141PNG gốc |
| S2-02 | Codex | Mã và kiểm tra đạt |SpriteLibrary/manifest/mask/per-frame timing |
| S2-03 | Codex | Windows GPU kiểm tra đạt |Nearest riêng,320×320,4×4pixel;macOS chưa build/QA |
| S2-04 | Codex | Mã và kiểm tra đạt |Animator distance/turn/transition/pause |
| S2-05 | Codex | Mã và kiểm tra đạt |Dừng mọi pha, budget an toàn/đặt chân tại chỗ, ngắt bế/rơi |
| S2-06 | Codex | Tích hợp, release mở để duyệt |Runner manifest, foot anchor, --legacy rõ ràng, launcher/shortcut mới |
| S2-07 | Codex + Leader nghiệm thu | Leader duyệt chuyển động ngày28/10/2026 |“Ổn rồi, bạn tiếp tục dự án đi”; bản candidate-v5-flow |
| S3-01 | Codex | Hoàn thành mã nền và kiểm định |Physical pixels, foot/HWND/grip, snapshot thuần vàgeneration; live body thay ởS3-04 |
| S3-02 | Codex | Mã/kiểm định scanner đạt; foreground kiểm tra bằng sự kiện tổng hợp |DWM/WinEvent,500ms fallback,gom sự kiện,IDgeneration,RAIIhook; đã nối tick, chưa cósurfacephysics |
| S3-03 | Codex | Hình học/clearance và kiểm định đã có |Gờ/tường trừ che,standing/climbing/mantle; native cặpDWM cô lập,đổiZ-order native cònchờQA |
| S3-04 | Codex | Đã nối body/world và kiểm định |Swept landing, support/carriage/loss, gravity1800, balance; native DWM/body harness và session riêng |
| S3-05 | Codex | Đã có planner/follower và nối runner |Đi/leo/mantle/hop/jump/drop, kiểm lại world, cache thất bại; native DWM/Animator harness, chưa QA tay tổng thể |
| S3-06 | Codex | Mã và kiểm định trong phạm vi đạt | Cache/display/DPI320×320, sàn tiếp giáp/gap/recovery; native thông điệp tổng hợp đạt, mixed-DPI/unplug phần cứng còn QA S3-07 |
| S3-07 | Codex | Đã sửa topmost, còn QA tay/hardware | Overlay122đạt/18ignored,session11/scanner11 đạt;release mới mởPID41452. Monitor30phút thuộc hash trước. Xem ai/SENKO_S3_07_QA.md |
| S4-01 | Codex | Mã, kiểm định và release đạt trong phạm vi | Context foreground/idle/fullscreen250ms,tạmRAM/redacted;6testoverlaygồm2native và2testruntime. Xem ai/SENKO_S4_01_CONTEXT.md |
| S4-02 | Codex | Mã, kiểm định và release đạt trong phạm vi | SenkoBrain4Hz/utility/route khả thi/cam kết/cooldown/FIFO10; mô phỏng9test và native session. Xem ai/SENKO_S4_02_BRAIN.md |
| S4-03 | Codex | Mã, kiểm định và release đạt trong phạm vi | PointerTracker16mẫu/600ms, lọc mục tiêu/Glance một lần, giữ cam kết và hướng trên thân; xem ai/SENKO_S4_03_POINTER.md |
| S4-04 | Codex; Gen sở hữu art P2 | P1 headpat đã nối, Tail/P2 có logic chờ ảnh | Frame/alpha/mirror233frame, Tail46core bảo thủ; native capture/hover đạt. Xem ai/SENKO_S4_04_TOUCH.md |
| S4-05 | Codex | Tiếp theo, chưa bắt đầu | Phản ứng ứng dụng/idle/chăm sóc50phút |
| S4-06..S4-07 | Codex; phối hợp asset đúng quyền | Chưa bắt đầu | Memory/QA GĐ4 |
| S5-01..S5-05 | Theo quyền sở hữu asset/tích hợp | Chưa bắt đầu |Sau GĐ4:P2/tối ưu/benchmark/QA30phút |

Kế hoạch đã được Leader giao, nhưng cổng nghiệm thu từng giai đoạn vẫn giữ nguyên.
Bảng cũ phía trên là lịch sử; không dùng trạng thái C-03 cũ để phủ nhận bằng chứng
Senko mới hoặc đánh đồng S2-07 với việc Leader đã nghiệm thu.

### SENKO-G2-GAIT-FIX — bổ sung sau phản hồi Leader
S2-01/S2-04/S2-06 được sửa: v4-cute-gait217PNG45clip thay2gait ngang; đi/chạy theo
displacement và chuyển tại contact không restart liên tục. Mã/native đạt, còn
1test topmost trong suite chưa đạt; chi tiết ai/SENKO_G2_GAIT_FIX.md. S2-07 vẫn
chờ Leader đánh giá nét dễ thương/chuyển động, không chuyển GĐ3 trước nghiệm thu.

### Cập nhật SENKO-G2-FLOW — 28/10/2026
- Bản chạy mới candidate-v5-flow:16pha đi/chạy ngang và ease vận tốc start/arrival/stop; giữ201PNG ngoài gait. Kiểm tra kỹ thuật đạt theo ai/SENKO_G2_FLOW_FIX.md; GĐ2 vẫn chờ Leader nghiệm thu chuyển động, chưa GĐ3. Chưa soak30phút binary mới.





### S4-05-A (28/10/2026)
Đã có policy app/idle/care, nối idle clip và app utility bias; chưa hoàn tất S4-05. Còn worldevent/concern/energy nghỉ và native idle context QA; P2 chờ ảnh. Xem ai/SENKO_S4_05_CARE.md. S4-06 chưa mở.


### SENKO-RP — kế hoạch thay thế đã được Leader giao (28/10/2026)
Đặc tả: ai/SENKO_REACTION_PHYSICS_PLAN.md. R01 đã đồng bộ; P01/P02 và một phầnP03 có prototype/tests, chưa đóngP01..04; R02..07 chưa triển khai theo thiết kế mới. R08 yêu cầuGen quaMSG238/chờpreviewduyệt, R09 chưa mở. Tạm giữ S4-06/phần mới. Chi tiết ai/SENKO_RP_PHYSICS_PROGRESS.md và preview ai/logs/SENKO-RP-PHYSICS/index.html.

### SENKO-RP-P04-A (29/10/2026)
Signedmotor/Animator/relativeimpact/translatingflight có mã và kiểm định, releaseA45682B8... đã mở. Chưa đóng toànP04; xem ai/SENKO_RP_P04_PROGRESS.md. R02..07/R08/R09 chưa hoàn thành; S4-06 tiếp tục giữ.


### SENKO-RP-P04-B (29/10/2026)
Movingwallcatch/mantleclipprogress/landingrecovery có mã, kiểm định và releaseF97E98E6...; P04 còn visual/contact/leo-momentum theo ai/SENKO_RP_P04_B_PROGRESS.md. R02..09 chưa hoàn tất, giữ S4-06.


### SENKO-RP-P04-C (29/10/2026)
Lõi motorleo/traversalmomentum/climbcontactphase có kiểmđịnh và release6BFDB5BD...; nghiệmthuvisual/contact/hardware/30phút còn mở. TiếpR02 trongcùngđợtnângcấp; không S4-06. Xem ai/SENKO_RP_P04_C_PROGRESS.md.


### SENKO-RP-R02 (29/10/2026)
Coreemotion/episode có mã và test; liveemotionobserver đã nối, episodeactor/biểucảm/lựa chọn mới chờ R03/04+artđúng. ReleaseCD59AA1E... đang mở. Xem ai/SENKO_RP_R02_PROGRESS.md. R03..09 chưa hoàn tất, giữ S4-06.


### SENKO-RP-R03 (29/10/2026)
Invite/notice/fixedoffer/farewell có logic và runner; P1Look episode đã live/nativeproof. ArtPlay/farewell chờGen, QAchuộttay còn mở. Release78093347...; xem ai/SENKO_RP_R03_PROGRESS.md. TiếpR04 trong cùngđợtnângcấp, giữ S4-06.


### SENKO-RP-R04 (29/10/2026)
Luna codepolicy, Max runner/tests, Codex review và finalchecks: moodtouch/anti-repeatreward/quietreassurance có mã/nativeproof và releaseD2C3A115...; cònart/Headpat4phasehandover/visualacceptance. Runtime261+2fixture/render30/session20 đạt. Xem ai/SENKO_RP_R04_PROGRESS.md; chưa mởS4-06/phần mới.

### SENKO-RP-R04-B (29/10/2026)
Headpat4phase/actualpresentedIDreward có mã và kiểmđịnh; Luna/Maxcode, Codexreview/finalQA. Runtime269+2fixture/render30/session24 đạt, release06FA679F... mở. Cònart/visualacceptance R04 vàQA tay/30phút, khôngmởS4-06/phầnmới. Xem ai/SENKO_RP_R04_B_PROGRESS.md.

### SENKO-RP-R05 (29/10/2026)
Codex tự làm theo yêu cầu ngừngsubagent. Lõi handling/contactemotion đã nối và kiểmđịnh: runtime276+2fixture/render30/session25/build/smoke đạt, release60F5C853... mở. Lift/guarded/landingvariant/dust/dizzy art vàvisualacceptance còn thiếu; không đóngnghiệmthuR04/R05. R06/R07/S4-06 chưa mở. Báocáoai/SENKO_RP_R05_PROGRESS.md.

### SENKO-RP-R06 (29/10/2026)
Codex tự làm, khôngsubagent. Corewindow/media đã nối và kiểmđịnh: Work/Mediautilitykhôngquiet, visiblewindow/foregroundcoalesce, SMTCPlaying/Paused/Unknown read-onlyworker. Runtime284+2fixture/render30/session25/media4/nativeDWMobserver1/build/smokeđạt; releaseD6BED9C0... mở. Music/surpriseart vàR04/R05visual cònthiếu; R07tiếp, giữS4-06/phầnmới. Báocáoai/SENKO_RP_R06_PROGRESS.md.

### SENKO-RP-R07 (29/10/2026)
Codex tự làm. Corecontextualrest/actualposturerecovery/return/greet/care50-30-5 +phase/token/visible-route cómã/harness, P1sleep-wake đãnativeproof/preview. Runtime294+2fixture/render30/session27/build/smokeđạt; release4800A871... mở. P2greet/tea/stretch/offeractualfeedback/propboundsvàR04..06artcòntiếpR08, chưanghiệmthutổngthể/30phút/S4-06. Báocáoai/SENKO_RP_R07_PROGRESS.md.

### SENKO-RP-R08-A (29/10/2026)
Codex tự làm, tái sử dụng surprise P1 vào sự kiện cửa sổ mới. Runtime295+2fixture/render30/native27/Clippy/build/smoke5s đạt; release500C4114... mở. Chưa nativeproof riêng Surprise, chưa R08 tổng thể/R09/30phút. Ma trận ảnh và hợp đồng Gen: ai/SENKO_RP_R08_PROGRESS.md; không sửa asset/manifest, không mở S4-06.

### SENKO-RP-R08-B (29/10/2026)
Surprise có nativeproof riêng với snapshot tiêm: 4phase/3presentedframe/onecompletion, Grab/Held/captureCancel/airborne. Native29/29/Clippy/build/smoke đạt, release2AAD96BB... mở. Preview ai/logs/SENKO-RP-R08-B/index.html. R08/P2 toàn thể vẫn chờ Gen, chưaR09/30phút/S4-06. Báo cáo ai/SENKO_RP_R08_B_PROGRESS.md.

### SENKO-RP-R08-C (29/10/2026)
Thêm read-only --audit tiếp nhận asset: asset-tool12/12, auditv5 45clip/233frame/runnerValid, Clippy/fmt/diffcheck đạt. Không sửa gameplay/asset hoặc buildrelease mới. Gen/P2/preview còn chờ, không đóngR08/R09/S4-06. Xem ai/SENKO_RP_R08_C_PROGRESS.md.

### SENKO-RP-R08-D (29/10/2026)
Leader giao Codex thay Gen làm P2. Nhóm đầu4clip24frame đã có nguồnAI/PNG80/manifest/GIF/previewv5beforeafter trong candidate-attention-v1; audit4/24/tool12/12/Clippy đạt. Còn duyệt nét/hướng/pose transitions trước tích hợp; các nhóm khác tiếp sau. Không còn chờ Gen để sản xuất, không sửa bộ đang chạy/R09/S4-06. Xem ai/SENKO_RP_R08_D_PROGRESS.md.

### SENKO-ANIM-A01/A02 —29/10/2026
Bắt đầuplan160/45FPSđãduyệt. Inventory75mục/baseline30mẫu; model-v1 12PNG160/keypose5hướng đãcópreview, chờduyệtA02trướcmassproduction. Tool13/13/Clippyđạt, chưađổiapp/A03native160/A09. Báocáoai/SENKO_ANIM_A01_A02_PROGRESS.md.

### SENKO-ANIM-A03 —29/10/2026
A02đãleaderduyệt. Nền160loader/masks/regions/scale/45clockđãtest: render32/runtime295/tool13/native30/Clippy/build/smokeđạt. A03chưađầyđủcontacts/player/fullsession160; chưa45FPSart/packdefaultchange/A09. Xemai/SENKO_ANIM_A03_PROGRESS.md.

### SENKO-ANIM-A03-B / A04nguồn —29/10/2026
Nền160contacts/player/fullsession/controlsđãtest, render32/runtime296/tool13/native31+controls1601/JScontractđạt. TiếpA04: nguồnwalkside12keypose mới có, chưagaitQA/45FPS. Hardwarecadence/contactsartthật/fullbudget/soakA09vẫntheođõi, khôngđổidefaultpack. Báocáoai/SENKO_ANIM_A03_B_PROGRESS.md.

### SENKO-ANIM-A04 —29/10/2026
Walksidecandidate36PNG160/800ms/96pxcycle cóaudit/player, tool14/14; chưaduyệtgait/volume/seam, chưaintegrate. Lượt bịngắt, reportai/SENKO_ANIM_A04_PROGRESS.md, tiếp sửaquality trước run/cáchướng.

### SENKO-ANIM-A04-C —29/10/2026
Sửanguồnpha/guides/interleave, candidate36v3giảmheightvariation123..125; tool15/15/Clippy/auditđạt. Cópreviewso sánh. ChưađóngA04/visualgait/contact/sync hoặcintegrate, tiếpqualitywalkside. Xemai/SENKO_ANIM_A04_C_PROGRESS.md.

### SENKO-ANIM-A04-D —29/10/2026
Sửa footpatch10/28 và contacts mẫu6frame; tạo12keypose start/stop; sửa AnimatorSettling160 đúng45FPS,80giữcũ. Render32/runtime297/tool16/native31/Clippy/build/smokeđạt. Artcandidate chưaintegrate/A04complete. Previewwalk-review-v5.html/reportai/SENKO_ANIM_A04_D_PROGRESS.md. Lượt bịngắt, tiếpfullcontact/startstopinbetweens/nativeactualgait.

### SENKO-ANIM-A04-E —29/10/2026
Đãstart9/200ms vàstop10/240ms/canonicalseams, chuỗiAnimator thậtphải/trái, nativeactualart1/1(9/36/10/Pause/Idle),tool16/16/Clippyđạt. Partialside-sequence-v1 khôngfullrunner/defaultpack, A04còncontact/sync/movingbody/turn/run/hướngkhác. Xemai/SENKO_ANIM_A04_E_PROGRESS.md.


### SENKO-ANIM-A04-F — 29/10/2026
Harness body/sàn tổng hợp 12 ca dừng + 1 quay đầu; sửa stop_clips theo sync0/18: 6 điểm nối sai → 12/12 đúng, tọa độ/vận tốc body trước/sau giữ nguyên. Render33/runtime298+2fixture/tool17/native33/Clippy/build/smoke đạt. Preview moving-world-v5/index.html; báo cáo ai/SENKO_ANIM_A04_F_PROGRESS.md, ADR0118. Contact toàn chu kỳ và quay đầu45FPS còn thiếu; A04 chưa đóng, app vẫn v5. Không Brain/physics/defaultpack/subagent/commit/push.


### SENKO-ANIM-A04-G — 29/10/2026
Sửa normalize160_gait neo eo thay vùng quần rộng; chỉ tool xuất walk/footpatch, không productionruntime. Candidate walk-waist-36-v7 giữ36frame/96px/800ms, patch10/28; preview waist-review-v1 so trước/sau và raster36/36. Tool18/18/Clippy/fmt/diff/artifact+JSclock10s30/60/120 đạt; không native/buildrelease mới. Hai source AI12pose v3/v4 bị loại vì pha chân sai, alpha0 nền đã xác nhận (đính chính nhận xét nền nâu). Còn stance/contact ngữ nghĩa và quay đầu/run/hướngkhác; A04 chưa đóng/defaultpack vẫn v5. Xem ai/SENKO_ANIM_A04_G_PROGRESS.md/ADR0119. Không subagent/commit/push.


### SENKO-ANIM-A04-H — 29/10/2026
Leader yêu cầu sửa chân vung nhanh. Ứng viên tempo1200ms/144px thay800ms/96px tại cùng120px/s; không motor/physicschange.36PNG giữ nguyên,30drawing/s chứ chưa45FPS (cần54tranh thật). Preview tempo-review-v2 so clock/manifest riêng; side-sequence-tempo-v4 + tempo-world-v1 có12/12seams và13case. Tool18/Clippy/fmt/diff/artifact/JS/native chuyên biệt1đạt; không release/defaultswitch. Còn sửa stance và18inbetweens thực, A04 chưa hoàn tất. Report ai/SENKO_ANIM_A04_H_PROGRESS.md/ADR0120. Không subagent/commit/push.


### SENKO-ANIM-A04-I — 29/10/2026
Sửa dáng đi thật thay chậm clock:54tưthế từ nguồn vector chân mới,60%stance/chân,double support12/54frame,khôngflight,clearance3.5nativepx.131hàng trên giữ pixel model; khôngwarp ảnh hoặc productionphysicschange. 8nguồnAI thử không được nhận làm loop, exactprompt trongA04_I_PROVENANCE.json. Pack cuối walk-grounded-54-v7; preview walking-review-v5; world walking-world-v2/partialside-grounded-v5. Tool19/Clippy/fmt/diff/audit/JS/native1 đủ54walk+10stop haihướng đạt. A04 chưa duyệt chất lượng/arm-tail/transitions/run/hướngkhác, defaultv5/A09 giữ. Report ai/SENKO_ANIM_A04_I_PROGRESS.md/ADR0121; không subagent/commit/push/releasebuild.


### SENKO-ANIM-A04-J — 29/10/2026
Leader báo lỗi hình A04-I. Đã xem browser thực bằng nativeCUA: mask xóa hakama thành chân dài/góc cạnh. Sửa giữ146hàng gốc và mép gấu, chỉ thay cổ chân/tabi, tabi đầy hơn. Final walk-grounded-54-v11, sourcewalk-grounded-v6, previewwalking-review-v7 đã ràframe13/phải và27/mirror trongbrowser;v6đãràcontact0. Tool19/Clippy/fmt/diff/audit/JS/native1 đạt; phase/physics/defaultpack không đổi. Replaybodytracecũ hợp lệ cùngmetadata, khôngclaim13caseworldmới. Report ai/SENKO_ANIM_A04_J_PROGRESS.md, A04_J_REPAIR.md. A04/A09chưađóng, khôngsubagent/commit/push/releasebuild.

### SENKO-ANIM-A04-K — 30/10/2026
Leader duyệt J, tiếp tục A04: chuyển tiếp start/stop0/stop27 cùng silhouetteJ, partialside-grounded-v8/previewtransitions-review-v2.14/14/18 hình riêng/400ms saugộphold, chưa45drawing/s hoàn chỉnh. Audit alpha/upper146/contact/endpoints +SpriteLibraryplayer đạt, đã xem montage; chưa native/playback/release mới/defaultswitch. Report ai/SENKO_ANIM_A04_K_PROGRESS.md. Không runtime/Brain/physics/subagent/commit/push; A04 còn mở.

### SENKO-ANIM-A04-L —30/10/2026
Tiếp K: actualBody/GroundMotion/Animator13ca mới trên side-grounded-v8;12/12canonicalstopseams. Native test mở rộng đủhai sync×hai hướng:1/1đạt,bốntrace60Hz đủ54walk và14/18stopPresented. Sửa sequence-report metadata cũ; khôngPNG/timing/productionlogicchange. Previewtransitions-world-v1,open queued chưaxácnhậnbrowser. Report ai/SENKO_ANIM_A04_L_PROGRESS.md;A04cònarm-tail/turn/run/hướngkhác,defaultv5giữ. Khôngsubagent/commit/push/releasebuild;CHANGELOGbỏqua.

### SENKO-ANIM-A04-M —30/10/2026
Nguồnturn ngang→front12hình mới bằngbuilt-inimagegen/modelrefs,toolturn160/singlescale/hardpalette/player. Packturn-side-front-v1/previewturn-review-v1,266ms/12unique,height124..127;endpoint/pivot/volume cònrà,chưaAnimatorintegration. Tool19/Clippy/audit11hash/fmt/diffđạt;đãxemsource/atlas,chưa browserplayback/native/release. Reportai/SENKO_ANIM_A04_M_PROGRESS.md. A04còn mở,khôngBrain/physics/default/subagent/commit/push;CHANGELOGbỏqua.

### SENKO-ANIM-A04-N —30/10/2026
Optionalauthoredturnedges nốiAnimator/loader,v4clip8refs/177ms từ12artM+canonicalendpoints,partialside-sequence-turn-v1. Runtime299/render33/fixtures2/Clippyđạt;13worldcasesmới/reversalđủ8frames×4turn. Pause/Held/Air/frontmirror/invalidlooptestđạt. Previewturn-world-v2;khôngnative/browserplayback/release/defaultswitch. Height124..127/pivotcònrà,A04chưađóng. Reportai/SENKO_ANIM_A04_N_PROGRESS.md/ADR0122. KhôngBrain/physics/subagent/commit/push;CHANGELOGbỏqua.

### SENKO-ANIM-A04-O —30/10/2026
Thửimagegen sửaheightturnv2,đocùngscalevẫnh124..127 nênkhôngnhận/khônglắpvàopackN. Nguồn/prompt/READMEgiữriêng. Bổsungnativereplayturnmode,testcuối1/1đủ8frame×4turn/frontmirror;nativewalkregression1/1cả4traceđạt. Chỉtestcode/asset thử,khôngproduction/default/releasechange. Reportai/SENKO_ANIM_A04_O_PROGRESS.md. Height/pivotvẫnmở,A04chưađóng;khôngsubagent/commit/push,CHANGELOGbỏqua.

### SENKO-ANIM-A04-P —30/10/2026
Backturn12artmới,imagegen2lượt(v1đuôinhảyloại,v2cócenterpose);height124..125/31RGBA/alphađạt. Candidate side-sequence-turn-v2 có8edge×8refs177ms,24artfront+back/aliasreverse,không64art. Loader/backcanonicalmirror+runtimeunitmởrộng;runtime299/render33/fixtures2/tool19/Clippyđạt. TouractualAnimator120Hz vànative8edge1/1đủframesPresented;Nodeplayerđạt. Previewturn-tour-v1(openqueued),reportai/SENKO_ANIM_A04_P_PROGRESS.md/ADR0122. Pivot/yaw/heightfront/gaitkháccònA04,khôngdefault/Brain/physics/subagent/commit/push;CHANGELOGbỏqua.

### SENKO-ANIM-A04-Q —30/10/2026
Run18source×2lượt chưađạtcontact9. Pháthiệncuttercũcropbỏcellorigin,sửa riêngrunfixed6×3/commontransform,unitgiữ4pxflight. Sourcev2saufixvẫnclearance9=4pxnênstrictdistancegate từchối. Finaltime-onlyrun-review-only-v1/player run-review-v2,18unique/400ms/32RGBA,khôngrun_side/sync;khôngtíchhợp. Tool20/Clippy/audit/clock10sđạt,khôngnative/browser/release/defaultchange. Reportai/SENKO_ANIM_A04_Q_PROGRESS.md. A04run/kháccònmở,khôngBrain/physics/subagent/commit/push;CHANGELOGbỏqua.

### SENKO-ANIM-A04-R —30/10/2026
Sheeteditrunv3vẫn9clearance3px→loại. Tạo4groundedkeysimagegen/patch0,1,9,10,mộtscalechung/soleregistercontact;14framekhácbytegiữ. Run-contact-v1/previewrun-review-v3:contact0/9=0/0px,flight5/14=5/3px,height124/122,18unique400ms128px. Tool20/Clippy/audit/clockđạt;textureIDindexbugtoolđãsửavàCLIrerunpass. Nộiseam/legidentity/footlockchưachốt,khôngruntime/default/release/native/browserclaim. Reportai/SENKO_ANIM_A04_R_PROGRESS.md. KhôngBrain/physics/subagent/commit/push,CHANGELOGbỏqua,A04mở.

### SENKO-ANIM-A04-S —30/10/2026
Runworldharness12caBody/motor/Animator thật,max280;4ca60Hzđủ18Runframe.72switchphasechecks đợisync/giữMovingđạt;harnesssaiassumptionimmediateswitchđãsửa,khôngruntimechange. Start/stopcanonical0/12đúng→cầnrunarttransitionriêng.18/128 ở280 chỉ39.375drawing/s→cầnbổsung6artthậtlên24/reference240=45,khôngmotorchange. Runfootmetadatachưađủ/chưacertstance. Previewrun-world-v2,reportai/SENKO_ANIM_A04_S_PROGRESS.md. Tool20/Clippy/walk13regressionđạt;khôngnative/default/release/Brain/physics/subagent/commit/push,CHANGELOGbỏqua,A04mở.

### SENKO-ANIM-A04-T — 30/10/2026
Thêm6artimagegen vào18R→24unique, giữ18PNGbytes/128px,sync0/12,flight7/19. Run-24-v2 sửa neo x theo eo của6hình mới, không scale riêng/groundflight. Reference240→45draw/s,max280→52.5;clock533ms làxấp xỉ533.333,10s sai<=1frame. Bodytrace12ca/78switchchecks/24framesseen60Hz/tool20/Clippy/auditđạt. Previewrun-world-v4;reportai/SENKO_ANIM_A04_T_PROGRESS.md. Startstop/stance/volume còn,khôngproduction/default/native/release/Brain/physics/subagent/commit/push;CHANGELOGbỏqua,A04mở.

### SENKO-ANIM-A04-U —30/10/2026
18newart/3runstartstopclip8refs177ms,canonicalidle/run0/run12,nốiooptionalrun_start/stop_clips. Startingđổigiaitgiữprogress;loaderstrictstartstop,ADR0123. Runtime300/render33/fixtures2/tool20/Clippy/auditđạt;12/12startstopseams/78switchchecks,native1đủ8start24run8stophaihướng. Walk13tracegiốngS. Previewrun-world-v6,reportai/SENKO_ANIM_A04_U_PROGRESS.md. Nộiseam/legidentity/stance/volumecònA04;khôngdefault/release/Brain/physics/subagent/commit/push,CHANGELOGbỏqua.

### SENKO-ANIM-A04-V —30/10/2026
Walk3/4trước12keymớiimagegen2lượt:layoutv1bịcliploại,v2spaced3×4/silhouetteregistration→packwalk-34-keys-v3.12unique31RGBA/hardalpha/time-only10Hz1200ms,khôngdistance/45FPSintegration,height124..130cầnrà. Previewwalk-34-review-v1bannerrõkey-only;tool20/Clippy/auditđạt,khôngnative/browser/release/defaultchange. Reportai/SENKO_ANIM_A04_V_PROGRESS.md+LOCOMOTION_STATUSmatrix. KhôngBrain/physics/subagent/commit/push,CHANGELOGbỏqua,A04mở.

## A04-W/X — cập nhật 31/10/2026
Đi 3/4 trước có18key/1200ms/15hình-s; hai pack54frame chưa đạt nét mặt. Preview X thử giữ đầu bằng lớp Canvas, PNG nguồn không đổi; kiểm tra offline54frame và tool20/Clippy đạt. Còn duyệt tóc–cổ/stance/volume, chưa tích hợp production hoặc hoàn thành A04. Báo cáo: ai/SENKO_ANIM_A04_W_PROGRESS.md và ai/SENKO_ANIM_A04_X_PROGRESS.md.

## A04-Y —31/10/2026
Bổ sung CLIwalk34-contact160 và preview walk-34-contact-review-v2:phase theo144px/54frame,sànmốc/zoomchân/frame-step/mirror/pause/tốcđộ,carriage táchphase. Tool20/Clippy và offline actualJS54frame+12cadence/speedcases đạt;PNGsource bytegiữ. Chỉharness,khôngBody/OSnative/production/default;artstance/volume/nối cònA04. Báo cáo ai/SENKO_ANIM_A04_Y_PROGRESS.md. Khôngsubagent/commit/push;CHANGELOGbỏqua vìchưapháthành.
