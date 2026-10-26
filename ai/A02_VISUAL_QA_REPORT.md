# A-02 — Báo cáo Kiểm tra Hiển thị, Độ nét & Duyệt Tỷ lệ Người que (~256px)

- **Ngày kiểm tra:** 26/10/2026
- **Người thực hiện:** Gen (Chuyên gia Hình ảnh, Hoạt họa & Tư vấn Dự án Pet)
- **Trạng thái bước `A-02`:** **ĐẠT (PASSED)** — Đã hoàn tất đo đạc ảnh render GPU D3D11 thực tế, đối chiếu kích thước với mốc ~256 px (`0.16 × H_screen`), kiểm tra trực quan độ nét ở kích thước mục tiêu và chốt thông số tỷ lệ hiển thị cho bước `C-03`.

---

## 1. Phạm vi và tài liệu/mã nguồn đã đối chiếu

Đã đọc đầy đủ theo quy định:
- Tài liệu điều phối: `AGENTS.md`, `GEMINI.md`, `PROJECT_MAP.md`, `ai/PROJECT_MASTER_PLAN.md`, `ai/TEAM_PROTOCOL.md`, `AI_COLLABORATION_REPORT.md`, `TASKS.md`, `HANDOFF_CODEX.md`, `HANDOFF_ANTIGRAVITY.md`, `BongoCat/AGENTS.md` và tin nhắn mới nhất trong `ai/SYNC.md` (không sửa `ai/SYNC.md`).
- Tham chiếu kích thước của Leader: `ai/references/desktop-cat.png` (`2560 × 1600 px`) và `ai/references/desktop-cat-size.json` (chiều cao mục tiêu khi đứng thẳng = `16%` chiều cao màn hình ≈ **`256 px`**, không tính phần đệm trong suốt).
- Mã nguồn Rust thực tế (giữ nguyên 100%, không sửa chéo phạm vi của Codex):
  - `BongoCat/crates/bongocat-render/src/stickman.rs`: Hàm `standing_snapshot(TextureId)` tạo mesh tam giác gồm đầu tròn rỗng (64 đoạn, tâm `[0.0, 0.38]`, bán kính trong `0.092`, bán kính ngoài `0.12`), thân và 4 chi dạng capsule (`r = 0.014`). Tổng chiều cao phần nhìn thấy của người que trong không gian model là **`1.00` đơn vị** (`y` từ `-0.50` đến `+0.50`), tổng chiều rộng hai tay là **`0.508` đơn vị** (`x` từ `-0.254` đến `+0.254`), đặt trong `CanvasInfo` kích thước **`0.60 × 1.04`**.
  - `BongoCat/crates/bongocat-overlay/src/windows/tests/stickman.rs` & `BongoCat/crates/bongocat-overlay/src/windows/geometry.rs`: Tạo `NativeOverlay` D3D11 với `OverlaySessionOptions::default()` (`scale_percent = 100%`, `DEFAULT_OVERLAY_WINDOW_WIDTH = 350`), xuất ảnh readback RGBA `C02-d3d11.png` và ảnh ghép nền trắng `C02-preview.png`.

---

## 2. Kiểm tra kỹ thuật đã thực thi

1. **Kiểm thử hợp đồng hình học & khung xương (`bongocat-render`):**
   - Lệnh: `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render stickman -- --nocapture`
   - Kết quả: **`exit 0`** (1 passed: `stickman::tests::skeleton_is_valid_and_fits_canvas`), log lưu tại `ai/logs/A02/geometry_qa.log`.
   - Ghi chú trung thực về phiên chạy D3D11: Khi gọi lại test `c02_stickman_d3d11_proof` từ tiến trình CLI nền hiện tại, `Present` của DXGI trả về `TemporaryPresentationUnavailable ("DXGI swap chain is occluded")` do tiến trình CLI chạy trong phiên nền bị che khuất hiển thị. Ảnh readback GPU D3D11 thực tế `ai/logs/A02/C02-d3d11.png` (SHA256 `9ab81b8633ab139e25706f1ce2a8831791cf6c95aa3ec0cac988664357f3e6da`) và log `ai/logs/A02/render.log` đã được tạo từ lần chạy D3D11 `c02_stickman_d3d11_proof` (`exit 0`) và được kiểm tra pixel trực tiếp dưới đây.
2. **Đo đạc pixel thực tế và kết xuất bản xem trước ở tỷ lệ mục tiêu ~256 px:**
   - Chạy kịch bản kiểm tra bằng `System.Drawing.Bitmap` trên `ai/logs/A02/C02-d3d11.png`, xuất log chi tiết tại `ai/logs/A02/measurement.log` và ảnh kiểm định tỷ lệ mục tiêu tại `ai/logs/A02/A02-scale-256px-preview.png`.

---

## 3. Kết quả đối chiếu kích thước và duyệt tỷ lệ hiển thị (~256 px)

| Hạng mục đo đạc | Ảnh GPU Harness gốc (`scale_percent = 100%`) | Mốc mục tiêu đã duyệt (`scale_percent = 44%`) | Đánh giá QA |
|---|---|---|---|
| **Kích thước cửa sổ / Canvas (px)** | `350 × 607 px` | **`154 × 267 px`** | Đúng tỷ lệ `0.60 : 1.04` (`15 : 26`) |
| **Bounding box người que (px)** | `(27, 12) – (322, 594)` | **`(12, 5) – (141, 261)`** | Căn giữa cân đối, có lề an toàn chống cắt nét |
| **Kích thước hiển thị thực tế (Rộng × Cao)** | `296 × 583 px` | **`130 × 257 px`** (mục tiêu `~256 px`) | **ĐẠT** (sai số 1 px so với mốc 256 px) |
| **Tỷ lệ Rộng / Cao nhân trắc** | `0.5077` (`296 / 583`) | **`0.5058`** (`130 / 257`) | **ĐẠT** (giữ chuẩn tỷ lệ người que `~1 : 2`) |
| **Độ dày nét thân/chi & vành đầu** | `~16.3 px` (`0.028` đơn vị) | **`~7.2 px`** (`0.028 × 256 px`) | Rõ nét, tách biệt tốt trên nền Desktop |
| **Kiểm tra tâm đầu rỗng (`[0.0, 0.38]`)** | `alpha = 0` (trong suốt hoàn toàn) | `alpha = 0` (trong suốt hoàn toàn) | **ĐẠT** đúng thiết kế đầu tròn rỗng |
| **Số pixel đục / pixel khử răng cưa** | `23.822` đục / `0` trung gian | `4.988` đục / `1.594` trung gian | Bản thu chuẩn 256 px mượt và liền nét |

### Quy chuẩn tỷ lệ hiển thị được duyệt (Approved Display Scale Spec):
- **Nguyên nhân ảnh harness gốc cao 583 px:** `OverlayWindow` đang dùng chiều rộng mặc định của mèo BongoCat (`DEFAULT_OVERLAY_WINDOW_WIDTH = 350 px` ở `scale_percent = 100%`). Do canvas người que có tỷ lệ dọc `0.60 × 1.04`, chiều rộng 350 px kéo chiều cao cửa sổ lên `607 px` (người que cao `583 px`, gấp `2.2773 lần` mốc 256 px).
- **Thông số tỷ lệ hiển thị chính thức duyệt cho người que:**
  1. Theo cơ chế `scale_percent` sẵn có của `OverlaySessionOptions`: đặt **`scale_percent = 44`** (tương ứng cửa sổ **`154 × 267 px`**, chiều cao người que hiển thị đạt **`256–257 px`**).
  2. Theo công thức tổng quát theo chiều cao màn hình thực tế ($H_{\text{screen}}$) và DPI:
     - Chiều cao hiển thị mục tiêu của người que: $H_{\text{visible}} = \text{round}(0.16 \times H_{\text{screen}})$ (với màn hình tham chiếu `2560 × 1600`, $H_{\text{visible}} = 256\text{ px}$).
     - Chiều cao cửa sổ overlay (gồm lề `1.04`): $H_{\text{window}} = \text{ceil}(H_{\text{visible}} \times 1.04) = 267\text{ px}$.
     - Chiều rộng cửa sổ overlay: $W_{\text{window}} = \text{ceil}(H_{\text{window}} \times 0.60 / 1.04) = 154\text{ px}$.

---

## 4. Duyệt trực quan độ nét và giới hạn hiện tại

1. **Kiểm tra trực quan ảnh thực tế (`ai/logs/A02/C02-preview.png` và `ai/logs/A02/A02-scale-256px-preview.png`):**
   - Đã mở và kiểm tra trực tiếp hai file ảnh: đầu tròn rỗng cân đối, khớp cổ nối kín vào thân, hai tay mở góc tự nhiên, hai chân đứng vững, đầu mút các chi bo tròn (capsule cap).
   - Ở kích thước mục tiêu **130 × 257 px** (`ai/logs/A02/A02-scale-256px-preview.png`), độ dày nét ~7.2 px và đường kính ngoài của đầu ~61.4 px (lòng rỗng ~47.1 px) đảm bảo nhìn rõ ràng trên màn hình Desktop mà không bị rối hoặc quá mảnh.
   - Trong ảnh readback D3D11 gốc (`C02-d3d11.png`), rasterizer tam giác mặc định chưa bật MSAA nên có `0` pixel alpha trung gian (răng cưa nhị phân nhẹ ở rìa chéo). Tuy nhiên ở kích thước 256 px, hình khối tổng thể sắc nét, đạt yêu cầu giai đoạn khung xương cơ bản.
2. **Giới hạn trung thực & Bàn giao bước tiếp theo (`C-03`):**
   - Hiện tại người que mới chạy trong harness kiểm thử D3D11 (`c02_stickman_d3d11_proof`), chưa được nối vào luồng khởi chạy mặc định của `bongocat-app`.
   - Gen giữ nguyên ranh giới sở hữu file: không tự ý sửa các file `.rs` của Codex và không sửa `ai/SYNC.md`.
   - **Bàn giao sang `C-03` cho Codex:** Áp dụng tỷ lệ hiển thị đã duyệt (`154 × 267 px` canvas / `scale_percent = 44%` cho mốc 256 px, hoặc công thức $0.16 \times H_{\text{screen}}$) khi triển khai hệ thống Vật lý (Trọng lực, Kéo chuột & Ném) và tích hợp cửa sổ người que.
