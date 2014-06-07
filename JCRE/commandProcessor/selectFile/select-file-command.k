require "../../appletDeselection/applet-deselection.k"
require "../../responses/response-handler.k"
require "../../../semantics/jcard-semantics.k"

module SELECT-FILE-COMMAND
	imports APPLET-DESELECTION
	imports RESPONSE-HANDLER
	imports JCARD-SEMANTICS

	syntax Stmts ::="'SelectAppletOnLogicalChannel" "[" Int "]"
	syntax Stmts ::= "'executeSelectFileGivenChannel" "[" Int "]"


	/* ************************************************************************************************* */
	/* 		The logical channel has an active applet, the procedure being that it deselects				 */
	/*		this applet first and then select the one matching the AID in the data field of APDU 		 */
	/* ************************************************************************************************* */
	rule <k> 'executeSelectFileGivenChannel[LC:Int] => 'deselectAppletOnLogicalChannel[LC] ~> 
			'SelectAppletOnLogicalChannel[LC] ...</k>
		<logicalChannel>
		 	...
		 		<selectedApplet> LApplet:Int </selectedApplet>
		 		<channelNumber> LC </channelNumber>
		 	...
		</logicalChannel>
		<apduCommand>
	      	...
	         	<dataField> Aid:Int </dataField>
	      	...
	    </apduCommand>
	    <tableApplets>
	      	...
	        	AnotherLApplet:Int |-> (aid (NameApplet:Exp, Rid:Int, Pix:Int, S:String))
	      	...
	    </tableApplets>
		when LApplet =/=Int -1 andBool Aid ==Int (Rid +Int Pix)


	rule <k> (nothing(void) => .) ~> 'SelectAppletOnLogicalChannel[LC:Int] ... </k>

	/* ************************************************************************************************* */
	/* 					The logical channel has no active applet, so it 	???							 */
	/*		 			selects the one matching the AID in the data field of APDU 		 				 */
	/* ************************************************************************************************* */
	rule <k> 'executeSelectFileGivenChannel[LC:Int] => 'SelectAppletOnLogicalChannel[LC] ...</k>
		<logicalChannel>
		 	...
		 		<selectedApplet> -1 </selectedApplet>
		 		<channelNumber> LC </channelNumber>
		 	...
		</logicalChannel>
		<apduCommand>
	      	...
	         	<dataField> Aid:Int </dataField>
	      	...
	    </apduCommand>
	    <tableApplets>
	      	...
	        	AnotherLApplet:Int |-> (aid (NameApplet:Exp, Rid:Int, Pix:Int, S:String))
	      	...
	    </tableApplets>
		  when Aid ==Int (Rid +Int Pix)


	/* ************************************************************************************************* */
	/*		4. The Java Card RE searches the internal applet table which lists all successfully  		 */
	/*	    installed applet instances on the card for an applet instance with a matching AID. 			 */
	/*	 	If a matching applet instance is found, it is picked as the candidate applet instance.  	 */
	/* ************************************************************************************************* */
	// Case 1. When the targeted applet is already ACTIVE but it is MULTISELECTABLE
	rule <k> 'SelectAppletOnLogicalChannel[LC:Int] => 'response ...</k>
	    <logicalChannel>
			...
			 	<selectedApplet> LPrevious:Int => L </selectedApplet>
		        <state>  "open" </state>
		        <channelNumber> LC </channelNumber>
		    ...
		</logicalChannel>
		<apduCommand>
	      	...
	         	<dataField> Aid:Int </dataField>
	      	...
	    </apduCommand>
	    <tableApplets>
	      	...
	        	L:Int |-> (aid (NameApplet:Exp, Rid:Int, Pix:Int, "active"))
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
	        when Aid ==Int Rid +Int Pix


	/* ************************************************************************************************* */
	/*	  5. If the candidate applet instance is not a multiselectable applet, and the candidate    	 */
	/*	  applet's context is active, the logical channel remains open and the Java Card RE 			 */
	/*	  records an error response status code of 0x6985 (SW_CONDITIONS_NOT_ 							 */
	/*	  SATISFIED). Prior to sending the response code, if there is an active applet 					 */
	/*	  instance on the logical channel, then the Java Card RE may optionally deselect the 			 */
	/*	  applet instance, as described in Section 4.7, "Applet Deselection", and set the state 		 */
	/*	  so that no applet is active on the specified logical channel. 								 */
	/* ************************************************************************************************* */
	// Case 2. When the targeted applet is already ACTIVE but it is NOT MULTISELECTABLE
	rule <k> 'SelectAppletOnLogicalChannel[LC:Int] => 'response ...</k>
	    <logicalChannel>
		 	...
			 	<selectedApplet> LPrevious:Int </selectedApplet>
		        <state>  "open" </state>
		        <channelNumber> LC </channelNumber>
		    ...
		</logicalChannel>
		<apduCommand>
	       	...
	        	<dataField> Aid:Int </dataField>
	      	...
	    </apduCommand>
	    <tableApplets>
	      	...
	         	L:Int |-> (aid (NameApplet:Exp, Rid:Int, Pix:Int, "active"))
	      	...
	    </tableApplets>
	    <response>
	      	...
	      		<sw1> _ => "69"</sw1>
         		<sw2> _ => "85"</sw2>
         	...
        </response>
         when Aid ==Int Rid +Int Pix 


    /* ************************************************************************************************* */
	/* 					Case 3. When the targeted applet is NOT ACTIVE 	 								 */
	/* ************************************************************************************************* */
	rule <k> 'SelectAppletOnLogicalChannel[LC:Int] => lookupMember(<envStack> EStack </envStack>, String2Id("select"))(.Exps) ~> 'response ...</k>
		<logicalChannel>
		 	...
		 	<selectedApplet> LPrevious:Int => L </selectedApplet>
	        <state>  "open" </state>
	        <channelNumber> LC </channelNumber>
	        ...
		</logicalChannel>
		<apduCommand>
         	...
         	<dataField> Aid:Int </dataField>
         	...
        </apduCommand>
        <tableApplets>
         	...
         	L:Int |-> (aid (NameApplet:Id, Rid:Int, Pix:Int, "inactive") => aid (NameApplet, Rid, Pix, "active"))
         	...
        </tableApplets>
        <store>
		 	...
		 		AIL |-> objectClosure(<crntClass> appletInfo(NameApplet, Rid, Pix) </crntClass> <envStack> EStack </envStack>)
		 	...
		</store>
         when Aid ==Int Rid +Int Pix 

    rule <k> (true => . ) ~> 'response ...</k> 


	/* ************************************************************************************************* */
	/* 					Otherwise, if no AID match is found:  											 */
	/*		If there is no active applet instance on the specified logical channel, the Java 			 */
	/*			Card RE responds with status code 0x6999 (SW_APPLET_SELECT_FAILED). 	   				 */
	/* ************************************************************************************************* */
	rule <k> 'executeSelectFileGivenChannel[LC:Int] => 'response ...</k>
		<logicalChannel>
		 	...
		 	<selectedApplet> -1 </selectedApplet>
	        <state>  "open" </state>
	        <channelNumber> LC </channelNumber>
	        ...
		</logicalChannel>
		<response>
		 	...
		 		<sw1> _ => "69" </sw1>
		 		<sw2> _ => "99" </sw2>
		 	...
		</response>


	/* ************************************************************************************************* */
	/* 					Otherwise, the active applet instance on this logical channel is set as the      */
	/*						currently selected applet instance and the SELECT FILE command is 			 */
	/*							forwarded to that applet instance's process method.	   					 */
	/* ************************************************************************************************* */
	rule <k> 'executeSelectFileGivenChannel[LC:Int] => lookupMember(<envStack> EStack </envStack>, String2Id("process"))(objectClosure(<crntClass> appletInfo(Main,Rid1:Int,Pix1:Int) </crntClass> <envStack> EStack2 </envStack>).String2Id("data")) ~> 'response ...</k>
		<logicalChannel>
		 	...
		 	<selectedApplet> LApplet:Int </selectedApplet>
	        <state>  "open" </state>
	        <channelNumber> LC </channelNumber>
	        ...
		</logicalChannel>
		<tableApplets> LApplet |-> aid(E:Id, Rid:Int, Pix:Int, _:String) ... </tableApplets>
		 <store>
		 	...
		 		AIL |-> objectClosure(<crntClass> appletInfo(E,Rid,Pix) </crntClass> <envStack> EStack </envStack>)
		 		ML |-> objectClosure(<crntClass> appletInfo(Main,Rid1,Pix1) </crntClass> <envStack> EStack2 </envStack>)
		 	...
		 </store>
		when LApplet =/=Int -1


	/* ************************************************************************************************* */
	/* 		3. If the specified logical channel is not open on the I/O interface that received the       */
  	/*		SELECT FILE command, it is now opened and the Java Card RE state is set so that 			 */
 	/*		no applet is active on this new logical channel. The specified logical channel will   		 */
	/*		be the assigned channel for the applet instance that will be active on it. 					 */
	/* ************************************************************************************************* */
    rule <k> 'executeSelectFileGivenChannel[LC:Int] => 'response ...</k>
    	<logicalChannels> ... ( . =>
									<logicalChannel>
									 	...
									 		<selectedApplet> -1 </selectedApplet>
						                    <state>  "open" </state>
						                    <channelNumber> LC </channelNumber>
									 	...
									</logicalChannel>
							  )
			 ...
		</logicalChannels>
		<unusedLCNo>
		 	...
		 	ListItem(LC:Int) => . 
		 	...
		 </unusedLCNo>

endmodule