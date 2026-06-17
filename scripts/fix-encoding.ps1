$root = Split-Path -Parent $PSScriptRoot
$files = Get-ChildItem (Join-Path $root "*.html")
foreach ($f in $files) {
  $c = [System.IO.File]::ReadAllText($f.FullName)
  $c = $c.Replace([char]0x2014, [string][char]0x2014) 
  $c = $c -replace 'expeditions@Stackly Adventure\.com', 'hello@stacklyadventure.com'
  [System.IO.File]::WriteAllText($f.FullName, $c, [System.Text.UTF8Encoding]::new($false))
}
Write-Host "Fixed $($files.Count) files"
