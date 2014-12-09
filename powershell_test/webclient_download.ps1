$version = "34.0"
$URL = "https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${version}/win32/ja/Firefox Setup ${version}.exe"

$saveDir = $(Get-Item .).FullName
$webclient = New-Object -TypeName System.Net.WebClient
$webclient.DownloadFile($URL, ("${saveDir}\Firefox Setup ${version}.exe"))