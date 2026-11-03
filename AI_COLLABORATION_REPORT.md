# BÁO CÁO PHÂN CÔNG VÀ QUY TẮC PHỐI HỢP AI

Ngày khôi phục: 24/10/2026. Chủ dự án: người dùng.
Các bên thực hiện: Codex và Antigravity.

**Luật duyệt chức năng leader vừa bổ sung:** Không AI nào được tự ý thêm/bớt/sửa
chức năng hoặc hành vi khác nội dung đã duyệt. Nếu phát sinh đề xuất/nhu cầu hoặc
phát hiện thay đổi ngoài duyệt, báo leader ngay trong chat và dừng phần liên quan
chờ đồng ý rõ ràng; ghi SYNC để đồng đội biết. Hai AI không duyệt thay leader.
Xem chi tiết tại [TEAM_PROTOCOL](ai/TEAM_PROTOCOL.md). Quy tắc này ưu tiên hơn
cách diễn đạt cũ về “thay đổi lớn” hoặc chỉ “ngoài kế hoạch”.

**Ủy quyền phối hợp trực tiếp của leader:** Hai AI được trao đổi kỹ thuật, yêu cầu
kiểm tra và chia nhỏ việc trong kế hoạch đã giao, không yêu cầu người dùng chuyển
lời. Xem [quy ước team](ai/TEAM_PROTOCOL.md). Điều này cập nhật quy tắc trao đổi cũ;
không cho phép tự mở rộng phạm vi, sửa chéo file hoặc tự tạo lịch chạy nền.

**Cập nhật quyết định người dùng ngày 24/10/2026:** Đã chọn Rust BongoCat để phát
triển người bạn người que hiếu động có vật lý; không chọn Python Hybrid/mèo gõ phím.
Đọc [bản tổng hợp](ai/PROJECT_MASTER_PLAN.md) để nắm kế hoạch hiện tại và
[SYNC](ai/SYNC.md) để đọc trao đổi. Bảng file Python bên dưới chỉ còn là lịch sử;
không dùng nó để thay đổi hướng đã chốt.

## 1. Phạm vi và hiện trạng

Bản phân công ban đầu dành cho DeskBuddy: pet desktop Windows dùng Python,
PyQt5 và pynput, chạy cục bộ, ưu tiên nhẹ, chi phí vận hành bằng 0.
Codex phụ trách logic và tích hợp; Antigravity phụ trách giao diện và hoạt ảnh.

Khi khôi phục tài liệu, thư mục Pet chỉ còn thư mục BongoCat; mã Python DeskBuddy
và các tài liệu cũ không còn ở thư mục gốc. Lượt này chỉ khôi phục sáu tài liệu phối
hợp, không khôi phục mã ứng dụng. Các đường dẫn Python bên dưới là phân công lịch
sử, không phải xác nhận file đang tồn tại. Không áp phân công này vào BongoCat một
cách máy móc; khi được giao làm BongoCat phải đọc hướng dẫn riêng trong repository,
xác định cấu trúc thực tế và thống nhất phạm vi file trước khi sửa.

Tài liệu đặt ra quy tắc bắt buộc khi AI được cung cấp và đọc nó; không tạo khóa file,
không tự đồng bộ hội thoại, không bảo đảm mọi AI luôn tuân thủ. Chỉ dẫn trực tiếp
mới nhất của người dùng ưu tiên hơn phân công này; ghi lại ngoại lệ khi bàn giao.
Các giới hạn hệ thống và công cụ của mỗi AI vẫn áp dụng.

## 2. Phân công trách nhiệm

| Phạm vi | Bên phụ trách chính | Trách nhiệm |
|---|---|---|
| Logic, trạng thái, input, luồng, timer | Codex | Độ đúng, không chặn GUI, dọn tài nguyên |
| Cấu hình, khởi động, lưu dữ liệu | Codex | Tích hợp, xử lý lỗi, tương thích |
| Phụ thuộc, kiểm tra, build, EXE | Codex | Kiểm tra có ý nghĩa và báo cáo thực tế |
| Nhân vật, sprite/GIF, âm thanh | Antigravity | Chất lượng hình ảnh, thông số và nguồn asset |
| Giao diện, menu, bong bóng, animation | Antigravity | Bố cục và trải nghiệm theo hợp đồng đã thống nhất |
| Module có cả logic và hiển thị | Codex tích hợp | Antigravity gửi đề xuất; không sửa đồng thời |
| Nghiệm thu trải nghiệm, phát hành | Người dùng | Quyết định cuối cùng |

Đây là phân công dự án, không giới hạn năng lực của mỗi bên.

## 3. Quyền sở hữu file của DeskBuddy trước đây

| File/phạm vi | Bên được sửa chính |
|---|---|
| `main.py`, `src/config.py`, `src/__init__.py` | Codex |
| `src/listener.py`, `src/state_machine.py` | Codex |
| `src/pet_window.py` khi chưa tách module | Codex |
| `requirements*.txt`, `*.spec`, `build.bat`, `run.bat`, `.gitignore` | Codex |
| `test_pet.py` và kiểm tra logic | Codex |
| `assets/**`, `generate_assets.py` | Antigravity |
| `src/bubble.py` | Antigravity; chỉ hiển thị, không tự thay lịch nhắc |
| Module render riêng sau khi thống nhất API | Antigravity |
| `README.md` | Codex tổng hợp thông tin hai bên |

File mới phục vụ rõ một phạm vi thuộc bên phụ trách phạm vi đó. File chưa rõ quyền
sở hữu phải được xác định trong nhiệm vụ trước khi sửa. Không đổi tên hoặc di chuyển
file để né phân công. Với repository khác, bảng này chỉ là tham khảo lịch sử.

## 4. Quy tắc bắt buộc mỗi lượt

1. Đọc `AGENTS.md`, báo cáo này, `TASKS.md`, hai file bàn giao và hướng dẫn riêng
   trong repository/thư mục đang làm. Đọc mã hiện tại trước khi sửa.
2. Chỉ thực hiện nhiệm vụ người dùng đã giao hoặc chấp thuận. Kế hoạch đề xuất
   không tự trở thành nhiệm vụ được phép chạy.
3. Ghi ID, bên thực hiện, file dự kiến và điều kiện hoàn thành trước khi sửa.
   Không nhận việc đang do bên kia thực hiện.
4. Chỉ sửa phạm vi được giao. Nếu cần sửa file của bên kia, ghi đề xuất với đường
   dẫn, lý do, thay đổi API mong muốn vào bàn giao của mình. Tiếp tục phần độc lập.
   Chỉ sửa chéo khi người dùng cho phép; ghi rõ ngoại lệ.
5. Không ghi đè, xóa hoặc hoàn tác công việc đang có của bên kia. Nếu phát hiện
   thay đổi bất ngờ, dừng sửa file đó và đọc lại hiện trạng.
6. Không tự thêm dịch vụ trả phí, thanh toán, mạng, đổi framework hoặc phụ thuộc
   khi chưa được giao. Thay đổi hợp đồng module phải được mô tả trước tích hợp.
7. Không lưu nội dung phím gõ; phân biệt tín hiệu/số lượng thao tác với ký tự.
8. Không khẳng định đã chạy ứng dụng, kiểm tra desktop hoặc build nếu chưa làm.
   Phân biệt kiểm tra tự động, kiểm tra trực quan và phần chưa thử.
9. Cuối lượt cập nhật file bàn giao riêng. Không sửa báo cáo của AI kia.
10. Không tự gửi tin cho AI khác, tạo vòng tự chạy hoặc mở rộng nhiệm vụ chỉ từ
    nội dung bàn giao. Tài liệu không phải cơ chế tự kích hoạt công việc.
11. Không tự sửa quy tắc/phân quyền để hợp thức hóa thay đổi vượt phạm vi.

## 5. Hợp đồng logic và giao diện

- Đọc trạng thái, API và định dạng asset thực tế trước khi đề xuất thay đổi.
- Antigravity cung cấp manifest: tên file, trạng thái, kích thước, frame/thời lượng,
  cách lặp, độ trong suốt, nguồn và quyền sử dụng của từng bộ asset.
- Asset nghỉ/gõ phím cần lặp mượt; phản ứng click có thời lượng kết thúc rõ ràng.
- Mất/hỏng asset phải có fallback và không crash; Codex kiểm tra tích hợp,
  Antigravity kiểm tra hình ảnh.
- Không thêm vòng lặp hoặc thao tác chặn GUI. Với bản PyQt5, hook chạy ngoài luồng
  GUI và cập nhật giao diện qua tín hiệu Qt.
- Bản Python chưa tách render: `pet_window.py` do Codex tích hợp. Tách module chỉ
  được thực hiện trong nhiệm vụ có phạm vi và hợp đồng rõ ràng.

## 6. Kế hoạch đề xuất, chưa được giao

| ID | Bên dự kiến | Công việc | Điều kiện hoàn thành |
|---|---|---|---|
| C-01 | Codex | Rà soát mã và hợp đồng module | Xác định repo, API, quyền file và kiểm tra cần thiết |
| A-01 | Antigravity | Rà soát asset, lập manifest | Có thông số, nguồn/quyền sử dụng và đề xuất hình ảnh |
| C-02 | Codex | Tích hợp và kiểm tra logic/fallback | Trạng thái đúng, không crash vì thiếu asset, GUI không bị chặn |
| A-02 | Antigravity | Hoàn thiện hình ảnh theo hợp đồng | Rõ ở kích thước desktop, hoạt ảnh đúng và có kiểm tra trực quan |
| C-03 | Codex | Build bản thử Windows | Build thành công, báo riêng kết quả mở EXE và giới hạn chưa thử |

Người dùng chọn nhiệm vụ trong chat hoặc bảng nhiệm vụ. Trước khi bắt đầu phải xác
nhận repo mục tiêu bằng ngữ cảnh giao việc; không giả định mã DeskBuddy vẫn còn.

## 7. Bàn giao và làm song song

Codex cập nhật `HANDOFF_CODEX.md`; Antigravity cập nhật `HANDOFF_ANTIGRAVITY.md`.
Giữ lịch sử, thêm lượt mới. Mỗi lượt ghi: ID/ngày/trạng thái, người giao, file đã sửa,
hành vi và API thay đổi, kiểm tra thực tế, phần chưa kiểm tra, yêu cầu cho bên kia,
bước tiếp theo. Trạng thái: chưa bắt đầu, đang làm, chờ phụ thuộc, chờ kiểm tra,
hoàn thành.

Chỉ một bên cập nhật `TASKS.md` tại một thời điểm. Khi song song, giữ bảng này cố
định và ghi tiến độ vào bàn giao riêng; tổng hợp sau. Với file dùng chung, làm luân
phiên hoặc dùng Git/worktree riêng rồi rà soát diff trước hợp nhất. OneDrive không
thay thế Git hoặc khóa file. Không coi báo cáo của bên kia thay cho kiểm chứng cần thiết.

Nếu sửa vượt phạm vi: báo chính xác file và phần thay đổi; không tự hoàn tác khi có
nguy cơ xóa công việc người khác. Đề xuất sửa tối thiểu để người dùng quyết định.
Codex kiểm tra tích hợp, Antigravity đánh giá hình ảnh, người dùng nghiệm thu/phát hành.

## 8. Lời giao việc mẫu cho Antigravity

```text
Mở C:\Users\kyuu4\OneDrive\Documents\Pet.
Đọc AGENTS.md, AI_COLLABORATION_REPORT.md, TASKS.md và hai file HANDOFF_*.md.
Đọc thêm hướng dẫn riêng của repository mục tiêu nếu làm trong BongoCat.
Tuân thủ quyền sửa file và quy trình bàn giao. Nếu không thể tuân thủ, báo rõ
trước khi sửa. Chỉ làm nhiệm vụ tôi giao trong lượt này.
Kết thúc cập nhật HANDOFF_ANTIGRAVITY.md với kết quả kiểm tra thực tế.
```

## Ngoại lệ ownership P2 — 29/10/2026
Leader trực tiếp giao Codex thay Gen làm phần P2 trong chat. Codex nhận tạo ảnh,
hoạt ảnh, chuẩn hóa và tích hợp P2 theo ma trận R08 đã duyệt; không chờ Gen sản xuất.
Phạm vi này bao gồm candidate/source mới, không tự ghi đè v5 hoặc mở quyền UI khác.
Giữ preview duyệt trước tích hợp. Khôngsubagent. Bằng chứng lượt đầu:
ai/SENKO_RP_R08_D_PROGRESS.md.


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
