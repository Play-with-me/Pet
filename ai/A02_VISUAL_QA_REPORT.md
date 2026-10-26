# A-02 — Kiểm tra hiển thị và độ nét người que

Ngày: 26/10/2026. Người thực hiện: Gen theo chỉ thị trực tiếp của leader.
Trạng thái: **CHƯA ĐẠT nghiệm thu A-02 trên Desktop**. Đã kiểm tra thật harness GPU và đo ảnh; chưa xác nhận kích thước trong app chính.

## Phạm vi và nguồn đã đọc
Đã đọc AGENTS.md, PROJECT_MAP, PROJECT_MASTER_PLAN, SYNC mới, báo cáo phân công, TASKS, hai bàn giao, TEAM_PROTOCOL, BongoCat/AGENTS.md, phần kiến trúc render trong technical-design và mã liên quan. TASKS còn trạng thái cũ; chỉ thị trực tiếp hiện tại giao A-02 được ưu tiên. Không có ai/BRIDGE_EVIDENCE_FORMAT.md; dùng schema leader cung cấp. ID/phạm vi đã ghi vào HANDOFF_ANTIGRAVITY trước khi kiểm tra. Không sửa SYNC theo yêu cầu mới nhất.

Mã được kiểm tra, giữ nguyên:
- BongoCat/crates/bongocat-render/src/stickman.rs: standing_snapshot sinh đầu vòng 64 đoạn, thân, hai tay và hai chân capsule, nét đen. Chiều cao hình học 1 đơn vị; canvas 0.6 × 1.04.
- BongoCat/crates/bongocat-overlay/src/windows/tests/stickman.rs: tạo NativeOverlay click-through, draw/present D3D11 và readback; dùng kích thước overlay mặc định, không đặt chiều cao pet 256 px.
- Hồ sơ C-02 xác nhận chưa bootstrap người que vào app chính. Không tự triển khai phần tích hợp thuộc Codex trong lượt QA này.

## Kiểm tra thực tế
Lệnh từ gốc Pet, PATH bổ sung %USERPROFILE%\.cargo\bin; C02_OUTPUT_DIR trỏ tuyệt đối tới ai/logs/A02:

```powershell
cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay c02_stickman_d3d11_proof -- --ignored --nocapture --test-threads=1
```

Kết quả exit 0; 1 GPU test passed. Log: ai/logs/A02/render.log. Test thật kiểm tra alpha nền trong suốt, tâm đầu rỗng, nét đầu/thân/từng chi. Ảnh vừa tái tạo: ai/logs/A02/C02-d3d11.png (RGBA), C02-preview.png (readback ghép trắng, không phải ảnh chụp Desktop). Không sửa bằng chứng C-02 cũ.

Đo bằng System.Drawing.Bitmap.GetPixel trên toàn bộ ảnh RGBA, lấy bounding box pixel alpha >128; log ai/logs/A02/measurement.log:

| Đại lượng | Kết quả |
|---|---|
| Canvas GPU | 350 × 607 px |
| Bounding box gồm hai đầu mút | (27,12)–(322,594) |
| Người que thực, không tính padding | 296 × 583 px |
| So mốc 256 px | cao gấp 2.2773 lần, vượt 327 px |
| Pixel alpha >128 | 23822 |
| Pixel alpha giữa 0 và 255 | 0 |

Mốc 256 px ứng với khoảng 16% ảnh tham chiếu 2560 × 1600. 583/1600 = 36.44% chỉ là phép đối chiếu với ảnh tham chiếu, không phải tỷ lệ đo trên màn hình hiện tại. Chưa đo DPI, kích thước màn hình vật lý hoặc tỷ lệ logical/physical Windows; không suy chúng từ wallpaper.

## Duyệt hình ảnh
Đã mở C02-preview.png vừa tạo bằng công cụ xem ảnh: đầu tròn rỗng, thân và bốn chi đầy đủ, đối xứng, các điểm nối liên tục; không bị cắt ở mép canvas. Tỷ lệ hình học đứng rõ ràng ở kích thước harness. Tuy nhiên đường chéo/vòng đầu còn bậc pixel; không có pixel alpha trung gian nên ảnh hiện tại không có bằng chứng khử răng cưa ở biên. Chưa duyệt độ nét ở đúng 256 px hoặc trên nền Desktop sáng/tối. Không chọn màu mới và không tạo ảnh minh họa thay bằng chứng chạy.

## Kết luận và bàn giao
- Render hình học qua GPU: đạt phép kiểm tra đã chạy.
- Kích thước mục tiêu trong harness hiện tại: không đạt (583 px thay vì khoảng 256 px).
- Hiển thị sản phẩm trên Desktop, DPI và độ nét tại kích thước mục tiêu: chưa kiểm chứng; A-02 chưa hoàn tất, không chuyển bước chỉ vì đã có báo cáo/manifest.
- Bước tiếp: Codex nối người que vào lifecycle app theo kế hoạch được giao và quy đổi kích thước theo màn hình/DPI; sau đó Gen chụp vùng pet thật và đo lại, duyệt nét ở tỷ lệ mục tiêu. Không tự sửa Rust hoặc mở rộng chức năng trong lượt này.
- Không chạy full workspace/just check, không build sản phẩm/installer, không chạy lại app chính. Fetch đã chạy thành công; giữ toàn bộ sửa Rust có sẵn, không merge/commit/push. CHANGELOG bỏ qua vì chỉ QA và tài liệu; không có trạng thái local cần xóa.

Manifest ai/A-02.evidence.json ghi status failed để không diễn giải kiểm tra harness đạt thành nghiệm thu Desktop đạt. SHA256 chỉ bảo đảm tính toàn vẹn artifact.