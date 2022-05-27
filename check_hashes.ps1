$SkyrimCurrentHash = Get-ChildItem -Path "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\*" -Recurse | Get-FileHash -Algorithm SHA1 | Select-Object Hash,@{N='Path';E={$_.Path | Resolve-Path -Relative}}
$Skyrim1597Hash = Get-Content ".\SkyrimSE_1.5.97_hashes.sh1"
Write-Output $SkyrimCurrentHash > ".\SkyrimSE_Current_hashes.sh1"
$result = $SkyrimCurrentHash -eq $Skyrim1597Hash
Write-Output $result
Write-Output =========================================================
Write-Output $SkyrimCurrentHash
Write-Output =========================================================
Write-Output $Skyrim1597Hash