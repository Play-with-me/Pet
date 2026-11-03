# A04-O — rà nguồn quay và native Present,30/10/2026

## Phạm vi
Leader tiếp tục plan sauN. Chủ yếu sửa nguồnquay quaimagegen/đokíchthước; bổ sungnativeQA cóscope ghi HANDOFFtrước sửa. KhôngproductionAnimator/Brain/physics/planner/defaultpackchange,khôngsubagent/dependency/lock/commit/push. Fetchoriginđãchạy.

## Nguồn thử và quyết định không nhận
Dùngbuilt-inimagegen edit sheetM, yêucầusửachiềucao/volume/pivot,khôngco giãn từngframe. Nguồnmớiđãcopy vào resources/characters/senko-160-source/turn-side-front-v2-raw.png vàexactprompt turn-side-front-v2-prompt.txt;filegốc generated_images giữnguyên. Tool--turn-keys160 xửlýmộtscalechung vàloadernạp thànhcông, tạo turn-side-front-v2. Đãxem atlasqua view_image.

Audit read-only đo cảhai: v1height124..127/opaquearea7563..8427;v2height124..127/area7700..8552. Khôngchứngminhđượccảithiệnheight; **khôngnhậnv2**,khônglắpvào partialpackN. READMEcandidate ghi rõ. Areađổi theo yaw, khôngsuyđó làvolume3D;medianmàuwaist chỉdiagnostic,khôngchứngnhậnpivot. Khôngtựscale từngframe đểđạtbảngsố.
Nhưvậy mụctiêuổnđịnhheight/pivot chưađóng. Lượt nàykhôngtuyênbốđãsửaxonghình,giữnguồnđãduyệtv1.

## Native QA đã bổ sung và chạy thật
Test native160_moving_trace_uses_sync_specific_stop_without_position_clamp cómodeopt-in SENKO_160_REPLAY_TURN=1. Chếđộ thườnggiữ4ca2sync×2hướng. ModeturnchọnreversaltrongtraceN đãcó,recordframeSeen saudrawvàassertđủframecả4clipturn/frontendpointkhôngmirror. Chỉtestcode trongcompanion_sprites.rs;khôngđổiproductionrenderer.

Kếtquả cuối:
- turnmode1/1pass,8.50s, đủ8frame×4clipturnPresented,bothfrontcanonicalunmirrored;reuse/reversedrawings khôngtính32artmới.
- thường1/1pass,18.09s,4trace60Hz,đủ54walk vàmappedstop14/18haihướng.
- HWNDđi theobodytrace,vịtríthực đượcassert. ĐâyreplayBody/GroundMotion/Animatortracetrênsàntổnghợp;khôngliveDWM/manual/cadencehardware measurement. Khôngquay video hoặcxembrowserplaybacktronglượtnày.
- Scopedrustfmt vàdiffcheckđạt. Khôngchạytoànbộruntime/render/Clippymới vìproductionkhôngđổi. Test đầu cóprintkếtquảwalk4case dưkhiturnmode,đãsửalogthànhif/elsevàchạylạicảhai;chỉlog-final làmkếtluận.

Logs/scripts/audit:ai/logs/SENKO-ANIM-A04-O.

## Bàn giao
Nativecoverage quaysauNđãcó. Art height/pivot/volumevẫncầnnguồntốthơn. A04 cònarm-tail/run/cáchướng/backturns,khôngchuyểnA05..A09. App/defaultpack/binarygiữnguyên;khôngreleasebuild/soak30phút. CHANGELOGbỏqua:cùngtínhnăngchưapháthành. KhôngADR mới vìthửnguồnvàtest-only,contractADR0122giữnguyên.
