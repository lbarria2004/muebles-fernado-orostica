$sourceDir = "c:\Users\56951\Downloads\fotos cocina\site\assets\img\gallery"
$outputFile = "c:\Users\56951\Downloads\fotos cocina\site\gallery_items.html"

$files = Get-ChildItem -Path $sourceDir | Where-Object { $_.Extension -match "\.(jpg|jpeg|png|webp)" }

$htmlContent = $files | ForEach-Object {
    "<div class='gallery-item'><img src='assets/img/gallery/$($_.Name)' alt='Proyecto' loading='lazy'></div>"
}

$htmlContent | Out-File -FilePath $outputFile -Encoding utf8
Write-Host "Gallery HTML generated with $($files.Count) items."
