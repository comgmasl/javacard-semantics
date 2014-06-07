require "open-command-syntax.k"
require "../../../appletDeselection/applet-deselection.k"

module ORIGIN-RANDOM-CHANNEL
	imports OPEN-COMMAND-SYNTAX
	imports APPLET-DESELECTION


	/* ************************************************************************************************* */
	/*																		   							 */
	/*		7. Determine the applet instance to be selected on the new logical channel.					 */
	/*		■ If the origin logical channel is not the basic logical channel:							 */
	/*		■ If an applet instance is active on the origin logical channel, pick the applet			 */
	/*		instance as the candidate for selection on the new logical channel.			 				 */
	/*																									 */
	/* ************************************************************************************************* */


	/* ************************************************************************************************* */
	/*		     If there is no selected applet on the origin channel then the opening 					 */
	/*				     channel will have no selected applet as well									 */
	/* ************************************************************************************************* */
	rule <k> 'determineAppletForNewChannel [OriginalChannelNo:Int, LCNo] => . ...</k>
		<logicalChannel>
			...
				<channelNumber> OriginalChannelNo </channelNumber>
				<selectedApplet> -1 </selectedApplet>
			...
		</logicalChannel>
		when OriginalChannelNo =/=Int 0


	/* ************************************************************************************************* */
	/* If there is a selected applet on the origin channel then it will become the candidate applet      */
	/* for the new channel and we have to verify if the applet is multiselectable    					 */
	/* ************************************************************************************************* */
	rule <k> 'determineAppletForNewChannel [OriginalChannelNo:Int, LCNo:Int] =>																		 'verifyCandidateAppletFromOriginChannel [LCNo , LApplet] ...</k>
		<logicalChannel>
			...
				<channelNumber> OriginalChannelNo </channelNumber>
				<selectedApplet> LApplet:Int </selectedApplet>
			...
		</logicalChannel>
		when OriginalChannelNo =/=Int 0


	/* ************************************************************************************************* */
	/* 						Case 1. The candidate applet is MULTISELECTABLE 							 */
	/* ************************************************************************************************* */
	rule <k> 'verifyCandidateAppletFromOriginChannel[LC:Int, LApplet:Int] => . ...</k>
		<logicalChannel>
		 	...
		 	<selectedApplet> LPrevious:Int => LApplet </selectedApplet>
	        <state>  "open" </state>
	        <channelNumber> LC </channelNumber>
	        ...
	 	</logicalChannel>
	    <tableApplets>
	       	...
	       	LApplet |-> (aid (NameApplet:Exp, Rid:Int, Pix:Int, "active"))
	       	...
	    </tableApplets>
	    <classes> ...
			<class>
			 	...
			 	<className>
			 		NameApplet
			 	</className>
			 	<classRid>
			 		Rid
			 	</classRid>
			 	<classPix>
			 		Pix
			 	</classPix>
			 	<implements>
			 		...
			 			ListItem(MultiSelectable)
			 		...
			 	</implements>
			 	...
			</class>
		... </classes>


	/* ************************************************************************************************* */
	/* 				Case 2. The candidate applet is NOT MULTISELECTABLE (close the new channel)			 */
	/* ************************************************************************************************* */
	rule <k> 'verifyCandidateAppletFromOriginChannel[LC:Int, LApplet:Int] => . ...</k>
	    <tableApplets>
	       	...
	       	LApplet |-> (aid (NameApplet:Exp, Rid:Int, Pix:Int, "active"))
	       	...
	    </tableApplets>
	    <logicalChannels>
			... (
		 		<logicalChannel>
		 			...
		 				<channelNumber> LC </channelNumber>
		 			...
		 		</logicalChannel> => .
	 			)
	 		...
		</logicalChannels>
		<response>
			...
				<sw1> _ => "69" </sw1>
		 		<sw2> _ => "85" </sw2>
		 		<dataResponse> _ => "" </dataResponse>
		 	...
		</response> 
		<unusedLCNo>
		 	. => ListItem(LC) 
		 	...
		 </unusedLCNo>    


endmodule