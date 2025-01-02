#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
SetKeyDelay 0

SendInput "{Control Up}"
SendInput "{Shift Up}"
SendInput "{Alt Up}"

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
