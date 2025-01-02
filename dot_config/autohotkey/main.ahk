#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
SetKeyDelay 0

SendInput "{Control Up}"
SendInput "{Shift Up}"
SendInput "{Alt Up}"

; ================================================================================
; - Reload
; ================================================================================

~F13 & 0::Reload
