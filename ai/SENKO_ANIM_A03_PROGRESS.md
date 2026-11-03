# SENKO-ANIM-A03 — nền loader/mask/clock, phần đầu (29/10/2026)

Leader đã duyệtmodelA02 bằng chỉđạo tiếp tục theo plan. Không cần duyệt lại mẫu này.
A03 đang thực hiện, **chưa đánh dấu hoàn thành toàn bộ**.

## Đã sửa
- SpriteLibrary chấp nhận tuple80/scale4/anchor40,76 hoặc160/scale2/anchor80,152;
  texture dimensions, alpha indexing, mirror và bounds dựa kích thước nguồn thật.
- Clip nhận regions theo frame: head/tail rectangle half-open, kiểm tra số lượng,
  bounds và overlap. Alpha trước region, không bắt nền trong suốt. Pack160 chưa có
  metadata thì opaque làBody, không đoán đầu/đuôi từ sprite80. Bộ80 giữ đường cũ.
- Overlay đổi desktop→source theo library.scale. Không sửa helper/body vật lý.
- Hàm motion_delays_45 phân bổ22/23ms,450frame đúng10000ms. Audit ghi canvas/scale/anchor.
- Testfixture160 lấy pose01 model đãduyệt, vùng head/tail **synthetic chỉ testmapping**,
  không phải vùng tươngtác đãduyệt hoặc packchạythật. Không sảnxuất framegiả đểgọi45FPS.

## Kiểm định thực chạy
Renderer32pass; runtime295pass/1ignored export +2sharedfixtures; assettool13pass.
Clippy runtime/render/overlay all-targets+senko-asset-tools, scopedfmt/diffcheck đạt.
Native session30/30 đạt, gồm GPU160×2/nointerpolation, alphamirror, hit-test desktopâm;
đã xemảnh gpu160-Right.png. Native còn kiểm tra hồi quy bộ80/capture/rest/gait/touch.
Timingunit kiểm tra22/23ms/tổng10s và lấy mẫu30/60/120Hz, chưa đo cadence45FPSnative.
Checksum protectedruntime/oldmanifests so A01 vẫngiống; không đổi Brain/physics/planner.

just senko-build đạt; smoke5giây exit0. MởlạiPID15440 bằngpackv5 đãcó, khôngđổi
đườngchạy mặcđịnh. HashB4FAF9AD6C4C06C7FF19B731632C25F9B5DF0C0CF19BBC9E4C616699ED101FC6.
Đây làrelease có nền đọc160, **không phải release toànbộ hoạtảnh160/45FPS**.

## Phần tiếp theo trong A03
Metadata contact/grip/prop và công cụ xuất từ các frame thực; manifest player timing
chính xác; test Animator/pause/transition với fixture160 và native fullrunner riêng;
kiểm tra limits/dedup và tài nguyên trước production45FPS nhiềuclip. Sau đóA04gait8hướng.
Cácảnh chuyểnđộng thật45FPS chưađược sảnxuất tronglượt này. Khôngsuy fixture tĩnh
thành chứngminh độmượt hoặc45FPS. Không30phút/A09/manualmouse/mixedDPI/macOS.
Khôngsubagent/commit/push/dependency. CHANGELOGskip: hoànthiện cùngtínhnăng chưa phát hành.
