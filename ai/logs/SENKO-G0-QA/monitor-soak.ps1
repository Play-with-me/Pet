param([string]$RunDirectory=$PSScriptRoot)
$ErrorActionPreference='Stop'
$start=Get-Content -LiteralPath (Join-Path $RunDirectory 'soak-start.json') -Raw | ConvertFrom-Json
$process=Get-Process -Id $start.pid -ErrorAction Stop
$process.EnableRaisingEvents=$true
$null=$process.Handle
$initialAge=([DateTime]::UtcNow-$process.StartTime.ToUniversalTime()).TotalSeconds
$clock=[Diagnostics.Stopwatch]::StartNew()
$samples=Join-Path $RunDirectory 'soak-samples.jsonl'
while ($true) {
    $elapsed=$initialAge+$clock.Elapsed.TotalSeconds
    try {
        $process.Refresh()
        if ($process.HasExited) { throw "Release pet exited before test finished, exit code $($process.ExitCode)" }
        $sample=[ordered]@{utc=[DateTime]::UtcNow.ToString('o');elapsed_seconds=[Math]::Round($elapsed,2);pid=$process.Id;responding=$process.Responding;cpu_seconds=$process.TotalProcessorTime.TotalSeconds;working_set=$process.WorkingSet64;private_bytes=$process.PrivateMemorySize64;handles=$process.HandleCount}
        $sample | ConvertTo-Json -Compress | Add-Content -LiteralPath $samples -Encoding utf8
        if ($elapsed -ge $start.minimum_seconds) {
            $hash=(Get-FileHash -LiteralPath $start.exe -Algorithm SHA256).Hash
            if ($hash -ne $start.sha256) { throw 'EXE changed during soak' }
            [ordered]@{status='passed';pid=$process.Id;elapsed_seconds=$elapsed;responding=$process.Responding;exe_sha256=$hash;minimum_seconds=$start.minimum_seconds;clock='process initial age plus monotonic Stopwatch'} | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $RunDirectory 'soak-result.json') -Encoding utf8
            Write-Output "SOAK PASSED elapsed=$elapsed pid=$($process.Id)"
            break
        }
        Write-Output "Soak running: $([Math]::Round($elapsed))s / $($start.minimum_seconds)s; responding=$($process.Responding)"
    } catch {
        [ordered]@{status='failed';elapsed_seconds=$elapsed;error=$_.Exception.Message} | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $RunDirectory 'soak-result.json') -Encoding utf8
        throw
    }
    Start-Sleep -Seconds 30
}
