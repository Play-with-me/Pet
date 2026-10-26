---
markmap:
  color: ["#2563eb", "#0d9488", "#d97706", "#9333ea", "#e11d48", "#0284c7"]
  colorFreezeLevel: 2
  initialExpandLevel: 2
  maxWidth: 250
  spacingHorizontal: 100
  spacingVertical: 10
---
# BongoCat · Bản đồ AI

## Bắt đầu tại đây
- [Bản tổng hợp kế hoạch](../PROJECT_MASTER_PLAN.md)
- [Tin nhắn Codex ↔ Gen](../SYNC.md)
- [PROJECT_MAP](../../PROJECT_MAP.md)
- [Quy tắc workspace](../../AGENTS.md)
- [Quy tắc BongoCat](../../BongoCat/AGENTS.md)
- [Nhiệm vụ](../../TASKS.md)
- [Kế hoạch người bạn desktop](companion.html)

## Kiến trúc và bằng chứng
- [Thiết kế chính](../../BongoCat/docs/technical-design.md)
- [Quyết định ADR](../../BongoCat/docs/adr/)
- [23 module và luồng dữ liệu](../MODULE_MAP.md)
- [Cây đầy đủ và từng file](../FILE_INDEX.md)
- [Danh mục máy đọc](../project-index.json)
- [Benchmark](../../BongoCat/docs/benchmark/)

## Lắp ghép và giao diện
- [app](../../BongoCat/crates/bongocat-app/src/main.rs)
  - Khởi động, lifecycle, settings và shutdown
- [ui](../../BongoCat/crates/bongocat-ui/src/lib.rs)
  - GPUI và component
- [ui-protocol](../../BongoCat/crates/bongocat-ui-protocol/src/lib.rs)
  - Typed command và snapshot
- [i18n](../../BongoCat/crates/bongocat-i18n/src/lib.rs)
  - Ngôn ngữ và bản dịch

## Input và runtime
- [input](../../BongoCat/crates/bongocat-input/src/lib.rs)
  - Kiểu keyboard, cursor và gamepad
- [platform](../../BongoCat/crates/bongocat-platform/src/lib.rs)
  - Windows / macOS adapter
- [runtime](../../BongoCat/crates/bongocat-runtime/src/lib.rs)
  - Owner trạng thái, input và pacing
- [Input semantics](../../BongoCat/shared/behavior/input-semantics.md)

## Model và render
- [model](../../BongoCat/crates/bongocat-model/src/lib.rs)
- [model-store](../../BongoCat/crates/bongocat-model-store/src/lib.rs)
- [live2d](../../BongoCat/crates/bongocat-live2d/src/lib.rs)
- [live2d-playback](../../BongoCat/crates/bongocat-live2d-playback/src/lib.rs)
- [live2d-render](../../BongoCat/crates/bongocat-live2d-render/src/lib.rs)
- [render](../../BongoCat/crates/bongocat-render/src/lib.rs)
- [overlay](../../BongoCat/crates/bongocat-overlay/src/lib.rs)
  - Cửa sổ native, D3D11 / Metal
- [audio](../../BongoCat/crates/bongocat-audio/src/lib.rs)
- [resources](../../BongoCat/resources/)
- [Cubism vendor](../../BongoCat/vendor/)

## Plugin
- [plugin-manager](../../BongoCat/crates/bongocat-plugin-manager/src/lib.rs)
  - Catalog và lifecycle package
- [plugin-service](../../BongoCat/crates/bongocat-plugin-service/src/lib.rs)
  - Owner dịch vụ
- [plugin-hud](../../BongoCat/crates/bongocat-plugin-hud/src/lib.rs)
  - Layout và lớp hiển thị
- SDK và plugin chính thức ở repository riêng
  - Đọc CONTRIBUTING trước khi làm

## Dữ liệu và phân phối
- [config](../../BongoCat/crates/bongocat-config/src/lib.rs)
- [storage](../../BongoCat/crates/bongocat-storage/src/lib.rs)
- [log](../../BongoCat/crates/bongocat-log/src/lib.rs)
- [update](../../BongoCat/crates/bongocat-update/src/lib.rs)
- [packaging](../../BongoCat/crates/bongocat-packaging/src/main.rs)
- [justfile](../../BongoCat/justfile)
  - Điểm vào kiểm tra và build
- [tools](../../BongoCat/tools/)
- [CI](../../BongoCat/.github/workflows/)

## Phối hợp hai AI
- [Phân công và giới hạn](../../AI_COLLABORATION_REPORT.md)
- [Codex bàn giao](../../HANDOFF_CODEX.md)
- [Antigravity bàn giao](../../HANDOFF_ANTIGRAVITY.md)
- Markdown là nguồn chung
  - Sửa nội dung rồi build lại HTML
  - Không sửa trực tiếp HTML tự sinh
  - Không sửa cùng nguồn trong cùng thời điểm
