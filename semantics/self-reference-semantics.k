require "../syntax/jcard-syntax.k"

module SELF-REFERENCE-SEMANTICS
	imports JCARD-SYNTAX

/*
\section{Self reference}
The rule for self referencing is that the "this" operator will always be evaluated to the value of the current object kept in the "crntObj" cell.
*/
	rule <k> this => objectClosure(Obj) ...</k>
       <crntObj> Obj </crntObj>

endmodule