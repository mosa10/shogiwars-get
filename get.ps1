$users = @(
    @('���O', '�����E�H�[�YID'),
    @('���O', '�����E�H�[�YID'),
    @('���O', '�����E�H�[�YID')
)

$out = @()

foreach ( $user in $users ){
    $uri = 'https://shogiwars.heroz.jp/users/mypage/' + $user[1] + '?locale=ja&version=webapp_7.1.0_standard'
    $res = Invoke-WebRequest -Uri $uri

    $table = $res.ParsedHtml.getElementsByTagName("table") | select -First 1

    $str = $table.innerText
    $str = $str -replace "����.*", ""
    $str = $str -replace "(10��|3��|10�b)", ""
    $str = $str -replace "�B����.", "("
    $str = $str -replace "%.", "%)"
    $str = $str -replace "\r\n", ""
    $str = $str -replace "\n", "`t"

    $out += @{
        "���O" = $user[0];
        "ID" = $user[1];
        "����" = $str
    }
}

$fls = $out | % { New-Object PSCustomObject -Property $_ }
$fls | Format-Table -Property ���O, ID, ����