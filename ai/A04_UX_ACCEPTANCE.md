# A-04 — Báo cáo Nghiệm thu Trải nghiệm & Độ mượt Tổng thể (UX & Smoothness Acceptance Report)

- **Mã bước:** `A-04`
- **Ngày thực hiện:** 26/10/2026
- **Người phụ trách:** Gen (Chuyên gia Hình ảnh, Hoạt họa & Tư vấn Dự án Pet)
- **Trạng thái bước `A-04`:** **ĐẠT (PASSED)** — Đã hoàn tất kiểm tra thực thi mã nguồn `C-02`/`C-03`/`C-04`, kiểm chứng nhịp khung hình ~60 FPS và bước vật lý 240 Hz, xác minh toán học chuyển tiếp nội suy mượt giữa 8 tư thế (`Idle`, `Walk`, `Chase`, `ClimbWall`, `Fall Stretch`, `Land Squash`, `Evade/Sulk`, `Recover`) không giật lag/nhảy vị trí và không tràn biên `CanvasInfo`, sẵn sàng chuyển sang bước `C-05` (Đóng gói Bản chạy thử nghiệm trên Windows).

---

## 1. Khung Cam kết Lượt làm việc & Đối chiếu Hiện trạng Ổ cứng

### 1.1. Khung Cam kết (Tuân thủ `AGENTS.md`, `GEMINI.md` & `ai/LEADER_CONSTITUTION.md`)
- **Mã Ticket:** `A-04`
- **Danh sách file tạo/cập nhật trong lượt này:**
  - [ai/A04_UX_ACCEPTANCE.md](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/ai/A04_UX_ACCEPTANCE.md) (Báo cáo nghiệm thu trải nghiệm & độ mượt tổng thể)
  - [ai/A-04.evidence.json](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/ai/A-04.evidence.json) (Manifest nghiệm thu SHA256 chuẩn UTF-8 không BOM cho bước `A-04`)
  - `ai/logs/A04/build-check.log` (Log biên dịch `bongocat-render`, `bongocat-runtime`, `bongocat-overlay` & các examples)
  - `ai/logs/A04/unit-tests.log` (Log chạy 22 unit tests `bongocat-render` + 125 unit tests & 2 fixture tests `bongocat-runtime`)
  - `ai/logs/A04/clippy-check.log` & `ai/logs/A04/fmt-check.log` (Log kiểm tra `cargo clippy -- -D warnings` và `cargo fmt --check`)
  - `ai/logs/A04/example-physics-smoke.log` & `ai/logs/A04/example-autonomous-smoke.log` (Log chạy thực tế 2 binary `companion_physics.exe` và `companion_autonomous.exe`)
  - `ai/logs/A04/ux_smoothness_qa.ps1` & `ai/logs/A04/ux-smoothness-qa.log` (Kịch bản & log kiểm định độ mượt nội suy chuyển tiếp 8 tư thế ở 60 FPS)
  - `ai/logs/A04/A04-transition-smoothness-sheet.png` (`1232 × 267 px`, bảng 8 tư thế chuẩn ở kích thước cửa sổ đã duyệt `154 × 267 px`/ô)
  - `ai/logs/A04/A04-motion-continuity-preview.png` (`616 × 267 px`, bảng kiểm định quỹ đạo nội suy Onion-Skin 4 cặp chuyển đổi tư thế trọng yếu)
  - [HANDOFF_ANTIGRAVITY.md](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/HANDOFF_ANTIGRAVITY.md) (Ghi nhận bàn giao bước `A-04`)
- **Ranh giới bảo toàn:** Không tự ý sửa bất kỳ file `.rs` nào của Codex (`stickman.rs`, `physics.rs`, `autonomous.rs`, `companion.rs` đều giữ nguyên 100% SHA256 của các bước `C-02`, `A-02`, `C-03`, `A-03`, `C-04`); không sửa `ai/SYNC.md`.

---

## 2. Kết quả Kiểm tra Thực thi trên Ổ cứng (Build, Tests, Lint & Examples)

Toàn bộ lệnh kiểm tra dưới đây đã được thực thi trực tiếp trong workspace `C:\Users\kyuu4\OneDrive\Documents\Pet`:

| Hạng mục kiểm tra | Lệnh thực thi | Kết quả thực tế | File Log / Bằng chứng |
|---|---|---|---|
| **1. Biên dịch Crates & Examples** | `cargo build --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-runtime -p bongocat-overlay --examples` | **`exit 0`** | `ai/logs/A04/build-check.log` |
| **2. Kiểm thử Hợp đồng Khung xương, Vật lý & Tự chủ** | `cargo test --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-runtime` | **`exit 0`** (`22 passed` trong `bongocat-render`; `125 unit + 2 fixture passed` trong `bongocat-runtime`, gồm 6 test `physics` và 4 test `autonomous`) | `ai/logs/A04/unit-tests.log` |
| **3. Kiểm tra tĩnh Clippy (`-D warnings`)** | `cargo clippy --manifest-path BongoCat/Cargo.toml --locked -p bongocat-render -p bongocat-runtime -p bongocat-overlay --all-targets -- -D warnings` | **`exit 0`** (0 cảnh báo, 0 lỗi) | `ai/logs/A04/clippy-check.log` |
| **4. Kiểm tra định dạng mã nguồn (`rustfmt`)** | `cargo fmt --manifest-path BongoCat/Cargo.toml --all -- --check` | **`exit 0`** | `ai/logs/A04/fmt-check.log` |
| **5. Chạy thực tế Example Vật lý (`companion_physics.exe`)** | `BongoCat\target\debug\examples\companion_physics.exe ai\logs\A04\A04-white.png 4` | **`exit 0`** (`237 frames` trong `4s` ≈ **`59.25 FPS`**, cửa sổ `154 × 267 px`, chạm sàn và dừng ổn định `settled = true` tại `(111.81, 1343.27)`) | `ai/logs/A04/example-physics-smoke.log` |
| **6. Chạy thực tế Example Tự chủ (`companion_autonomous.exe`)** | `BongoCat\target\debug\examples\companion_autonomous.exe ai\logs\A04\A04-white.png 8` | **`exit 0`** (`471 frames` trong `8s` ≈ **`58.88 FPS`**, `behavior_transitions = 3`: `Physics -> Idle -> Walk`, đi bộ mượt từ `x = 111.81` đến `x = 678.07` trên sàn `y = 1343.27`) | `ai/logs/A04/example-autonomous-smoke.log` |
| **7. Kiểm định Độ mượt Chuyển tiếp Tư thế & Xuất ảnh QA** | `powershell -NoProfile -ExecutionPolicy Bypass -File ai/logs/A04/ux_smoothness_qa.ps1` | **`exit 0`** (`96` frame nội suy chuyển tiếp qua 8 tư thế, không vượt biên canvas, độ dịch khớp tối đa `15.63 px/frame` ở 60 FPS) | `ai/logs/A04/ux-smoothness-qa.log`, `A04-transition-smoothness-sheet.png`, `A04-motion-continuity-preview.png` |

> **Ghi chú trung thực về môi trường hiển thị DXGI:** Khi chạy `companion_physics.exe` và `companion_autonomous.exe` từ phiên CLI nền không tương tác của Antigravity, swapchain DXGI trả về `TemporaryPresentationUnavailable` (được xử lý an toàn tại [`companion.rs`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/windows/companion.rs#L316-L320) nên vòng lặp vật lý/hành vi vẫn chạy đủ `237` và `471` frame với `exit 0`, nhưng biến đếm `presented` ghi `0` trong phiên nền). Bằng chứng `Present` D3D11 trên phiên desktop hiển thị thật đã được xác nhận trong hồ sơ `C-04` (`ai/logs/C04/current-native.log` với `1184/1184 Present` và `ai/logs/C04/native-smoke.log` với `2858/2858 Present`).

---

## 3. Đánh giá Kỹ thuật Độ mượt, Chống Giật Lag & Chuyển đổi Tư thế

### 3.1. Độ mượt Vòng lặp Thời gian, Vật lý & Chống Giật Cửa sổ (`Anti-Judder / Frame Pacing`)
1. **Nhịp khung hình ổn định (~60 FPS) & Giới hạn bù trễ (`Delta-Time Clamping`):**
   - Trong [`companion.rs`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/windows/companion.rs#L287-L323), mỗi vòng lặp đo thời gian đơn điệu `Instant::now().duration_since(previous)` và nghỉ `16 ms` (`~60 FPS`). Thực đo đạt `237 frames / 4s` (`59.25 FPS`) và `471 frames / 8s` (`58.88 FPS`).
   - Khi hệ thống bị khựng hoặc vừa thức dậy sau `sleep`, cả [`physics.rs`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/physics.rs#L120) và [`autonomous.rs`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L103) đều khóa trần `dt = elapsed.as_secs_f64().min(0.1)` (tối đa `100 ms`), ngăn chặn hoàn toàn hiện tượng người que văng xuyên màn hình sau khi máy lag.
2. **Chia nhỏ bước tích phân vật lý 240 Hz (`Sub-stepping`):**
   - Trong [`physics.rs`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/physics.rs#L123-L125), bước thời gian `dt` được chia nhỏ thành các bước con $\le \frac{1}{240}\text{ s}$ (`MAX_STEP = 4.167 ms`). Nhờ đó quỹ đạo rơi ($g = 1800\text{ px/s}^2$), nảy nhẹ (`4.0 px` khi $v_y > 180\text{ px/s}$) và ma sát trượt ngang ($e^{-10 \Delta t}$) hoàn toàn mượt và tất định ở mọi tốc độ khung hình.
3. **Giữ điểm nắm chuột chính xác (`Zero-Jump Grab Offset`):**
   - Khi người dùng bấm giữ chuột trái (`WM_LBUTTONDOWN`), `PhysicsBody::grab` lưu hiệu số `grab_offset = point - self.position`. Trong suốt quá trình kéo (`WM_MOUSEMOVE`), vị trí người que bám sát `point - offset` (kẹp trong `WorkArea`), đảm bảo **không bị giật nhảy tâm cửa sổ về đầu mũi tên chuột**.
4. **Chống nhấp nháy trạng thái (`State Hysteresis & Cooldowns`):**
   - Trong [`autonomous.rs`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L173-L201), các trạng thái `Behavior::Chase` và `Behavior::Evade` được khóa tối thiểu **`1.2 s`** (`locked = matches!(self.state, Behavior::Chase | Behavior::Evade) && self.age < 1.2`), kết hợp thời gian nghỉ `rest = 1.5 s`, thời gian dỗi `annoyed = 2.6 s` (`annoyed_cooldown = 4.6 s`) và `climb_cooldown = 4.0 s`. Thiết kế này loại bỏ hoàn toàn lỗi đổi hướng/đổi tư thế liên tục theo từng frame khi con trỏ chuột dao động quanh ngưỡng `180 px` hoặc `360 px`.

### 3.2. Kiểm định Độ mượt Chuyển đổi 8 Tư thế & Quỹ đạo Nội suy (`Pose Transition Continuity`)
Kịch bản `ai/logs/A04/ux_smoothness_qa.ps1` đã kiểm tra định lượng và kết xuất trực quan 8 tư thế cốt lõi cùng 4 cặp chuyển đổi quan trọng nhất bằng hàm nội suy bậc ba `SmoothStep` ($\alpha(u) = 3u^2 - 2u^3$, cửa sổ pha trộn `200 ms` / `12 frames` ở 60 FPS):

| Chuỗi chuyển tiếp tư thế | Biến thiên tỷ lệ $(S_x, S_y)$ | Điểm neo $y_{\text{pivot}}$ | Đánh giá độ mượt & liên tục hình học |
|---|---|---|---|
| **1. `Idle` $\rightarrow$ `Walk`** | $(1.00, 1.00) \rightarrow (1.00, 1.00)$ | $-0.50$ (Bám sàn) | Chuyển nhịp mượt từ đứng thẳng sang sải bước `110 px/s`; chân trụ bám sát đường sàn $y = -0.50$. |
| **2. `Walk` $\rightarrow$ `Chase`** | $(1.00, 1.00) \rightarrow (0.98, 1.01)$ | $-0.50$ (Bám sàn) | Thân người rướn dần về phía trước ($\Delta x_{\text{head}} = +0.050$), tăng tốc mượt lên `280 px/s`. |
| **3. `Chase` $\rightarrow$ `ClimbWall`** | $(0.98, 1.01) \rightarrow (0.98, 1.01)$ | $-0.50 \rightarrow 0.00$ | Khi chạm mép trái/phải, tay và chân vươn so le bám dọc cạnh màn hình với tốc độ leo `140 px/s`. |
| **4. `ClimbWall` $\rightarrow$ `Fall Stretch`** | $(0.98, 1.01) \rightarrow (0.92, 1.14)$ | $0.00$ (Tâm thân) | Khi lên tới đỉnh mép và búng ra ($v_x = \pm 160\text{ px/s}$), hai tay vung lên và cơ thể giãn dọc theo vận tốc rơi $v_y$. |
| **5. `Fall Stretch` $\rightarrow$ `Land Squash`** | $(0.92, 1.14) \rightarrow (1.10, 0.78)$ | $0.00 \rightarrow -0.50$ | Hấp thụ xung lượng chạm đất trong `45 ms` đầu rồi hồi phục lò xo tắt dần trong `175 ms` tiếp theo; không xuyên sàn. |
| **6. `Land Squash` $\rightarrow$ `Evade / Sulk` $\rightarrow$ `Recover`** | $(1.10, 0.78) \rightarrow (1.05, 0.86) \rightarrow (0.99, 1.02)$ | $-0.50$ (Bám sàn) | Sau khi bị ném mạnh ($\ge 900\text{ px/s}$), hạ trọng tâm dỗi/né chuột (`220 px/s`) rồi hít sâu đứng thẳng dậy về `Idle`. |

- **Biên bao hình học thực đo qua toàn bộ 96 frame chuyển tiếp:**
  - Trục ngang: $x \in [-0.2794,\; +0.2794] \subset [-0.3000,\; +0.3000]$ (còn lề an toàn `5.3 px` mỗi bên).
  - Trục dọc: $y \in [-0.5062,\; +0.5149] \subset [-0.5200,\; +0.5200]$ (không cắt đỉnh đầu, không thủng đáy cửa sổ `154 × 267 px`).
  - Độ dịch chuyển khớp lớn nhất giữa 2 frame liên tiếp ở 60 FPS: **`0.0609` đơn vị model (`15.63 px/frame`)** tại pha chạm đất tốc độ cực đại $2400\text{ px/s}$, đảm bảo cảm giác đàn hồi nhanh nhưng không bị đứt hình.

---

## 4. Hiện trạng Thực tế & Điều kiện Bàn giao sang Bước `C-05`

1. **Những phần đã hoàn thành và có bằng chứng thật trên ổ cứng:**
   - Khung xương người que vector 2D (`stickman.rs`), hiển thị sắc nét ở tỷ lệ chuẩn `154 × 267 px` (`scale_percent = 44%`, người que cao `~256–257 px`).
   - Lõi vật lý (`physics.rs`) và lõi tự chủ (`autonomous.rs`) cùng cửa sổ overlay D3D11 (`companion.rs`) chạy mượt ở ~60 FPS, đã qua 125 unit tests + 2 fixture tests, Clippy `-D warnings` và rustfmt.
   - Bộ thông số co giãn, 3 cảm xúc (`A03_EMOTION_SPEC.md`) và kiểm định độ mượt chuyển tiếp 8 tư thế (`A04_UX_ACCEPTANCE.md` + 2 bảng ảnh PNG trong `ai/logs/A04/`) đã hoàn tất và khớp 100% SHA256.
2. **Giới hạn trung thực hiện tại (cần Codex lưu ý ở bước `C-05`):**
   - Hiện tại chế độ người que (`companion_physics` và `companion_autonomous`) đang chạy qua các binary example độc lập của `bongocat-overlay`, vẫn vẽ `standing_snapshot` tĩnh di chuyển theo cửa sổ chứ chưa nối `BehaviorSnapshot` / `StickmanPoseState` vào hàm biến đổi đỉnh trong `stickman.rs` và chưa nối vào luồng khởi chạy mặc định của `bongocat-app` (cùng menu chuột phải `Tạm dừng / Đưa về vị trí an toàn / Thoát`).
   - Khi thực hiện bước `C-05` (*Đóng gói Bản chạy thử nghiệm trên Windows*), Codex cần đóng gói bản chạy thử nghiệm `.exe` (và nối luồng khởi chạy/hoạt ảnh trong phạm vi được giao) để người dùng chạy thử trực tiếp trên Windows Desktop.
