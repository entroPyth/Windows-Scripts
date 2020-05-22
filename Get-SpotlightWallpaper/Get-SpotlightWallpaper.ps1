# Get Spotlight Wallpapers with dimensions 1920X1080

# Get List of Spotlight files
$spotlightFolder = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
$spotlightFiles = (Get-ChildItem $spotlightFolder).Name
$wallpaperPath = "$env:USERPROFILE\Pictures\Wallpaper\"

# Create Wallpaper Folder in $env:USERPROFILE\Pictures if it doesn't exist
If (!(Test-Path -Path $wallpaperPath)) {
    New-Item -ItemType Directory -Force -Path $wallpaperPath
}

# Get image meta data and copy to $WallpaperPath if 1920X1080
Write-Host "Checking for 1920x1080 Images..."
ForEach ($file in $spotlightFiles) {
    add-type -AssemblyName System.Drawing
    $image = New-Object System.Drawing.Bitmap $spotlightFolder$file
    If ($image.Height -eq '1080' -AND $image.Width -eq '1920') {
        Write-Host "Found $file"
        Copy-Item $spotlightFolder$File $wallpaperPath
        Rename-Item -Path $wallpaperPath$file -NewName ($file + ".jpg")
    }
}

