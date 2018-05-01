#SingleInstance force
#NoTrayIcon

#Include %A_LineFile%\..\..\TrayTip.ahk


/** TrayTipTest
*/
TrayTipTest()
{
	$TrayTip 	:= new TrayTip()

	$TrayTip
		.timeout(3)
		.show("No icon", "Test Message")
		
	;$TrayTip
	
	.info()
	.timeout(1)
	.show("Info", "info Message")
	
	.error()
	.timeout(5)
	.sound()
	.show("ERROR", "ERROR Message")
	
	;MsgBox,262144,, TraTip finish,2 	
}

/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
TrayTipTest()

;exitApp
;sleep, 10000
