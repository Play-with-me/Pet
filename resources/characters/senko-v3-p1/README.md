# Senko P1 — bộ ứng viên GĐ1

Ngày tạo: 27/10/2026. Nguồn: AI ImageGen tích hợp trong Codex, sau đó chuẩn hóa bằng Rust. Không gắn nhãn vẽ tay hoặc asset cộng đồng.

Các ảnh `source/` là sprite sheet mới tạo, không lấy từ 46 ảnh `../senko/` đang chạy. Mỗi sheet dùng `idle.png` làm tham chiếu tạo hình (trừ chính idle). Một lượt sửa sheet climb bổ sung frame mantle còn thiếu; bản nguồn được chọn có 14 pose, không nhân đôi frame để bù.

Danh sách B4 P1 có **28 clip, 100 frame** khi cộng chính xác. Tổng “≈101” trong plan là ước lượng. Không thêm P2, không đổi runtime trong GĐ1.

## Tái tạo

Từ thư mục Pet:

```powershell
& "$env:USERPROFILE/.cargo/bin/cargo.exe" run --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --features senko-asset-tools --bin senko_asset_pipeline -- resources/characters/senko-v3-p1/source resources/characters/senko-v3-p1/candidate-NEXT
```

Output phải là thư mục **chưa tồn tại**. Pipeline kiểm tra đầu vào trước khi tạo output, không xóa hoặc ghi đè asset. `candidate-v1` bị loại vì cắt lưới đều không phù hợp các hàng nguồn AI; xem REJECTED.md trong đó. Chỉ dùng bản cuối được nêu trong báo cáo GĐ1.

Pipeline: khóa chroma toàn ảnh (kể cả lỗ kín); tách từng silhouette liên thông rồi gán tâm hình vào lưới dự kiến để không cắt ngang pose khi hàng/cột AI lệch; từ chối hình chạm biên ảnh, hình gộp/quá lớn hoặc nhiều silhouette lớn cùng ô; bỏ thành phần rời nhỏ; căn trục áo đỏ và đường tiếp xúc xuống `(40,76)`; dùng tỷ lệ chung trong từng sheet từ pose đứng cao 62 px; majority sampling theo ô; ép bảng 31 RGB chung + transparent; alpha chỉ 0/255; kiểm tra biên/canvas/count. Không co giãn mỗi pose theo chiều cao riêng.

`normalization.json` lưu sheet/cell, anchor nguồn, tỷ lệ và bbox đầu ra để kiểm tra lại. `(40,76)` là neo chung dự kiến của bộ ảnh; kiểm tra metadata không thay thế đánh giá thân/khớp có trượt khi chuyển clip. Các clip leo/bế còn cần hợp đồng điểm bám tay ở GĐ2–3.

## Đầu ra và duyệt

Mỗi clip có PNG gốc 80×80 đánh số từ 0. `preview/index.html` hiển thị 28 GIF ở ×4, cho đổi nền sáng/tối/màu và mở từng PNG. `preview/contact-sheet.png` gồm 100 frame đọc trái→phải, trên→dưới. Thứ tự và tên clip nằm trong trang preview.

`senko.anim.json` có trạng thái candidate, canvas/scale/anchor, danh sách file, số frame, facing/mirror và thông số nhịp dự kiến. GIF lặp để xem dù runtime clip có thể không lặp. Tốc độ GIF chỉ để duyệt hình; chưa phải Animator theo quãng đường. Trong manifest, stride_px=18 của walk/run biểu thị physical pixel mỗi frame theo công thức plan; chưa dùng trong app.

Nguồn chỉ có front, 3/4 trước, side, back theo bảng P1 của plan; chưa khẳng định đủ tám hướng di chuyển. Bộ ảnh cần Leader duyệt trước khi tích hợp GĐ2; PNG mới không tự thay thế `../senko/shime*.png`.

Feature `senko-asset-tools` chỉ bật encoder/decoder GIF có sẵn trong dependency image đã khóa; build Senko thông thường không cần bật feature này. Không thêm framework hoặc gọi mạng trong pipeline.
