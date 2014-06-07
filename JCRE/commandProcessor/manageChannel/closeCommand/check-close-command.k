require "close-command.k"

module CHECK-CLOSE-COMMAND
	imports CLOSE-COMMAND

	syntax Stmts ::= "'checkCloseLogicalChannel" "[" Int "," Int "]"

	/* ********************************************************************************************** */	
	/* 4. If the specified logical channel to close is the basic logical channel (logical channel 0)  */
  	/*	or the specified logical channel number is greater than 19, the Java Card RE  				  */
 	/*	responds with status code 0x6A81 (SW_FUNC_NOT_SUPPORTED).	                                  */
	/* ********************************************************************************************** */
	rule <k> 'checkCloseLogicalChannel [Origin:Int, ToClose:Int] => 'response ...</k>
		<logicalChannel>
		 	...
		 	<channelNumber> Origin </channelNumber>
		 	...
		</logicalChannel>
		<response>
		 	...
		 	<sw1> _ => "6A" </sw1>
		 	<sw2> _ => "81" </sw2>
		 	...
		</response>
		 when ToClose ==Int 0 orBool ToClose >Int 19


	/* ****************************************************************************************** */
	/* 5. If the specified logical channel to close is currently open on the I/O interface that	  */
	/*	  received the MANAGE CHANNEL CLOSE command, deselect the active applet 				  */
	/*	  instance (if any) on the specified logical channel as described above in Section 4.7,   */
	/*	  "Applet Deselection". The specified logical channel is now closed. The Java Card 		  */
	/*	  RE responds with status code 0x9000. 													  */
	/* ****************************************************************************************** */
	rule <k> 'checkCloseLogicalChannel [Origin:Int, ToClose:Int] => 'closeChannel [ToClose] ...</k>
		<logicalChannel>
		 	...
		 	<channelNumber> Origin </channelNumber>
		 	...
		</logicalChannel>
		<logicalChannel>
		 	...
		 	<channelNumber> ToClose </channelNumber>
		 	...
		</logicalChannel>
		 when ToClose >Int 0 andBool ToClose <Int 20


	/* ***************************************************************************************** */	
	/*  6. Otherwise, if the specified logical channel is closed or not available on that I/O    */
  	/*	interface, the Java Card RE responds with warning status code 0x6200 (SW_                */
 	/*	WARNING_STATE_UNCHANGED).               												 */
	/* ***************************************************************************************** */
	rule <k> 'checkCloseLogicalChannel [Origin:Int, ToClose:Int] => 'response ...</k>
		<logicalChannel>
		 	...
		 	<channelNumber> Origin </channelNumber>
		 	...
		</logicalChannel>
		<response>
		 	...
		 	<sw1> _ => "62" </sw1>
		 	<sw2> _ => "00" </sw2>
		 	...
		</response>
		 when ToClose >Int 0 andBool ToClose <Int 20



	/* ***************************************************************************************** */	
	/*	2. If the origin logical channel on the I/O interface that received the MANAGE
  	/*	CHANNEL CLOSE command is not open, the Java Card RE responds with status				 */
 	/*	code 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED). 										 */
	/* ***************************************************************************************** */
	/* this works because the above rule handles the case when the origin logical channel is opened*/
	rule <k> 'checkCloseLogicalChannel [Origin:Int, ToClose:Int] => 'response ...</k>
		<response>
		 	...
		 	<sw1> _ => "68" </sw1>
		 	<sw2> _ => "81" </sw2>
		 	...
		</response>

endmodule