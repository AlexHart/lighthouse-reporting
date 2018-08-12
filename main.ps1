# urls.ps1 should contain an array with all the urls to process.
$urls = .".\urls.ps1"

Write-Host "********************************************************************************" -ForegroundColor Red
Write-Host "Start reporting" -ForegroundColor Green
Write-Host "********************************************************************************" -ForegroundColor Red

# Create a folder for each day that the reports are executed.
$dateForFolder = Get-Date -UFormat "%Y%m%d"
$reportsPath = ".\reports\" + $dateForFolder

# Ensure that the reports folder exists.
New-Item -ItemType Directory -Force -Path $reportsPath | Out-Null

# Move the execution to the reports folder.
Push-Location $reportsPath

For ($i = 0; $i -lt $urls.Length; $i++) {
    $url = $urls[$i]
    Write-Host "Processing: " -NoNewline
    Write-Host $url -ForegroundColor Blue

    # Call lighthouse
    lighthouse $url --chrome-flags="--headless" --quiet
}

# Go back to the main directory.
Pop-Location

Write-Host "********************************************************************************" -ForegroundColor Red
Write-Host "Process finished" -ForegroundColor Green
Write-Host "********************************************************************************" -ForegroundColor Red