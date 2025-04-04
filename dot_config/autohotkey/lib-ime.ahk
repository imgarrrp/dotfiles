/**
 * @author zero-plusplus (https://github.com/zero-plusplus)
 * @licence MIT
 * @link https://gist.github.com/zero-plusplus/ad54d19d3e0d34587396c4667fa10079
 */
/**
 * This class provides static methods for getting/setting the state of the [Input Method Editor (IME)](https://en.wikipedia.org/wiki/Input_method).
 */
class Ime {
  /**
   * Get/Set IME status. Enable if `true` IME status, disable if `false`.
   * @type {boolean}
   */
  static status {
    get {
      return this.get()
    }
    set {
      return this.set(value)
    }
  }
  /**
   * Get a boolean value indicating whether the IME is enabled or disabled.
   * @return {boolean}
   */
  static getStatus() {
    static IMC_GETOPENSTATUS := 0x0005

    return !!(this._sendMessage(IMC_GETOPENSTATUS))
  }
  /**
   * Set the IME status.
   * @param {boolean} status - Enable if `true`, disable if `false`.
   * @throws Error - Throw an exception if the state setting fails.
   */
  static setStatus(status) {
    static IMC_SETOPENSTATUS := 0x006

    errorCode := this._sendMessage(IMC_SETOPENSTATUS, status)
    if (0 < errorCode) {
      throw Error("Failed to set status. code: " errorCode)
    }
  }
  /**
   * Common process for sending SendMessage.
   * @private
   * @param {number} wParam
   * @param {number} [lParam := 0]
   */
  static _sendMessage(wParam, lParam := 0) {
    static WM_IME_CONTROL := 0x0283

    return DllCall(
      "SendMessage",
      "UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", WinActive("A")),
      "UInt", msg := WM_IME_CONTROL,
      "Int", wParam,
      "Int", lParam
    )
  }
}