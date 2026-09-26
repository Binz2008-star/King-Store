[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$ZipPath,

  [string]$RepoPath = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ZipPath -PathType Leaf)) {
  throw "ZIP file not found: $ZipPath"
}

if (-not (Test-Path -LiteralPath (Join-Path $RepoPath ".git") -PathType Container)) {
  throw "RepoPath is not a Git repository: $RepoPath"
}

Push-Location $RepoPath
try {
  git fetch origin
  if ($LASTEXITCODE -ne 0) { throw "git fetch failed." }

  git switch theme/king-store-sense
  if ($LASTEXITCODE -ne 0) { throw "Could not switch to theme/king-store-sense." }

  git reset --hard origin/theme/king-store-sense
  if ($LASTEXITCODE -ne 0) { throw "Could not reset branch to origin/theme/king-store-sense." }

  $temp = Join-Path ([System.IO.Path]::GetTempPath()) ("king-store-sense-" + [guid]::NewGuid().ToString())
  New-Item -ItemType Directory -Path $temp | Out-Null

  try {
    Expand-Archive -LiteralPath (Resolve-Path $ZipPath) -DestinationPath $temp -Force

    $rootItems = @(Get-ChildItem -LiteralPath $temp -Force)
    if ($rootItems.Count -eq 1 -and $rootItems[0].PSIsContainer) {
      $source = $rootItems[0].FullName
    } else {
      $source = $temp
    }

    git rm -r --ignore-unmatch .
    if ($LASTEXITCODE -ne 0) { throw "git rm failed." }

    Get-ChildItem -LiteralPath $source -Force | ForEach-Object {
      Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $RepoPath $_.Name) -Recurse -Force
    }

    git add -A
    if ($LASTEXITCODE -ne 0) { throw "git add failed." }

    $status = git status --short
    if (-not $status) {
      Write-Host "No changes detected; branch already matches the ZIP."
      exit 0
    }

    git commit -m "Import complete King Store Sense branded theme"
    if ($LASTEXITCODE -ne 0) { throw "git commit failed." }

    git push origin HEAD:theme/king-store-sense
    if ($LASTEXITCODE -ne 0) { throw "git push failed." }

    Write-Host ""
    Write-Host "SUCCESS: complete Sense theme pushed to theme/king-store-sense."
    git rev-parse HEAD
  }
  finally {
    if (Test-Path -LiteralPath $temp) {
      Remove-Item -LiteralPath $temp -Recurse -Force
    }
  }
}
finally {
  Pop-Location
}
