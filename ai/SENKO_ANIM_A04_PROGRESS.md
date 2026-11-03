# SENKO-ANIM-A04 — walkside bản nháp36frame (29/10/2026)

Đã chuẩn hóa keypose12 và tạo candidate36 PNG160×160 từ ba dải AI12frame,
sharedscale/palette32/hardalpha/anchor, không nội suy hoặc nhân bản PNG. Hai nguồn
sheetlớn6×6 chỉcó30poseđãloại, không bùframe. Nguồn mới được lưu riêng cạnh nguồn cũ.

Candidate: resources/characters/senko-160/walk-side-36-strips-v1.
Player: resources/characters/senko-160/walk-side-36-player-v1/index.html.
Trong player chọn walk_side_clock_preview để xem đúngclock800ms/36frame=45FPS.
walk_side dùngdistance stride96/36px/frame, quãngđườngchu kỳ96px giữ từv5.
Tốcđộ120px/s cho45FPS; mặcđịnhplayer140px/s khôngđồngnghĩa45FPSởdistance mode.
GIFphụtrợ lượngtửdelay, khôngdùng làmchuẩnclock.

Audit:36frame/36RGBAkhácnhau, canvas160/scale2, palette32; fragmentkhôngđủrunner.
Tool14/14testđạt; Clippy xem logs/SENKO-ANIM-A04/clippy.log. Không sửa runtime/Brain/
physics/packdefault; checksum protectedmodules vàv5manifestkhôngđổi. Khôngbuildrelease
vì chỉasset/offlinetool; khôngchạy native haynhậnQA trênbảnmới.

**Chưa đạtvisualacceptance hoặc hoànthànhA04.** Silhouetteheight121..127px; còn
mốinối giữa cácdải, phasechân/tay/volume vàloopseam phải rà/sửa. Sync0/18 chỉmốcpha
đềxuất, chưađượcduyệt; contactchân chưaannotate vàkhôngđoántựđộng. CóđủPNG/timing
khôngchứngminhchu kỳbướcđúnghoặcđộmượt. Không đưa candidate vàoapp khiqualitycòntreo.
Bướctiếp ràchuyểnpha, sửađúngsource/framecầnthiết rồi previewnative/harness; tiếprun/
start/stop/cáchướng saukhiwalksideđạt. Khônghỏilại modelA02 đãduyệt.

Lượt bịngắt khi đanghoànthiệnkiểmđịnh/bàn giao. Khôngsubagent/commit/push/dependency.
CHANGELOGskip:nháp cùngtínhnăngchưapháthành. Khôngghiđèv5/nguồncũ hoặc đổiứngdụng.
