require "../../../../syntax/jcard-syntax.k"

module RUNTIME-NONSTATIC-METHOD-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX

  /*--------------------------------------AT RUNTIME---------------------------------------------------*/


  rule <k> M:Modifier Fi:Final St:Static T:Type F:Id (Ps:Params) S => . ...</k>
      <crntClass> Info:AppletInfo </crntClass>
      <location> OL1:Int </location>
      <env> Env => Env[L/F] </env>
      <store> ... . => L |-> methodClosure(getTypes(Ps)->T,Info,OL1,Ps,S, M,Fi, St) ...</store>
      <nextLoc> L => L +Int 1 </nextLoc>
      <parsing> false </parsing>
      when St ==K nonstatic


  rule <k> M:Modifier Fi:Final St:Static T:Type F:Id (Ps:Params) throws EsT:Types S => . ...</k>
      <crntClass> Info:AppletInfo </crntClass>
      <location> OL1:Int </location>
      <env> Env => Env[L/F] </env>
      <store> ... . => L |-> methodClosure(getTypes(Ps)->T,Info,OL1,Ps,S, M,Fi, St) ...</store>
      <nextLoc> L => L +Int 1 </nextLoc>
      <parsing> false </parsing>
      when St ==K nonstatic

endmodule