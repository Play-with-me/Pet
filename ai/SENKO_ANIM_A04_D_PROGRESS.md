# SENKO-ANIM-A04-D — sửa pha chân, contact mẫu và chuyển tiếp (29/10/2026)

Người dùng chấp nhận preview A04-C và yêu cầu tiếp tục theo plan. Không yêu cầu duyệt
lại mẫu A02. Codex tự thực hiện, không subagent.

## Đã sửa và sản xuất
- Imagegen sửa riêng nguồn chân ở cell3/9 của dải1/3, vốn có tư thế đặt chân rộng
  chen giữa các tư thế passing. Chuẩn hóa nguồn edit, chỉ lấy vùng chân/hem dưới
  [58,132,128,153) vào frame10/28. Không morph, kéo giãn chân hoặc đổi hình thân.
- Candidate walk-guided-36-v4 có hai patch; v5 giữ ảnh v4 và thêm visual contacts
  cho sáu frame9/10/11/27/28/29. Các điểm này là mẫu vị trí đế chân để soát hình,
  vai trái/phải theo phase guide, chưa xác minh grounded contact hoặc stance toàn chu kỳ.
- Delta check: chỉ hai file frame10/28 đổi, 34 file còn lại giữ nguyên byte. Pixel
  ngoài patch trong hai frame sửa giữ nguyên. Timing800ms/cycle96px không đổi.
- Vẽ mới12keypose start/stop, chuẩn hóa160, sáu pose mỗi clip. Preview giữ200ms/240ms
  như v5. Đây là keypose draft, chưa phải45FPS transition; còn frame giữa và endpoint QA.
- Sửa Animator: Settling160 tiến45frame/s; pack80 vẫn35ms/frame. Tránh đặt chân
  chậm chỉ vì tăng số frame. Không thay body, phanh, Brain, planner hoặc cooldown.

## Kiểm tra thực chạy
- Renderer32; runtime297pass/1ignoredexport +2sharedfixtures; asset tool16/16.
- Native toàn nhóm31/31; gồm fixture160 fullsession và hồi quy bộ v5. Không coi
  fixture tĩnh này là native gait của candidate mới. Chưa native actual-gait v5candidate.
- Clippy all-targets asset-tools, scopedfmt và diffcheck đạt. Audit walk candidate
  bằng loader production; fragment thiếu fullrunner là dự kiến, không báo pack hoàn chỉnh.
- Test mới36frame xác minh200ms→9bước Settling ở45FPS, pause không tăng clock,
  sau đó vào Stopping. Test patch bảo vệ mọi pixel ngoài vùng chân.
- Checksum protected behavior modules và v5 manifests so A01 không đổi. Animator
  thay duy nhất clock hình ảnh160 đã nêu; không sửa các quy tắc lựa chọn hoặc vật lý.

## Preview và nguồn
So sánh sửa chân + bảng start/stop: resources/characters/senko-160/walk-review-v5.html.
Player walk-guided-player-v5: chọnwalk_side_clock_preview cho timing45FPS. Distance
mode mặc định140px/s không phải reference45FPS; dùng120px/s nếu đối chiếu quãng đường.
Player startstop-player-v1 là keypose timing200/240ms, không nhận là45FPS đầy đủ.
PNG nguồn, prompt và provenance: senko-160-source/gait/PASSING_FIX_AND_TRANSITIONS.md.
Contact source: passing-contact-review-v1.json; không tự đoán contact cho30frame còn lại.

## Phần còn lại
A04 chưa hoàn thành: hoàn thiện start9frame/200ms; stop vẽ thêm đoạn chuyển động
ở nhịp45FPS, giữ pose cuối để bảo toàn tổng240ms; chốt endpoint và foot contacts toàn
chu kỳ; kiểm tra body/foot sliding bằng native harness actualart, rồi run/các hướng.
Sync0/18 vẫn cần contact QA trước tích hợp. Độ mượt/kết quả16test không thay nghiệm thu
chuyển động tự nhiên. Không đổi defaultpack, chưa A09/perf/30phút/mixedDPI/macOS.
CHANGELOGskip: tiếp tục tính năng chưa phát hành. Không commit/push/dependency/branch.

Release build đạt; smoke5giây exit0; mởPID47088 bằngv5; hash693C2BE78E12EA02A698F01877717344176B1E19731B0E7AA3DB36F7AEBA9B1B. Bộart160candidate chưađượctíchhợp.

