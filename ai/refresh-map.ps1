param()
$ErrorActionPreference = 'Stop'
$workspaceRoot = Split-Path -Parent $PSScriptRoot
$skipDirs = @('.git','target','node_modules','.venv','__pycache__','build','dist','.pytest_cache')
$skipFiles = @('ai/FILE_INDEX.md','ai/project-index.json')
$items = [System.Collections.Generic.List[object]]::new()
function Read-Tree([string]$folder) {
    foreach ($entry in (Get-ChildItem -LiteralPath $folder -Force | Sort-Object @{Expression={-not $_.PSIsContainer}},Name)) {
        if ($entry.PSIsContainer -and $skipDirs -contains $entry.Name) { continue }
        if ($entry.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            # OneDrive placeholders also use ReparsePoint; exclude actual symlinks/junctions only.
            if ($entry.LinkType) { continue }
        }
        $rel = $entry.FullName.Substring($workspaceRoot.Length + 1).Replace('\','/')
        if ($skipFiles -contains $rel) { continue }
        $items.Add([pscustomobject]@{ path=$rel; kind=$(if($entry.PSIsContainer){'directory'}else{'file'}); bytes=$(if($entry.PSIsContainer){$null}else{$entry.Length}) })
        if ($entry.PSIsContainer) { Read-Tree $entry.FullName }
    }
}
Read-Tree $workspaceRoot
$dependencies = [System.Collections.Generic.List[object]]::new()
foreach ($manifest in ($items | Where-Object { $_.path -match '^BongoCat/crates/[^/]+/Cargo.toml$' })) {
    $section = ''
    $source = ($manifest.path -split '/')[2]
    foreach ($line in (Get-Content -LiteralPath (Join-Path $workspaceRoot $manifest.path))) {
        if ($line -match '^\[([^\]]+)\]') { $section = $Matches[1]; continue }
        if ($section -match '(^|\.)(dependencies|dev-dependencies|build-dependencies)$' -and $line -match '^\s*(bongocat-[\w-]+)(?:\.workspace)?\s*=') {
            $dependencies.Add([pscustomobject]@{ from=$source; to=$Matches[1]; section=$section })
        }
    }
}
$snapshot = [ordered]@{
    generated_at_utc=[DateTime]::UtcNow.ToString('o')
    root='Pet'
    repository='BongoCat'
    entrypoint='PROJECT_MAP.md'
    exclusions=$skipDirs
    excluded_files=$skipFiles
    note='Physical inventory; self-generated output files excluded. Dependency declarations are not a resolved graph or completion evidence.'
    items=@($items.ToArray())
    declared_internal_dependencies=@($dependencies.ToArray())
}
$utf8 = New-Object System.Text.UTF8Encoding($false)
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'project-index.json'), ($snapshot | ConvertTo-Json -Depth 8), $utf8)
$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# Danh mục file và cây đầy đủ')
$lines.Add('')
$lines.Add('[← Trang đầu](../PROJECT_MAP.md) · [Bản đồ module](MODULE_MAP.md) · [JSON](project-index.json)')
$lines.Add('')
$lines.Add('Tự sinh từ file vật lý. Không sửa tay; chạy `ai/refresh-map.ps1` để cập nhật.')
$lines.Add('Bỏ qua Git metadata, cache, output build, môi trường ảo và hai file output tự sinh.')
$lines.Add('')
$lines.Add(('Số file: {0}; số thư mục: {1}.' -f @($items | Where-Object kind -eq 'file').Count, @($items | Where-Object kind -eq 'directory').Count))
$lines.Add('')
$lines.Add('## Cây thư mục và file')
$lines.Add('')
$lines.Add('```text')
$lines.Add('Pet/')
foreach ($item in $items) {
    $parts = $item.path -split '/'
    $suffix = if ($item.kind -eq 'directory') { '/' } else { '' }
    $lines.Add(('  ' * $parts.Length) + '|-- ' + $parts[-1] + $suffix)
}
$lines.Add('```')
$lines.Add('')
$lines.Add('## Liên kết từng file')
$lines.Add('')
foreach ($item in ($items | Where-Object kind -eq 'file')) {
    $url = (($item.path -split '/' | ForEach-Object { [Uri]::EscapeDataString($_) }) -join '/')
    $lines.Add(('- [{0}](../{1})' -f $item.path,$url))
}
$lines.Add('')
$lines.Add('## Dependency nội bộ khai báo trong Cargo.toml')
$lines.Add('')
$lines.Add('Mỗi cạnh là khai báo, gồm cả test/build/target; chưa resolve feature/target. SDK plugin nằm ở repo riêng.')
$lines.Add('')
$lines.Add('| Crate | Phụ thuộc | Section |')
$lines.Add('|---|---|---|')
foreach ($edge in $dependencies) { $lines.Add(('| `{0}` | `{1}` | `{2}` |' -f $edge.from,$edge.to,$edge.section)) }
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'FILE_INDEX.md'), ($lines -join "`n"), $utf8)
Write-Output ('Generated FILE_INDEX.md and project-index.json: {0} entries, {1} dependency declarations.' -f $items.Count,$dependencies.Count)
