# Senko GĐ2 — S2-01 đến S2-07

27/10/2026. Leader giao triển khai kế hoạch GĐ2–GĐ5, giữ cổng nghiệm thu từng giai
đoạn. Lượt này đã triển khai đến bản GĐ2 để nghiệm thu; **chưa bắt đầu GĐ3–GĐ5**.
Không đánh dấu Leader đã duyệt nhịp mới hoặc nghiệm thu trải nghiệm GĐ2.

## Bản chạy và hình

- Release `BongoCat/target/release/examples/companion_senko.exe` dùng
  `resources/characters/senko-v3-g2/candidate-v2`; shortcut Senko Pet và Chay_Pet.bat
  đã chuyển sang bộ này. Đã mở release, PID47868 tại lần kiểm tra, phản hồi tốt;
  mở lần2 exit0, còn một tiến trình. Evidence release-process.json ghi hash EXE.
- Bộ233PNG/45clip: giữ nguyên byte141PNG GĐ1, thêm92ảnh/17clip. Thêm idle_back34
  bốn ảnh; mỗi hướng front/34/back34/back thêm walk8/run8/start3/stop3. Side giữ
  walk/run16. Cả hai mật độ giữ144px mỗi vòng, stride lần lượt18/9px mỗi frame.
- Năm hướng gốc và mirror ba hướng nghiêng cung cấp tám hướng. Front/back không
  mirror. Chỉ ảnh/harness có tám hướng; trên desktop hiện vẫn đi ngang theo vật lý
  nền GĐ0, không đi lên khoảng trống. World/đường đi nằm ở GĐ3.
- Nguồn ImageGen, prompt và SHA ở senko-v3-g2-source. Ngoại lệ asset theo nhiệm vụ
  trực tiếp; không ghi đè141ảnh, bộ46ảnh hoặc bàn giao Gen.
- Gallery `candidate-v2/preview/index.html`; preview từ Animator thật tại
  `candidate-v2/animator-preview-v2/index.html`:16GIF walk/run×8hướng +turn và trace.
  GIF Animator160×160, HTML hiển thị320×320 nearest; GIF từng clip ở gallery là
  320×320. Không tính các ảnh lặp theo tick của GIF demo thành asset mới.

## Mã và giao diện

| Mã | Triển khai | Trạng thái |
|---|---|---|
| S2-01 | Ma trận hướng và bộ233ảnh/45clip, PNG/GIF/manifest | QA kỹ thuật đạt, chờ Leader duyệt hình |
| S2-02 | render/sprite_anim.rs: SpriteLibrary/SpriteClip/SpriteFrame, loader/mask/timing | Mã và test đạt |
| S2-03 | TextureFilter Linear/Nearest theo phiên, samplerD3D11 và lựa chọn Metal; canvas320 | GPU Windows đạt; macOS chưa build/QA |
| S2-04 | runtime/animator.rs: Direction8/AnimAction/AnimStage/AnimPose/Animator | Mã/test/preview đạt |
| S2-05 | distance/sync, budget an toàn, đặt chân tại chỗ, turn70ms và cooldown500ms | Test mọi16pha chân đạt |
| S2-06 | companion_sprites.rs, runner mới, foot adapter, mask theo Present; launcher/shortcut | Release/native đạt |
| S2-07 | Test, native/GPU readback, preview và bản để nghiệm thu | Chờ Leader nghiệm thu trải nghiệm |

Loader kiểm tra schema1,80×80,scale4,anchor40/76; file/số ảnh/delay/sync/stride;
alpha0/255/palette≤32; từ chối path escape và symlink thoát thư mục. Nạp trước
session. Lỗi bộ mới trả về lifecycle/log/dialog, không âm thầm dùng ảnh cũ.

Animator nhận thời gian đơn điệu và **quãng đường tự di chuyển so với bề mặt**.
Vị trí do cửa sổ chở không được tăng phase. Khi dừng có thể hoàn tất bước trong
budget; thiếu khoảng trống thì chạy các tư thế đặt chân ở gốc cố định rồi stop.
Bế/rơi ngắt ngay. Turn cam kết đích đến, tránh đảo giữa chừng, tối thiểu500ms
giữa hai lần bắt đầu đổi hướng. Pause không tiến clock/phase.

Phiên dùng body adapter104×248; chân=(body.x+52,body.y+248), cửa sổ=chân−(160,304).
Không đổi nghĩa PhysicsBody/người que. Hit-test theo frame/mirror đã Present
thành công và gốc HWND hiện tại, kể cả HWND đã di chuyển nhưng Present tạm lỗi.
Capture giữ đến release/cancel; menu/pause/reset/mutex/lifecycle được giữ.

Đường46frame cũ còn qua lựa chọn rõ ràng:

```powershell
& .\BongoCat\target\release\examples\companion_senko.exe .\resources\characters\senko 0 --legacy
```

Thoát pet hiện tại trước khi muốn chạy bản legacy, vì mutex vẫn chặn mở trùng.
Không cần xóa trạng thái cục bộ. Shortcut trước lượt có bản sao trong logGĐ2.

## Kiểm tra đã thực hiện

Script/log/evidence trong `ai/logs/SENKO-G2/`:

| Kiểm tra | Kết quả |
|---|---|
| Render/runtime |28render +136runtime +2fixture đạt |
| Overlay lib |112đạt,10opt-in bỏ qua trong lượt thường |
| Pipeline / lifecycle |8 +2test đạt |
| Native GĐ2 final |3đạt: grab/drag/release/pause/reset/exit bằng SendMessage; sustained Present; GPU readback |
| GPU |5hướng kiểm tra khối4×4/hardalpha/mirror; ảnh GPU lưu trong log |
| Native hồi quy C02/C03/C04/C05 |4đạt; C04 chạy20giây, cả hai mép giữ hành vi người que |
| Native46ảnh |1smoke đạt |
| QA ảnh GDI+ độc lập |233PNG,45GIF,32RGBA,233đáy y76; unique pixel hash trong từng clip |
| Bảo toàn bộ GĐ1 |141PNG SHA256 khớp;28thời lượng GIF gốc không đổi |
| Preview Animator |16trace walk/run×8hướng đều có start/moving/stop và kết thúc Idle; thêm turn GIF |
| Build/lint |release đạt; Clippy all-targets ba crate +asset-tools đạt; fmt file sửa/diff-check đạt |
| Cargo update --workspace |0package đổi phiên bản; lock chỉ thêm6quan hệ dependency đã có trong workspace |

Native input là **thông điệp Win32 tổng hợp**, không tuyên bố đã có lượt chuột tay
thật/menu popup thật trên GĐ2. Đã xem nguồn/strip và ảnh GPU; preview/live release
còn cần Leader đánh giá cảm nhận. Không coi hash/đủ frame là bằng chứng mọi pose đẹp.

Lỗi tìm được: candidate-v1 thiếu sync cho các clip distance ngoài side; loader
đã chặn. Sửa writer xuất sync cho mọi clip distance và xuất candidate-v2; v1 có
REJECTED.md. Một lượt native hồi quy thiếu biến output-dir nên không chạy được;
đã giữ log unconfigured và chạy lại đủ cấu hình,4test đạt. Các lỗi ban đầu không
được tính là kết quả đạt.

## Giới hạn và bước tiếp

Chưa thế giới cửa sổ, brain/app context/xoa đầu/đuôi thực tế, persistence hoặc
P2/benchmark/QA30phút trên binary mới. GĐ0 từng kiểm tra30phút không được dùng
thay cho soak GĐ2. Hành vi lựa chọn ý định hiện vẫn là nền GĐ0; yêu cầu không
luôn đuổi con trỏ được triển khai ở S4-02/S4-03 sau GĐ3, không giả vờ đã có brain.

Không fullworkspace just check hoặc fullfmt; lỗi format ngoài phạm vi đã có từ
lượt trước không bị sửa ké. Không chứng nhận macOS/soak8giờ. ADR-0098 và Technical
Design ghi hợp đồng mới. Master/TASKS ghi quyết định Leader và cổng giai đoạn.

Fetch thấy origin/master2badde88; giữ dirty checkout, không merge upstream, không
commit/push/đổi nhánh hoặc sửa bàn giao Gen. CHANGELOG bỏ qua: tiếp tục phát triển
Senko chưa phát hành, không thêm mục nhật ký phát hành cho từng bước. Không có
dữ liệu người dùng cần xóa. **Bước tiếp theo: nghiệm thu GĐ2, rồi S3-01.**
