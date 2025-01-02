# ================================================================================
# - Prompt
# ================================================================================

function Prompt {
	return "$($PWD.Path.Replace($HOME, '~'))> "
}

# ================================================================================
# - PSReadLine
# ================================================================================

Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs
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

$chezmoi = chezmoi source-path
$ahk = "$HOME\.config\autohotkey\main.ahk"
$ahkd = "$HOME\.config\autohotkey"
