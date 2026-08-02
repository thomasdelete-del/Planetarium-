$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$htmlPath = Join-Path $root 'GaiaKonverter.html'
$port = 8765
$prefix = "http://127.0.0.1:$port/"
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add($prefix)
try { $listener.Start() } catch { Write-Host "Port $port ist belegt. Schließe einen bereits laufenden Starter." -ForegroundColor Red; Read-Host; exit 1 }
Write-Host "Gaia-Konverter läuft: $prefix" -ForegroundColor Green
Write-Host 'Dieses Fenster geöffnet lassen. Zum Beenden Strg+C.'
Start-Process $prefix
function Send-Bytes($response,[byte[]]$bytes,$type,$status=200){$response.StatusCode=$status;$response.ContentType=$type;$response.ContentLength64=$bytes.Length;$response.OutputStream.Write($bytes,0,$bytes.Length);$response.Close()}
try {
  while($listener.IsListening){
    $ctx=$listener.GetContext();$path=$ctx.Request.Url.AbsolutePath
    try {
      if($path -eq '/' -or $path -eq '/GaiaKonverter.html'){Send-Bytes $ctx.Response ([IO.File]::ReadAllBytes($htmlPath)) 'text/html; charset=utf-8'}
      elseif($path -eq '/base'){$wc=[Net.WebClient]::new();$data=$wc.DownloadData('https://storage.googleapis.com/tetra3rs-testvecs/gaia_merged.bin');Send-Bytes $ctx.Response $data 'application/octet-stream'}
      elseif($path -eq '/tap' -and $ctx.Request.HttpMethod -eq 'POST'){$reader=[IO.StreamReader]::new($ctx.Request.InputStream,$ctx.Request.ContentEncoding);$body=$reader.ReadToEnd();$wc=[Net.WebClient]::new();$wc.Headers['Content-Type']='application/x-www-form-urlencoded';$data=$wc.UploadData('https://gea.esac.esa.int/tap-server/tap/sync','POST',[Text.Encoding]::UTF8.GetBytes($body));Send-Bytes $ctx.Response $data 'text/csv; charset=utf-8'}
      else{Send-Bytes $ctx.Response ([Text.Encoding]::UTF8.GetBytes('Nicht gefunden')) 'text/plain; charset=utf-8' 404}
    } catch {Send-Bytes $ctx.Response ([Text.Encoding]::UTF8.GetBytes(('Serverfehler: '+$_.Exception.Message))) 'text/plain; charset=utf-8' 502}
  }
} finally {$listener.Stop();$listener.Close()}
