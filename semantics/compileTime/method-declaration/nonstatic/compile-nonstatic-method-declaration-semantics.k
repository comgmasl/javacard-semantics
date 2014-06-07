require "../../../../syntax/jcard-syntax.k"
require "../../../specialMethods/process-method-semantics.k"

module COMPILE-NONSTATIC-METHOD-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX
	imports PROCESS-METHOD-SEMANTICS


/*@
\section{Parsing phase}
	Another construction that is discarded while parsing is in progress is the declarations of functions that are not static. These methods represent instance methods and are of no interest for the static environment cell of a class and therefore are ignoring during this stage of the execution.	
*/

	rule <k> M:Modifier Fi:Final St:Static T:Type X:Id(Ps:Params) Bl => . ...</k>
      	<parsing> true </parsing>
      	when St =/=K static andBool Id2String(X) =/=String "process" 

    rule <k> M:Modifier Fi:Final St:Static T:Type X:Id(Ps:Params) throws EsT:Types Bl => . ...</k>
      	<parsing> true </parsing>
     	when St =/=K static andBool Id2String(X) =/=String "process" 

endmodule