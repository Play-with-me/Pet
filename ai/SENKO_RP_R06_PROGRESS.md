# SENKO-RP / R-06 — cửa sổ và media
Bàn giao29/10/2026. Codex tự làm, không subagent. Lõi logic/nguồn dữ liệu đã nối; diễn xuất mới còn chờ ảnh.

## Thay đổi
- Bỏ quiet-appbias Work/Media trong Brain: cùng nhu cầu/ý định thì điểm utility bằng nhóm Other, không tự giảm đi/chạy hoặc tăng ngồi chỉ vì làm việc/nghe nhạc. Giữ bias quan sát Chat đã có.
- EnvironmentAttention theo danh tính WindowId/generation của snapshot hiện tại. Lấy baseline lúc khởi động; chỉ phát hiện xuất hiện nhìn thấy, không kết luận process/ứng dụng vừa mở hoặc tắt. Di chuyển, resize, Z-order không tạo novelty lặp.
- Gom cửa sổ mới và foreground350ms, cooldown chung5s; chỉ giữ sự kiện mới nhất trong mỗi nhóm, không xếp hàng phát lại sau cooldown. Đóng trước khi ổn định thì hủy. Trên512cửa sổ quan sát thì bỏ phản ứng observer thay vì tăng lưu trữ; world/physics vẫn dùng đầy đủ snapshot.
- Pause/bế/rơi/touch/mất dữ liệu hoặc suspend/rollback cập nhật baseline và bỏ pending cũ. Foreground thiếu không bị coi là đóng app. Chỉ sự kiện appearance đã gom mới tăng curiosity, không tăng mỗi tick kéo cửa sổ.
- Nối chú ý cửa sổ vào P1Look khi hướng phù hợp. Sự kiện không thay mục tiêu tuyến đã cam kết; directtouch/bế/rơi vẫn ưu tiên. Surprise mới chưa có art, không dùng động tác sai để thay.
- Media có Playing/Paused/Unknown, freshness riêng. Không suy Spotify/YouTube hoặc tên cửa sổ thành đang phát. WindowsSMTC workerMTA đọc trạng thái tối đa32phiên, không lấy title/artist/thumbnail hoặc điều khiển playback. Có phiênPlaying thì Playing; chỉ kết luận Paused khi tất cả phiên đã đọc đều xác định không phát; lỗi/thiếu/truncated chưa thấyPlaying thì Unknown. Stopped ánh xạ Paused; Closed/Opened/Changing làUnknown.
- Worker thăm dò500ms, chỉ giữ một sampleenum/timestamp. GUI đọc try_lock, không chờ IPC; RequestAsync có timeout750ms/cancel, thử lại có khoảng nghỉ. Sample quá1.5s thànhUnknown; dao độngUnknown không kích hoạt lại Play giả. Shutdown có tín hiệu/done/join với budget1s; không tuyên bố đã kiểm tra dịch vụ OS bị treo.
- MediaStarted có edge/cooldown8s và cảm xúc ngắn hạn. ActorListen/nghe nhạc thiếu ảnh được gateMissingAsset, không thay bằngPlay/headpat/ngồi. Trạng thái hiện tại vẫn được trả cho runtime; chưa có diễn xuất nghe nhạc hoàn chỉnh hoặc actorstop theo media.

## Kiểm định
- 8 test environment: burst/settle, generationreuse, foregroundcoalesce, blocked/suspend, playbacktruth/Unknown, geometry/Zorder, pause/stale và cooldownkhôngreplay. Test exeSpotify+Unknown không tạoMediaStarted; fullscreen không chặn phản ứng.
- Runtime284pass/1ignored(export)+2fixture, renderer30pass. Test utilityWork/Media bao phủ đủ5ý định. Clippy3crate/alltargets/assettools và scopedfmt/diffcheck được kiểm tra trên mã cuối.
- NativeDWM fixture riêng: xuất hiện -> một event, kéo nhiều lần không novelty, đóng không giả applifecycle. Đây là scanner+observer tích hợp cô lập, chưa phải video toàn chuỗi cửa sổ production.
- Media có test mapping/all-session aggregation/Unknown-stale-lock và nativequery/workerjoin. Nguồn thực tế trảPlaying trong lượt kiểm tra; không điều khiển media của người dùng. Paused/multi-session/error là kiểm tra dữ liệu tiêm, chưa QA tay nhiều trình phát thực.
- Chỉ bật Foundation/Media_Control/WinRT binding của windows0.62.2 đang có. cargo update --workspace --offline:0package, hashCargo.lock không đổi so với đầu lượt. Không thêm/nâng phiên bản dependency. Testfixture lúc đầu dùng nhầm constructor; đã sửa sang install(0,0) đúng mẫu hiện hữu trước kiểm định đạt.

## Còn lại
ẢnhListen/surprise và R04/R05 mới còn thiếu theoR08/MSG238, chưaGenxácnhận; không sửa PNG/manifest/Gen. Chưa nghiệmthu trựcquan tổng thể, QA tay/fullscreen games/mixedDPI/unplug/macOS/fullworkspace/benchmark hoặc30phút hash mới. R07idle/ngủ/chăm sóc theo năng lượng tiếp theo; mốc idle2/10phút cũ còn trong runner đến lúc thay đúng phần đó. S4-06/phần mới giữ lại. Khôngsubagent/commit/push/branch/securitychange. CHANGELOG bỏqua tiếp tụcSenko chưa phát hành; không cần xóa dữ liệu người dùng.

## Nguồn API
Đối chiếu generatedbindings windows0.62.2 tại máy và [RequestAsync — Microsoft Learn](https://learn.microsoft.com/en-us/uwp/api/windows.media.control.globalsystemmediatransportcontrolssessionmanager.requestasync?view=winrt-26100), [mô tả SMTC của Microsoft](https://devblogs.microsoft.com/oldnewthing/20231108-00/?p=108980). Nguồn chỉ xác định hợp đồng API, không thay bằng chứng kiểm tra thực chạy.

Rà soát cuối bổ sung cờ chặn một tick sau menu/reset/capturecancel/displayrecovery, kể cả popup đóng trước1s: baseline được cập nhật và pending cũ bị bỏ, không dựa riêng vào timeout để tránh replay. Không thay đổi chính sách idle/ngủ R07 trong bước này.

## Kết quả cuối và release
Session cuối25/25 đạt: headpat4phase/presentedID/interrupt/refusal, handlingcontact, Look, capturecancel, DPI/pause/reset/exit/alpha/Nearest và gait. Walk/run đủ16pha, selftravel189.99/495.17px; native5s295Present. Media4/4 và DWMwindowobserver1/1 đạt; các log riêng phân biệt rõ phần native và dữ liệu tiêm. Clippy/fmt/diffcheck đạt.
`just senko-build` và startuprelease5s exit0 đạt. Đóng đúngPID7644/path trước build; mở bản mớiPID13352/responding. SHA256D6BED9C09CE9166CAD0C636685A626FC9FDB6EAE11AB68D148CA406DC6048BB3. Xem build.log/release.json. Chưa30phút bản mới. TiếpR07 trong cùng đợt nâng cấp, chưa mởS4-06 hoặc phần mới.
