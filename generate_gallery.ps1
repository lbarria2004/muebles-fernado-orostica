$originalDir = "c:\Users\56951\Downloads\fotos cocina\site\fotos_originales"
$galleryDir = "c:\Users\56951\Downloads\fotos cocina\site\assets\img\gallery"
$outputFile = "c:\Users\56951\Downloads\fotos cocina\site\gallery_items.html"

# Ensure gallery directory exists
if (-not (Test-Path $galleryDir)) {
    New-Item -ItemType Directory -Path $galleryDir | Out-Null
}

# Clear existing gallery images to remove old files with spaces
Get-ChildItem -Path $galleryDir -Include *.* -Recurse | Remove-Item -Force

$files = Get-ChildItem -Path $originalDir | Where-Object { $_.Extension -match "\.(jpg|jpeg|png|webp|mp4)" }
$count = 1
$htmlContent = @()

foreach ($file in $files) {
    if ($file.Extension -eq ".mp4") {
        # Handle videos differently if needed, or skip for now if only images were shown
        # For now, let's include them but maybe with a video tag? 
        # The original site only had img tags in the provided index.html snippet?
        # Wait, looking at file list in Step 27... there was one .mp4
        # "WhatsApp Video...mp4"
        # But the index.html snippet didn't seem to show a video tag.
        # Let's skip videos for the image gallery strictly to avoid breaking layout, 
        # unless user asks for video support. The user said "fotos".
        continue
    }

    $newName = "project_$count$($file.Extension)"
    Copy-Item $file.FullName -Destination "$galleryDir\$newName"
    $htmlContent += "<div class='gallery-item'><img src='assets/img/gallery/$newName' alt='Proyecto' loading='lazy'></div>"
    $count++
}

$htmlContent | Out-File -FilePath $outputFile -Encoding utf8
Write-Host "Processed $($count - 1) images."
