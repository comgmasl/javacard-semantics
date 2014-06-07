require "../syntax/jcard-syntax.k"

module GENERIC-GUARD-SEMANTICS
	imports JCARD-SYNTAX

/*@	
\subsubsection{Generic guard}

A generic computational guard: it allows the computation to continue
only if a prefix guard evaluates to true.
*/

	rule true ~> true? => .  [structural]
	
endmodule