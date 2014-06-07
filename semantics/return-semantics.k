require "../syntax/jcard-syntax.k"
require "../JCRE/io/write-output.k"

module RETURN-SEMANTICS
	imports JCARD-SYNTAX
  imports WRITE-OUTPUT

/*@
\section{Return}
  The return operation signals the need of a context switch. The control needs to be given back to the previous context. This is accomplished with the help of the defined rewriting rule for the "return V"
  computation. The rule conducts a verification to check that the type of the value being returned is compatible with the expected return type. If this checkup is successful, the next logical computational tasks are brought into the "k" cell. Furthermore, the previous environment, the code instructions that have to be executed and other information are restored in the current context by extracting them from the top of the "fstack".
*/

  rule <k> return V:Val; ~> _
           => subtype(typeOf(V), T) ~> true? ~> unsafeCast(V, T) ~> K
        </k>
        <control>
         <fstack> ListItem((Env, K, C)) => . ...</fstack>
         (<return> T:Type </return> _ => C)
        </control>
        <env> _ => Env </env>

  rule <k> return; => return nothing(T); ...</k> <return> T </return>
    	[structural]

endmodule