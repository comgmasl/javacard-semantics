require "open-command-syntax.k"
require "assign-logical-channel-number.k"
require "open-command.k"

module CHECK-OPEN-COMMAND
	imports OPEN-COMMAND-SYNTAX
	imports ASSIGN-LOGICAL-CHANNEL-NUMBER
	imports OPEN-COMMAND

	
	/* ************************************************************************************************* */
	/* 			1.P2=0 when the Java Card RE shall assign a new logical channel number. 				 */
	/* ************************************************************************************************* */
	rule <k> 'checkOpenLogicalChannel [ OriginChannelNo:Int , 0 ] => 
												'assignNewLogicalChannelNumber [ OriginChannelNo ]... </k>
		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> OriginChannelNo </channelNumber>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>
		<apduCommand>
        ...
          <INS> "0x70" </INS>
          <P1> "0" </P1>
          <P2> "0" </P2>
          <Le> Le:String </Le>
        ...
      	</apduCommand>
       	when Le ==String "1"


    /* ******************************************************************************************* */
  	/*         4. If the P2=0 variant is used:                                                     */
  	/*          ■ If the expected length value (Le) is not equal to 1, the Java Card RE responds   */
  	/*          with status code 0x6C01 (SW_CORRECT_LENGTH_00+0x01).                               */
  	/* ******************************************************************************************* */
  	rule <k> 'checkOpenLogicalChannel [ OriginChannelNo:Int , 0 ] => 'response ...</k>
  		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> OriginChannelNo </channelNumber>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>
		<apduCommand>
        ...
          <INS> "0x70" </INS>
          <P1> "0" </P1>
          <P2> "0" </P2>
          <Le> Le:String </Le>
        ...
      	</apduCommand>
      	<response>
        	...
          	<sw1> _ => "6C" </sw1>
         	<sw2> _ => "01" </sw2>
        	...
      	</response>
       	when Le =/=String "1"


	/* ************************************************************************************************* */
	/*																		   							 */
	/* 			5 .If the P2 != 0 variant is used:							   							 */
	/*	If the specified logical channel number is not supported or resources for the 					 */
	/*	specified logical channel are not available or the logical channel is already open,				 */
	/*	the Java Card RE responds with status code 0x6A86 (SW_INCORRECT_P1P2).							 */
	/*																	       							 */
	/* ************************************************************************************************* */


	/* ************************************************************************************************* */
	/* 			If the given number for the logical channel is not between 1-19 report error			 */
	/* ************************************************************************************************* */
    rule <k> 'checkOpenLogicalChannel [ OriginChannelNo:Int , ToOpen:Int ] => 'response... </k>
		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> OriginChannelNo </channelNumber>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>
		<response>
		 	...
		 		<sw1> _ => "6A" </sw1>
		 		<sw2> _ => "86" </sw2>
		 	...
		</response>
		when ToOpen <Int 1 orBool ToOpen >Int 19


	/* ************************************************************************************************* */
	/* 			If the logical channel requested for opening is already opened							 */
	/* ************************************************************************************************* */
	rule <k> 'checkOpenLogicalChannel [ OriginChannelNo:Int , ToOpen:Int ] => 'response... </k>
		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> ToOpen </channelNumber>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>
		<response>
		 	...
		 		<sw1> _ => "6A" </sw1>
		 		<sw2> _ => "86" </sw2>
		 	...
		</response>
		when ToOpen >Int 0 andBool ToOpen <Int 20


	/* ************************************************************************************************* */
	/* 			If all the checks are passed proceed with opening the logical channel					 */
	/* ************************************************************************************************* */
	rule <k> 'checkOpenLogicalChannel [ OriginChannelNo:Int , ToOpen:Int ] => 																					'openGivenNewLogicalChannel[OriginChannelNo, ToOpen]... </k>
		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> OriginChannelNo </channelNumber>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>
		when ToOpen >Int 0 andBool ToOpen <Int 20


	/* ************************************************************************************************* */
	/*						2. If the origin logical channel on that I/O interface is not open,   		 */
	/*	  					 the Java Card RE responds with status code 0x6881 							 */
	/*	   					 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)									         */
	/* ************************************************************************************************* */
	// this works because there is a rule first that applies when the origin channel is opened
	rule <k> 'checkOpenLogicalChannel [ OriginChannelNo:Int , ToOpen:Int ] => 'response ...</k>
		<response>
		 	...
		 	<sw1> _ => "68" </sw1>
		 	<sw2> _ => "81" </sw2>
		 	...
		</response>
	


endmodule