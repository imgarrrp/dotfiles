; @author zero-plusplus (https://github.com/zero-plusplus)
; @link https://gist.github.com/zero-plusplus/ad54d19d3e0d34587396c4667fa10079
; @author imgarrrp (https://github.com/imgarrrp)
; @licence MIT

class Ime {
	static GetStatus() {
		static IMC_GETOPENSTATUS := 0x005

		return !!(this.__SendMessage(IMC_GETOPENSTATUS))
	}

	static SetStatus(Status) {
		static IMC_SETOPENSTATUS := 0x006

		ErrorCode := this.__SendMessage(IMC_SETOPENSTATUS, Status)
		if (ErrorCode > 0) {
			throw Error("Failed to set status. ErrorCode: " . ErrorCode)
		}
	}

	static GetConversionMode() {
		static IMC_GETCONVERSIONMODE := 0x001

		return this.__SendMessage(IMC_GETCONVERSIONMODE)
	}

	static SetConversionMode(ConversionMode) {
		static IMC_SETCONVERSIONMODE := 0x002

		ErrorCode := this.__SendMessage(IMC_SETCONVERSIONMODE, ConversionMode)
		if (ErrorCode > 0) {
			throw Error("Failed to set conversion mode. ErrorCode: " . ErrorCode)
		}
	}

	static GetSentenceMode() {
		static IMC_GETSENTENCEMODE := 0x003

		return this.__SendMessage(IMC_GETSENTENCEMODE)
	}

	static SetSentenceMode(SentenceMode) {
		static IMC_SETSENTENCEMODE := 0x004

		ErrorCode := this.__SendMessage(IMC_SETSENTENCEMODE, SentenceMode)
		if (ErrorCode > 0) {
			throw Error("Failed to set sentence mode. ErrorCode: " . ErrorCode)
		}
	}

	static ToggleMonitor() {
		static Toggle := false

		if (!Toggle) {
			SetTimer Monitor, 100
			Toggle := true
		} else {
			SetTimer Monitor, 0
			ToolTip ""
			Toggle := false
		}

		Monitor() {
			if (!Toggle) {
				SetTimer unset, 0
				ToolTip ""
				return
			}

			Status := this.GetStatus()
			ConversionMode := this.GetConversionMode()
			SentenceMode := this.GetSentenceMode()

			ToolTip Format("Status: {1}`r`nConversionMode: {2}`r`nSentenceMode: {3}", Status, ConversionMode, SentenceMode)
		}
	}

	static __SendMessage(WParam, LParam := 0) {
		static WM_IME_CONTROL := 0x0283

		return DllCall(
			"SendMessage",
			"UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", WinActive("A")),
			"UInt", Msg := WM_IME_CONTROL,
			"Int", WParam,
			"Int", LParam
		)
	}
}
