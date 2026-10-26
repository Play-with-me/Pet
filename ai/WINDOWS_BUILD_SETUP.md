# Bước còn lại để build trên Windows

Cập nhật 25/10/2026. Không thay chức năng ứng dụng.

**Đã hoàn tất bước cài MSVC/SDK:** Gen xác nhận MSG-016 và Codex đã tự chạy lại
probe exit 0. App gốc build/run dev-smoke exit 0; xem [BASELINE_REPORT.md](BASELINE_REPORT.md).
Không cần chạy lại installer chỉ vì các hướng dẫn lịch sử bên dưới; bước còn lại
hiện là điều tra test topmost của mã gốc, không phải thiếu toolchain.

## Đã làm và kiểm tra

- Cài Rust **1.97.1** x64 MSVC theo `BongoCat/rust-toolchain.toml`, cùng Cargo,
  rustfmt và Clippy. `rustc --version`, `cargo --version` và danh sách component đã qua.
- Cài **just 1.59.0** vào `%USERPROFILE%\.cargo\bin\just.exe`; `just --version`
  và `just --list` trong BongoCat đã chạy thành công.
- Rustup và just tải từ nguồn chính thức, so SHA-256 trước khi chạy/giải nén.
- Không sửa PATH toàn hệ thống hoặc PATH người dùng; dùng đường dẫn đầy đủ hoặc
  bổ sung PATH cho riêng phiên PowerShell.
- Kiểm tra chương trình Rust tối thiểu trong TEMP thất bại với:

```text
error: linker `link.exe` not found
Native linker probe exit code: 1
```

Đây là lỗi môi trường linker, chưa phải lỗi mã BongoCat. Chưa chạy baseline ứng dụng.

## Leader cần xác nhận cài MSVC/SDK qua UAC

Phiên Codex hiện không có quyền Administrator. Đã tải bootstrapper Build Tools từ
Microsoft và kiểm tra chữ ký `Valid`, publisher Microsoft Corporation. Chưa chạy cài.

Mở PowerShell và chạy:

```powershell
Start-Process -FilePath "$env:TEMP\deskbuddy-rust-setup\vs_BuildTools.exe" -Verb RunAs -WindowStyle Normal -ArgumentList '--passive --wait --norestart --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.26100' -Wait
```

Xác nhận UAC của Windows và đợi cài hoàn tất. Lệnh không tự khởi động lại máy. Nếu
installer yêu cầu restart, hoàn thành việc đó trước lần kiểm tra tiếp theo.

File nằm trong TEMP; nếu đã bị dọn, tải lại từ
[Microsoft Build Tools 2022](https://aka.ms/vs/17/release/vs_buildtools.exe), chọn
Desktop development with C++, MSVC x64/x86 và Windows SDK. Không cần cài IDE đầy đủ.

Sau khi cài, báo Codex để kiểm tra compiler/linker/SDK, chạy lại probe rồi baseline.
Không chỉ dựa vào việc installer đóng cửa sổ để báo build thành công.

Trong PowerShell cần dùng toolchain, có thể bổ sung cho riêng phiên:

```powershell
$env:Path = "$env:USERPROFILE\.cargo\bin;$env:Path"
rustc --version
cargo --version
just --version
```

## Nguồn

- [Rust Windows installation](https://rust-lang.org/tools/install/).
- [just 1.59.0](https://github.com/casey/just/releases/tag/1.59.0).
- [Microsoft Build Tools component IDs](https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2022).
- [Microsoft bootstrapper và tham số](https://learn.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2022).
