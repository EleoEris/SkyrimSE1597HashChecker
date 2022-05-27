$startLocation = $pwd
Set-Location "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition"
$SkyrimCurrentHash = Get-ChildItem -Path ".\*" -Recurse | Get-FileHash -Algorithm SHA1 | Select-Object Hash,@{N='Path';E={$_.Path | Resolve-Path -Relative}}
Set-Location $startLocation
$Skyrim1597Hash = Get-Content ".\SkyrimSE_1.5.97_hashes.sh1"
Write-Output $SkyrimCurrentHash > ".\SkyrimSE_Current_hashes.sh1"

#Compare-Object  -ReferenceObject $SkyrimCurrentHash -DifferenceObject $Skyrim1597Hash | Select-Object -ExpandProperty InputObject
Compare-Object -ReferenceObject $Skyrim1597Hash -DifferenceObject $SkyrimCurrentHash
#Write-Output $SkyrimCurrentHash
#Write-Output =========================================================
#Write-Output $Skyrim1597Hash
