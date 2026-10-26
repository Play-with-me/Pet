---
markmap:
  color: ["#2563eb", "#0d9488", "#d97706", "#9333ea", "#e11d48", "#0284c7"]
  colorFreezeLevel: 2
  initialExpandLevel: 2
  maxWidth: 250
  spacingHorizontal: 110
  spacingVertical: 12
---
# Người bạn desktop

## Trải nghiệm đã chốt
- [Bản tổng hợp đầy đủ cho Gen](../PROJECT_MASTER_PLAN.md)
- [Trao đổi Codex ↔ Gen](../SYNC.md)
- Một người que **rất hiếu động**
- Cử chỉ và hành động, không hội thoại AI
- Windows trước; một pet trên màn hình chính
- [Quy tắc phối hợp](../../AI_COLLABORATION_REPORT.md)

## Vật lý hoạt hình
- Trọng lực → rơi → tiếp đất → nảy nhẹ
- Kéo trái để nhấc
  - Giữ đúng điểm bấm
  - Có tư thế bị giữ
- Vung và thả để ném
  - Lấy vận tốc gần thời điểm thả
  - Giới hạn lực ném
- Biên thế giới
  - Sàn theo vùng làm việc Windows
  - Leo hai cạnh màn hình
  - Đổi màn hình → phục hồi vị trí an toàn

## Tính cách và chơi cùng
- Tò mò
  - Nhìn và tiến về con trỏ
  - Vẫy chào khi click
- Phấn khích
  - Chạy, nhảy, đuổi chuột
  - Xen kẽ nghỉ ngắn
- Khó chịu tạm thời
  - Phản ứng sau khi bị ném
  - Né chuột → hồi phục
- Ưu tiên xử lý
  - Tạm dừng → đang giữ → vật lý → hành vi → nghỉ

## Kiến trúc Rust
- [BongoCat hiện có](architecture.html)
- Logic companion
  - State và physics không chứa handle Windows/GPU
  - Bước cố định và đồng hồ đơn điệu
- Adapter Windows
  - Chuột, capture, DPI và vùng làm việc
  - Áp dụng vị trí cửa sổ
- Renderer
  - Nhận snapshot và tư thế
  - Người que hình học nguyên bản trước
- GPUI giữ vai trò giao diện cài đặt

## Phân công
- Codex
  - Khảo sát nền và build gốc
  - Vật lý, hành vi, tích hợp, kiểm tra
  - [Bàn giao](../../HANDOFF_CODEX.md)
- Antigravity
  - Tìm tài nguyên bằng Google
  - Ghi nguồn và quyền sử dụng
  - Tư thế và chất lượng hình ảnh
  - [Bàn giao](../../HANDOFF_ANTIGRAVITY.md)
- Chủ dự án
  - Chọn hình dáng
  - Đánh giá cảm giác chơi
  - Nghiệm thu từng giai đoạn

## Các cổng nghiệm thu
- 0 · Nền gốc
  - Chạy được bản BongoCat gốc
  - Chốt điểm tích hợp và quyền sửa file
- 1 · Vật lý
  - Người que render trong suốt
  - Kéo, ném, rơi, va chạm hoạt động
- 2 · Tính cách
  - Chuyển hành vi có chủ đích
  - Không mắc kẹt hoặc đổi động tác liên tục
- 3 · Hình ảnh
  - Hoạt ảnh rõ ở kích thước desktop
  - Chân bám sàn và leo đúng hướng
- 4 · Bản thử
  - Build Windows và hướng dẫn
  - Chủ dự án chơi thử

## Kiểm tra
- Tự động
  - Vật lý, biên, pause, capture và trạng thái
  - Thời gian/ngẫu nhiên tái hiện được
- Máy Windows
  - DPI 100 / 125 / 150 / 200%
  - Lock, sleep và đổi vùng làm việc
  - Click xuyên, menu thoát
  - Chạy liên tục 30 phút

## Để sau
- Va chạm cửa sổ ứng dụng
- Ragdoll và nhiều pet/màn hình
- Phản ứng gõ phím, âm thanh
- Hội thoại AI và nhắc deadline
- Bán skin và thanh toán
