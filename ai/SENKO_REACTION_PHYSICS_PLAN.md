# SENKO — nâng cấp phản ứng và vật lý có sức nặng

Leader duyệt triển khai trong chat ngày 28/10/2026. Đây là đặc tả hiện hành thay các quy tắc quiet-app/idle cố định ở S4-05-A. Chưa phải báo cáo hoàn thành.

## Quyết định sản phẩm
- Tinh nghịch/hoạt bát/tò mò/quấn chủ/tình cảm, hầu hết năng động. Biểu cảm hoạt hình giàu cảm xúc, giữ nét v5. Có việc riêng, không bám con trỏ.
- Pointer gần: chú ý rồi tự quyết. Rê nhẹ gần bé: lời mời. Rời sau chơi: lưu luyến vừa phải. Xoa đầu tùy tâm trạng; đuôi nhạy theo thân thiết; dỗi nhẹ/dễ làm hòa. Bế/thả có diễn biến cảm xúc.
- Làm việc/fullscreen vẫn tự do hoạt động trên mọi bề mặt hợp lệ; không vùng né pointer. Chỉ chọn sự kiện cửa sổ đáng chú ý. Media dùng trạng thái Playing/Paused/Unknown, không suy tên app thành đang phát.
- Nghỉ theo ngữ cảnh/năng lượng, bỏ ép ngủ10phút. Chăm sóc50phút hoạt động, cooldown30phút, nghỉ5phút tính lại; mời nhẹ rồi rút. Cục bộ; không lưu phím/title/cursorhistory; không đọc màn hình/thu âm; không chữ/âm thanh cho care.
- Bổ sung art ngay đợt này, Gen sở hữu art; Codex logic/tích hợp/test/build. Preview trước-trong-sau và nhánh ngắt phải được Leader duyệt trước tích hợp. Không mở S4-06/phần mới trước nghiệm thu.

## Vật lý và hợp đồng
- Physicalpx, giây, gravity1800 dùng chung planner/body; jump110ngang/90dọc. Giữ gờ/tường hợp lệ, không biến toàn nội dung cửa sổ thành khối đặc, không ragdoll.
- Brain yêu cầu tốc độ/hướng; motion giới hạn gia tốc/phanh/ma sát, tính khoảng phanh trước mép/mục tiêu. Vận tốc liên tục; quay đầu phanh trước đổi hướng. Tách selftravel/carriage/passiveslide, chỉ selftravel tăng phase chân.
- Bế giữ chính xác điểm nắm; đoạn mẫu RAM ngắn lọc vận tốc thả, giữ đứng yên làm mất đà. Cancel không ném. Khi bay bảo toàn đà ngang/trọng lực, không bẻ quỹ đạo theo ý định.
- Swept first-impact, normalvelocity hấp thụ không bật bóng, tangentialvelocity còn đà và giảm bởi ma sát. Có thể trượt khỏi gờ; impact theo relativevelocity có phân loại đặt/nhẹ/mạnh và hysteresis.
- Surface timestamp/velocity/acceleration; slowcarriage, friction/grip giới hạn; detach kế thừa velocitybề mặt hợp lệ+relative. Snapshot discontinuity không tạo impulse. Leo/mantle có tiếp xúc/trọng tâm, body điều khiển tiến độ. Reset/displayrecovery là thao tác riêng, không che lỗi vật lý.
- Cấu hình nội bộ tập trung; prototype hiệu chỉnh trước release. Pause/menu > held > fall/contact > touch > event > intent. Runtime thuần không Win32. Reaction không set vị trí/vận tốc để diễn.

## Phản ứng
- Chuỗi nhận biết/chú ý/quyết định/thực hiện/kết thúc/trở lại, có cam kết/cooldown/interrupt; không random mỗi tick.
- Tách needs/emotiontemporary/intention; cảm xúc bounded, nguyên nhân và decay; chỉ RAM. Touch reward chỉ lần được chấp nhận. Dỗi có đường nguôi/làm hòa.
- Tình huống phủ: flyby, near, invite, farewell; headaccept/decline; tailsurprise/protect/accept; repeatedtouch/sulk/reconcile; held/release/impact; work/newwindow/rapidforeground; mediaplayback; idle/return/care.

## Mã và cửa nghiệm thu
R-01 đồng bộ đặc tả; P-01 sharedmotioncontract/config; P-02 acceleration/braking/turn/friction; P-03 gripthrow/impact/movingplatform; P-04 planner/traversal/Animator. R-02 emotions/episodes; R-03 pointer/invite/farewell; R-04 headtail/sulk; R-05 held/impactemotion; R-06 window/media; R-07 contextualrest/care; R-08 art; R-09 QA/release.
Thứ tự R01 -> P01..04 -> R02..07 -> tích hợp -> R09; R08 phối hợp từ prototype. Mỗi mã có phạm vi trước sửa, kiểm tra phù hợp và báo cáo thật.
Kiểm tra frame-rate30/60/144, braking/edge/turn, throwthenhold/cancel, landing/slide, platform/occlusion/suspend; seededemotion, nofalseinvite/rewardloops, displayedalpha/mirror/originâm; native contextinjection và hồi quy. Nghiệm thu5nhóm: weight, play, touch/emotion, app/media, rest/care. Soak30phút đúng binary mới, không suy8giờ hoặc hardware chưa thử.
