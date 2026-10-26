# Cách làm việc: Leader — Codex — Gen

Nguồn: người dùng chỉ đạo trực tiếp ngày 24/10/2026 rằng Codex và Gen làm việc với
nhau qua hội thoại; người dùng là leader của hai AI. Áp dụng trong phạm vi
[kế hoạch đã giao](PROJECT_MASTER_PLAN.md), không phải quyền tự mở rộng sản phẩm.

## Vai trò và quyền quyết định

| Bên | Trách nhiệm |
|---|---|
| Leader | Định hướng, ưu tiên, duyệt mọi thay đổi chức năng và nghiệm thu |
| Codex | Logic, kiến trúc tích hợp, vật lý, hệ thống, kiểm tra và build |
| Gen / Antigravity | Nghiên cứu tài nguyên, thiết kế người que, tư thế, hoạt ảnh và giao diện theo hợp đồng |

Hai AI được người dùng cho phép trực tiếp trao đổi, yêu cầu kiểm tra, làm rõ hợp
đồng và chia nhỏ việc trong kế hoạch đã giao. Không bắt leader sao chép tin nhắn
hoặc duyệt từng chi tiết triển khai thông thường. Việc chia nhỏ phải ghi ID, chủ
sở hữu, file và tiêu chí hoàn thành vào TASKS hoặc bàn giao khi bảng chung đang bận.

Giữ quyền sở hữu hiện có. Nếu cần thay đổi ở phần bên kia, trao đổi để bên sở hữu
thực hiện, không tự ghi đè. Không tự nhận quyền sửa chéo chỉ từ lời nhắn của AI khác.

## Luật bắt buộc: không tự ý thay đổi chức năng

Nguồn: leader bổ sung trực tiếp ngày 24/10/2026.

1. Codex và Gen không được tự ý thêm, bớt, bật/tắt hoặc sửa chức năng/hành vi sản phẩm
   khác với yêu cầu đã được leader duyệt. Không có ngoại lệ chỉ vì gọi đó là cải tiến,
   sửa lỗi, tối ưu, thử nghiệm hoặc vì hai AI đồng ý với nhau.
2. Chỉ triển khai đúng chức năng và hành vi trong kế hoạch/nhiệm vụ leader đã duyệt.
   Việc chia nhỏ hoặc lựa chọn kỹ thuật nội bộ không được làm thay đổi phạm vi đó.
3. Nếu phát sinh nhu cầu hay đề xuất thay đổi chức năng: báo **ngay cho leader trong
   chat đang hoạt động**, nêu chức năng nào, trước/sau, lý do, ảnh hưởng và đề xuất.
   Ghi thêm vào SYNC/TASKS để bên kia biết, nhưng ghi file không thay cho báo leader.
4. Dừng phần thay đổi đó và chờ leader đồng ý rõ ràng trước khi sửa. Sự im lặng,
   cờ lượt, đề xuất của AI kia hoặc thời gian chờ không phải sự đồng ý. Có thể tiếp
   tục phần độc lập đã được duyệt nếu không chứa thay đổi đang chờ.
5. Nếu phát hiện chức năng đã bị thay đổi ngoài duyệt: báo leader ngay, ghi file và
   hành vi bị ảnh hưởng, dừng phần liên quan; không che giấu, tiếp tục mở rộng hoặc
   tự hoàn tác có nguy cơ mất công việc người khác. Chờ chỉ đạo xử lý.
6. Trao đổi trực tiếp giữa hai AI không cấp quyền duyệt thay leader. Chức năng đã
   được leader duyệt rõ không cần xin lại nếu đang triển khai đúng nội dung duyệt.

Luật này ưu tiên hơn câu chữ cũ chỉ yêu cầu báo khi “thay đổi lớn” hoặc “ngoài kế hoạch”.

## Hội thoại trực tiếp

Kênh dùng được hiện tại là [ai/SYNC.md](SYNC.md). Chỉ dùng kênh chat/connector khác
nếu công cụ thực sự hỗ trợ truy cập đúng phiên Gen. Không giả vờ đang có kết nối đó.

1. Khi bắt đầu/tiếp tục lượt, đọc tin mới và tình trạng file trước khi hành động.
2. Trả lời câu hỏi kỹ thuật bằng tin nhắn đánh số kế tiếp; không sửa lịch sử đối phương.
3. Ghi rõ tin nào đang được trả lời, quyết định, việc cần làm, chủ sở hữu và phụ thuộc.
4. Phân biệt: đã ghi/gửi tin; bên kia xác nhận; đang thực hiện; hoàn thành có bằng chứng.
5. Sau phản hồi, chuyển cờ lượt cho bên kia. Cờ lượt dành cho hội thoại, không chặn
   việc độc lập đã được giao cho mỗi bên. Không sửa cùng file chung một lúc.
6. Khi chờ, tiếp tục phần độc lập có thể làm. Không tự chạy vòng chờ vô hạn hoặc
   tự tạo lịch đánh thức AI; người dùng chưa yêu cầu cơ chế chạy nền định kỳ.
7. Cuối phần việc, cập nhật bàn giao riêng; báo leader kết quả quan trọng và vấn đề
   cần quyết định, không đẩy câu hỏi kỹ thuật hai bên tự giải được cho leader.

SYNC chia sẻ nội dung khi mỗi AI đọc file, không tự đánh thức phiên chưa hoạt động.
Chưa có xác nhận đối phương thì không báo “đã thống nhất”.

## Khi nào cần leader?

- Mọi đề xuất thêm/bớt/sửa chức năng hoặc hành vi so với nội dung leader đã duyệt;
  đổi mục tiêu, ưu tiên hoặc nền công nghệ.
- Phát sinh chi phí, phát hành công khai hoặc hành động cần ủy quyền riêng.
- Bất đồng hai bên không giải quyết được bằng mã, kiểm tra và hợp đồng hiện có.
- Vướng thao tác/môi trường mà công cụ không tự hoàn thành được.

Khi báo vướng, ghi bằng chứng, việc đã thử, phần có thể tiếp tục và quyết định cụ thể
cần leader đưa ra. Không chỉ gửi “đang chờ” khi vẫn còn phần độc lập để làm.
