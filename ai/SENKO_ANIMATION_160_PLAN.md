# SENKO — Animation160 / 45FPS — kế hoạch đã duyệt

Nguồn: leader gửi PLEASE IMPLEMENT THIS PLAN ngày29/10/2026.
- Phong cách candidate-attention-v1;45clip nền+4clipnháp+toàn bộP2, Codex tự làm hình và logic hoạt ảnh, khôngsubagent.
- Canvas160×160/scale2/anchor80,152; cửa sổ320×320/kíchthước vật lý giữ nguyên.
- 45FPS ở đoạn chuyển động, delay22/23ms phân bổ; giữ pose có chủ đích, không nhân bản để đạt sốframe. Biểu cảm<=6giây; locomotion theo quãng đường/physical progress.
- Chỉasset/manifest/loader/Animator/posemapping/masks/contact/cache/preview. KhôngBrain/nhucầu/xácsuất/cooldown/physics/planner/media/storage.
- A01 inventory/callsites/clock/contact/interrupt/baseline; A02 model năm hướng và pose đứng/đi/quay/tilt/vui/bế, leaderduyệt trước massproduction.
- A03 loader160/dynamicmask/metadata/anchor/audit/preview45FPS; A04 locomotion8hướng; A05 traversal/held/impact; A06 chúý/chơi/touch/emotion; A07 rest/media/greet/care; A08 tíchhợp đồngnhất; A09 regression/perf/release/30phútđúnghash.
- Giữ physicsfeedback/episodeactualPresent/pause/capture/noholdair. Clip cũ quay lại bằng lựa chọn pack rõràng, khôngsilentfallback.
- Native timing30/60/120Hz,10giâyclock; hit-test/mirror/âm/DPI, bế/rơi/menu/reset/clickthrough, regressionrenderer/ngườique.
- Dựtoán memorytrướcfullpack, đoCPU/private/working/GPU/cadence. Preview chính đọcmanifest; GIF phụtrợ.
- Nghiệmthu: model→gait→physicsacting→emotion→care→fullapp. Phát sinh đổi hànhvi/vậtlýngoàiphạmvi phải báoleader trước, khôngtựsửa.

## Trạng thái lượt đầu
A01 đã cóinventory75mục vàbaseline30mẫu. A02 đã có12PNG160/bảngmẫu/modelmetadata, **chờ leaderduyệt**; chưa massproduction. A03..A09 chưahoànthành. Chi tiết SENKO_ANIM_A01_A02_PROGRESS.md.
