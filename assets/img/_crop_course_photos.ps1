Add-Type -AssemblyName System.Drawing

function CropSave($inFile, $outFile, $x, $y, $w, $h) {
  $src = [System.Drawing.Image]::FromFile((Join-Path $PSScriptRoot $inFile))
  $cropRect = New-Object System.Drawing.Rectangle($x, $y, $w, $h)
  $cropped = New-Object System.Drawing.Bitmap($w, $h)
  $g = [System.Drawing.Graphics]::FromImage($cropped)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.DrawImage($src, (New-Object System.Drawing.Rectangle(0,0,$w,$h)), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
  $g.Dispose()
  $src.Dispose()
  $cropped.Save((Join-Path $PSScriptRoot $outFile), [System.Drawing.Imaging.ImageFormat]::Png)
  $cropped.Dispose()
  Write-Output "saved $outFile"
}

CropSave "_src_window_woman.png" "photo-courses-hero.png" 0 0 540 900
CropSave "_src_flatlay_flowers.png" "photo-ippoplus-hero.png" 0 0 820 900
