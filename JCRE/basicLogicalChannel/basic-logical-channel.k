require "../../syntax/jcard-syntax.k"

module BASIC-LOGICAL-CHANNEL
	imports JCARD-SYNTAX


	syntax Stmts ::= "'openBasicLogicalChannel"

	/* ************************************************************************************************* */
	/* 			When the program is initialized, the basic logical channel is opened and the  			 */
	/*			default applet for that channel is selected      			            				 */
	/* ************************************************************************************************* */
	rule <k> 'openBasicLogicalChannel => . ...</k>
		<logicalChannels> ... ( . => 
		 							<logicalChannel>
		 								<selectedApplet> L </selectedApplet>
		 								<state> "open" </state>
		 								<channelNumber> 0 </channelNumber>		 								
		 							</logicalChannel>
		 						)
		 					...			
		</logicalChannels> 
		<defaultApplets>
		 	0 |-> aid (AN:Exp, Rid:Int, Pix:Int, S:String)
		 	...
		</defaultApplets>
		<tableApplets>
		 	...
		 	L:Int |-> aid (AN, Rid, Pix, _ => "active")
		 	...
		</tableApplets>


    /* ************************************************************************************************* */
	/* 			If the basic logical channel has no default applet associated simply open the  			 */
	/*			basic logical channel 												     				 */
	/* ************************************************************************************************* */
	rule <k> 'openBasicLogicalChannel => . ...</k>
		<logicalChannels> ... ( . => 
		 							<logicalChannel>
		 								<selectedApplet> -1 </selectedApplet>
		 								<state> "open" </state>
		 								<channelNumber> 0 </channelNumber>		 								
		 							</logicalChannel>
		 						)
		 					...			
		</logicalChannels> 
	

endmodule