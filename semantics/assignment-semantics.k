require "../syntax/jcard-syntax.k"

module ASSIGNMENT-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Assigment}
  The assignment operation is manipulated according to the phase of the execution and other existing conditions. The ultimate form it reaches is the below one. For the left element of the operation the store location is known and the right element is evaluated to its value. The assigment performs a check to see whether the type of the left and right operands are compatible and replaces the value hold at the given store location with the new value.
*/

 context (HOLE => lvalue(HOLE)) = _

 rule <k> loc(L) = V:Val
           => subtype(typeOf(V),typeOf(V')) ~> true?
              ~> unsafeCast(V, typeOf(V')) ...</k>
       <store>... L |-> (V' => unsafeCast(V, typeOf(V'))) ...</store>
    		[assignment]


endmodule