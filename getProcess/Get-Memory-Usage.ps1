# Seiichi Ariga <seiichi.ariga@gmail.com>

$processArr = @()
<# 思ったようにいかなかった # 理由 Foreach-Object に -Parallelをつけると、行列への挿入が行われない
Get-Process | Foreach-Object -Parallel { 
    $processArr += $_
}

Foreach-Object $processArr {
    Write-Host $_.PagedMemorySize64
    Write-Host $_.PrivateMemorySize64
}

$processArr
#>


Get-Process | Foreach-Object {
    $workingSet = $_.WS
    $processName = $_.Name
    $processPath = $_.Path
    $processArr += "${processName} : ${workingSet} : ${processPath}"
}

$processArr
