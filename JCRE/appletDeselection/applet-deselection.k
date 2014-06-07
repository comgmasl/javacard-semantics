require "../../syntax/jcard-syntax.k"
require "../../semantics/jcard-semantics.k"

module APPLET-DESELECTION
	imports JCARD-SYNTAX
	imports JCARD-SEMANTICS
	
	syntax Stmts ::= "'deselectAppletOnLogicalChannel" "[" Int  "]"
	syntax Stmts ::= "'searchOnOtherLogicalChannel" "[" Int "," Int "]"


  /* ************************************************************************************************* */
  /*        If the applet instance to be deselected is active on more than one logical channel, 	   */
  /*		or ?another applet instance from the same package is also active?, the Java Card RE   	   */
  /*		sets the currently selected applet instance to be the applet instance being 			   */
  /*		deselected, and calls its MultiSelectable.deselect(appInstStillActive) method, where the   */
  /*		appInstStillActive parameter is set to true if the same applet instance is   			   */
  /*		still active on another logical channel. 										   		   */
  /* ************************************************************************************************* */
	rule <k> 'deselectAppletOnLogicalChannel [NoLC:Int] => 'searchOnOtherLogicalChannel [NoLC,LApplet] ...</k>
		<tableApplets>
		 	...
		 	LApplet |-> (aid (NameApplet:Id, Rid:Int, Pix:Int, _:String) )
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
			 	<extends>
			 		Applet
			 	</extends>
			 	<implements>
			 		...
			 			ListItem(MultiSelectable)
			 		...
			 	</implements>
			 	...
			</class>
		... </classes>
		<logicalChannel>
			...
			<selectedApplet> LApplet:Int </selectedApplet>
			<channelNumber> NoLC </channelNumber>
			...
		</logicalChannel>
	

	/* ************************************************************************************************* */	
    /* 	 if the applet is active on another channel MultiSelectable.deselect which simply returns true   */
    /* ************************************************************************************************* */
	rule <k> 'searchOnOtherLogicalChannel [NoLC:Int, LApplet:Int] => . ...</k>
		<logicalChannel>
		 	...
		 	<selectedApplet> LApplet </selectedApplet>
		 	<channelNumber> AnotherLC </channelNumber>
		 	...
		</logicalChannel>
		 when AnotherLC =/=Int NoLC


	/* ************************************************************************************************* */	
    /* 						if it is not active on another channel Applet.deselect  					 */
    /* ************************************************************************************************* */
	rule <k> 'searchOnOtherLogicalChannel [NoLC:Int, LApplet:Int] => lookupMember(<envStack> EStack </envStack>, String2Id("deselect"))(.Exps)  ...</k>
		<logicalChannel>
		 	...
		 	<selectedApplet> LApplet </selectedApplet>
		 	<channelNumber> AnotherLC </channelNumber>
		 	...
		</logicalChannel>
		<tableApplets>
		 	...
		 	LApplet |-> (aid (NameApplet:Id, Rid:Int, Pix:Int, _:String)  => aid(NameApplet, Rid, Pix, "inactive"))
		 	...
		</tableApplets>
		<store>
		 	...
		 		AIL |-> objectClosure(<crntClass> appletInfo(NameApplet, Rid, Pix) </crntClass> <envStack> EStack </envStack>)
		 	...
		</store>
		

	/* ************************************************************************************************* */
	/*		Otherwise, the Java Card RE sets the currently selected applet instance to be the  			 */
	/*		applet instance being deselected, and calls its Applet.deselect method. Upon 				 */
	/*		return or uncaught exception, the Java Card RE clears the fields of all CLEAR_ON_ 			 */
	/*		DESELECT transient objects in the context of deselected applet instance. 					 */
	/*		Note that the deselection is always successful even if the 									 */
	/*		applet instance throws an exception from within the deselect 								 */
	/*		method.																						 */
	/* ************************************************************************************************* */
	/*					applet not multiselectable => applet.deselect 									*/
	rule <k> 'deselectAppletOnLogicalChannel [NoLC:Int] =>  lookupMember(<envStack> EStack </envStack>, String2Id("deselect"))(.Exps)  ...</k>
		 <tableApplets>
		 	...
		 	LApplet |-> (aid (NameApplet:Id, Rid:Int, Pix:Int, _:String) => 
		 			aid (NameApplet, Rid, Pix, "inactive"))
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
			 	<extends>
			 		Applet
			 	</extends>
			 	...
			 </class>
		... </classes>
		<logicalChannel>
			...
			<selectedApplet> LApplet:Int </selectedApplet>
			<channelNumber> NoLC </channelNumber>
			...
		 </logicalChannel>
		 <store>
		 	...
		 		AIL |-> objectClosure(<crntClass> appletInfo(NameApplet, Rid, Pix) </crntClass> <envStack> EStack </envStack>)
		 	...
		 </store>


endmodule