#Requires AutoHotkey v2.0 
#SingleInstance Force
InstallKeybdHook
SetKeyDelay 0

GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"
GroupAdd "Terminals", "ahk_exe pwsh.exe"
GroupAdd "Terminals", "ahk_exe powershell.exe"
GroupAdd "Browsers", "ahk_exe chrome.exe", unset, "ピクチャー イン ピクチャー"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Filers", "ahk_exe explorer.exe ahk_class CabinetWClass"
GroupAdd "Obsidian", "ahk_exe Obsidian.exe"
GroupAdd "Taskbar", "ahk_exe explorer.exe ahk_class Shell_TrayWnd"

; ================================================================================
; - Reset Modifiers
; ================================================================================

SendInput "{Control Up}"
SendInput "{Shift Up}"
SendInput "{Alt Up}"

; ================================================================================
; - Terminals
; ================================================================================

#HotIf WinActive("ahk_group Terminals")
#HotIf

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

#HotIf !WinActive("ahk_group Terminals")

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

!h:: {
	InvisibleBorder := 8
	Tweak := 1
	WinGetPos unset, unset, unset, &TaskbarHeight, "ahk_group Taskbar"

	WinRestore WinActive("A")
	WinMove -InvisibleBorder, -Tweak, A_ScreenWidth/2+InvisibleBorder*2, A_ScreenHeight-TaskbarHeight+InvisibleBorder+Tweak
}

!l:: {
	InvisibleBorder := 8
	Tweak := 1
	WinGetPos unset, unset, unset, &TaskbarHeight, "ahk_group Taskbar"

	WinRestore WinActive("A")
	WinMove A_ScreenWidth/2-InvisibleBorder, -Tweak, A_ScreenWidth/2+InvisibleBorder*2, A_ScreenHeight-TaskbarHeight+InvisibleBorder+Tweak
}

; ================================================================================
; - Window Switching
; ================================================================================

~F13 & `;::AltTab

!a:: {
	if (WinExist("ahk_group Terminals")) {
		WinActivate
	} else {
		try {
			Run "wt.exe"
		} catch {
			Run "powershell.exe"
		}
	}
}

!c:: {
	if (WinExist("ahk_group Browsers")) {
		WinActivate
	} else {
		try {
			Run "chrome.exe", unset, "Max"
		} catch {
			Run "msedge.exe", unset, "Max"
		}
	}
}

!f:: {
	if (WinExist("ahk_group Filers")) {
		WinActivate
	} else {
		Run EnvGet("USERPROFILE") . "\Downloads"
	}
}

!o:: {
	if (WinExist("ahk_group Obsidian")) {
		WinActivate
	} else {
		Run EnvGet("LOCALAPPDATA") . "\Programs\Obsidian\Obsidian.exe"
	}
}

; ================================================================================
; - WandA
; ================================================================================

*Alt:: {
	SendInput "{Alt Down}"

	global WandaHook := InputHook("V")
	WandaHook.KeyOpt("{All}", "E")
	WandaHook.KeyOpt("{LControl}{RControl}{LShift}{RShift}{LAlt}{RAlt}{LWin}{RWin}", "-E")
	WandaHook.Start()
	WandaHook.Wait()
}

*Alt Up:: {
	SendInput "{Alt Up}"

	global WandaHook
	if (IsSet(WandaHook)) {
		WandaHook.Stop()
		if (WandaHook.EndReason = "EndKey") {
			return
		}
	}

	SendEvent "{LWin}"
}

; ================================================================================
; - EandC
; ================================================================================

*Enter:: {
	SendInput "{Control Down}"

	global SandsHook := InputHook("V")
	SandsHook.KeyOpt("{All}", "E")
	SandsHook.KeyOpt("{LControl}{RControl}{LShift}{RShift}{LAlt}{RAlt}{LWin}{RWin}", "-E")
	SandsHook.Start()
	SandsHook.Wait()
}

*Enter Up:: {
	if (!GetKeyState("F13", "P")) {
		SendInput "{Control Up}"
	}

	global SandsHook
	if (IsSet(SandsHook)) {
		SandsHook.Stop()
		if (SandsHook.EndReason = "EndKey") {
			return
		}
	}

	SendEvent "{Blind}{Enter}"
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
