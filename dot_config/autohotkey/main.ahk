#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
SetKeyDelay 0

SendInput "{Control Up}"
SendInput "{Shift Up}"
SendInput "{Alt Up}"

GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"
GroupAdd "Terminals", "ahk_exe pwsh.exe"
GroupAdd "Terminals", "ahk_exe powershell.exe"
GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe mullvadbrowser.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Filer", "ahk_exe explorer.exe ahk_class CabinetWClass"
GroupAdd "Obsidian", "ahk_exe Obsidian.exe"

; ================================================================================
; - Browsers
; ================================================================================

#HotIf WinActive("ahk_group Browsers")

^[::Browser_Back
^]::Browser_Forward
^+[::^+Tab
^+]::^Tab

#HotIf

; ================================================================================
; - Emacs-like Keybindings
; ================================================================================

#HotIf WinActive("ahk_group Terminals")

~F13 & b:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Left}"
	SendInput "{Control Down}"
}

~F13 & n:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Down}"
	SendInput "{Control Down}"
}

~F13 & p:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Up}"
	SendInput "{Control Down}"
}

~F13 & f:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Right}"
	SendInput "{Control Down}"
}

~F13 & a:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Home}"
	SendInput "{Control Down}"
}

~F13 & e:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{End}"
	SendInput "{Control Down}"
}

~F13 & m:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Enter}"
	SendInput "{Control Down}"
}

~F13 & i:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Tab}"
	SendInput "{Control Down}"
}

~F13 & h:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{BackSpace}"
	SendInput "{Control Down}"
}

~F13 & d:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Delete}"
	SendInput "{Control Down}"
}

~F13 & [:: {
	SendInput "{Control Up}"
	SendEvent "{Blind}{Escape}"
	SendInput "{Control Down}"
}

~F13 & k:: {
	SendInput "{Control Up}"
	SendInput "+{End}{Delete}"
	SendInput "{Control Down}"
}

~F13 & u:: {
	SendInput "{Control Up}"
	SendInput "+{Home}{BackSpace}"
	SendInput "{Control Down}"
}

~F13 & w:: {
	SendInput "{Control Up}"
	SendInput "^{BackSpace}"
	SendInput "{Control Down}"
}

#HotIf

; ================================================================================
; - Window Manipulation
; ================================================================================

^q::
!q::WinClose "A"

!m:: {
	MinMax := WinGetMinMax(WinActive("A"))

	if (MinMax = 1) {
		WinRestore
	} else {
		WinMaximize
	}
}

!z:: {
	WinSetAlwaysOnTop -1, "A"
}

; ================================================================================
; - Window Switching
; ================================================================================

~F13 & `;::AltTab

!a:: {
	if (!WinExist("ahk_group Terminals")) {
		try {
			Run "wt.exe"
		} catch {
			Run "powershell.exe"
		}
	}

	WinWait "ahk_group Terminals"
	WinActivate
}

!c:: {
	if (!WinExist("ahk_group Browsers")) {
		try {
			Run "chrome.exe", unset, "Max"
		} catch {
			Run "msedge.exe", unset, "Max"
		}
	}

	WinWait "ahk_group Browsers"
	WinActivate
}

!f:: {
	if (!WinExist("ahk_group Filer")) {
		Run EnvGet("USERPROFILE") . "\Downloads"
	}

	WinWait "ahk_group Filer"
	WinActivate
}

!o:: {
	if (!WinExist("ahk_group Obsidian")) {
		Run EnvGet("LOCALAPPDATA") . "\Programs\Obsidian\Obsidian.exe"
	}

	WinWait "ahk_group Obsidian"
	WinActivate
}

; ================================================================================
; - SandS
; ================================================================================

*Space:: {
	SendInput "{Shift Down}"

	global SandsHook := InputHook("V")
	SandsHook.KeyOpt("{All}", "E")
	SandsHook.KeyOpt("{LControl}{RControl}{LShift}{RShift}{LAlt}{RAlt}{LWin}{RWin}", "-E")
	SandsHook.Start()
	SandsHook.Wait()
}

*Space Up:: {
	SendInput "{Shift Up}"

	global SandsHook
	if (IsSet(SandsHook)) {
		SandsHook.Stop()
		if (SandsHook.EndReason = "EndKey") {
			return
		}
	}

	SendEvent "{Blind}{Space}"
}

; ================================================================================
; - CtoC
; ================================================================================

*F13::SendInput "{Control Down}"
*F13 Up::SendInput "{Control Up}"

; ================================================================================
; - Reload
; ================================================================================

~F13 & 0::Reload
