Add-Type -AssemblyName System.Drawing

$srcPath = Join-Path $PSScriptRoot "_source_businesscard.png"
$outPath = Join-Path $PSScriptRoot "logo.png"

$src = [System.Drawing.Image]::FromFile($srcPath)

$cropRect = New-Object System.Drawing.Rectangle(1670, 45, 270, 260)
$cropped = New-Object System.Drawing.Bitmap($cropRect.Width, $cropRect.Height)
$g = [System.Drawing.Graphics]::FromImage($cropped)
$g.DrawImage($src, (New-Object System.Drawing.Rectangle(0,0,$cropRect.Width,$cropRect.Height)), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$src.Dispose()

$cropped.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$cropped.Dispose()
Write-Output "saved $outPath"
