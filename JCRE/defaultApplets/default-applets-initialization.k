require "../../syntax/jcard-syntax.k"

module DEFAULT-APPLETS-INITIALIZATION
	imports JCARD-SYNTAX

/* @ \subsection{Default applets }
 Module which registers default applets for logical channels
 This module needs to be modified according to the choices of the
 implementer of the cards internal state.

 "the Java Card RE performs its initialization, if the contacted interface is
  not already active, and then checks to see if its internal state indicates that a
  particular applet instance is the default applet instance for the basic logical
  channel on the contactless I/O interface."
 
  We map the logical channel (which can be from 0 (basic) to 19) to a default applet instance.
*/ 

 syntax Stmts ::= "'assignDefaultAppletForChannel" "[" Int "," Int "]" ";"

 rule <k> 'assignDefaultAppletForChannel [LCNo:Int, NoApplet:Int]; => . ...</k>
 	  <tableApplets>
 	  	...
 	  		NoApplet |-> aid(E:Exp, Rid:Int, Pix:Int, S:String)
 	  	...
 	  </tableApplets>
 	  <defaultApplets> ... . =>
 	  		LCNo |-> aid(E, Rid, Pix, S)
 	  ...
 	  </defaultApplets>

endmodule