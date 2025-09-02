# Load the generated colors from wal
$colorsPath = "$HOME\.cache\wal\colors.json"
$stylesPath = "$HOME\.config\yasb\styles.css"
$backupPath = "$stylesPath.bak"

try {
    # Convert the JSON colors to a PowerShell object
    $colors = Get-Content -Raw -Path $colorsPath | ConvertFrom-Json

    # Generate the @variables{} section
    $variablesSection = @"
:root {
    --backgroundcol: $($colors.special.background);
    --foregroundcol: $($colors.special.foreground);
    --cursorcol: $($colors.special.cursor);
    --colors0: $($colors.colors.color0);
    --colors1: $($colors.colors.color1);
    --colors2: $($colors.colors.color2);
    --colors3: $($colors.colors.color3);
    --colors4: $($colors.colors.color4);
    --colors5: $($colors.colors.color5);
    --colors6: $($colors.colors.color6);
    --colors7: $($colors.colors.color7);
    --colors8: $($colors.colors.color8);
    --colors9: $($colors.colors.color9);
    --colors10: $($colors.colors.color10);
    --colors11: $($colors.colors.color11);
    --colors12: $($colors.colors.color12);
    --colors13: $($colors.colors.color13);
    --colors14: $($colors.colors.color14);
    --colors15: $($colors.colors.color15);
}
"@

    # Load existing styles content or initialize if file is missing
    if (-not (Test-Path -Path $stylesPath)) {
        $stylesContent = ""
    } else {
        $stylesContent = Get-Content -Raw -Path $stylesPath
    }

    # Enhanced regex to match the :root{ } block more accurately
    if ($stylesContent -match "(:root\s*{[^}]*})") {
        # Replace the existing :root{} section
        $newStylesContent = $stylesContent -replace "(:root\s*{[^}]*})", $variablesSection
    } else {
        # Prepend the new :root{} section if not found
        $newStylesContent = "$variablesSection`n$stylesContent"
    }

    # Trim trailing whitespace from the content
    $newStylesContent = $newStylesContent.TrimEnd()

    # Backup current styles.css before writing new content
    Copy-Item -Path $stylesPath -Destination $backupPath -Force

    # Write to a temporary file to ensure content safety
    $tempPath = "$stylesPath.tmp"
    $newStylesContent | Set-Content -Path $tempPath

    # Overwrite styles.css with temp file content
    Move-Item -Path $tempPath -Destination $stylesPath -Force

    Write-Output "Updated styles.css successfully."

} catch {
    Write-Output "An error occurred: $_"
    # Restore from backup if something fails
    if (Test-Path -Path $backupPath) {
        Copy-Item -Path $backupPath -Destination $stylesPath -Force
        Write-Output "Restored from backup."
    }
}
