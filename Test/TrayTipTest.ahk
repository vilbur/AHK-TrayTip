#SingleInstance force
#NoTrayIcon

#Include %A_LineFile%\..\..\TrayTip.ahk


/** TrayTipTest
*/
TrayTipTest()
{
	new TrayTip().show("1) Message defaults")
	
	new TrayTip("Custom Title")
			.show("2) Message with default title & timeout", 2)
	
			.show( "Message Title", "3) Message with title & timeout", 2)
			
			.info().show("Info", "4) Info Message")
		
			.timeout(3).title("New Default Title").show("5) Changed title & timeout")
	
			.sound().error().show("6) Error with sound")
			
			.sound(false).warning().show("Warning", "7) Sound off for next messages")
		

}

/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
TrayTipTest()

;exitApp
;sleep, 10000
