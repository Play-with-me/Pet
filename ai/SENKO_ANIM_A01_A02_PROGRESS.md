# SENKO-ANIM — A01/A02 lượt đầu (29/10/2026)

## Đã làm
Khóa kế hoạch mới tại SENKO_ANIMATION_160_PLAN.md. Chỉ thay phần ảnh/công cụ offline,
không sửa runner/runtime/renderer/Brain/physics/planner hoặc bộ ảnh mặc định.
Codex tự làm, không subagent. Ownership hình trong đợt làm lại toàn bộ do leader giao.

A01: inventory75mục:45clipnền/233frame +4clipnháp/24frame +26mụcP2 mới.
Inventory ghi manifest, clock, hướng, loop, sync, frame timing, nguồn tham chiếu,
nhóm A04..A07, yêu cầu contact/ngắt. Tìm literal không đồng nghĩa actor đang dùng;
clip ít dùng/hang không bị xóa vì không thấy callsite. Các mục P2 chưa có ảnh/actor
được ghi planned, không nhận là đã có chức năng mới. Nguồn JSON/Markdown:
logs/SENKO-ANIM-A01/inventory.json và inventory.md.

A02: imagegen built-in từ attention-v2-raw (phong cách leader chọn), tạo nguồn6×2
mới model-v1-raw.png, không phóng ảnh80 để giả chi tiết. Công cụ --model160 dùng
nguồn lớn, tách silhouette, cùng scale124px chiều cao mẫu3/4 và palette31+transparent.
Xuất12PNG160, contact.png, model.json và index.html hiển thị×2. Có5hướng và keypose
đi/quay/tilt/vui/bế. Source sốpixel2172×724; bảng keypose không phải animation45FPS.

## Baseline thực đo
Bản live PID10984, hash2AAD96BB63AD39CA8DAED9DA490E97A60136EE96C2736CE0FC78131F4E4883A4.
30mẫu khoảng1giây/mẫu, không dừng pet hoặc điều khiển desktop/con trỏ người dùng.
Phiên tự sinh hoạt không kiểm soát ngữ cảnh; không phải benchmark idle/walk/climb.
CPU trung bình0.1034%toànmáy/max0.1926%; working set trung bình48.72MiB/max49.04MiB;
private trung bình76.77MiB/max76.82MiB. Sốliệu/rawsamples trong baseline.json.
Chưa đo GPU/framecadence mới; phép đo trước/sau cókịchbản tươngđương thuộc A09.

Dựtoán thô75clip×1giây×45frame×160×160×4 ≈329.6MiB RGBA chưaalpha/dupCPU-GPU/cache;
không coi là kíchthước pack cuối. Loaderhiện giới hạn8192texture/32màu/1024frame mỗi clip.
Không tăng giới hạn tùy tiện, đánhgiá tài nguyên A03/A08 trước sản xuấtfullpack.

## Kiểm định
Tool13/13test đạt; gồm testmới normalize160 lấy detail từnguồn, hardalpha/palette và
physicalfoot tươngđương80×4. Các testchuẩn hóa80cũ vẫn đạt. Clippyassettool/tests,
scopedrustfmt/diffcheck đạt. Đã xemsource/contactsheet; đủ12pose/canvas/palette/bounds.
Không testnative160 vì loader/runner chưa nhậnpack160; không buildrelease hoặc30phút.
Không gắn model.json thànhsenko.anim.json; không báo đầyđủP2/45FPS/visualacceptance.

## Điểm duyệt tiếp theo
TheoA02 trongplan leader vừa duyệt: duyệt khuônmặt/tỷlệ/màu/nămhướng/keypose trước
massproduction. Bảngmẫu này là tài liệu cụthể đểduyệt, chưa được đánhdấu approved.
Cầnkiểm tra nhấtquánvolume/khuônmặt và silhouetteởgócngang/sau; poseđi/bế tĩnh không
chứngminh chuyểnđộng/tiếpđất. TiếpA03nền160/timing/hit-test và các nhóm sau theo plan.

Khôngcommit/push/dependency/branch/security hoặc sửaGenhandoff. CHANGELOGskip vì
cùng tínhnăngchưa phát hành. Khôngcầnxóa dữliệu người dùng.
