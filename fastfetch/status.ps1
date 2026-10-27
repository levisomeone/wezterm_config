param([string]$check, [string]$arg, [string]$name)
[Console]::OutputEncoding = [Text.UTF8Encoding]::new()
$esc = [char]27
$on  = "$esc[38;2;158;206;106m●$esc[0m"   # verde = online
$off = "$esc[97m●$esc[0m"                 # branco = offline
function Out-Status($up) { if ($up) { "$on $name" } else { "$off $name" } }

switch ($check) {
  "port" {
    $c = New-Object System.Net.Sockets.TcpClient
    try {
      $t = $c.ConnectAsync("127.0.0.1", [int]$arg)
      Out-Status ($t.Wait(500) -and $c.Connected)
    } catch { Out-Status $false } finally { $c.Dispose() }
  }
  "web" {
    try {
      $r = Invoke-WebRequest -Uri $arg -UseBasicParsing -TimeoutSec 4 -MaximumRedirection 5
      Out-Status ($r.StatusCode -lt 400)
    } catch { Out-Status $false }
  }
}
