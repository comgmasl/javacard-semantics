require "open-command-syntax.k"
require "origin-basic-channel.k"
require "origin-random-channel.k"
require "../../../responses/response-handler.k"

module OPEN-COMMAND
	imports OPEN-COMMAND-SYNTAX
	imports ORIGIN-BASIC-CHANNEL
	imports ORIGIN-RANDOM-CHANNEL
	imports RESPONSE-HANDLER

	syntax Stmts ::= "'checkAfterAppletSelectMethod" "[" Int "]"

	/* ************************************************************************************************* */
	/* 			If P2 = 0 add the assign new number to the response    									 */
	/* ************************************************************************************************* */
	rule <k> 'openAssignedNewLogicalChannel [OriginalChannelNo:Int, LCNo:Int] => 																'determineAppletForNewChannel [OriginalChannelNo, LCNo] 
									~> 'checkAfterAppletSelectMethod [LCNo] ~> 'response ...</k>
		<logicalChannels> 
			... ( . => 
		 			<logicalChannel>
		 				<selectedApplet> -1 </selectedApplet>
                   		<state>  "open" </state>
                   		<channelNumber> LCNo </channelNumber>
		 			</logicalChannel>
		 		)...
		</logicalChannels>
		<response>
		 	...
		 		<sw1> "90" </sw1>
		 		<sw2> "00" </sw2>
		 		<dataResponse> _ => Int2String (LCNo) </dataResponse>
		 	...
		</response>


	/* ************************************************************************************************* */
	/* 			If P2 != 0 simply proceed to determine the candidate applet for the new channel 		 */
	/* ************************************************************************************************* */
	rule <k>'openGivenNewLogicalChannel [OriginalChannelNo:Int, LCNo:Int] => 																	'determineAppletForNewChannel [OriginalChannelNo, LCNo]
									~> 'checkAfterAppletSelectMethod [LCNo] ~> 'response ...</k>
		<logicalChannels> 
		 	... ( . => 
		 			<logicalChannel>
		 				<selectedApplet> -1 </selectedApplet>
                   		<state>  "open" </state>
                   		<channelNumber> LCNo </channelNumber>
		 			</logicalChannel>
		 		)...
		</logicalChannels>
		<unusedLCNo>
		 	...
		 	ListItem(LCNo:Int) => . 
		 	...
		 </unusedLCNo>


	//this rule is for selection on an applet from an open channel command
	rule <k> (true ~> 'checkAfterAppletSelectMethod [LCNo] => .) ~> 'response ...</k>

	/* ************************************************************************************************* */
	/*			If the applet instance's select method throws an exception or returns false,  			 */
	/* 			then the Java Card RE closes the new logical channel. The Java Card RE responds with     */
	/*			status code 0x6999 																		 */
	/* ************************************************************************************************* */
	rule <k> (false ~> 'checkAfterAppletSelectMethod [LCNo:Int] => . ) ~> 'response ...</k>
		 <logicalChannels> 
		 	... ( 
		 			<logicalChannel>
		 				...
                   		<channelNumber> LCNo </channelNumber>
                   		...
		 			</logicalChannel> => .
		 		)...
		</logicalChannels>
		 <response>
		 	...
		 		<sw1> _ => "69" </sw1>
		 		<sw2> _ => "99" </sw2>
		 	...
		 </response>
		 <unusedLCNo>
		 	. => ListItem(LCNo)
		 	...
		 </unusedLCNo>


	rule <k>('checkAfterAppletSelectMethod [LCNo:Int] => . ) ~> 'response ...</k>


endmodule