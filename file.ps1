# Quick targeted scan for common password locations
$quickPaths = @(
    "C:\Users\*\Desktop\*.txt",
    "C:\Users\*\Documents\*.txt",
    "C:\Users\*\*.config",
    "C:\Users\*\*.env",
    "C:\inetpub\wwwroot\web.config",
    "C:\xampp\htdocs\*.php",
    "C:\xampp\mysql\data\*.ini"
)

Get-ChildItem -Path $quickPaths -Recurse -ErrorAction SilentlyContinue | 
Where-Object { $_.Length -lt 1MB } |
Select-String -Pattern '(password|pwd|pass|secret|key|token)[\s:=]+["'']?([^"''\s]{4,})' |
Select-Object Filename, LineNumber, Line
