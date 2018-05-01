

/** TrayTip
 *
 */
Class TrayTip
{
	static CLSID	:= "{75BEEFAD-E0FE-460A-A9FB-489E53D6C64E}"	

	_timeout	:= 3
	_sound	:= 16
	_icon	:= 0 ; 'noicon|warning|error|info'	
	
	/**
	 */
	__New()
	{
		this._setTrayTipShow()		
	}
	
	/**
	 */
	show( $title, $message )
	{
		
		this._TrayTipShow.test()

		this._TrayTipShow.show($title, $message, this._getOptions(), this._timeout)

		return this
	}

	/**
	 */
	hide()
	{
		
	}
	/*---------------------------------------
		PROPERTIES
	-----------------------------------------
	*/
	/** Set\Get sound
	 *
	 * @param	string	sound
	 * @return	self|_sound
	 */
	sound( $sound:=true )
	{
		this._sound	:= ! $sound
		
		return this
	} 
	/** Set timeout
	 *
	 * @param	int	seconds
	 * @return	self
	 */
	timeout( $seconds:=3 )
	{
		this._timeout	:= $seconds
		
		return this
	}
	/*---------------------------------------
		ICONS
	-----------------------------------------
	*/
	/** Set\Get icon
	 *
	 * @param	string	icon
	 * @return	self|_icon
	 */
	icon( $icon:="info" )
	{
		if( $icon )
			this._icon	:= $icon
		
		return $icon ? this : this._icon
	} 
	/** Set icon info
	  * @return	self
	 */
	info()
	{
		return % this.icon("info")
	}
	/** Set icon warning
	  * @return	self
	 */
	warning()
	{
		return % this.icon("warning")
	}
	/** Set icon error
	  * @return	self
	 */
	error()
	{
		return % this.icon("error")
	}
	/*---------------------------------------
		PRIVATE
	-----------------------------------------
	*/
	/**
	 */
	_getOptions()
	{
		$icons := 	{"info":	1
			,"warning":	2
			,"error":	3}
		
		$options := ( this._icon ? $icons[this._icon] : 0 ) + this._sound
		
		return $options
	} 

	/** Get focused control (file list) when Total commander window lost focus
	 *		
	 */  
	_setTrayTipShow()
	{
		if( ! this._TrayTipShow )
			try
			{
				this._TrayTipShow := ComObjActive(this.CLSID)
			}
			
		if( ! this._TrayTipShow )
			this._runTrayTipShow()
	}
	/** Get focused control (file list) when Total commander window lost focus
	  * 
	 */  
	_runTrayTipShow()
	{
		$CLSID := this.CLSID
		
		Run, %A_LineFile%\..\TrayTipShow.ahk %$CLSID%
		sleep, 10
		this._setTrayTipShow()
	}
}








