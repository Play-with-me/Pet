# S3-04 — Vật lý và điểm tựa

Ngày 28/10/2026. Codex triển khai theo lệnh tiếp tục của Leader. S3-04 đã nối vào runner; GĐ3 chưa nghiệm thu tổng thể.

## Thay đổi

- Runner manifest dùng `SenkoBody` làm chủ vị trí chân, grip, vận tốc và điểm tựa. Không sửa `PhysicsBody` hoặc đường chạy người que/legacy.
- Trọng lực 1800 px/s²; giới hạn bù sau suspend 100 ms, bước con tối đa 1/240 giây. Dùng thời điểm cắt mặt phẳng để chọn gờ đầu tiên trên đường rơi và kiểm tra chiều rộng/headroom tại x lúc chạm. Tiếp đất dừng vận tốc, giữ điểm tựa, không xuyên gờ khi rơi nhanh.
- Điểm tựa lưu ID owner/generation, offset chân theo owner và thời điểm snapshot. Chở theo chỉ khi vận tốc cửa sổ dưới 1500 px/s và sweep thân còn trống; tính vận tốc bằng khoảng thời gian hai mẫu world, không dùng frame dt.
- Đóng, thu nhỏ, mất cạnh, bị che, resize không còn đủ chỗ, generation đổi hoặc dịch quá nhanh làm Senko rơi từ vị trí thực. Sửa lỗi bắt được trong test: handle được dùng lại không được nhận lại điểm tựa tức thì ở cùng mặt phẳng.
- Chỉ quãng đường tự đi tăng phase gait. Chở theo dùng clip `balance_wobble` có sẵn; bế/rơi ngắt ngay. Giữ ease và quay qua hướng trung gian đã duyệt.
- Controller GĐ2 nay chỉ trả intent, không gọi vật lý hoặc ghi vị trí. Giữ ngưỡng 24/64 px, tốc độ 110/280 px/s và chu kỳ nghỉ; đối chiếu 700 bước với luật cũ đạt. Đi bị chặn ở vùng chân đứng an toàn, chưa tự leo hoặc nhảy sang bề mặt khác.
- Pause giữ thân/hình tại chỗ; nếu cửa sổ dịch hoặc biến mất lúc pause, bỏ điểm tựa để rơi khi resume. Bế giữ offset, vật lý không kéo thân khi đang giữ capture.
- Guard biên tối thiểu chống ném mất pet; giải quyết chân xuyên work-floor sau khi thả và phục hồi dưới desktop về một sàn monitor thật. Không tạo sàn trong khoảng trống màn hình. Cache/display invalidation/mixed-DPI/unplug vẫn thuộc S3-06.

## Kiểm tra thực chạy

Log: `ai/logs/SENKO-S3-04/`.

- Thêm test analytic gravity/suspend, first-impact bất kể thứ tự ledge, x tại lúc chạm, gờ hẹp, local-foot khi tự đi, carriage dùng thời gian mẫu, ngưỡng 1500/zero-delta, destroy/minimize/reuse/resize, sweep/headroom, pause/resume, bế/ngắt, edge budget, floor penetration/recovery và khoảng trống màn hình.
- Test Animator xác nhận đúng balance clip và bị held/fall ngắt; test intent 700 bước xác nhận không ghi vị trí và giữ luật GĐ2. Tổng runtime173unit+2fixture và renderer28unit đạt, theo runtime-render-final.log.
- Native DWM + body harness dùng HWND thử được cô lập khỏi occluder ngoài môi trường: tiếp đất, dịch chậm, dịch nhanh đo trên timestamp thật, minimize/close làm mất support đều đạt. Đây là dữ liệu DWM thật nối body trong harness, **không phải video hay QA tay pet production đứng trên cửa sổ đó**.
- Nhóm scanner 7 test đạt, gồm 3 native. Hồi quy production-style session 9 test đạt, gồm 4 native: kéo/thả, pause/reset/exit, sustained Present, đủ16pha đi/chạy khi thân di chuyển, GPU Nearest4×4/Linear mặc định. Đo 295 Present/5giây ≈59/s; không coi là benchmark CPU hoặc chứng nhận ổn định dài hạn.
- Runtime/fixture/renderer, Clippy ba crate/all-targets/asset-tools, fmt file sửa và `just senko-build` được kiểm tra; kết quả cuối tại các log tương ứng. Không thêm dependency hoặc sửa lockfile trong lượt này. Bản release mở lại, hash/PID và chống mở trùng ở release.json/lifecycle.json.

## Giới hạn và phần tiếp theo

S3-05 mới tìm và thực thi tuyến đi–leo–mantle–nhảy–thả. Hiện có thể bế/thả Senko xuống gờ hợp lệ, nhưng chưa có tự tìm đường leo lên đó. S3-06 xử lý monitor/DPI/recovery đầy đủ; S3-07 kiểm định native tổng thể và bàn giao GĐ3.

Chưa QA tay đứng/di chuyển trên cửa sổ production, native Z-order đổi thành công, mixed-DPI/unplug, soak30phút binary mới, macOS hoặc toàn workspace. Hạn chế foreground/Z-order của host và testcase topmost cũ giữ nguyên như báo cáo trước; không sửa ngoài phạm vi hoặc gọi toàn repository xanh.

Không commit/push/chuyển nhánh/sửa asset v5 hoặc bàn giao Gen. Origin/master `47a73ed1` đã fetch, chưa merge dirty tree. CHANGELOG bỏ qua vì tiếp tục tính năng Senko chưa phát hành; không có dữ liệu người dùng cần xóa. GĐ4/GĐ5 chưa bắt đầu.
