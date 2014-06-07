require "../../../../syntax/jcard-syntax.k"

module RUNTIME-NONSTATIC-MEMBER-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX

  /* ************************************************************************************************ */
  /*            At runtime nonstatic members are stored 						                                  */
  /* ************************************************************************************************ */

   rule <k> var M:Modifier Fi:Final St:Static T:Type X:Id; => . ...</k>
      <env> Env:Map => Env[L:Int/X] </env>
      <store>... . => L |-> undefined(T) ...</store>
      <nextLoc> L => L +Int 1 </nextLoc>
      <parsing> false </parsing>
        when St =/=K static 

   rule <k>M:Modifier Fi:Final St:Static T:Type X:Id[N:Int]; => . ...</k> 
      <env> Env => Env[L/X] </env>
      <store>... . => L |-> array(T, L +Int 1, N)
                      (L +Int 1)...(L +Int N) |-> undefined(T) ...</store>
      <nextLoc> L:Int => L +Int 1 +Int N </nextLoc>
      <parsing> false </parsing>
        when N >=Int 0 andBool St =/=K static

endmodule