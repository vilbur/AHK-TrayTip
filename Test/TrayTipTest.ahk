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
			
			.info("Info", "4) Info Message")
		
			.timeout(3).title("New Default Title").info("5) Changed title & timeout")
	
			.sound().error("6) Error with sound")
					.show("Next Error", "7) Icon is not changed in show() method")
			
			.sound(false).warning("Warning", "8) Sound is off for next messages")
		
}

/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
TrayTipTest()


exitApp
