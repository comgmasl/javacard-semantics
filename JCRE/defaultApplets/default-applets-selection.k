require "../../syntax/jcard-syntax.k"
require "../../semantics/jcard-semantics.k"

module DEFAULT-APPLETS-SELECTION
	imports JCARD-SYNTAX
	imports JCARD-SEMANTICS

/* This module is only used when a MANAGE CHANNEL OPEN with the origin channel the basic 
on is received */
	
	syntax Stmts ::= "'DefaultAppletForLogicalChannel" "[" Int "]"


	/* ************************************************************************************************* */
	/* 		When a new channel is opened with the manage channel open command, the default applets   	 */
	/*		table is searched to find a default applet. If applet inactive => select that applet on 	 */
	/*		the new channel without any other verification.										 		 */
	/* ************************************************************************************************* */
	rule <k> 'DefaultAppletForLogicalChannel [LCNo:Int] => lookupMember(<envStack> EStack </envStack>, String2Id("select"))(.Exps)  ...</k>
		<tableApplets> L:Int |-> aid(E, Rid, Pix, ("inactive" => "active")) ... </tableApplets>
		<defaultApplets> 
		 	...
		 		LCNo |-> aid(E:Id,Rid:Int,Pix:Int, _:String)
		 	...
		</defaultApplets>
		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> LCNo </channelNumber>
		 				<selectedApplet> _ => L </selectedApplet>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>
		<store>
		 	...
		 		AIL |-> objectClosure(<crntClass> appletInfo(E,Rid,Pix) </crntClass> <envStack> EStack </envStack>)
		 	...
		</store>


	/* ************************************************************************************************* */
	/* 		When a new channel is opened and it has a default applet that is ACTIVE,  					 */
	/*		but MULTISELECTABLE, applet becomes active on that channel as well	 						 */
	/* ************************************************************************************************* */
	rule <k> 'DefaultAppletForLogicalChannel [LCNo:Int] => . ...</k>
		<defaultApplets> 
		 	...
		 		LCNo |-> aid(AppletName:Id,Rid:Int,Pix:Int, _:String)
		 	...
		</defaultApplets>
		<tableApplets> L:Int |-> aid(NameApplet:Id, Rid, Pix, "active") ... </tableApplets>
		<logicalChannels>
		 	...
		 		<logicalChannel>
		 			...
		 				<channelNumber> LCNo </channelNumber>
		 				<selectedApplet> _ => L </selectedApplet>
		 			...
		 		</logicalChannel>
		 	...
		</logicalChannels>	
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
	/* 		When a new channel is opened and it has a default applet that is ACTIVE, but  				 */
	/*	NOT MULTISELECTABLE close the channel and return response 0x6985 (SW_CONDITIONS_NOT_SATISFIED).  */
	/* ************************************************************************************************* */
	rule <k> 'DefaultAppletForLogicalChannel [LCNo:Int] => . ...</k>
		<tableApplets> L:Int |-> aid(E, Rid, Pix, "active" ) ... </tableApplets>
		<defaultApplets> 
		 	...
		 		LCNo |-> aid(E:Exp,Rid:Int,Pix:Int, _:String)
		 	...
		</defaultApplets>
		<logicalChannels>
		 	... (
			 		<logicalChannel>
			 			...
			 				<channelNumber> LCNo </channelNumber>
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
		 	. => ListItem(LCNo) 
		 	...
		 </unusedLCNo>  


    /* ************************************************************************************************* */
	/* 							When no default applet is given for logical channel  					 */
	/* ************************************************************************************************* */
	rule <k> 'DefaultAppletForLogicalChannel [LCNo:Int] => . ...</k>
		<defaultApplets> 
		  	DefaultAppletsMap:Map
		</defaultApplets>
		 when notBool(LCNo in keys(DefaultAppletsMap))



endmodule