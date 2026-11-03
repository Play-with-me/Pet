# A04-M — nguồn quay đầu ngang → chính diện,30/10/2026

## Phạm vi và sản xuất
Leader cho tiếp tục plan sau L. Codex tiếp tục A04 với nguồn quay đầu mới, không subagent. Chỉ thêm module offline turn160.rs và CLI --turn-keys160, không sửa Animator production/Brain/vật lý/planner/defaultpack. Fetch origin đã chạy; checkout/lockfile giữ nguyên, không commit/push.

Dùng built-in imagegen (không CLI/API fallback), tham chiếu contact model-v1,pose02 ngang vàpose00 chính diện. Nguồn gốc resources/characters/senko-160-source/turn-side-front-v1-raw.png, exact prompt trong turn-side-front-v1-prompt.txt; bản gốc generated_images giữ nguyên. Sheet6×2 tạo12 tư thế chuyển yaw ngang phải→3/4trước→chính diện. Xem trực tiếp sheet nguồn và montage160: cùng nhân vật, chân ngắn/hakama rộng, tay gần ngực; có thay đổi mặt/thân/đuôi. Không gọi đây là endpoint-match hoặc yaw được đo chính xác.

## Công cụ và asset
turn160.rs chia6×2, một hệ số scale chung tính từ chiều cao ảnh đầu124nativepx, chuẩn hóa theo chuẩnmodel cũ; không resize riêng từngframe. Kiểm tra khung, khôngframe trống/trùng, xuất palette32RGBA/alpha cứng/manifest/atlas/report; loader SpriteLibrary nạp lại. Không dùng morph/warp raster. Điểm neo logical80,152/scale2; chưa có contactpivot perframe ngữ nghĩa.
Pack: resources/characters/senko-160/turn-side-front-v1.
Player: resources/characters/senko-160/turn-review-v1/index.html.
12hình khác nhau,delay22/23ms,tổng266ms tại45Hz. Đây là một gócquay90độ nháp, không phải đủ8hướng/quay180độ hoặc clip đang dùng trong app. Hình đầu/cuối mới vẽ chưa alias pixel với idlemodel; chưa nối để tránh seam sai. Chiều cao124..127px chungscale: códaođộng3px cần rà/correct nguồn trước acceptance, không tự co/giãn từngframe để che lỗi.

## Kiểm tra thực chạy
- Asset-tool19/19 hiện có đạt; không thêm unit test chỉ phản chiếu implementation. Chạy trực tiếp tool trên nguồn thật thành công, loader kiểm định pack lúc xuất.
- Clippy asset-tool -Dwarnings/rustfmt phạm vi/diffcheck đạt.
- Audit read-only Python/Pillow:12unique,160square,32RGBA,alpha0/255,baseline152,không clipping,266ms;11hash baseline A01không đổi. Không suy thành toàn bộ filephysics đã được hash.
- Đã xem nguồn và atlas qua view_image. NativeCUA thấy cửa sổ app hiện ở chat khác, nên không tự chuyển chat hoặc điều hướng browser của chat khác. open_in_codex trảqueued; chưa xácnhận browserplayback. Không nativePresent mới hoặc hardware45FPS measurement/release/soak.
Log/scripts ở ai/logs/SENKO-ANIM-A04-M.

## Tiếp theo
Rà và chỉnh height/volume/điểm xoay/endpoint; sau đó bổ sung các đoạn chuyển còn lại và nối Animator trong phạm vi hoạt ảnh. Arm-tail/startstop/run/cáchướng vẫn thuộc A04. Giữ A05..A09 sau cổng nghiệm thu. App vẫnpack cũ; không đánh dấu A04hoànthành chỉ vì đã có12PNG.
CHANGELOG bỏ qua: cùng tính năng chưa phát hành, không thay chức năng đã phát hành. Không ADR mới vì chỉ tool authoring offline, không đổi kiến trúc/hợp đồng.
