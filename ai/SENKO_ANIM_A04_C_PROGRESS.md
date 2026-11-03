# SENKO-ANIM-A04-C — sửa pha chu kỳ đi ngang (29/10/2026)

## Thay đổi
Nhận thấy v1 ghép ba dải liên tiếp chưa bảo đảm chỉ cómộtchu kỳ. Tạo sơđồ chịu lực/
đưa chân12pha độc lập, rồi imagegenvẽ lại12keypose vàhai dải12inbetweens ởpha1/3,2/3.
Tất cả nguồn mới được lưu riêng, không biến dạng hoặc nội suy pixel ảnh cũ.

Tool --walk160-interleave ghép key[k],third[k],two_thirds[k],key[k+1]. Cótestthứtự
vàchặnnguồnthiếu12cell. Khônglặpảnh đểđủ36frame, dữliệuảnh36RGBAkhácnhau.
NguồnAI cómậtđộpixelkhácnhau dùcùngkíchthướcfile; v2 dùngrawscalechung bịnhấpngô
124/126/129px. v3 cânchuẩn một lần cho toànsheet bằngreferenceđầu sheet; tỷlệcủa
sheet giữnguyên cả12frame, không fit từngpose/chân/tay. Mappingnguồn/cell/scale minh
bạchtrong gait-report.json. Fieldsource_sheet_scales làscale thực, shared_scale của
artifactv3 làreferencefirstsource, khôngápdụngcho cả3sheet. Toolvềsauđãđổi tên
fieldreference_source_scale đểtránhnhầmlẫn; PNGv3khôngđượcghiđèchỉđểđổitênmetadata.

## Kết quả thực kiểm tra
- v3:36PNG160,36RGBAkhácnhau, hardalpha, palette32, anchorchân152, silhouette123..125px
  (v1:121..127; v2trướccânnguồn:123..129). Giảmheightvariationkhôngchứngminhheadvolume/gaitđãđạt.
- Clock36frame=800ms,45FPSởreference; distancecycle96px giữv5, stride96/36;
  reference120px/s, khôngđổi runtime hoặc tốcđộ thực của pet.
- Auditproductionloaderđạt vềcấutrúc; fragmentnotRunner làđúng. Tool15/15testđạt,
  Clippy/scopedfmt/diffcheckđạt. Checksumprotectedruntime/v5manifestsoA01khôngđổi.
- Đãxemnguồnmới, contact-sheetv2 và kiểmtham sốv3. Chưa cóQA chuộttay/nativegaitv3/
  cadencehardware. CácGIF phụtrợ bịquantizeddelay; player làchuẩntiming.
- Khôngruntime/Brain/physics/defaultpackchange, khôngbuildrelease hoặcsoak mới.

## Bàn giao
Candidate: resources/characters/senko-160/walk-guided-36-v3.
Player: resources/characters/senko-160/walk-guided-player-v3/index.html;
chọnwalk_side_clock_preview. Distance mặcđịnhplayer140px/s khôngphải45FPS;
chỉnh120px/s nếuđốichiếumotionphase. So sánh: senko-160/walk-review-v3.html.
Nguồn/prompt: senko-160-source/gait/GUIDED_KEYS_V2.md và GUIDED_INBETWEENS_V1.md.

## Chưa hoàn thành
A04vẫnđanglàm. Chưaduyệt tựnhiên của toànchu kỳ; cầnrà pha9..11/27..29 giữa các
inbetween, đặtchân, tay/đuôi vàloopseam. Sync0/18 vẫnprovisional, contacts chưaannotate,
khôngđoánfootcontacts bằngbbox. Chưanối vàoapp hoặc làmrun/start/stop/cáchướngkhác.
Khôngnhận36unique+45clock làchứngminh45FPSactingđạt. ModelA02đãduyệt, khônghỏilại.
Khôngsubagent/commit/push/dependency. CHANGELOGskip vì cùngfeaturechưapháthành.
