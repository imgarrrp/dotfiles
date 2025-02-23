# ================================================================================
# - PSReadLine
# ================================================================================

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord Ctrl+v -Function Paste
Set-PSReadLineKeyHandler -Chord Ctrl+i -Function Complete

# ================================================================================
# - PSStyle
# ================================================================================

if (Get-Variable -Name PSStyle -ErrorAction Ignore) {
	$PSStyle.FileInfo.Directory = $PSStyle.Reset
}

# ================================================================================
# - Variables, Aliases, Functions
# ================================================================================

$config = "$HOME\.config"
$nvim = "$HOME\.config\nvim\init.lua"
$ahk = "$HOME\.config\autohotkey\main.ahk"

function mycd {
	param(
		[String]$Path
	)

	if (!($Path)) {
		Set-Location -Path $HOME
		return
	}

	if (Test-Path -Path $Path -PathType Container) {
		Set-Location -Path $Path
		return
	}

	if (Test-Path -Path $Path -PathType Leaf) {
		$Parent = (Get-Item -Path $Path).DirectoryName

		if ($Parent -and (Test-Path -Path $Parent -PathType Container)) {
			Set-Location -Path $Parent
		}

		return
	}

	Set-Location -Path $Path
}
Remove-Item -Path Alias:cd
Set-Alias -Name cd -Value mycd
