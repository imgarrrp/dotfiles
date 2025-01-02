$PROFILE = "$HOME\.config\powershell\profile.ps1"
$PROFILE = $PROFILE | Add-Member -MemberType NoteProperty -Name Original -Value $PSCommandPath -PassThru

if (Test-Path -Path $PROFILE) {
	. $PROFILE
} else {
	Write-Warning -Message "Cannot load profile '$PROFILE' because it does not exist."
}
