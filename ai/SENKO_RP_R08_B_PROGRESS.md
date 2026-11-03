# SENKO-RP-R08-B — kiểm định riêng Surprise (29/10/2026)

Codex tự thực hiện; không subagent, không sửa PNG/manifest/Gen. Phạm vi R08-A
được kiểm định sâu hơn, chưa mở S4-06 hoặc R09.

## Kết quả
- Thêm hai harness native đi qua EnvironmentAttention → director → Animator →
  renderer/Present. Snapshot cửa sổ mới được tiêm sau khi cơ thể có điểm tựa;
  con trỏ đặt xa và ý định Watch cố định trong test. Không gọi đây là DWM/chuột tay QA.
- Chuỗi đầy đủ: bốn phase, một episode ID; ba frame surprise 0/1/2 đã thực sự
  Present; không tự dịch thân; theo dõi thêm 20 tick sau kết thúc không phát lại.
- Ngắt: gửi Grab vào HWND thuộc test khi surprise đã hiển thị; tick sau Held,
  episode bị hủy. Kéo lên 140px rồi hủy capture: rời Held và rơi, không replay surprise.
- Có GIF capture native trước–trong–sau dùng timing thực, đã xem contact sheet.
  GIF lặp phục vụ xem lại, không biểu thị event lặp trong ứng dụng.

## Kiểm tra đã chạy
- Hai test riêng: 2/2 đạt. Hồi quy session native toàn nhóm: 29/29 đạt.
- Clippy runtime/render/overlay all-targets + senko-asset-tools: đạt.
- Scoped rustfmt và git diff --check: đạt.
- just senko-build: đạt; smoke bản release 5 giây exit0, mở lại PID10984.
- SHA256: 2AAD96BB63AD39CA8DAED9DA490E97A60136EE96C2736CE0FC78131F4E4883A4.
- Không chạy lại runtime/render suite vì không sửa logic các module này; kết quả
  R08-A295+2fixture/render30 thuộc lượt trước, không ghi thành test mới lượt này.

Lần đầu harness có lỗi thiếu qualification WindowId, đã sửa; kịch bản capture-cancel
ban đầu kỳ vọng rơi khi chưa kéo khỏi sàn nên không đạt. Đã sửa fixture kéo lên trước
khi hủy capture, không sửa vật lý để đáp ứng kỳ vọng sai. Log cuối surprise-final.log
và native-all.log là kết quả đạt; surprise.log giữ lần chưa đạt.

## Bàn giao và phần tiếp
Preview: logs/SENKO-RP-R08-B/index.html. Ma trận hình và hợp đồng Gen vẫn ở
SENKO_RP_R08_PROGRESS.md; chưa thấy xác nhận hoặc bộ P2 mới từ Gen trong SYNC.
R08 chưa nghiệm thu toàn bộ: các clip tương tác cảm xúc/held/media/greet/care còn thiếu.
Bước tiếp trong cùng đợt là tiếp nhận/kiểm định preview các clip đó trước tích hợp.
Chưa có QA tay, DWM end-to-end riêng Surprise, mixedDPI/unplug, macOS hoặc soak30phút
trên bản mới. Không commit/push/đổi nhánh/dependency. CHANGELOG bỏ qua vì kiểm định
và hoàn thiện cùng tính năng chưa phát hành.
