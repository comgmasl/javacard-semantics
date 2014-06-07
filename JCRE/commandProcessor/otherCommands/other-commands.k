require "../../responses/response-handler.k"
require "../../../semantics/jcard-semantics.k"

module OTHER-COMMANDS
	imports RESPONSE-HANDLER
	imports JCARD-SEMANTICS

	syntax Stmts ::= "'generalCommand" "[" Int "]"

	/* ************************************************************************************************* */
	/*		If there is no active applet instance on the logical channel to be used for dispatching      */
	/*		the command, the Java Card RE shall respond to the APDU with status code 0x6999 			 */
	/*		(SW_APPLET_SELECT_FAILED). 																	 */
	/* ************************************************************************************************* */
	rule <k> 'generalCommand[LCNo:Int] => 'response ...</k>
		 <logicalChannel>
		 	...
		 		<channelNumber> LCNo </channelNumber>
		 		<selectedApplet> -1 </selectedApplet>
		 	...
		 </logicalChannel>
		 <response>
		 	...
		 		<sw1> _ => "69" </sw1>
		 		<sw2> _ => "99" </sw2>
		 	...
		 </response>


	/* ************************************************************************************************* */
	/*		When an APDU other than a Applet SELECT FILE or a MANAGE CHANNEL 							 */
	/*		command is received, and there is an active applet instance on the logical channel to 		 */
	/*		be used for dispatching the command, the Java Card RE sets the active applet instance 		 */
	/*		on the origin channel as the currently selected applet instance and invokes the 			 */
	/*		process method passing the APDU as a parameter.  											 */
	/* ************************************************************************************************* */
	rule <k> 'generalCommand[LCNo:Int] => lookupMember(<envStack> EStack </envStack>, String2Id("process"))(objectClosure(<crntClass>  appletInfo(Main, Rid1:Int, Pix1:Int) </crntClass> <envStack> EStack2 </envStack>).String2Id("data")) ~> 'response ...</k>
		 <logicalChannel>
		 	...
		 		<channelNumber> LCNo </channelNumber>
		 		<selectedApplet> LAC:Int </selectedApplet>
		 	...
		 </logicalChannel>
		 <tableApplets> LAC |-> aid(E:Exp, Rid:Int, Pix:Int, _:String) ... </tableApplets>
		 <store>
		 	...
		 		AIL |-> objectClosure(<crntClass> appletInfo(Class:Id, Rid, Pix) </crntClass> <envStack> EStack </envStack>)
		 		ML |-> objectClosure(<crntClass> appletInfo(Main, Rid1, Pix1) </crntClass> <envStack> EStack2 </envStack>)
		 	...
		 </store>

		
    rule <k> (nothing ( (void) ) => . ) ~> 'response ...</k>


endmodule