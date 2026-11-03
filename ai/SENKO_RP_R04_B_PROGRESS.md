# SENKO-RP / R-04-B — xoa đầu theo episode và hình thực hiển thị
Bàn giao29/10/2026. Tiếp R04, không chuyển sang phần mới.

## Phân công và kiểm soát
- Luna: runtime TouchAcceptance, nhận diện đúng episodeID/kind/phase, thưởng một lần sau presentation;18testpolicy.
- Max: HeadpatEpisodeActor, bốn pha, phanh/quay đúng hướng, nối successfuldraw và native/harness.
- Codex: đọc mã, yêu cầu sửa replay khi presentation lỗi, hủy token cũ, giữ routecamkết và ưu tiên reaction trước ý định nghỉ; bỏ HeadpatGesture không còn caller, kiểm định tích hợp/build/release và tài liệu. Không sửa asset/Gen.

## Thay đổi
P1 headpat đi qua Noticing/Preparing/Performing/Settling của ReactionDirector. Chuẩn bị chờ motor0, AnimatorIdle và hướng đã chốt, không tự giữ vị trí hoặc xóa vận tốc. Actor chỉ phát một lần, không restart khi clip kết thúc. Thưởng affection/social, AcceptedHeadpat và socialinteraction chỉ sau draw thành công có đúng ID/kind/Performing, mỗi receipt xác nhận một lần. Chuẩn bị, missingasset, wrongID, failedpresentation hoặc bị ngắt trước frame đầu không thưởng. Pause đóng băng; bế/rơi/menu/reset/recovery/hủy làm mất yêu cầu chưa hiển thị. Khi clip đã chạy hết mà không present được lần nào, hủy không phát lại/chờ10s.

## Kiểm định và lỗi phát hiện
Runtime269pass/1ignored(export)+2fixture, renderer30pass trên mã đã gỡ helpercũ. Policy18test gồm cancel/wrongID/phase/pause/once/cooldown và R04mood trước đó.
Lượt session đầu21pass/1fail: gait không xuất hiện vì dùng idle thật Windows. Cô lập context chỉ trong fixture gait, giữ16frame/quãngđường/thời gian2s; lần sau logOSidle241.484s, walk đủ16pha191.41px và run16pha478.50px. Đây là sửa fixture kiểm tra vận động, không sửa chính sách ngủ production.
Lượt session sau22pass/1fail: Look bị ý định ngồi nghỉ chặn ở pha chuẩn bị. Đang sửa ưu tiên event>intention đúng plan; không che bằng context giả cho Look. Các ca mới Headpat4phase/firstpresentreward và ngắt khi chuẩn bị đều đạt trong lượt này. Kết quả cuối và release được ghi bổ sung bên dưới sau kiểm định.

## Giới hạn
Headpat dùng P1 hiện có, không phải bộ biểu cảm mới. TailCare/Decline/ProtectTail/Sulk/Reconcile thiếu ảnh tiếp tục gate rõ; R04 chưa nghiệm thu trực quan đầy đủ. Gen chưa phản hồi yêu cầu preview MSG238. R05..07 và persistence chưa mở; các mốc idle/quiet-app cũ chưa thay toàn bộ. Chưa QA tay/mixedDPI/unplug/macOS/fullworkspace/benchmark hoặc30phút hash mới. Không commit/push/dependency/branch/Windowssecurity/art; CHANGELOG bỏ qua phần tiếp tục Senko chưa phát hành.

## Kết quả cuối sau sửa
Session cuối24/24 đạt (`session-verified.log`): đủ4phase/1episode/1reward theo presentedID; bế trong Preparing không headpatframe/không reward; capturecancel; refusal; Look; alpha/Nearest/DPI/pause/reset/exit. Unit mô phỏng clip đã chạy nhưng present thất bại kiểm tra không replay/không thưởng; không tuyên bố đã gây mất GPU thật.
Ca ưu tiên Look mới bao phủ cả4phase và navigation hiện hữu; runtimeLook native sau sửa đạt, nhưng OSidle của lượt cuối đã thấp trở lại nên không gọi đó là nativeproof khiidlecao. Lỗi idlecao được tái hiện trước sửa và helperpriority được unitkiểm định. Không inject Activecontext cho Look để che lỗi.
Gait cuối walk16pha187.35px/run16pha477.11px; native5s295Present. Clippy3crate/alltargets/assettools, scopedrustfmt/diffcheck đạt. Lỗi test/helpercũ lúc gỡ đồng thời đã xử lý; finalruntime269+2fixture/render30đạt.

## Release
`just senko-build` và startup5s exit0 đạt. Đóng đúngPID46140/path trước build, mở bản mới PID2680/responding. SHA25606FA679FF1C91095BF51F47B31754E3C9C6B4B7497C904F4DEAFAFD94A1B1398. Xem build.log/release.json. Chưa30phút hoặc nghiệmthu tổng thểR04. Tiếp theo là hoàn thiện preview/ảnh thiếu và nghiệmthu R04; không tự coi phần đó hoàn thành để mở persistence/phần mới.
