# C-01 — Kết quả baseline BongoCat gốc

Ngày: 25/10/2026. Yêu cầu trực tiếp từ leader sau MSG-016.
**Kết luận: build release và dev-smoke chạy được; bộ quality gate chưa đạt do
một test topmost trên Windows thất bại, tái hiện được khi chạy riêng.**

## Nền được kiểm tra

- Repository: BongoCat; HEAD `4f76289d93273d9f833d6823a6ed1e4d87ddc3bf`, version 2.3.1.
- Branch master, sau fetch chậm origin/master một commit; không pull/merge/switch.
- Rust/Cargo 1.97.1, just 1.59.0, Visual Studio 2022 Build Tools, Windows SDK.
- Codex tự compile và chạy lại probe native trong TEMP: **exit 0**.
- Không sửa mã nguồn, Cargo.toml hoặc Cargo.lock. Git working tree BongoCat sạch
  cả trước và sau; `git diff --exit-code -- Cargo.toml Cargo.lock` exit 0.

## Kiểm tra đã chạy

| Lệnh / bước | Kết quả thực tế |
|---|---|
| `cargo fmt --all -- --check` trong just check | Qua |
| Clippy workspace/all targets/all features, loại app | Qua |
| Clippy app, feature storage-test-injection | Qua |
| Clippy app, feature production | Qua |
| `cargo test --locked --workspace` trong just check | Dừng tại overlay: 1 test thất bại |
| `just check` toàn recipe | **Exit 101**, không được đánh dấu PASS |
| Test topmost chạy riêng, exact/nocapture | **Exit 101**, cùng assertion thất bại |
| `just dev-smoke` | **Exit 0**, app release được build và chạy với run-seconds 4/settings-window-smoke |

Các nhóm test hoàn tất trước khi dừng có tổng **650 passed, 1 failed, 2 ignored**.
Đây không phải tổng test toàn workspace: các nhóm phía sau điểm thất bại chưa chạy.
`cargo check --locked --workspace --release` ở cuối just check cũng chưa chạy vì
recipe dừng trước đó. Build release của dev-smoke không thay cho gate workspace này.

## Lỗi nền tái hiện

Test:
`windows::tests::window::a_demoted_model_window_returns_to_the_topmost_band`.

Vị trí: [window.rs](../BongoCat/crates/bongocat-overlay/src/windows/tests/window.rs),
dòng 242; assertion đầu tiên ngay sau tạo cửa sổ:

```text
assertion failed: window.is_topmost()
```

Chạy riêng:

```powershell
cargo test --locked -p bongocat-overlay --lib windows::tests::window::a_demoted_model_window_returns_to_the_topmost_band -- --exact --nocapture
```

Kết quả: 0 passed, 1 failed, 108 filtered out, exit 101. Lỗi không chỉ xuất hiện
trong lần chạy nhiều test; chưa xác định nguyên nhân gốc từ hai lần chạy này.
Không tự kết luận do Wallpaper Engine, DPI, test hay OS và chưa sửa code để né lỗi.
Đây là lỗi quan sát được trên checkout gốc trước khi có code companion.

## Chạy ứng dụng thật

Chạy entrypoint có sẵn `just dev-smoke`, không tạo launcher sản phẩm mới. Recipe
chuẩn bị plugin và chạy:

```text
cargo run --locked -p bongocat-app --release -- --run-seconds 4 --settings-window-smoke
```

- Plugin checkout do helper gốc quản lý tại target/plugin-dev, revision SDK đúng
  `89971f44e7d73af8c1aaf38f49aa723589457d8d`.
- Python3 trên PATH mặc định là Windows Store alias. Dùng Python 3.12.14 có sẵn,
  shim `python3.cmd` chỉ ở TEMP và PATH riêng của tiến trình; không sửa justfile.
- Build release hoàn thành (lần build đầu ghi 7m07s), ứng dụng được thực thi và recipe
  trả exit 0. Sau khi kết thúc không còn tiến trình bongocat-app.
- Đây là bằng chứng smoke qua CLI/harness; chưa có QA trực quan do Codex quan sát
  hoặc ảnh chụp pet, chưa đo nhiều DPI, soak hay kiểm tra đầy đủ plugin lifecycle.

EXE development baseline: `BongoCat/target/release/bongocat-app.exe`, 27.468.288 byte.
SHA-256: `D94FD9D83BEF2C13DE9F3C3891A41B9C8BCBE5DA1DC98106CA9E573A2CF44018`.
Không phải bản companion hoặc installer phát hành; không phân phối artifact này.

## Log và việc còn lại

- [Toàn bộ just check](logs/C01-2026-10-25-just-check.log).
- [Exit just check](logs/C01-2026-10-25-just-check.exit.txt).
- [Test topmost riêng + backtrace](logs/C01-2026-10-25-topmost-isolated.log).
- [Build/run dev-smoke](logs/C01-2026-10-25-dev-smoke.log).
- [Exit dev-smoke](logs/C01-2026-10-25-dev-smoke.log.exit.txt).

Blocker môi trường MSVC đã giải quyết. C-01 đã có kết quả baseline, nhưng quality
gate còn đỏ. Việc còn lại: thống nhất xử lý test topmost/lỗi nền bằng bằng chứng,
không tự tắt test hoặc thay chức năng; phần spike người que vẫn chưa triển khai.
Codex bàn giao kết quả cho Gen qua MSG-017, không đòi leader chuyển lời.

CHANGELOG: bỏ qua vì chỉ chạy baseline và ghi tài liệu, chưa sửa sản phẩm.
