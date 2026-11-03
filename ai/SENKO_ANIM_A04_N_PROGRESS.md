# A04-N — nối quay đầu vào Animator ứng viên,30/10/2026

## Thay đổi
Tiếp plan theo leader. Chỉ Animator/loader/assetassembly/test và tài liệu; không Brain/body/motor/planner/defaultpack, không subagent/dependency/lockfile/commit/push. Fetch origin thành công.

Animator đọc optional turn-edge clips:side→34→front→34→side, dùng delay manifest thay ảnh đứng70ms ở các pack có khai báo. Bản cũ không khai báo giữ đườngturn cũ. Phầnmirror chínhdiện ởframeđầucuối bị tắt để giữ chiều phụ kiện. Pause/bế/rơi vẫn đúng quyền điều khiển cũ. Không sửa cooldown500ms hoặc ý định.
Loader kiểm tra4tên mới làtimed/nonloop/mirror và exactidle textureendpoint, lỗi khai báo trảerror. Không âmthầm bỏ qua clip sai. ADR0122 ghi hợp đồng.

Partialpack side-sequence-turn-v1 giữwalk/startstopK và thêm4clip8thamchiếu/177ms. Dùng12nguồnM+canonicalidleendpoint, đảo thứ tự choquayngược; không32tranh mới hoặc đủmọihướngturn. Táchdirection mỗi45độ,quay180độ tổng708ms tại45Hz, không sửa vật lý. Mối nối ngoài dùng cùngtexturealias; nối nội bộ vớiảnh model khác pose vẫn cần visualQA.

## Kiểm tra thực chạy
- Render33/33,runtime299pass+1ignored,sharedfixtures2pass. Full runtime/render sauproductionchanges đạt. Sau thêmassertmalformedloop trongtest, testmục tiêu chạy lại đạt.
- Test mới kiểmtra22/23delay,tiếnframe/đoạn, pause,mirrorleft/frontendpoint, bế/rơi ngắt vàloaderrejectloop. Fixture test dùngcùngảnhchấm, không bằngchứng chấtlượngart.
- Clippy runtime/render alltargets-Dwarningsđạt; rustfmtphạmvi vàdiffcheckđạt.
- --walk-world160 tạo13ca mới trêncandidate(30/60/120Hz×2hướng×2sync+1reversal60Hz). Audit reversalthựcAnimator thấyđủ8frame cả4clipturn,canonicalendpointsđúng vàfrontfirstkhôngmirror. KhôngclaimnativeGPUturnPresent. Log/audit/scripts:ai/logs/SENKO-ANIM-A04-N.
- Player loader nạp candidate sauvalidation mới thànhcông. turn-world-v2/index.html làtraceactualBody/GroundMotion/Animator trênsàntổnghợp;turn-integrated-review-v1 làmanifestplayer riêng.
- open_in_codex trảqueued,chưa xácthựcbrowserplayback/nativePresentmới/hardwarecadence. Không releasebuild/soak30phút; ứngdụngđangchạy khôngđổibinary/defaultpack.

## Giới hạn và bước tiếp
NguồnM đã leader cho tiếp tục nhưngdaođộngheight124..127px/pivot/volume chưa sửa: khôngco giãntừngframe đểgiảổnđịnh. Lượt này tập trung phần tíchhợpAnimator đãkiểmđịnh, không tuyênbố đãgiảiquyết height như dựkiếnđầulượt. Quay qua gócsau,cácrun/hướngđi,armtail/chuyểntiếptoànthân cònA04. ChưaA04complete/A05/A09. Chuỗi mới phải xemthực vàhiệuchỉnh nguồn tiếp.
CHANGELOG bỏqua:cùngtínhnăngchưapháthành. Không thayhànhvi/vậtlý để làmảnhtrôngđúng.
