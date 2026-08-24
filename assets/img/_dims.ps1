Add-Type -AssemblyName System.Drawing
foreach ($f in @("hero-bg-1.png","hero-bg-2.png")) {
  $img = [System.Drawing.Image]::FromFile((Join-Path $PSScriptRoot $f))
  Write-Output "$f : $($img.Width) x $($img.Height)"
  $img.Dispose()
}
