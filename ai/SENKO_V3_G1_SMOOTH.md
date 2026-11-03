# SENKO-V3-G1-SMOOTH — tăng ảnh trung gian

Ngày 27/10/2026. Leader xác nhận tạo hình hiện có ổn và yêu cầu thêm ảnh để tăng
độ mượt. Điều chỉnh mật độ B4 theo chỉ thị trực tiếp, không thêm hành vi/GĐ2.
Codex tiếp tục ngoại lệ sản xuất asset đã giao ở GĐ1.

## Bộ bàn giao

`resources/characters/senko-v3-p1/candidate-v6-smooth`: **141 PNG / 28 clip**,
giữ nguyên byte của 100 PNG candidate-v2, thêm **41 ảnh AI trung gian / 11 clip**.
`preview/compare.html`: trái cũ, phải mới; 11 GIF so sánh cùng thời lượng.
`preview/index.html`: toàn bộ 28 clip, PNG rời và GIF ×4.

| Clip | Cũ → mới |
|---|---:|
| walk_side / run_side | mỗi clip 8 → 16 |
| climb_up | 6 → 12 |
| mantle | 5 → 9 |
| headpat | 6 → 11 |
| land / sit_enter / sit_exit / wake | mỗi clip 3 → 5 |
| walk_start / walk_stop | mỗi clip 2 → 3 |

17 clip còn lại giữ nguyên, gồm held_happy 4 frame. Ban đầu thử thêm45ảnh/12clip;
loại4 ảnh held_happy sau hai lượt tạo vì tóc/đuôi lệch khi xen key gốc. Không lấy
số lượng ảnh làm bằng chứng chất lượng. v3/v4/v5 có REJECTED.md, không dùng để
tích hợp; giữ làm bằng chứng QA. Candidate-v2 được bảo toàn.

## Thực hiện

- ImageGen tạo bốn sheet đầu, sau QA tạo lại riêng walk/run/start/headpat và thử
  lại held theo strip gốc. Nguồn/prompt/SHA256 ở `smooth-source/`.
- Rust chuẩn hóa nền magenta, palette, alpha cứng, trục thân và đáy y76. Tỷ lệ
  midpoint khớp chiều cao trung bình hai key kề nhau, tránh lệch kích thước từ
  sheet AI. Không sửa PNG gốc hoặc lặp ảnh để tăng số frame.
- Loop có midpoint cuối→đầu; one-shot chỉ chèn giữa key. Preview chia chính xác
  delay centisecond GIF gốc; terminal key one-shot giữ delay cũ. Manifest thêm
  preview_frame_ms/frame_ms; bộ tiêu thụ GĐ2 phải đọc mảng, không lấy ms×số ảnh.
- Walk/run giữ quãng đường vòng: stride18×8 →9×16, sync0/4 →0/8.
- CLI offline: `--smooth <base> <sources> <NEW-output>`, từ chối ghi đè output.
  inbetweens.rs quản lý nguồn sửa và loại held không đạt.

## Kiểm định đã thực hiện

Script/log tái lập ở `ai/logs/SENKO-G1-SMOOTH/`:

- 8unit/roundtrip tests đạt; Clippy bin `-D warnings` và rustfmt pipeline/helper
  đạt. Không tuyên bố fullworkspace fmt/test.
- Windows GDI+ độc lập:141PNG80×80,28GIF320×320 đúng số frame, palette32RGBA,
  alpha0/255, không magenta/cắt biên; hash pixel giải mã khác nhau trong từng clip.
  Evidence ghi bbox từng ảnh, tất cả bottom y76.
- 100PNG key khớp SHA256 tại đúng vị trí mới;28tổng thời lượng GIF giải mã khớp
  bộ cũ và preview_frame_ms; quãng đường/sync walk/run bảo toàn.
- Đã xem source và strip tĩnh11clip sửa, đối chiếu mặt/tóc/chân/tay/đuôi.
  Motion audit có mean pixel delta thấp hơn ở11clip: đi8.982→8.462,
  chạy16.206→13.610. Chỉ báo này **không phải phép đo cảm nhận độ mượt**;
  còn khoảng chuyển chưa giảm max delta. Không khẳng định mọi đoạn hoàn hảo
  hoặc đã QA trực tiếp trên pet đang chạy.

## Giới hạn và bàn giao

Bộ mới là ứng viên xem trước GĐ1, chưa Leader nghiệm thu nhịp mới/chưa nối
Animator GĐ2. Không thay bộ Senko đang chạy, physics, hành vi hoặc mã Gen.
Chưa bổ sung hai hướng còn thiếu của ma trận tám hướng. GĐ0 giữ kết quả kiểm tra
30phút theo Leader, không suy rộng từ lượt asset này.

Không commit/push/đổi nhánh. Fetch thấy origin/master tiến lên a8d68d63; giữ dirty
checkout, chưa merge hoặc tuyên bố kiểm tra trên upstream mới. CHANGELOG bỏ qua
vì ứng viên offline chưa tích hợp/phát hành. Không dữ liệu người dùng cần xóa.
