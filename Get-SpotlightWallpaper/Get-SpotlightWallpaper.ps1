# 05-22-2020 entropyth
# Get Spotlight Wallpapers with dimensions 1920X1080
# Copy to $env:USERPROFILE\Pictures\Wallpaper\Spotlight\ and add ".jpg" file extension.

# Get List of Spotlight files
$spotlightFolder = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
$spotlightFiles = (Get-ChildItem $spotlightFolder).Name
$wallpaperPath = "$env:USERPROFILE\Pictures\Wallpaper\Spotlight\"

# Create Wallpaper Folder in $env:USERPROFILE\Pictures\Spotlight\ if it doesn't exist
If (!(Test-Path -Path $wallpaperPath)) {
    New-Item -ItemType Directory -Force -Path $wallpaperPath > $null
}

# Get image meta data and copy to $WallpaperPath if 1920X1080
Write-Host "Checking for 1920x1080 Images..."
ForEach ($file in $spotlightFiles) {
    add-type -AssemblyName System.Drawing
    $image = New-Object System.Drawing.Bitmap $spotlightFolder$file
    If ($image.Height -eq '1080' -AND $image.Width -eq '1920') {
        Write-Host "Found 1920X1080 file: $file"
        If (!(Test-Path -Path "$wallpaperPath$file.jpg")) {
            Write-Host "Copying $file to $wallpaperPath"
            Copy-Item $spotlightFolder$File "$wallpaperPath$file.jpg"
        } 
        elseif (Test-Path -Path "$wallpaperPath$file.jpg") {
                Write-Host "$file already exists, skipping"
        }
    }
}

# To do:
## Set Desktop Background to Slideshow with path to $wallpaperPath
