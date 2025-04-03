$GlobalProfile = "$HOME\.config\powershell\profile.ps1"

if (Test-Path -Path $GlobalProfile) {
    . $GlobalProfile
} else {
    Write-Warning -Message "Cannot load global profile '$GlobalProfile' because it does not exist."
}