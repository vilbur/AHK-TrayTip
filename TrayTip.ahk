

/** TrayTip
 *
 */
Class TrayTip
{
	static CLSID	:= "{75BEEFAD-E0FE-460A-A9FB-489E53D6C64E}"	

	_title	:= ""
	_timeout	:= 7
	_sound	:= 16
	_icon	:= 0 ; 'noicon|warning|error|info'	
	
	/**
	 */
	__New($title:="")
	{
		this._setTrayTipShow()
		this._setDefaultTitle($title)
	}
	
	/**
	 */
	show( $params* )
	{
		this._TrayTipShow.show( this._getParams( $params )* )
		
		return this
	}
	/** Set icon info
	  * @return	self
	 */
	info( $params* )
	{
		this.icon("info")
		return % this.show( $params* )
	}
	/** Set icon warning
	  * @return	self
	 */
	warning( $params* )
	{
		this.icon("warning")
		return % this.show( $params* )
	}
	/** Set icon error
	  * @return	self
	 */
	error( $params* )
	{
		this.icon("error")
		return % this.show( $params* )
	}

	
	/*---------------------------------------
		ANALYZE & GET PARAMETERS
	-----------------------------------------
	*/
	/**
	 */
	_getParams( $params )
	{
		
		;$title	:= this._getTitleDefaultOrParameter( $params )
		;$message	:= this._getMessageParam( $params )
		
		$params := [ this._getTitleDefaultOrParameter( $params )
					,this._getMessageParam( $params )
					,this._getOptions()
					,this._getTimeoutParam( $params )]

		return $params
	

	}
	/** Use default title if only message is defined
	 */
	_getTitleDefaultOrParameter( $params )
	{
		return $params.2 && this._isNotNumber($params.2) ? $params.1 : this._title
	}
	/** Message can be 1st or 2nd param
	 */
	_getMessageParam( $params )
	{
		;Dump($params, "params", 1)
		;return "message"
		return $params.2 && this._isNotNumber($params.2) ? $params.2 : $params[1]
	}
	/** Timeout can be 2nd or 3rd param, or use  this._timeout
	 */
	_getTimeoutParam( $params )
	{
		return $params.3 && this._isNumber($params.3) ? $params.3 : ( $params.2 && this._isNumber($params.2) ? $params.2 :  this._timeout  )
	}
	/**
	 */
	_isNumber( $variable )
	{
		return % ! [$variable].GetCapacity(1)
	} 
	/**
	 */
	_isNotNumber( $variable )
	{
		return % [$variable].GetCapacity(1)>0
	} 
	
	/*---------------------------------------
		PROPERTIES
	-----------------------------------------
	*/
	/** Set title
	 *
	 * @param	string	title
	 * @return	self
	 */
	title( $title )
	{
		this._title	:= $title
		
		return this
	} 
	/** Set\Get sound
	 *
	 * @param	string	sound
	 * @return	self|_sound
	 */
	sound( $sound:=true )
	{
		this._sound	:= $sound ? 0 : 16
		
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

	/*---------------------------------------
		PRIVATE
	-----------------------------------------
	*/
	/**
	 */
	_setDefaultTitle( $title )
	{
		if( ! $title )
			$title := RegExReplace( A_ScriptName, "i).(ahk|exe)$", "" ) 
			
		this._title := $title
	}
	
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








