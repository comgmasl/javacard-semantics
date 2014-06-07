require "../syntax/jcard-syntax.k"

module CAST-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Class casting}
	Class casting launches a rutine checkup to verify that the casting is a valid one.
*/

	/* ************************************************************************************ */
  	/*                   				  Class casting				       	                */
  	/* ************************************************************************************ */
	rule (C:Id) objectClosure(<crntClass> _ </crntClass> Obj)
    		=> objectClosure(Obj) instanceOf C ~> true?	~> objectClosure(<crntClass> C </crntClass> Obj)

    // primitive casting presumption that only correct programs will be executed
    rule <k> (T:Type) V:Val => V ...</k>

endmodule