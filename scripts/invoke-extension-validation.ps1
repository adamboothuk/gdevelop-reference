param(
    [Parameter(Mandatory = $true)]
    [string] $ExtensionName,

    [string] $ProjectPath = 'C:\GameDev\AI-Playground\AI Playground.json',

    [string] $OutputRoot = 'C:\GameDev\AI-Playground\html5-validation',

    [switch] $ExportHtml5,

    [switch] $UseNpxGdexporter,

    [switch] $BrowserSmoke,

    [switch] $RequireSplitInstall,

    [int] $Port = 8060,

    [string] $ChromePath = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
)

$ErrorActionPreference = 'Stop'

function Get-Slug {
    param([string] $Name)
    return ($Name -replace '[^A-Za-z0-9]', '').ToLowerInvariant()
}

if (-not (Test-Path -LiteralPath $ProjectPath)) {
    throw "Project file not found: $ProjectPath"
}

$projectBytes = [System.IO.File]::ReadAllBytes($ProjectPath)
if ($projectBytes.Length -ge 3 -and
    $projectBytes[0] -eq 0xEF -and
    $projectBytes[1] -eq 0xBB -and
    $projectBytes[2] -eq 0xBF) {
    throw "Project file has a UTF-8 BOM. GDevelop/gdexporter can reject this as malformed: $ProjectPath"
}

$projectDirectory = Split-Path -Parent $ProjectPath
$extensionSlug = Get-Slug -Name $ExtensionName
$project = Get-Content -Raw -LiteralPath $ProjectPath | ConvertFrom-Json

$inlineMatches = @()
$splitMatches = @()

if ($project.eventsFunctionsExtensions) {
    foreach ($extension in $project.eventsFunctionsExtensions) {
        if ($extension.name -eq $ExtensionName) {
            $inlineMatches += $extension
        }

        if ($extension.referenceTo -eq "/eventsFunctionsExtensions/$extensionSlug") {
            $splitMatches += $extension
        }
    }
}

$splitPath = Join-Path $projectDirectory "eventsFunctionsExtensions\$extensionSlug.json"
$exportedExtensionPath = Join-Path $projectDirectory "exported_extensions\$ExtensionName.json"

Write-Output "Project: $ProjectPath"
Write-Output "Extension: $ExtensionName"
Write-Output "Expected split reference: /eventsFunctionsExtensions/$extensionSlug"
Write-Output "Inline install entries: $($inlineMatches.Count)"
Write-Output "Split install references: $($splitMatches.Count)"
Write-Output "Split extension file exists: $(Test-Path -LiteralPath $splitPath)"
Write-Output "Exported extension source exists: $(Test-Path -LiteralPath $exportedExtensionPath)"

if ($RequireSplitInstall) {
    if ($splitMatches.Count -eq 0) {
        throw "Required split reference not found: /eventsFunctionsExtensions/$extensionSlug"
    }
    if (-not (Test-Path -LiteralPath $splitPath)) {
        throw "Required split extension file not found: $splitPath"
    }
}

$typePattern = [regex]::Escape("$ExtensionName::")
$rawProject = Get-Content -Raw -LiteralPath $ProjectPath
$instructionMatches = [regex]::Matches($rawProject, '"value"\s*:\s*"([^"]+)"') |
    Where-Object { $_.Groups[1].Value -match "^$typePattern" } |
    ForEach-Object { $_.Groups[1].Value } |
    Sort-Object -Unique

Write-Output "Serialized instruction type.value matches:"
if ($instructionMatches.Count -eq 0) {
    Write-Output "  (none found)"
} else {
    foreach ($match in $instructionMatches) {
        Write-Output "  $match"
    }
}

if ($ExportHtml5) {
    $gdexport = Get-Command gdexport -ErrorAction SilentlyContinue

    $outputDirectory = Join-Path $OutputRoot $extensionSlug
    New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

    Write-Output "Running gdexport..."
    if ($gdexport) {
        & $gdexport.Source --project $ProjectPath --out $outputDirectory
    } elseif ($UseNpxGdexporter) {
        & npx -p gdexporter gdexport --project $ProjectPath --out $outputDirectory
    } else {
        throw "gdexport was not found. Install gdexporter or rerun with -UseNpxGdexporter."
    }

    if ($LASTEXITCODE -ne 0) {
        throw "gdexport failed with exit code $LASTEXITCODE."
    }

    $indexPath = Join-Path $outputDirectory 'index.html'
    if (-not (Test-Path -LiteralPath $indexPath)) {
        throw "gdexport completed without producing index.html: $indexPath"
    }

    Write-Output "HTML5 export directory: $outputDirectory"
}

if ($BrowserSmoke) {
    $outputDirectory = Join-Path $OutputRoot $extensionSlug
    $indexPath = Join-Path $outputDirectory 'index.html'
    if (-not (Test-Path -LiteralPath $indexPath)) {
        throw "HTML5 export index.html not found: $indexPath"
    }

    if (-not (Test-Path -LiteralPath $ChromePath)) {
        throw "Chrome executable not found: $ChromePath"
    }

    $python = Get-Command python -ErrorAction SilentlyContinue
    if (-not $python) {
        throw "python was not found. It is needed for the local static server."
    }

    $url = "http://127.0.0.1:$Port/index.html"
    Write-Output "Starting static server at $url"
    $server = Start-Process -FilePath $python.Source `
        -ArgumentList @('-m', 'http.server', "$Port", '--bind', '127.0.0.1') `
        -WorkingDirectory $outputDirectory `
        -WindowStyle Hidden `
        -PassThru

    try {
        Start-Sleep -Seconds 2
        Write-Output "Running Chrome headless smoke test..."
        $chromeArgs = @(
            '--headless=new',
            '--disable-gpu',
            '--no-first-run',
            '--disable-extensions',
            '--virtual-time-budget=5000',
            '--dump-dom',
            $url
        )
        & $ChromePath @chromeArgs | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "Chrome smoke test failed with exit code $LASTEXITCODE."
        }
        Write-Output "Browser smoke test completed without Chrome process errors."
    } finally {
        if ($server -and -not $server.HasExited) {
            Stop-Process -Id $server.Id -Force
        }
    }
}
