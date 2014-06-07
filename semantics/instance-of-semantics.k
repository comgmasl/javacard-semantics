require "../syntax/jcard-syntax.k"

module INSTANCE-OF-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Instance-of}
	In order to verify the fact that a class is an instance of another given class, we must perform a lookup in the closure of the object. The class of the object is discovered by looking at the first element in the envStack list. If that class information matches exactly the information given after the "instance of" operator, then the result of the operation is true. 
*/
	rule objectClosure(<envStack> ListItem((appletInfo(C::Id,_:Int,_:Int),_)) ...</envStack> _)
       instanceOf C => true

  	rule objectClosure(<envStack> ListItem((appletInfo(C::Id,_:Int,_:Int),_)) => . ...</envStack> _)
       instanceOf C'  when C =/=K C'  [structural]

  	rule objectClosure(<envStack> . </envStack> _) instanceOf _ => false
  	
endmodule