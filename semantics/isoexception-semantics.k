require "../syntax/jcard-syntax.k"
require "../JCRE/responses/response-handler.k"

module ISOEXCEPTION-SEMANTICS
	imports JCARD-SYNTAX
	imports RESPONSE-HANDLER


/*@
  \section{Exception handling - part 2}
   The second part of the exception handling process deals with the issue of uncaught exceptions thrown by
   applets methods. The specification of Java Card states that when an exception defined in the Java Card API is thrown and unhandled, the exact exception type and the embedded reason code is transmitted to the client application. In essence, the exception object is transmitted by value. In our definition, when a "throw" instructions is encountered, the "xstack" cell is searched. This cell is an indicative of any preannounced exception handlers that are capable of dealing with a potential thrown exception. If the "xstack" cell is empty, then the exception type and embedded reason code have to be transmited to the client application, which runs inside the CAD. Therefore, we define the next two rules for throwing exceptions. The first one, inspects the "xstack", notices it is empty, so it retrieves from the store the value of the reason the exception occured and proceeds with throwing that value.
   The second rule takes care of the finishing touches of dealing with an uncaught exception. The "response" cell which is the way of communication between the card and the client application is updated with the value of the reason code. When an exception is thrown the execution of the method which caused the exception is halted. To ensure this, the top of the "fstack" cell is popped, in order to restore the environment which called the function that caused the exception.
*/


	/* ************************************************************************************************ */
	/*	When and ISOException is thrown and unhandled write the error code in the response cell         */
	/* ************************************************************************************************ */

	// when there is no one announced to handle the exception return it to client application
  rule <k> throw objectClosure(Obj:Bag <envStack> ... ListItem((_:AppletInfo,<env> ... X:Id |-> L:Int ...</env>))... </envStack>); => throw V; ...</k>
     	<control>
        <xstack> . </xstack>
         ...
    	</control>
     	<store> 
        ... 
          L |-> array(_,SL:Int, 2) 
     			SL |-> V:Val
       	...
      </store>
      when Id2String(X) ==String "theSw"

  rule <k> throw V:Int; ~> _  => . ...</k>
     	<control>
        ...
        <xstack> . </xstack>
        <fstack> ListItem((Env, K, C)) => . ...</fstack>
         (<return> T:Type </return> _ => C)
         ...
      </control>
    	<response>
			 ...
				<sw1> _ => substrString(IntToHexString(V), 0, 2) </sw1>
				<sw2> _ => substrString(IntToHexString(V), 2, 4) </sw2>
			 ...
		  </response>	
      <env> _ => Env </env>

endmodule