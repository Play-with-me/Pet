param([int]$SenkoProcessId, [string]$Executable, [string]$OutputDirectory)
$ErrorActionPreference = 'Stop'
$clock = [Diagnostics.Stopwatch]::StartNew()
$hash = (Get-FileHash -LiteralPath $Executable -Algorithm SHA256).Hash
$process = Get-Process -Id $SenkoProcessId
$process.EnableRaisingEvents = $true
$null = $process.Handle
$unresponsive = 0
$samples = 0
@{pid=$SenkoProcessId;utc=[DateTime]::UtcNow.ToString('o');minimum_seconds=1800;sha256=$hash;clock='monotonic Stopwatch from first observation; process age excluded'} | ConvertTo-Json | Set-Content (Join-Path $OutputDirectory 'soak-start.json')
try {
    while ($true) {
        $process.Refresh()
        if ($process.HasExited) { throw "Senko exited: $($process.ExitCode)" }
        if ($process.Path -ne $Executable) { throw 'Unexpected executable path' }
        if (!$process.Responding) { $unresponsive++ }
        $samples++
        @{elapsed_seconds=$clock.Elapsed.TotalSeconds;utc=[DateTime]::UtcNow.ToString('o');pid=$process.Id;responding=$process.Responding;cpu_seconds=$process.TotalProcessorTime.TotalSeconds;working_set=$process.WorkingSet64;private_bytes=$process.PrivateMemorySize64;handles=$process.HandleCount} | ConvertTo-Json -Compress | Add-Content (Join-Path $OutputDirectory 'soak-samples.jsonl')
        if ($clock.Elapsed.TotalSeconds -ge 1800) { break }
        Start-Sleep -Seconds 30
    }
    if ((Get-FileHash -LiteralPath $Executable -Algorithm SHA256).Hash -ne $hash) { throw 'Executable changed' }
    if ($unresponsive -gt 0) { throw "Unresponsive samples: $unresponsive" }
    @{status='passed';elapsed_seconds=$clock.Elapsed.TotalSeconds;samples=$samples;unresponsive_samples=$unresponsive;pid=$SenkoProcessId;sha256=$hash} | ConvertTo-Json | Set-Content (Join-Path $OutputDirectory 'soak-result.json')
} catch {
    @{status='failed';elapsed_seconds=$clock.Elapsed.TotalSeconds;samples=$samples;pid=$SenkoProcessId;error=$_.Exception.Message} | ConvertTo-Json | Set-Content (Join-Path $OutputDirectory 'soak-result.json')
    throw
}
