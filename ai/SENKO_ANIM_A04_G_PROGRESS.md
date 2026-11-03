# SENKO-ANIM-A04-G — bàn giao 29/10/2026

## Phạm vi và kết quả

Leader yêu cầu tiếp theo kế hoạch. Codex tự thực hiện, không subagent. Chỉ sửa công cụ chuẩn hóa/xem trước hoạt ảnh và tạo nguồn/ứng viên riêng. Không sửa Brain, body, vật lý, planner, Animator production, timer hoặc pack mặc định. Fetch origin đã chạy; giữ nguyên checkout và thay đổi đang có, không merge/commit/push/dependency/lockfile.

Phát hiện công cụ gait160 đang gọi normalize160 với trục lấy cả vùng trang phục đỏ. Khi ống quần di chuyển, trục này có thể lệch theo chân. Bổ sung normalize160_gait dùng dải eo đã có ở đường gait80, giữ nguyên tỷ lệ chung mỗi source sheet và baseline. Áp dụng cho xuất walk và hai footpatch passing. Các ảnh/model160 khác và gait80 không đổi.

Test hình tổng hợp có torso cố định và hai vị trí quần khác nhau xác nhận: trục cũ khác nhau, trục eo mới và vùng thân giống nhau. Không suy test này thành chứng nhận mọi frame hình thật đã hết rung. Với nguồn36 hiện có, độ đổi trục quy đổi nằm trong -6,680..0 physical px; đây là thay đổi hệ neo, không phải số đo giảm jitter.

## Artifact

- walk-waist-36-v6: xuất lại cùng ba source sheet cũ bằng neo eo. Không tạo thêm frame hoặc gọi đây là 36 tranh mới.
- walk-waist-36-v7: giữ footpatch frame10/28 từ nguồn AI trước. So với v6, 34 frame và pixel ngoài patch của 2 frame sửa giống hệt. 36/36 RGBA khác nhau, 31 màu gồm alpha, alpha cứng, canvas160. Giữ cycle96 physical px và clock800ms tham chiếu.
- Preview cuối: resources/characters/senko-160/waist-review-v1/index.html. So walk-guided-36-v5 với v7, cùng pha, hai hướng, pause/scrub, phóng chân. Camera minh họa theo thân, vạch sàn chạy theo tốc độ tham chiếu; không chạy body/Brain production.
- Tool --gait-raster-review160 xuất ảnh và đoạn pixel đục tại baseline y152 cho đủ36 frame ở hai pack. Đây là raster silhouette, không gán danh tính chân/trạng thái trụ, không biến thành metadata tương tác hoặc chứng nhận stance.

## Sản xuất hình và lỗi được giữ riêng

Built-in imagegen tạo walk-stance-keys-v3-raw.png và bản sửa v4 trong senko-160-source/gait. Prompt đầy đủ, reference, nguồn và lý do loại tại STANCE_KEYS_V3_V4.md. Cả hai chưa đạt pha chân: chân trụ chưa lùi đều, cuối nửa chu kỳ lại đưa ra trước, vai trò hai chân chưa rõ. Không đưa vào pack hoặc tự tạo inbetween để che lỗi.

Đính chính nhận xét ban đầu trong chat về nền nâu: kiểm tra alpha cho thấy nền có alpha0 với RGB nâu ẩn; không phải chứng cứ nền đục. Alpha nguồn phần nhân vật chủ yếu253 và có viền bán trong suốt, sẽ cần chuẩn hóa nếu ảnh được nhận. Lý do loại là chuyển động chân, không phải thiếu alpha0.

## Kiểm tra thực chạy

- Asset tool: 18/18 test đạt, gồm hồi quy trục eo160 và đoạn raster rời nhau/chạm biên phải.
- Clippy asset-tool -D warnings, rustfmt phạm vi và git diff --check đạt. CLI xuất v6/v7/review chạy thành công, loader production kiểm định các pack.
- Audit artifact read-only bằng Pillow đạt:36frame unique, hardalpha/palette,34file và ngoài patch giữ nguyên so v6;11 checksum module/manifest baselineA01 không đổi. Baseline này không bao phủ mọi file body/planner.
- JS player contract bằng Node DOM/RAF stub:72 tham chiếu PNG tồn tại, scrub36pha,10giây ở30/60/120Hz cùng clock10000ms/frame18, mirror/pause/reset đạt. Chưa kiểm tra browser GUI/GPU hoặc cadence45FPS phần cứng.
- Đã xem contact sheet v6/v7 trực tiếp. Chưa nghiệm thu chuyển động tự nhiên hoặc chân đứng yên trên sàn.
- Không chạy lại native/runtime regression và không build release mới: lượt này chỉ sửa binary asset-tool, không code runtime/render/app. Không dùng số test lượt trước làm kết quả lượt này. PID13000 của release A04-F vẫn Responding khi kiểm tra, pack mặc định vẫn candidate-v5-flow.

Log/audit/script kiểm tra tại ai/logs/SENKO-ANIM-A04-G. Không cần xóa dữ liệu người dùng. CHANGELOG bỏ qua: cùng tính năng chưa phát hành, công cụ/ứng viên chưa tích hợp.

## Phần tiếp

A04 chưa hoàn thành. Việc đã xong lượt này là sửa sai hệ neo và bổ sung bằng chứng raster toàn36frame; chưa xong contact ngữ nghĩa toàn chu kỳ. Tiếp sản xuất từng pose chân trụ/passing/đặt chân ở phạm vi nhỏ hơn để kiểm tra hình học trước khi mở lại36frame, rồi quay đầu đủ tư thế, run và các hướng còn lại. Không đổi vật lý để che trượt chân. Chưa A08 đổi pack mặc định, chưa A09 QA phần cứng/soak30phút.
