# Set variables
$Env:VSCODE_DEV = $null
$Env:ELECTRON_RUN_AS_NODE = 1

$ScoopCodium = "C:\Users\seiic\scoop\apps\vscodium\current\"
# Define the paths
$VSCodiumPath = Join-Path $ScoopCodium "VSCodium.exe"
$CLIPath = Join-Path $ScoopCodium "resources\app\out\cli.js"

# Execute the VSCodium.exe with the given parameters
& $VSCodiumPath $CLIPath --ms-enable-electron-run-as-node @args

# Clear the environment variables (Optional, as they are only set for this session)
$Env:VSCODE_DEV = $null
$Env:ELECTRON_RUN_AS_NODE = $null
