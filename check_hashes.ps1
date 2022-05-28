# Delete lines 2, 47-48 and 51-EoF if you want to remove the output function, I'll delete it in an update but rn I need data for debugging purposes.
Start-Transcript -Force -Path ".\output.log"

# Path to Skyrim Directory (The one with SkyrimSE.exe)
$SkyrimSEPath = "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition"

# Save SHA1 hash to file
$startLocation = $pwd
Set-Location $SkyrimSEPath
$SkyrimCurrentHash = Get-ChildItem -Path ".\*" -Recurse | Get-FileHash -Algorithm SHA1 | Select-Object Hash,@{N='Path';E={$_.Path | Resolve-Path -Relative}}
Set-Location $startLocation
Write-Output $SkyrimCurrentHash > ".\SkyrimSE_Current_hashes.sh1"

# Compare hashes
$filler = "##################################################"
$foundLine = $false
$missAmount = 0

foreach($line1597 in Get-Content ".\SkyrimSE_1.5.97_hashes.sh1") {
    foreach($lineCur in Get-Content ".\SkyrimSE_Current_hashes.sh1") {
        # Skip iteration if hashes match
        if($lineCur.Trim() -eq $line1597){
            $foundLine = $true
            continue
        }
    }
    # If hash hasn't been found proceed to save the info
    if(!($foundLine)) {
        if ($missAmount -eq 0) {
            Write-Host $filler -ForegroundColor DarkRed
        }
        $missAmount  += 1
        Write-Host $line1597
        Write-Host "Doesn't match" -ForegroundColor DarkRed
        Write-Host $filler -ForegroundColor DarkRed
    }
    $foundLine = $false
}

# Epilogue
if ($missAmount -eq 0) {
    Write-Host "`nScan complete and every file seems to be ok" -ForegroundColor Green
} else {
    Write-Host "`nScan complete, files with wrong hashes: $($missAmount)`n" -ForegroundColor DarkRed
    Write-Host "You can check the steam repos you'll have to redownload in the file file_table.txt" -ForegroundColor DarkRed
}
Write-Host "In the case you've encountered problems (such as having a working SkyrimSE 1.5.97 and still getting hashes that do not match), send me the contents of the program folder to eris.semiprofessional@gmail.com with 'SkyrimSE hash checker' as Subject." -ForegroundColor DarkMagenta
Write-Host "The files don't contain any sensitive information and it might help me debug this program." -ForegroundColor DarkMagenta
Write-Host "`nThanks for using SkyrimSE hash checker! -Eris" -ForegroundColor DarkMagenta
Pause

Stop-Transcript

# Save output file (for debugging purposes, please send me the output.log)
$log = get-content ".\output.log"
Write-Output "**********************" > ".\output.log"
Write-Output $log[9..($log.Length-5)] >> ".\output.log"