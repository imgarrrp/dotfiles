# ================================================================================
# - Prompt
# ================================================================================

function Prompt {
    return "$($PWD.Path.Replace($HOME, '~'))> "
}

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
# Variables, Aliases, Functions
# ================================================================================

$chezmoi = (chezmoi source-path)