# Sơ đồ dùng chung — Codex và Antigravity

Markmap chuyển Markdown thành sơ đồ tư duy có thể thu/mở nhánh, zoom và kéo.
Đã cài `markmap-cli` **0.18.12** tại đây; khóa dependency trong `pnpm-lock.yaml`.
Không phải dependency runtime của BongoCat. Không cần tài khoản hoặc API trả phí.

## Mở sơ đồ

- [Ý tưởng và kế hoạch người bạn desktop](companion.html).
- [Kiến trúc, module và nguồn mã](architecture.html).

Mở file HTML bằng trình duyệt. JS/CSS được nhúng để xem offline; link ra nguồn mã
cần giữ nguyên vị trí thư mục. Gửi một HTML riêng vẫn xem được sơ đồ nhưng các link
tới mã nguồn dự án sẽ không còn đúng nếu máy nhận thiếu thư mục tương ứng.

Để xem qua HTTP trong trình duyệt của Codex, chạy `node ai/diagrams/preview.mjs`
từ thư mục Pet rồi mở địa chỉ được in ra. Server chỉ nghe trên máy cục bộ; dừng
bằng Ctrl+C. Sơ đồ cũng có ảnh xem nhanh `companion.png` và `architecture.png`.

## Quy trình chung cho hai AI

1. Đọc [quy tắc](../../AGENTS.md), nhiệm vụ và bàn giao mới nhất.
2. Sửa `companion.md` khi cập nhật ý tưởng đã được người dùng chấp thuận;
   sửa `architecture.md` khi cấu trúc mã thực tế thay đổi. Ghi rõ thông tin đề xuất
   nếu chưa được duyệt. Không đánh dấu hoàn thành chỉ từ nội dung sơ đồ.
3. Chỉ một bên sửa cùng file nguồn tại một thời điểm; không sửa trực tiếp HTML.
4. Chạy từ thư mục Pet:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai\diagrams\build.ps1
```

5. Mở HTML kiểm tra chữ, link, thu/mở nhánh; ghi file đã sửa vào bàn giao riêng.

Nếu cài trên máy mới, dùng Node.js 18+ và `pnpm install --frozen-lockfile` trong
thư mục này, sau đó chạy `node build.mjs`. Lần cài đầu cần Internet; HTML đã build
không cần Internet. Công cụ không tự đồng bộ hội thoại hoặc tự gửi việc cho AI khác.

## Nguồn và giấy phép

- Mã nguồn: https://github.com/markmap/markmap
- CLI: https://markmap.js.org/docs/packages--markmap-cli
- Giấy phép MIT: bản sao tại `MARKMAP_LICENSE.txt`.
- Dependency cài qua registry npm; thông tin package trỏ về repository chính thức.
  Các dependency bắc cầu giữ giấy phép trong package riêng dưới `node_modules`.
