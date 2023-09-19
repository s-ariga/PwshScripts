# Seiichi Ariga <seiichi.ariga@gmail.com>

<#
Usage:
Postal-Api.ps1 1234567

Description:
コマンド引数で郵便番号(ハイフンなし7ケタor‐月8ケタ半角)を入力すると、住所部分が帰ってくる。

APIは https://zipaddress.net/ を使わせてもらってます
#>

# でもどちらかというと、住所 -> 郵便番号 のほうが使うよな...w

$url = "https://api.zipaddress.net/?zipcode="

# 2個以上検索するときは、間に時間を空ける
$firstTime = $true
$interval = 1

$Args | Foreach-Object {
    if ($firstTime -eq $false) {
        Start-Sleep -Seconds $interval
    }
    $request = $url + $_
    $res = Invoke-WebRequest $request
    $obj = ConvertFrom-Json $res.Content
    # {0:000-0000}は、変数の代入と3ケタ-4ケタのフォーマット指定
    if ($obj.code -eq '200') {
        Write-Host ("〒{0:000-0000}" -f $_ + ' の住所: ' + $obj.data.fullAddress) -ForegroundColor Cyan
    }elseif ($obj.code -eq '404') {
        Write-Host ("〒{0:000-0000}" -f $_ + 'は存在しません。') -ForegroundColor Red
    }else {
        Write-Host ("不明なエラー: " + $obj.code)
    }
    $firstTime = $false
}

