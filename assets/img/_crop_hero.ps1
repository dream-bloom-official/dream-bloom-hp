Add-Type -AssemblyName System.Drawing

function CropClean($inFile, $outFile) {
  $src = [System.Drawing.Image]::FromFile((Join-Path $PSScriptRoot $inFile))
  $cropRect = New-Object System.Drawing.Rectangle(0, 240, 1600, 660)
  $cropped = New-Object System.Drawing.Bitmap($cropRect.Width, $cropRect.Height)
  $g = [System.Drawing.Graphics]::FromImage($cropped)
  $g.DrawImage($src, (New-Object System.Drawing.Rectangle(0,0,$cropRect.Width,$cropRect.Height)), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
  $g.Dispose()
  $src.Dispose()
  $cropped.Save((Join-Path $PSScriptRoot $outFile), [System.Drawing.Imaging.ImageFormat]::Png)
  $cropped.Dispose()
  Write-Output "saved $outFile"
}

CropClean "hero-bg-1.png" "photo-interior-1.png"
CropClean "hero-bg-2.png" "photo-interior-2.png"
