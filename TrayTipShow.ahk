#SingleInstance force
;#NoTrayIcon
#Persistent

/** TrayTip
 *
 */
Class TrayTipShow
{
	/**
	 */
	__New()
	{
	}
	
	/**
	 */
	show($title, $message, $options, $timeout)
	{
		this._iconShow()

		TrayTip, %$title%, %$message%,, %$options%
		
		this._hideTrayTip($timeout)
		
	}
	
	/**
	 */
	_hideTrayTip($timeout)
	{
		
		;if( ! $timeout ) 
			;return
		
		$timeout_ms	:= $timeout < 500 ? $timeout * 1000 : $timeout
		
		sleep, %$timeout_ms%

		TrayTip  ; Attempt to hide it the normal way.
		this._iconHide()

		;Menu Tray, NoIcon
		;if SubStr(A_OSVersion,1,3) = "10."
		;{
		;	Menu Tray, NoIcon
		;	Sleep 200  ; It may be necessary to adjust this sleep.
		;	Menu Tray, Icon
		;}
	}
	/**
	 */
	_iconShow()
	{
		Menu Tray, Icon

		Menu Tray, Icon, %systemroot%\system32\shell32.dll, 222
	} 
	/**
	 */
	_iconHide()
	{
		Menu Tray, NoIcon
	} 
}

/*---------------------------------------
	Register object
-----------------------------------------
*/
TrayTipShowRegister(Object, CLSID, Flags:=0)
{
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}

/*---------------------------------------
	Run TrayTipShow script
-----------------------------------------
*/
$CLSID	= %1%

TrayTipShowRegister(TrayTipShow, $CLSID)


/*---------------------------------------
	This "revokes" the object, preventing any new clients from connecting
	to it, but doesn't disconnect any clients that are already connected.
	In practice, it's quite unnecessary to do this on exit. 
-----------------------------------------
*/
OnExit Revoke
return
 
Revoke:

TrayTipShowRegister(TrayTipShow, "")
ExitApp

