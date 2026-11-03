# S3-02 — quét cửa sổ và sự kiện

Ngày28/10/2026. Codex thực hiện theo lệnh Leader tiếp tục dự án; GĐ2 đã duyệt, S3-01 đã có hợp đồng. Đây là bước nguồn dữ liệu củaGĐ3, chưa có leo/va chạm cửa sổ.

## Kết quả

`overlay/windows/desktop_scan.rs` đọc EnumWindows theoZ-order, lấy khung DWM extended-frame bounds và trạng thái cloaked. Chỉ cửa sổ hiện, không thu nhỏ, không cloaked, có caption và tối thiểu200×100, không thuộc Senko/shell/desktop, không maximize/fullscreen mới được leo. Những vùng hiện nhưng không leo được vẫn giữ làm vật che; Progman/WorkerW loại khỏi thế giới. Không đọc title/exe/phím hoặc chụp màn hình.

Sáu hook OUTOFCONTEXT dùng message pump sẵn có. Callback chỉ đánh dấu dirty và tối đa256token destroyed; tràn hàng đợi thì hủy toàn bộ identity cũ để tránh nhận sai điểm tựa. Object event lọc OBJID_WINDOW/child0. Tick gom sự kiện, quét khi dirty hoặc sau500ms, validate trước publish. Nếu mẫu lỗi, snapshot trước giữ nguyên và lỗi được trả rõ; không publish tập monitor dở dang. Hook RAII gỡ trên đúng thread, kể cả lỗi cài một phần. Không tạo worker/hook phím hoặc vòng tự chạy mới.

Identity gồm token/PID/TID và generation tăng đơn điệu; destroy, biến mất khỏi enumeration hoặc đổi PID/TID làm hết identity cũ. Cửa sổ hidden/iconic còn trong enumeration giữ identity. Snapshot chỉ ở RAM. Mỗi world scan hiện lấy monitor display/work; cache và thông báo display/settings nằmS3-06.

Runner đã gọi scanner trong tick, vẫn dùng controller/physics đã duyệt. Snapshot chưa có gờ/tường; S3-03 sẽ trừ che khuất và S3-04 mới nối body/vật lý.

## Kiểm định

Log tại `ai/logs/SENKO-S3-02/`:

- 4unit test scanner đạt: filter,fullscreen/size,callback child/bounded queue,identityreuse/PID/TID.
- 1native test đạt: tạo/show,di chuyển/resize,Z-order,minimize/restore,destroy; DWM snapshotvalidate; sự kiện lifecycle thật; fallback499/500ms;100location notifications tổng hợp không quét trongcallback và một lần ởtick; sáu hook gỡ, cài lại được.
- Foreground thật: lần đầu Windows từ chối SetForegroundWindow trong host kiểm thử (lognative.log/native-final.log). Đã bỏ yêu cầu ép focus, dùng NotifyWinEvent qua hook thật để kiểm định đường nhậnforeground, giữ log lỗi ban đầu. Chưa có QA chuyểnforeground bằng thao tác người dùng; không coi sự kiện tổng hợp là chứng cứ đó.
- Hồi quy session9test đạt, gồm4native;295Present/5s≈59/s,walk/run đủ16pha khi thân di chuyển; kéo/thả,pause/reset/exit,GPU4×4pixel/Linear mặc định đạt.
- Runtime148unit+2fixture và renderer28unit đạt. Clippy3crate/alltargets/asset-tools,fmtfile sửa đạt. Cargo update --workspace đổi0package; chỉ bậtfeatureDWM/Accessibility củawindows-rs0.62.2 đã có. Build qua `just senko-build`; hash/PID tạirelease.json và chống mở trùng tạilifecycle.json.

## Giới hạn

Chưa S3-03..07: không chứng minh occlusion/mantle/landing/transport/routes,mixedDPI/unplug hoặc leo thực tế. Chưa QA tay/soak30phút binary mới/macOS/fullworkspace. Lỗi testtopmost của full overlay lượt trước vẫn ngoài phạm vi. Bản v5 và vật lý người que không sửa.

Tiếp theoS3-03: trừ vùng bị che cho gờ ngang, tường dọc và vùng mantle, dùng cả vùng không leo được làm occluder. GĐ4/GĐ5 chưa bắt đầu.

Không commit/push/chuyểnnhánh hoặc sửa bàn giaoGen. Origin/master47a73ed1 đãfetch, chưa merge dirtytree. CHANGELOG bỏ qua vì tiếp tục tính năngSenko chưa phát hành; không có dữ liệu người dùng cần xóa.

NguồnAPI: [SetWinEventHook](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setwineventhook), [DWM attributes](https://learn.microsoft.com/en-us/windows/win32/api/dwmapi/ne-dwmapi-dwmwindowattribute).
