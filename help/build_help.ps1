# Builds the Code Examples help from the sources in this folder:
#   ..\exampl.chm  with HTML Help Workshop (hhc.exe)
#   ..\exampl.pdf  with build_pdf.js (Node.js) and Microsoft Edge
# Usage (PowerShell):  .\build_help.ps1 [-NoChm] [-NoPdf]
param([switch]$NoChm, [switch]$NoPdf)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$root = Split-Path $here

if (-not $NoChm) {
    $hhc = Join-Path ${env:ProgramFiles(x86)} 'HTML Help Workshop\hhc.exe'
    if (-not (Test-Path $hhc)) { throw "HTML Help Workshop not found: $hhc" }
    Push-Location $here
    try {
        & $hhc exampl.hhp | Select-Object -Last 3
        # hhc returns 1 when the compile succeeds
        if ($LASTEXITCODE -ne 1) { throw "hhc failed (exit code $LASTEXITCODE)" }
        Move-Item -Force exampl.chm (Join-Path $root 'exampl.chm')
        "Built $(Join-Path $root 'exampl.chm')"
    } finally { Pop-Location }
}

if (-not $NoPdf) {
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw 'Node.js (node) is required to build the PDF' }
    $work = Join-Path ([IO.Path]::GetTempPath()) 'pbexamples_help_pdf'
    node (Join-Path $here 'build_pdf.js') $here (Join-Path $root 'exampl.pdf') $work
    if ($LASTEXITCODE -ne 0) { throw "PDF build failed (exit code $LASTEXITCODE)" }
}
