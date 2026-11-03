# A01 — danh mục chuyển đổi160

45 clip nền +4 clip nháp +26 mục P2 bổ sung. ID P2 là tên kỹ thuật để theo dõi asset; không tạo trigger hành vi mới.

| Clip | Nhóm | Hiện có | Clock | Hướng |
|---|---|---:|---|---|
|apex|A05|1|time|three_quarter|
|balance_wobble|A05|4|time|three_quarter|
|climb_up|A05|12|time|three_quarter|
|fall|A05|2|time|three_quarter|
|hang|A05|2|time|three_quarter|
|headpat|A06|11|time|three_quarter|
|held_happy|A05|4|time|front|
|idle_34|A04|4|time|three_quarter|
|idle_back|A04|2|time|back|
|idle_back34|A04|4|time|back_three_quarter|
|idle_front|A04|4|time|front|
|idle_side|A04|4|time|side|
|jump_prep|A05|2|time|three_quarter|
|land|A05|5|time|three_quarter|
|look_up|A06|3|time|three_quarter|
|mantle|A05|9|time|three_quarter|
|rise|A05|1|time|three_quarter|
|run_34|A04|8|distance|three_quarter|
|run_back|A04|8|distance|back|
|run_back34|A04|8|distance|back_three_quarter|
|run_front|A04|8|distance|front|
|run_side|A04|16|distance|side|
|sit_enter|A07|5|time|three_quarter|
|sit_exit|A07|5|time|three_quarter|
|sit_loop|A07|4|time|three_quarter|
|sleep|A07|4|time|three_quarter|
|surprise|A06|3|time|three_quarter|
|wake|A07|5|time|three_quarter|
|walk_34|A04|8|distance|three_quarter|
|walk_back|A04|8|distance|back|
|walk_back34|A04|8|distance|back_three_quarter|
|walk_front|A04|8|distance|front|
|walk_side|A04|16|distance|side|
|walk_start|A04|3|time|side|
|walk_start_34|A04|3|time|three_quarter|
|walk_start_back|A04|3|time|back|
|walk_start_back34|A04|3|time|back_three_quarter|
|walk_start_front|A04|3|time|front|
|walk_stop|A04|3|time|side|
|walk_stop_34|A04|3|time|three_quarter|
|walk_stop_back|A04|3|time|back|
|walk_stop_back34|A04|3|time|back_three_quarter|
|walk_stop_front|A04|3|time|front|
|wall_drop|A05|1|time|three_quarter|
|yawn|A07|6|time|three_quarter|
|attention_glance|A06|6|time|three_quarter|
|curious_tilt|A06|6|time|three_quarter|
|play_accept|A06|6|time|three_quarter|
|farewell_look|A06|6|time|three_quarter|
|play_continue|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|headpat_decline|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|headpat_shy|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|headpat_avoid|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|tail_look_back|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|tail_allow|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|tail_protect|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|tail_groom|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|sulk|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|calm_down|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|reconcile|A06|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|held_lift|A05|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|held_guarded|A05|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|place_gently|A05|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|land_hard|A05|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|slide|A05|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|watch_back|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|groom|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|listen_sway|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|greet|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|tea_offer|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|stretch_offer|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|care_wait|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|care_withdraw|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|dust_off|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|
|dizzy|A07|chưa có|theo hợp đồng hành động|chốt theo model và actor|

Chi tiết nguồn, vị trí tham chiếu, ngắt, contact và checksum: inventory.json. Tham chiếu literal có thể thuộc test; không coi tìm được chuỗi là chứng minh actor đã tích hợp.

Bộ mới dự kiến75 mục. Ví dụ mỗi mục1giây chuyển động45frame cần3375frame; RGBA160×160 khoảng329.6MiB, chưa gồm CPU alpha/GPU duplicate/cache. Bộ cũ233frame RGBA80×80 khoảng5.69MiB. Đây là dự toán thô, chưa là số đo bộ mới; A03 cần kiểm tra giới hạn loader và A08 giới hạn tài nguyên trước fullpack.

Các state Air/Held/Traversal/Recovery phải theo body; Gesture hữu hạn, Idle/Sit/Sleep cóloop; tên chuyển tiếp/actor mới nối tín hiệu đã có, không đổiBrain. Hang và clip ít dùng được giữ trong inventory dù có thể chưa có actor riêng.