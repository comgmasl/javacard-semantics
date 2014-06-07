require "../../../responses/response-handler.k"
require "../../../appletDeselection/applet-deselection.k"

module CLOSE-COMMAND
	imports RESPONSE-HANDLER
	imports APPLET-DESELECTION
	imports JCARD-SEMANTICS

	syntax Stmts ::= "'closeChannel" "[" Int "]"
	syntax Stmts ::= "'closeChannelAfterDeselect" "[" Int "]"

	/* ********************************************************************************************** */	
	/*				 		There is no active applet on the given logical channel 					  */
	/* ********************************************************************************************** */
	rule <k> 'closeChannel [ToClose:Int] => 'response ...</k>
    	<logicalChannels> 
    	   ... ( <logicalChannel>
    	   			...
    	   				<channelNumber> ToClose </channelNumber>
    	   				<selectedApplet> -1 </selectedApplet>
    	   			...
    	   		 </logicalChannel> => .
    	   )
    	   ...
    	</logicalChannels>
        <unusedLCNo>
            . => ListItem(ToClose) ...
        </unusedLCNo>


    /* ********************************************************************************************** */	
	/*				 		There is an active applet on the given logical channel 					  */
	/* ********************************************************************************************** */
    rule <k> 'closeChannel [ToClose:Int] => 'deselectAppletOnLogicalChannel [ToClose] ~>							 'closeChannelAfterDeselect [ToClose:Int] ...</k>
    	<logicalChannel>
    	   	...
    	   		<channelNumber> ToClose </channelNumber>
    	   		<selectedApplet> LActiveApplet:Int </selectedApplet>
    	   	...
    	</logicalChannel> 
    	 when LActiveApplet =/=Int -1


    rule <k> (nothing(void) => .) ~> 'closeChannelAfterDeselect [ToClose:Int] ... </k>


    /* ********************************************************************************************** */ 
	/*				 	Once the applet finished the deselect method close channel 					  */
	/* ********************************************************************************************** */
    rule <k> 'closeChannelAfterDeselect [ToClose:Int] => 'response ...</k>
    	<logicalChannels> 
    	   ... ( <logicalChannel>
    	   			...
    	   				<channelNumber> ToClose </channelNumber>
    	   			...
    	   		 </logicalChannel> => .
    	   )
    	   ...
    	</logicalChannels>
        <unusedLCNo>
            . => ListItem(ToClose) ...
        </unusedLCNo>


endmodule