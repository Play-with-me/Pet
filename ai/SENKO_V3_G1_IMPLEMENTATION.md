# Senko v3.0 — bộ ứng viên GĐ1

ID: SENKO-V3-G1. Ngày: 27/10/2026. Thực hiện: Codex theo yêu cầu trực tiếp Leader “Làm tiếp cho tôi GĐ1”. Nguồn được chọn trước đó: **AI tạo và chuẩn hóa pixel**.

## Kết quả bàn giao

Đã có pipeline Rust chạy thật và bộ P1 mới gồm **28 clip / 100 PNG**, cùng manifest, 28 GIF và trang duyệt offline. Đây là bộ ứng viên để Leader duyệt hình; chưa tích hợp vào ứng dụng và chưa chuyển GĐ2.

Đầu ra chính: [candidate-v2/preview/index.html](../resources/characters/senko-v3-p1/candidate-v2/preview/index.html).

- [Ảnh tổng hợp 100 frame](../resources/characters/senko-v3-p1/candidate-v2/preview/contact-sheet.png).
- [Manifest clip](../resources/characters/senko-v3-p1/candidate-v2/senko.anim.json).
- [Thông số chuẩn hóa từng frame](../resources/characters/senko-v3-p1/candidate-v2/normalization.json).
- [Nguồn và hướng dẫn tái tạo](../resources/characters/senko-v3-p1/README.md).
- [Bộ prompt specification](../resources/characters/senko-v3-p1/source/PROMPTS.md) và [SHA256 bảy ảnh nguồn](../resources/characters/senko-v3-p1/source/provenance-sha256.json).

Số frame theo từng nhóm B4: idle14, move20, air9, climb14, social13, rest23, reaction7; cộng chính xác là100. Không tự thêm P2 để làm tròn số101 ước lượng trong plan.

## Pipeline đã triển khai

Entrypoint: `BongoCat/crates/bongocat-overlay/src/bin/senko_asset_pipeline.rs`; helper `catalog.rs`, `normalize.rs`, `preview.rs` trong thư mục cùng tên.

1. Đọc bảy source PNG chroma mới, khóa màu trên toàn ảnh để bỏ cả lỗ kín; không dùng flood-fill nền.
2. Tách silhouette liên thông và gán tâm vào ô dự kiến. Lưới AI chỉ được dùng để xác định thứ tự, không cắt thẳng qua nhân vật khi hàng/cột lệch. Từ chối hình gộp/quá lớn/chạm biên hoặc nhiều silhouette lớn cùng ô.
3. Bỏ thành phần rời nhỏ; lấy trục áo đỏ của thân thay cho bounding box có đuôi hoặc chân bước dài. Generic fallback là dải tiếp xúc dưới.
4. Lấy một tỷ lệ chung cho mỗi sheet từ pose đứng tham chiếu62px; pose ngồi/ngủ/cúi thấp tự nhiên, không phóng to từng pose.
5. Thu xuống80×80 bằng majority sampling, palette cố định31 RGB + transparent; đầu ra alpha0/255. Mọi màu opaque thuộc cùng palette nên không còn viền magenta trong dữ liệu.
6. Neo chung(40,76), kiểm tra đủ clip/frame, không chạm biêncanvas, không có frame trống. Không bù ảnh thiếu bằng nhân đôi.
7. Xuất PNG, metadata, contact sheet, GIF320×320 bằng nearest và HTML đổi nền sáng/tối/màu để duyệt viền. Chỉ ghi vào thư mục mới, từ chối output tồn tại.

GIF dùng codec của dependency image0.25.10 đã khóa sẵn; thêm feature offline `senko-asset-tools = ["image/gif"]` và required-features cho binary mới. Không thêm package/version hoặc thay Cargo.lock; `--locked` chạy đạt. Build runner mặc định không cần bật feature công cụ này.

Các thông số ms/loop/sync/facing/mirror trong manifest là hợp đồng ứng viên để duyệt và dùng cho GĐ2. GIF lặp ngay cả với clip one-shot để dễ xem. Clip đi/run vẫn chỉ preview theo thời gian; chưa có Animator theo quãng đường. Stride18 được ghi rõ đơn vị physical pixel mỗi frame theo công thức trong plan, không âm thầm áp vào runtime cũ.

## Kiểm tra thực tế

Log và script tại `ai/logs/SENKO-G1/`.

| Kiểm tra | Kết quả |
|---|---|
| Pipeline chạy bảy source PNG | Exit0; 100frame,32 RGBA màu chung; log pipeline-run-v2.log |
| Unit/roundtrip test pipeline | **6/6 đạt**: inventory, key lỗ kín/giữ trắng, neo/palette/alpha, từ chối frame thiếu/quá lớn, hàng nguồn không đều, GIF đổi frame không lưu bóng cũ và đúng delay |
| Script QA độc lập Windows GDI+ | Decode100PNG và28GIF; đủ80×80/320×320 và số frame; alpha0/255;32 màu; không còn magenta;100/100 bbox đáyy76 |
| Độ khác nhau trong mỗi clip | SHA256 của mọi frame trong từng clip khác nhau; walk8/8,run8/8,climb6/6,held4/4; đây không tự chứng minh chuyển động đẹp |
| Clippy binary, feature senko-asset-tools | `--locked ... -- -D warnings`, exit0 |
| rustfmt entrypoint và helper | Exit0 |
| Check runner mặc định companion_senko | `--locked`, exit0 với feature công cụ tắt |
| Rà soát trực quan | Đã xem bảy source sheet, ảnh tổng hợp chuẩn hóa và strip walk_side/sit_enter; đã phát hiện và loại bản cắt lỗi |

Các lệnh chính:

```powershell
$cargo = "$env:USERPROFILE/.cargo/bin/cargo.exe"
& $cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --features senko-asset-tools --bin senko_asset_pipeline
& $cargo clippy --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --features senko-asset-tools --bin senko_asset_pipeline -- -D warnings
& ./ai/logs/SENKO-G1/verify-assets.ps1 -Candidate resources/characters/senko-v3-p1/candidate-v2
```

## Đã xử lý trong quá trình QA

- Sheet climb đầu thiếu một pose mantle; ImageGen sửa riêng hàng cuối thành đủ14 pose. Không đổi số frame hoặc nhân đôi ảnh để che thiếu.
- `candidate-v1` dùng cắt ô đều nên nhóm nghỉ bị cắt chân/lẫn hình hàng kế. Bản đó đã có REJECTED.md và manifest status=rejected-do-not-integrate. Chỉ candidate-v2 là bản đang bàn giao.
- Một số silhouette leo có đỉnh/tay và chân so le làm không tồn tại đường trống xuyên cả hàng. Pipeline cuối tách theo silhouette; test hàng không đều và QA ảnh thật đã chạy lại sau thay đổi.

## Giới hạn và cổng tiếp theo

- Chưa có nghiệm thu hình/nhịp GIF của Leader; chưa chứng minh không còn mọi lệch hình AI hoặc không trượt khớp giữa clip. Các trường hợp leo/bế cần điểm bám tay và kiểm tra chuyển tiếp khi làm GĐ2–3.
- Đúng bảng P1 hiện có front/3-4/side/back; không gọi đây là đủ tám hướng di chuyển. Điểm thiếu hướng phía sau đã nêu trong review, chưa tự mở rộng asset ngoài bảng B4 đã giao.
- GĐ1 giao asset và pipeline, không đổi sampler, scale app, runtime, brain hoặc collider. Senko đang chạy vẫn dùng46 shime*.png cũ. Chưa test gameplay với bộ mới; chưa chạy lại fullworkspace/soak/benchmark vì không tích hợp runtime trong lượt này.
- Leader duyệt bộ hình này trước GĐ2, đúng mục7 plan: “mỗi giai đoạn có cổng duyệt của Leader”. GĐ2 mới nối manifest/Animator và phóng to×4.

## Bàn giao và phạm vi

Theo chỉ thị GĐ1 mới, Codex tạo asset ứng viên/pipeline trong lượt này như ngoại lệ phân công đã ghi trước thực thi. Không ghi đè file asset/module của Gen; không sửa HANDOFF_ANTIGRAVITY.md. Không commit/push/đổi nhánh, không sửa các chức năng ngoài GĐ1. CHANGELOG bỏ qua: công cụ offline và asset ứng viên chưa tích hợp/phát hành. Không có dữ liệu cũ bắt buộc người dùng xóa.
