Add-Type -AssemblyName System.Drawing

$imgDir = $PSScriptRoot
$siteDir = Split-Path $imgDir -Parent | Split-Path -Parent
$projectRoot = Split-Path $siteDir -Parent
$resourcesDir = Join-Path $projectRoot "resources"

$srcFile = Get-ChildItem -Path $resourcesDir -Filter "*.jpg" | Where-Object { $_.Length -eq 914439 } | Select-Object -First 1
Write-Output "using source file: $($srcFile.Name)"

$outPath = Join-Path $imgDir "founder-photo.jpg"

$src = [System.Drawing.Image]::FromFile($srcFile.FullName)
Write-Output "source: $($src.Width) x $($src.Height)"

$cropRect = New-Object System.Drawing.Rectangle(150, 60, 1300, 1300)
$cropped = New-Object System.Drawing.Bitmap($cropRect.Width, $cropRect.Height)
$g = [System.Drawing.Graphics]::FromImage($cropped)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.DrawImage($src, (New-Object System.Drawing.Rectangle(0,0,$cropRect.Width,$cropRect.Height)), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$src.Dispose()

$jpgEncoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [int64]90)
$cropped.Save($outPath, $jpgEncoder, $encParams)
$cropped.Dispose()
Write-Output "saved $outPath"
