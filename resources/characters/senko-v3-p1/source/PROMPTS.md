# Bộ yêu cầu tạo ảnh GĐ1

Nguồn: built-in ImageGen trong Codex, 27/10/2026. Đây là bộ prompt specification đã dùng, chuẩn hóa cách trình bày; không phải bản chép nguyên văn từng lời gọi. Không dùng CLI/API key. Công cụ không trả tên phiên bản model trong kết quả.

## Yêu cầu chung

Production game sprite sheet for Senko-san, a gentle cheerful chibi fox spirit desktop companion. Pixel art on a coarse 80×80 logical grid per cell, hard edges, no antialiasing/dithering, at most 32 solid shared colors. Golden-orange bob hair, large orange fox ears with white inner fur, amber eyes, small red flower hair ornament, white miko kimono top with red collar, red hakama skirt, dark brown sandals, ONE large fluffy golden fox tail with cream tip; warm dark-brown outlines. Modest outfit and calm caring expression.

Pure flat chroma magenta #FF00FF background. Uniform cells, precise row-major order. Full body inside each cell. Standing height 62 logical pixels, body axis x40, feet/contact baseline y76. Fixed character scale, no enlarging seated/sleeping/crouching poses. No text, labels, grid borders, floor, pole, ledge, environmental wall, human hand, shadow, sparkles, hearts or symbols. Facing RIGHT unless explicitly front/back. Character/style reference for every later sheet is idle.png.

## idle.png — 4×4, 14 sprite

Row1: idle_front four breathing/blink/ear-tail frames, directly facing viewer.
Row2: idle_34 four breathing frames facing diagonally RIGHT toward viewer.
Row3: idle_side four breathing frames, strict RIGHT profile.
Row4: idle_back two breathing frames, back to viewer; last two cells empty magenta.

Keep body stationary, same costume and body scale; tail movement must not shift body axis.

## move.png — 5×4, 20 sprite

Row1: walk_side phases1–5. Row2: walk_side phases6–8, walk_start1–2. Row3: walk_stop1–2, run_side phases1–3. Row4: run_side phases4–8.

Eight distinct alternating-leg walk poses and eight distinct playful run poses. Strict RIGHT profile, tail behind to LEFT. Run has forward lean, airborne moment and alternating arms/legs. No fear, no idle-frame substitution. Walk start shows lean/push-off; walk stop decelerates then settles.

## air.png — 3×3, 9 sprite

Row1: jump_prep1 slight crouch, jump_prep2 deeper crouch, rise. Row2: apex, fall1, fall2. Row3: land1 compressed, land2 rising, land3 neutral standing.

Trusting calm/joyful expression, feet down during fall, sleeves and tail react to airborne motion. Crouches stay physically shorter than standing at fixed scale.

## climb.png — 4×4, 14 sprite

Cells1–6: six alternating hand/foot climbing-up poses against an INVISIBLE wall to the RIGHT. Cells7–8: two hanging-by-hands poses. Cells9–13: five mantle poses, reaching/pulling/knee over/hips over/final stand. Cell14: release arms and let go, wall_drop. Cells15–16 empty.

No actual wall, ledge, pole or human hand may be drawn. Keep all ears, tail, hands and feet inside cells. The first generation omitted a mantle frame. Targeted edit kept first12 cells and replaced bottom row: cell13 calm standing right-facing Senko; cell14 arms-out drop sprite; last two empty. The corrected selected output is saved as climb.png.

## social.png — 4×4, 13 sprite

Row1: held_happy1–4, dangling gently with relaxed legs, happy trusting open eyes/blink/smile, no panic/flailing and no holding hand. Row2: look_up1–3 then headpat1. Row3: headpat2–5, eyes close peacefully and ears flatten/rise. Row4: headpat6 recovery; final three empty.

The invisible owner's touch is expressed through the character only. No human hand or heart symbols.

## rest.png — 5×5, 23 sprite

Row1: sit_enter1–3 then sit_loop1–2. Row2: sit_loop3–4 then sit_exit1–3. Row3: yawn1–5. Row4: yawn6 then sleep1–4. Row5: wake1–3 then two empty cells.

Seated seiza/kneeling, tail beside her; sleep curls head on her OWN tail, no bed or pillow. Yawn progresses sleepy→hand to mouth→open mouth→wide yawn→close→hand lowers. Wake opens eyes curled→sits rubbing eye→awake seated smile. Sitting/sleeping stay shorter at the same body scale. An unwanted disconnected ear-motion mark in the raw sleep source is removed by silhouette filtering.

## reaction.png — 4×2, 7 sprite

Row1: surprise1–3 then balance_wobble1. Row2: balance_wobble2–4 then empty.

Surprise is curious ears/eyes and a small open mouth, no terror/exclamation mark. Balance leans left/right/corrects/settles with arms and tail counterbalancing, planted feet.

## Kiểm tra sau tạo

Không coi lưới, bảng màu hoặc alpha của ảnh nguồn AI là đúng chỉ từ prompt. Pipeline và QA kiểm tra lại ảnh thực tế. Nguồn PNG chưa phải asset 80×80 dùng trực tiếp; bộ chuẩn hóa nằm ở candidate-v2, chờ Leader duyệt từng clip.
