# Seiichi Ariga <seiichi.ariga@gmail.com>

$url = "https://api.zipaddress.net/?zipcode="

$firstTime = $true

$Args | Foreach-Object {
    if ($firstTime -eq $false) {
        Start-Sleep -Seconds 1
    }
    $request = $url + $_
    $res = Invoke-WebRequest $request
    $obj = ConvertFrom-Json $res.Content
    # {0:000-0000}は、変数の代入と3ケタ-4ケタのフォーマット指定
    if ($obj.code -eq '200') {
        Write-Host ("〒{0:000-0000}" -f $_ + ' の住所: ' + $obj.data.fullAddress) -ForegroundColor Cyan
    }elseif ($obj.code -eq '404') {
        Write-Host ("〒{0:000-0000}" -f $_ + 'は存在しません') -ForegroundColor Red
    }
    $firstTime = $false
}

