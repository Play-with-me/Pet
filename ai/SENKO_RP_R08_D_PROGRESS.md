# SENKO-RP-R08-D — Codex nhận sản xuất P2 (29/10/2026)

## Thay đổi phân công được leader chỉ đạo
Leader: “Bây thay thế Gen để làm phần này đi”. Codex nhận tạo hình/hoạt ảnh P2
trong ma trận R08 đã duyệt, cùng chuẩn hóa/kiểm định/tích hợp. Không tiếp tục coi
Gen là phụ thuộc chặn sản xuất P2. Đây là ngoại lệ trực tiếp về ownership P2,
không thay quy tắc hoặc tự nhận phần UI khác. Không subagent.

## Bản nháp nhóm đầu đã tạo
Dùng built-in imagegen với idle_34/0 và headpat/4 v5 làm tham chiếu. Lần1 có ký hiệu
nổi, đã dùng imagegen chỉnh lần2 để bỏ ký hiệu, giữ các chuỗi hành động. Lưu cả hai
nguồn mới ở resources/characters/senko-v3-r08-source, không ghi đè v5.

Thêm chế độ --p2-attention trong công cụ asset để tách6×4, dùng cùng một scale theo
frame tham chiếu đầu sheet, neo chân, canvas80/scale4 và palette31màu+transparent
của pipeline hiện có. Không nội suy, không kéo chân, không thay ảnh thiếu bằng đứng.

| Clip nháp | Frame | Thời lượng |
|---|---:|---:|
| attention_glance |6|890ms|
| curious_tilt |6|930ms|
| play_accept |6|910ms|
| farewell_look |6|1100ms|

Candidate độc lập: resources/characters/senko-v3-r08/candidate-attention-v1.
Preview/index.html ghép v5 idle400ms → clip mới → v5 idle500ms. GIF lặp để xem lại;
manifest là one-shot. Có PNG80×80, manifest, GIF, contact-sheet và provenance các
frame/scale/anchor từ pipeline. Không merge manifest vào bộ đang chạy.

## Kiểm tra thực hiện
- Đã xem source và contact-sheet chuẩn hóa. Nền đầu ra trong suốt/hard alpha,
  đủ24frame, palette32RGBA, không cắt canvas theo validator.
- SpriteLibrary production audit:4clip/24frame, cấu trúc hợp lệ. runnerValid=false
  là đúng vì đây là fragment P2, chưa có các clip nền và chưa tích hợp.
- Asset-tool12/12 test, Clippy asset-tool/tests đạt. Chưa test native actor vì chưa nối.
- Lần normalize đầu thiếu thư mục cha output nên dừng, tạo thư mục mới rồi chạy lại
  thành công; giữ log -prepare.log và -prepare-final.log. Không xóa/ghi đè candidate.
- Không buildrelease, không thay bộ v5 hoặc ứng dụng; không nhận audit là duyệt hình.

## Chưa nghiệm thu
Đây là **bản nháp để duyệt hướng hình**, không phải hoàn thành P2 hoặc chứng nhận
độ mượt. So với v5 vẫn cần duyệt khuôn mặt/hướng3/4, tỷ lệ đầu và biến thiên silhouette
qua các pose, đặc biệt chỗ chuyển vào/ra. Preview có v5 trước/sau để lộ rõ khác biệt,
không che bằng blur/tween. Số frame tiếp tục điều chỉnh qua preview tốc độ thật.

Sau khi hướng hình nhóm đầu được duyệt/sửa, tiếp nhóm xoa đầu/đuôi/dỗi/làm hòa,
bế/tiếp đất và sinh hoạt/media/chào/chăm sóc theo ma trận. Cần hoàn thiện các chuyển
bị ngắt và vùng tiếp xúc theo frame trước tích hợp đầy đủ. ChưaR09/30phút/S4-06.
Không commit/push/dependency/branch/security. CHANGELOGskip vì draft asset của
cùng tính năng chưa phát hành; không cần xóa dữ liệu người dùng.
