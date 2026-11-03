# BÁO CÁO TOÀN DIỆN: KIỂM TRA & CHẨN ĐOÁN LỖI HOẠT ẢNH & TƯƠNG TÁC CHUỘT (SENKO-SAN DESKTOP PET)

> **Người thực hiện:** Antigravity (Cặp đôi AI với Codex, dưới sự chỉ đạo của Leader)  
> **Thời gian:** 26/10/2026  
> **Trạng thái:** **HOÀN TẤT KIỂM TRA & CHẨN ĐOÁN NGUYÊN NHÂN — CHƯA CODE (Tuân thủ nghiêm ngặt chỉ thị của Leader)**  
> **Mục tiêu:** Rà soát trực tiếp trên máy tính của Leader để làm rõ bản chất 2 nhóm lỗi: (1) Lỗi khi trỏ chuột tới và (2) Lỗi hoạt ảnh giật cục/méo hình; đồng thời đề xuất giải pháp kỹ thuật cụ thể chờ Leader duyệt.

---

## 1. TỔNG QUAN PHẠM VI KIỂM TRA TRÊN HỆ THỐNG

Chúng tôi đã tiến hành khảo sát và phân tích toàn diện trên các module mã nguồn Rust và tệp tài nguyên thực tế của ứng dụng Pet trên máy tính:
1. [crates/bongocat-runtime/src/autonomous.rs](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs): Kiểm tra logic máy trạng thái hành vi tự chủ, cự ly và vector tương tác với con trỏ chuột (`step`), cơ chế ném (`thrown`), và hàm ánh xạ frame hoạt ảnh ([`shimeji_frame_id`](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L28-L64)).
2. [crates/bongocat-overlay/src/windows/companion.rs](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/windows/companion.rs): Kiểm tra vòng lặp thông điệp Windows (`pump_window_messages`), lấy tọa độ chuột thời gian thực qua `GetCursorPos`, và cơ chế đẩy texture lên GPU DirectComposition.
3. [crates/bongocat-overlay/src/windows/window_proc.rs](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/windows/window_proc.rs): Kiểm tra xử lý thông điệp chuột `WM_NCHITTEST`, `WM_LBUTTONDOWN`, `WM_MOUSEMOVE` và tính xuyên thấu (`click_through`).
4. [crates/bongocat-overlay/src/bin/slice_sprites.rs](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/bin/slice_sprites.rs): Kiểm tra thuật toán bóc tách ô frame, khử phông nền, tính tỷ lệ co giãn (`scale`) và căn lề tọa độ (`offset_x`, `offset_y`).
5. **Kiểm tra trực tiếp 46 tệp Sprite PNG** tại thư mục [resources/characters/senko/](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/resources/characters/senko) bằng script đo đạc pixel thực tế (bounding box, min/max X-Y, độ trong suốt).

---

## 2. NHÓM LỖI 1: LỖI KHI TRỎ CHUỘT TỚI (MOUSE HOVER & CURSOR INTERACTION)

Khi người dùng di chuyển con trỏ chuột đến gần hoặc đặt lên bé Senko, xuất hiện 4 hiện tượng bất thường nghiêm trọng:

### 2.1. Hiện tượng "Rung lắc / Co giật trái-phải 60 FPS" khi chuột dừng trên thân Pet (Direction Oscillation Jitter)
* **Vị trí mã nguồn:** [crates/bongocat-runtime/src/autonomous.rs: dòng 223–229](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L223-L229)
  ```rust
  } else if distance <= 360.0 && self.annoyed == 0.0 {
      self.direction = if cursor.is_some_and(|p| p.x > center.x) {
          1.0
      } else {
          -1.0
      };
      self.state(Behavior::Chase);
  }
  ```
* **Bản chất toán học & Kỹ thuật:**
  * Thuật toán so sánh `cursor.x > center.x` có **ranh giới chuyển đổi bằng đúng 0 pixel** (Zero Deadzone / Không có vùng trễ dung sai).
  * Trong trạng thái đuổi theo (`Chase`), Pet di chuyển với tốc độ $v = 110\text{ px/s}$ (hoặc $280\text{ px/s}$ nếu chuột di chuyển). Ở tần số 60 FPS ($dt \approx 0.0166\text{s}$), mỗi tick Pet di chuyển một bước $\Delta x \approx 1.83\text{ px} - 4.65\text{ px}$.
  * Khi con trỏ chuột dừng yên trên thân Pet (khoảng cách ngang nhỏ hơn bước di chuyển $\Delta x$):
    * **Tick 1:** $p_x > \text{center}_x \implies \text{direction} = +1.0$. Pet bước sang phải một bước $\Delta x$, khiến tâm Pet vượt quá con trỏ chuột.
    * **Tick 2:** Bây giờ $p_x < \text{center}_x \implies \text{direction} = -1.0$. Pet lập tức quay đầu bước sang trái một bước $\Delta x$.
    * **Tick 3:** Lại thành $p_x > \text{center}_x \implies \text{direction} = +1.0$.
  * **Hậu quả thị giác:** Biến `self.direction` liên tục đảo cực giữa $+1.0 \leftrightarrow -1.0$ **mỗi 16 mili-giây** (60 lần/giây). Kéo theo đó, cờ `snapshot.facing_right = self.direction > 0.0` đảo ngược liên hồi, khiến hình ảnh Senko bị **lật gương trái-phải 60 lần/giây kết hợp rung giật vị trí $\pm 2\text{px}$**, trông giống hệt như nhân vật đang bị điện giật hoặc co giật mất kiểm soát ngay dưới chuột của Leader.

### 2.2. Hiện tượng "Vung chuột nhanh làm Pet bị ném văng / hoảng sợ vô cớ" (Accidental Swipe Fling)
* **Vị trí mã nguồn:** [crates/bongocat-runtime/src/autonomous.rs: dòng 211–213](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L211-L213)
  ```rust
  if cursor_speed > 1600.0 && distance < 180.0 && self.annoyed_cooldown == 0.0 {
      self.thrown(900.0);
  }
  ```
* **Bản chất toán học & Kỹ thuật:**
  * Khi người dùng lướt chuột bình thường trên màn hình (ví dụ: chuyển giữa 2 màn hình hoặc vung chuột đóng cửa sổ), tốc độ con trỏ thường xuyên đạt $2000 - 3000\text{ px/s}$ (tương đương di chuyển 35 - 50 px trong 16ms).
  * Đoạn code trên so sánh tốc độ con trỏ tự do `cursor_speed > 1600.0` và khoảng cách `< 180.0`. Khi thỏa mãn, nó gọi ngay `self.thrown(900.0)` và gán `self.annoyed = 2.6` **dù người dùng hoàn toàn chưa bấm chuột** (`held == false`).
  * **Hậu quả thị giác:** Leader chỉ vô tình lia chuột qua gần Pet, chưa hề bấm vào, nhưng Pet bỗng nhiên bị kích hoạt trạng thái ném rơi tự do (`Behavior::Physics`), rồi lập tức hoảng sợ bỏ chạy thục mạng (`Behavior::Evade`) sang góc màn hình.

### 2.3. Khung cửa sổ $180 \times 180$ nuốt tương tác chuột ở vùng đệm trong suốt (Transparent Box Interception)
* **Vị trí mã nguồn:** [crates/bongocat-overlay/src/windows/window_proc.rs: dòng 166–168](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/windows/window_proc.rs#L166-L168)
  ```rust
  if message == WM_NCHITTEST && unsafe { (*state).companion.is_some() } {
      return LRESULT(HTCLIENT as isize);
  }
  ```
* **Bản chất kỹ thuật:**
  * Cửa sổ Pet được cấu hình với cờ `click_through: false` và toàn bộ kích thước $180 \times 180\text{ px}$ đều phản hồi `HTCLIENT` cho hệ điều hành Windows.
  * Trong khi đó, nhân vật Senko thực tế chỉ chiếm một phần ở giữa, xung quanh là khoảng đệm hoàn toàn trong suốt (`Alpha = 0`).
  * **Hậu quả:** Khi người dùng rê chuột gần Pet (vẫn cách nhân vật một khoảng trống), Windows đã xem con trỏ nằm trong cửa sổ Pet. Các icon Desktop, nút bấm trên Taskbar hoặc thanh cuộn của cửa sổ nằm phía dưới vùng trong suốt này **bị Pet nuốt trọn chuột, không thể nhấp hay tương tác được**.

### 2.4. Thiếu hẳn phản ứng thân thiện khi rê chuột (No Hover / Headpat Reaction)
* **Bản chất thiết kế:**
  * Hiện tại logic chỉ có 2 thái cực: hoặc dí theo chuột điên cuồng (`Chase`), hoặc né chạy (`Evade`). 
  * Khi người dùng đặt chuột đứng yên ngay trên đầu bé Senko để cưng nựng, hệ thống không nhận diện được cử chỉ này để kích hoạt tư thế xoa đầu (`Headpat` vui vẻ phe phẩy đuôi) mà lại ép Pet chạy xô vào con trỏ gây ra lỗi co giật (Lỗi 2.1).

---

## 3. NHÓM LỖI 2: LỖI HOẠT ẢNH (ANIMATION BUGS & VISUAL GLITCHES)

Qua đo đạc trực tiếp 46 tệp ảnh `shime1.png` – `shime46.png` và cấu trúc chuyển frame, chúng tôi phát hiện 4 lỗi hoạt ảnh cốt lõi:

```
BẢNG ĐO ĐẠC THỰC TẾ BOUNDING BOX CỦA 46 FRAME SENKO (TRÍCH ĐOẠN ĐẶC TRƯNG):
Frame  Width  Height  MinX  MaxX  MinY  MaxY  Ghi chú
 1       71     117    28    98     8   124  Idle đứng chuẩn (Tâm trục X = 63)
 2       73     117    28   100     8   124  Bước chân trái
 3       73     117    28   100     8   124  Bước chân phải
11       91     117    18   108     8   124  Ngồi xổm (Scale bị phóng đại lên cao 117px!)
15       71     117    28    98     8   124  Idle liếc trái
17       91     117    18   108     8   124  Idle liếc phải (Đuôi lệch -> Trục thân bị dời 10px!)
18      115     117     6   120     8   124  Tiếp đất squash (Bị kéo giãn thành to khổng lồ)
20      117     113     6   122    12   124  Ngủ cuộn tròn (Méo tỷ lệ)
```

### 3.1. Hiện tượng "Nhân vật bị giật nảy / dịch chuyển 10 pixel mỗi giây khi đứng yên" (Idle Teleport Hiccup)
* **Vị trí mã nguồn:** 
  * [crates/bongocat-runtime/src/autonomous.rs: dòng 30–38](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L30-L38)
  * [crates/bongocat-overlay/src/bin/slice_sprites.rs: dòng 101](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/bin/slice_sprites.rs#L101)
* **Bản chất toán học & Kỹ thuật:**
  * Trong `Behavior::Idle`, mã phát luân phiên: frame `1` (từ 0.0s đến 0.7s), frame `17` (từ 0.7s đến 0.85s), và frame `15` (từ 0.85s đến 1.0s).
  * Trong tệp cắt `slice_sprites.rs`, tác giả dùng công thức căn giữa bounding box của từng ảnh riêng lẻ:
    `offset_x = (128 - scaled_w) / 2;`
  * Ở frame 1 và 15, nhân vật có `MinX = 28, MaxX = 98` (chiều rộng 71px, tâm nhân vật nằm ở $X = 63$).
  * Ở frame 17, đuôi cáo xòe rộng sang một bên nên `MinX = 18, MaxX = 108` (chiều rộng 91px, công thức tự đẩy lệch toàn bộ ảnh sang trái 10px để căn giữa cái đuôi).
  * **Hậu quả thị giác:** Cứ mỗi chu kỳ 1 giây, khi chuyển từ frame 1 sang frame 17, **toàn bộ thân người, đầu và chân của Senko bỗng dưng dịch chuyển tức thời (teleport) sang bên trái 10 pixel**, rồi 0.15 giây sau lại giật ngược về vị trí cũ! Người dùng nhìn vào thấy nhân vật bị giật nảy liên tục dù đang đứng thở.

### 3.2. Mất hoàn toàn hoạt ảnh bước đi và chạy mượt (Walk & Run Pacing Broken)
* **Vị trí mã nguồn:** [crates/bongocat-runtime/src/autonomous.rs: dòng 39–48](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs#L39-L48)
  ```rust
  Behavior::Walk | Behavior::Chase => {
      let step = (self.phase * 4.0) as usize % 4;
      match step {
          0 => 2,
          1 => 1,
          2 => 3,
          _ => 1,
      }
  }
  ```
* **Bản chất kỹ thuật:**
  * Chu kỳ `Walk` và `Chase` hiện chỉ luân phiên giữa 3 ảnh: frame 2 (bước chân trái), frame 1 (đứng yên!), và frame 3 (bước chân phải).
  * Trong khi đó, trên bảng Sprite Sheet gốc [sheet_locomotion.png](file:///C:/Users/kyuu4/.gemini/antigravity/brain/995d59a3-a0ec-4775-9076-d67b438a1e6c/sheet_locomotion.png), chúng ta đã tạo ra **8 frame bước đi hoàn chỉnh** (Hàng 1) và **8 frame chạy nước rút tốc độ cao** (Hàng 2). Nhưng toàn bộ các frame này chưa được nạp vào code runtime!
  * Tốc độ đổi frame bị cố định ở $4\text{ FPS}$ (mỗi bước kéo dài $250\text{ms}$). Khi bé Senko đuổi theo chuột với tốc độ cao ($280\text{ px/s}$), nhân vật trượt trên sàn như đang trượt băng trong khi chân chỉ nhúc nhích 4 lần/giây và liên tục chêm vào tư thế đứng yên bất động (frame 1).

### 3.3. Biến dạng tỷ lệ cơ thể (Scale Distortion / Giant Squash)
* **Vị trí mã nguồn:** [crates/bongocat-overlay/src/bin/slice_sprites.rs: dòng 97](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/bin/slice_sprites.rs#L97)
  ```rust
  let scale = (max_bound / char_h as f32).min(max_bound / char_w as f32).min(1.0);
  ```
* **Bản chất kỹ thuật:**
  * Mỗi ô sprite frame tự tính toán hệ số phóng đại `scale` độc lập sao cho chiều cao `char_h` hoặc chiều rộng `char_w` chạm mức tối đa $118\text{ px}$.
  * Tư thế đứng thẳng (cao) có $H = 180\text{ px}$ trên sheet gốc bị co lại $scale \approx 0.65$.
  * Nhưng các tư thế ngồi xổm (frame 11), tiếp đất squash (frame 18), hay ngủ cuộn tròn (frame 20) vốn có chiều cao tự nhiên rất thấp (chỉ khoảng $60 - 80\text{ px}$), lại bị thuật toán **phóng to hết cỡ lên $117\text{ px}$**!
  * **Hậu quả thị giác:** Khi ngồi xuống hoặc tiếp đất, thay vì bé Senko thấp người xuống sàn một cách đáng yêu thì bé lại **phình to khổng lồ như một quả cầu**, làm mất hoàn toàn tỷ lệ nhân vật.

### 3.4. Ép cứng chân nhân vật vào đáy cửa sổ (Loss of Vertical Freedom)
* **Vị trí mã nguồn:** [crates/bongocat-overlay/src/bin/slice_sprites.rs: dòng 102](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/bin/slice_sprites.rs#L102)
  `let offset_y = 126_u32.saturating_sub(scaled_h).min(target_size - scaled_h);`
* Mọi frame đều bị kéo điểm đáy của pixel thấp nhất xuống đúng dòng $Y = 126$. Khi nhân vật nhảy lên không trung (`shime22.png`) hoặc rơi tự do (`shime4.png`), nhân vật vẫn bị ghim sát đáy hộp $128 \times 128$, triệt tiêu cảm giác đang ở trên không.

---

## 4. BẢNG TỔNG HỢP NGUYÊN NHÂN & GIẢI PHÁP ĐỀ XUẤT (CHỜ DUYỆT)

| Vấn đề phát hiện | Nguyên nhân gốc rễ | Giải pháp kỹ thuật chuẩn xác (Khi được duyệt) |
| :--- | :--- | :--- |
| **1. Rung lắc co giật 60Hz khi trỏ chuột** | So sánh $0\text{px}$ `p.x > center.x` không có Deadzone gây đảo hướng liên tục | Thiết lập **Deadzone $\pm 35\text{px}$ quanh tâm**. Trong vùng này, dừng di chuyển, giữ nguyên hướng và chuyển sang tư thế ngước nhìn/nghỉ ngơi. |
| **2. Bị văng ném khi vung chuột nhanh** | Ngưỡng `cursor_speed > 1600` tự kích hoạt `thrown()` dù không nhấn giữ chuột | Bỏ kích hoạt `thrown()` khi chuột tự do. Chỉ cho phép rơi/ném khi người dùng chủ động kéo-thả chuột trái (`PointerEvent::Release`). |
| **3. Cửa sổ $180 \times 180$ nuốt chuột xung quanh** | `WM_NCHITTEST` trả về `HTCLIENT` cho toàn bộ hình chữ nhật kể cả pixel trong suốt | Cập nhật `WM_NCHITTEST` kiểm tra Alpha kênh màu: pixel có `alpha < 30` sẽ trả về `HTTRANSPARENT` cho chuột xuyên qua bấm ứng dụng khác. |
| **4. Thiếu cử chỉ xoa đầu thân thiện** | Chưa có nhánh nhận diện chuột rê chậm trên đầu | Khi chuột hover nhẹ ở phần đầu ($Y < \text{center}_y$), kích hoạt chuỗi hoạt ảnh **Headpat & Purr (8 frame)** ve vẩy đuôi thích thú. |
| **5. Giật nảy 10px mỗi giây ở Idle** | Căn giữa bounding box độc lập làm lệch trục xương sống ($X=63$ sang $X=53$) | Khóa cứng trục xương sống nhân vật cố định tại **$X = 64$** cho toàn bộ 46 frame; mọi xòe đuôi/nghiêng đầu vẽ tỏa đều từ trục chuẩn. |
| **6. Hoạt ảnh đi/chạy giật cục 4 FPS** | Chỉ dùng 2 frame lẻ chêm frame đứng yên, thiếu 8 frame Walk & Run thật | Nạp toàn bộ **8 frame Walk chu kỳ khép kín** và **8 frame Run nước rút** từ Sheet 1, phát ở nhịp $10 - 12\text{ FPS}$ nội bộ. |
| **7. Nhân vật ngồi/squash bị phình to** | Hàm scale tự động cực đại hóa từng frame riêng biệt theo chiều cao hộp | Dùng một hệ số phóng đại cố định (Global Scale Ratio) cho mọi frame, giữ nguyên tỷ lệ tương đối giữa đứng thẳng, ngồi và cuộn tròn. |

---

## 5. KẾ HOẠCH TRIỂN KHAI DỰ KIẾN (KHI LEADER DUYỆT)

1. **Công việc 1: Cắt lại và chuẩn hóa bộ Sprite Sheets bằng công cụ chính xác (Asset Alignment):**
   - Cố định đường sàn $Y_{\text{floor}} = 124\text{ px}$ và trục tim người $X_{\text{spine}} = 64\text{ px}$.
   - Áp dụng Global Scale cố định để bảo toàn tỷ lệ nhân vật Senko (ngồi, nhảy, tiếp đất không bị méo).
   - Xuất trọn vẹn các chuỗi cử động: 8 frame Idle thở, 8 frame Walk, 8 frame Run, 8 frame Headpat xoa đầu, 4 frame Fall, 4 frame Land.
2. **Công việc 2: Nâng cấp Runtime Máy trạng thái trong [autonomous.rs](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-runtime/src/autonomous.rs):**
   - Thêm vùng trễ $\pm 35\text{px}$ dứt điểm hoàn toàn hiện tượng rung lắc/co giật đảo hướng.
   - Bỏ trigger ném chuột tự do.
   - Thêm trạng thái `Behavior::Curious` (Tò mò khi chuột lại gần) và `Behavior::Headpat` (Khi xoa đầu).
   - Nâng cấp bộ tính toán frame hoạt ảnh nội suy theo thời gian thực (8 - 12 FPS) khớp với từng bước chạy.
3. **Công việc 3: Tinh chỉnh Overlay Hit-Testing trong [window_proc.rs](file:///C:/Users/kyuu4/OneDrive/Documents/Pet/BongoCat/crates/bongocat-overlay/src/windows/window_proc.rs):**
   - Đảm bảo chuột chỉ bắt trúng cơ thể Senko, phần trong suốt cho phép click xuyên thấu xuống cửa sổ bên dưới.

---

> [!NOTE]
> **Cam kết từ Antigravity:** Báo cáo này hoàn toàn là kết quả khảo sát, đo đạc và phân tích kỹ thuật thực tế trên máy tính của Leader. Theo đúng mệnh lệnh của Leader, **chúng tôi chưa sửa hay thêm bất kỳ dòng code nào** vào ứng dụng. Xin kính trình Leader xem xét bản chẩn đoán trên!
