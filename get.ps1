$users = @(
    @('名前', '将棋ウォーズID'),
    @('名前', '将棋ウォーズID'),
    @('名前', '将棋ウォーズID')
)

$out = @()

foreach ( $user in $users ){
    $uri = 'https://shogiwars.heroz.jp/users/mypage/' + $user[1] + '?locale=ja&version=webapp_7.1.0_standard'
    $res = Invoke-WebRequest -Uri $uri

    $table = $res.ParsedHtml.getElementsByTagName("table") | select -First 1

    $str = $table.innerText
    $str = $str -replace "今月.*", ""
    $str = $str -replace "(10分|3分|10秒)", ""
    $str = $str -replace "達成率.", "("
    $str = $str -replace "%.", "%)"
    $str = $str -replace "\r\n", ""
    $str = $str -replace "\n", "`t"

    $out += @{
        "名前" = $user[0];
        "ID" = $user[1];
        "棋力" = $str
    }
}

$fls = $out | % { New-Object PSCustomObject -Property $_ }
$fls | Format-Table -Property 名前, ID, 棋力