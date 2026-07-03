$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$migrations = Get-ChildItem -Path (Join-Path $root "supabase\migrations") -Filter "*.sql" | Sort-Object Name

if ($migrations.Count -eq 0) {
    throw "No Supabase migrations found."
}

$prefixes = @{}
foreach ($migration in $migrations) {
    if ($migration.Name -notmatch "^\d{12}_[a-z0-9_]+\.sql$") {
        throw "Invalid migration name: $($migration.Name)"
    }

    $prefix = $migration.Name.Substring(0, 12)
    if ($prefixes.ContainsKey($prefix)) {
        throw "Duplicate migration prefix: $prefix"
    }
    $prefixes[$prefix] = $true

    $content = Get-Content -Raw $migration.FullName
    if ([string]::IsNullOrWhiteSpace($content)) {
        throw "Empty migration: $($migration.Name)"
    }
}

"Backend foundation OK: $($migrations.Count) migration(s) checked."
