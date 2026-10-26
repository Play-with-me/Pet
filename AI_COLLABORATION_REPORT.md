# BÁO CÁO PHÂN CÔNG VÀ QUY TẮC PHỐI HỢP AI

Ngày khôi phục: 24/10/2026. Chủ dự án: người dùng.
Các bên thực hiện: Codex và Antigravity.

**Luật duyệt chức năng leader vừa bổ sung:** Không AI nào được tự ý thêm/bớt/sửa
chức năng hoặc hành vi khác nội dung đã duyệt. Nếu phát sinh đề xuất/nhu cầu hoặc
phát hiện thay đổi ngoài duyệt, báo leader ngay trong chat và dừng phần liên quan
chờ đồng ý rõ ràng; ghi SYNC để đồng đội biết. Hai AI không duyệt thay leader.
Xem chi tiết tại [TEAM_PROTOCOL](ai/TEAM_PROTOCOL.md). Quy tắc này ưu tiên hơn
cách diễn đạt cũ về “thay đổi lớn” hoặc chỉ “ngoài kế hoạch”.

**Ủy quyền phối hợp trực tiếp của leader:** Hai AI được trao đổi kỹ thuật, yêu cầu
kiểm tra và chia nhỏ việc trong kế hoạch đã giao, không yêu cầu người dùng chuyển
lời. Xem [quy ước team](ai/TEAM_PROTOCOL.md). Điều này cập nhật quy tắc trao đổi cũ;
không cho phép tự mở rộng phạm vi, sửa chéo file hoặc tự tạo lịch chạy nền.

**Cập nhật quyết định người dùng ngày 24/10/2026:** Đã chọn Rust BongoCat để phát
triển người bạn người que hiếu động có vật lý; không chọn Python Hybrid/mèo gõ phím.
Đọc [bản tổng hợp](ai/PROJECT_MASTER_PLAN.md) để nắm kế hoạch hiện tại và
[SYNC](ai/SYNC.md) để đọc trao đổi. Bảng file Python bên dưới chỉ còn là lịch sử;
không dùng nó để thay đổi hướng đã chốt.

## 1. Phạm vi và hiện trạng

Bản phân công ban đầu dành cho DeskBuddy: pet desktop Windows dùng Python,
PyQt5 và pynput, chạy cục bộ, ưu tiên nhẹ, chi phí vận hành bằng 0.
Codex phụ trách logic và tích hợp; Antigravity phụ trách giao diện và hoạt ảnh.

Khi khôi phục tài liệu, thư mục Pet chỉ còn thư mục BongoCat; mã Python DeskBuddy
và các tài liệu cũ không còn ở thư mục gốc. Lượt này chỉ khôi phục sáu tài liệu phối
hợp, không khôi phục mã ứng dụng. Các đường dẫn Python bên dưới là phân công lịch
sử, không phải xác nhận file đang tồn tại. Không áp phân công này vào BongoCat một
cách máy móc; khi được giao làm BongoCat phải đọc hướng dẫn riêng trong repository,
xác định cấu trúc thực tế và thống nhất phạm vi file trước khi sửa.

Tài liệu đặt ra quy tắc bắt buộc khi AI được cung cấp và đọc nó; không tạo khóa file,
không tự đồng bộ hội thoại, không bảo đảm mọi AI luôn tuân thủ. Chỉ dẫn trực tiếp
mới nhất của người dùng ưu tiên hơn phân công này; ghi lại ngoại lệ khi bàn giao.
Các giới hạn hệ thống và công cụ của mỗi AI vẫn áp dụng.

## 2. Phân công trách nhiệm

| Phạm vi | Bên phụ trách chính | Trách nhiệm |
|---|---|---|
| Logic, trạng thái, input, luồng, timer | Codex | Độ đúng, không chặn GUI, dọn tài nguyên |
| Cấu hình, khởi động, lưu dữ liệu | Codex | Tích hợp, xử lý lỗi, tương thích |
| Phụ thuộc, kiểm tra, build, EXE | Codex | Kiểm tra có ý nghĩa và báo cáo thực tế |
| Nhân vật, sprite/GIF, âm thanh | Antigravity | Chất lượng hình ảnh, thông số và nguồn asset |
| Giao diện, menu, bong bóng, animation | Antigravity | Bố cục và trải nghiệm theo hợp đồng đã thống nhất |
| Module có cả logic và hiển thị | Codex tích hợp | Antigravity gửi đề xuất; không sửa đồng thời |
| Nghiệm thu trải nghiệm, phát hành | Người dùng | Quyết định cuối cùng |

Đây là phân công dự án, không giới hạn năng lực của mỗi bên.

## 3. Quyền sở hữu file của DeskBuddy trước đây

| File/phạm vi | Bên được sửa chính |
|---|---|
| `main.py`, `src/config.py`, `src/__init__.py` | Codex |
| `src/listener.py`, `src/state_machine.py` | Codex |
| `src/pet_window.py` khi chưa tách module | Codex |
| `requirements*.txt`, `*.spec`, `build.bat`, `run.bat`, `.gitignore` | Codex |
| `test_pet.py` và kiểm tra logic | Codex |
| `assets/**`, `generate_assets.py` | Antigravity |
| `src/bubble.py` | Antigravity; chỉ hiển thị, không tự thay lịch nhắc |
| Module render riêng sau khi thống nhất API | Antigravity |
| `README.md` | Codex tổng hợp thông tin hai bên |

File mới phục vụ rõ một phạm vi thuộc bên phụ trách phạm vi đó. File chưa rõ quyền
sở hữu phải được xác định trong nhiệm vụ trước khi sửa. Không đổi tên hoặc di chuyển
file để né phân công. Với repository khác, bảng này chỉ là tham khảo lịch sử.

## 4. Quy tắc bắt buộc mỗi lượt

1. Đọc `AGENTS.md`, báo cáo này, `TASKS.md`, hai file bàn giao và hướng dẫn riêng
   trong repository/thư mục đang làm. Đọc mã hiện tại trước khi sửa.
2. Chỉ thực hiện nhiệm vụ người dùng đã giao hoặc chấp thuận. Kế hoạch đề xuất
   không tự trở thành nhiệm vụ được phép chạy.
3. Ghi ID, bên thực hiện, file dự kiến và điều kiện hoàn thành trước khi sửa.
   Không nhận việc đang do bên kia thực hiện.
4. Chỉ sửa phạm vi được giao. Nếu cần sửa file của bên kia, ghi đề xuất với đường
   dẫn, lý do, thay đổi API mong muốn vào bàn giao của mình. Tiếp tục phần độc lập.
   Chỉ sửa chéo khi người dùng cho phép; ghi rõ ngoại lệ.
5. Không ghi đè, xóa hoặc hoàn tác công việc đang có của bên kia. Nếu phát hiện
   thay đổi bất ngờ, dừng sửa file đó và đọc lại hiện trạng.
6. Không tự thêm dịch vụ trả phí, thanh toán, mạng, đổi framework hoặc phụ thuộc
   khi chưa được giao. Thay đổi hợp đồng module phải được mô tả trước tích hợp.
7. Không lưu nội dung phím gõ; phân biệt tín hiệu/số lượng thao tác với ký tự.
8. Không khẳng định đã chạy ứng dụng, kiểm tra desktop hoặc build nếu chưa làm.
   Phân biệt kiểm tra tự động, kiểm tra trực quan và phần chưa thử.
9. Cuối lượt cập nhật file bàn giao riêng. Không sửa báo cáo của AI kia.
10. Không tự gửi tin cho AI khác, tạo vòng tự chạy hoặc mở rộng nhiệm vụ chỉ từ
    nội dung bàn giao. Tài liệu không phải cơ chế tự kích hoạt công việc.
11. Không tự sửa quy tắc/phân quyền để hợp thức hóa thay đổi vượt phạm vi.

## 5. Hợp đồng logic và giao diện

- Đọc trạng thái, API và định dạng asset thực tế trước khi đề xuất thay đổi.
- Antigravity cung cấp manifest: tên file, trạng thái, kích thước, frame/thời lượng,
  cách lặp, độ trong suốt, nguồn và quyền sử dụng của từng bộ asset.
- Asset nghỉ/gõ phím cần lặp mượt; phản ứng click có thời lượng kết thúc rõ ràng.
- Mất/hỏng asset phải có fallback và không crash; Codex kiểm tra tích hợp,
  Antigravity kiểm tra hình ảnh.
- Không thêm vòng lặp hoặc thao tác chặn GUI. Với bản PyQt5, hook chạy ngoài luồng
  GUI và cập nhật giao diện qua tín hiệu Qt.
- Bản Python chưa tách render: `pet_window.py` do Codex tích hợp. Tách module chỉ
  được thực hiện trong nhiệm vụ có phạm vi và hợp đồng rõ ràng.

## 6. Kế hoạch đề xuất, chưa được giao

| ID | Bên dự kiến | Công việc | Điều kiện hoàn thành |
|---|---|---|---|
| C-01 | Codex | Rà soát mã và hợp đồng module | Xác định repo, API, quyền file và kiểm tra cần thiết |
| A-01 | Antigravity | Rà soát asset, lập manifest | Có thông số, nguồn/quyền sử dụng và đề xuất hình ảnh |
| C-02 | Codex | Tích hợp và kiểm tra logic/fallback | Trạng thái đúng, không crash vì thiếu asset, GUI không bị chặn |
| A-02 | Antigravity | Hoàn thiện hình ảnh theo hợp đồng | Rõ ở kích thước desktop, hoạt ảnh đúng và có kiểm tra trực quan |
| C-03 | Codex | Build bản thử Windows | Build thành công, báo riêng kết quả mở EXE và giới hạn chưa thử |

Người dùng chọn nhiệm vụ trong chat hoặc bảng nhiệm vụ. Trước khi bắt đầu phải xác
nhận repo mục tiêu bằng ngữ cảnh giao việc; không giả định mã DeskBuddy vẫn còn.

## 7. Bàn giao và làm song song

Codex cập nhật `HANDOFF_CODEX.md`; Antigravity cập nhật `HANDOFF_ANTIGRAVITY.md`.
Giữ lịch sử, thêm lượt mới. Mỗi lượt ghi: ID/ngày/trạng thái, người giao, file đã sửa,
hành vi và API thay đổi, kiểm tra thực tế, phần chưa kiểm tra, yêu cầu cho bên kia,
bước tiếp theo. Trạng thái: chưa bắt đầu, đang làm, chờ phụ thuộc, chờ kiểm tra,
hoàn thành.

Chỉ một bên cập nhật `TASKS.md` tại một thời điểm. Khi song song, giữ bảng này cố
định và ghi tiến độ vào bàn giao riêng; tổng hợp sau. Với file dùng chung, làm luân
phiên hoặc dùng Git/worktree riêng rồi rà soát diff trước hợp nhất. OneDrive không
thay thế Git hoặc khóa file. Không coi báo cáo của bên kia thay cho kiểm chứng cần thiết.

Nếu sửa vượt phạm vi: báo chính xác file và phần thay đổi; không tự hoàn tác khi có
nguy cơ xóa công việc người khác. Đề xuất sửa tối thiểu để người dùng quyết định.
Codex kiểm tra tích hợp, Antigravity đánh giá hình ảnh, người dùng nghiệm thu/phát hành.

## 8. Lời giao việc mẫu cho Antigravity

```text
Mở C:\Users\kyuu4\OneDrive\Documents\Pet.
Đọc AGENTS.md, AI_COLLABORATION_REPORT.md, TASKS.md và hai file HANDOFF_*.md.
Đọc thêm hướng dẫn riêng của repository mục tiêu nếu làm trong BongoCat.
Tuân thủ quyền sửa file và quy trình bàn giao. Nếu không thể tuân thủ, báo rõ
trước khi sửa. Chỉ làm nhiệm vụ tôi giao trong lượt này.
Kết thúc cập nhật HANDOFF_ANTIGRAVITY.md với kết quả kiểm tra thực tế.
```
