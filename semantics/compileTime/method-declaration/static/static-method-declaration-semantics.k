require "../../../../syntax/jcard-syntax.k"
require "../../../specialMethods/install-method-semantics.k"
require "../../../specialMethods/register-method-semantics.k"
require "../../../specialMethods/process-method-semantics.k"

module STATIC-METHOD-DECLARATION-SEMANTICS
  imports JCARD-SYNTAX
  imports INSTALL-METHOD-SEMANTICS
  imports REGISTER-METHOD-SEMANTICS
  imports PROCESS-METHOD-SEMANTICS

/*@
\section{Parsing phase}
  Static method declarations introduce a new aspect of interest for the stage of parsing the program. Being clasified as class methods, they are retained, at this point of the execution, inside the static environment cell for the applet that is being examined. The storage procedure involves three configuration cells : "staticEnv" which represents a map between the name of the entity being written and its given location address, "nextLoc" which points to the free location in the store and "store" cell
  where, in this case, the "methodClosure" of the method is placed. 
*/

  rule <k> M:Modifier Fi:Final St:Static T:Type F:Id (Ps:Params) S => . ...</k>
      <crntApplet>
        appletInfo(C:Id, Rid:Int, Pix:Int)
      </crntApplet>
      <className> C </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> Env => Env[L/F] </staticEnv>
      <nextLoc> L => L +Int 1 </nextLoc>
      <store> ... . => L |-> methodClosure(getTypes(Ps)->T,appletInfo(C,Rid,Pix),-1,Ps,S, M,Fi, St) ...</store>      
      <parsing> true </parsing>
      when St ==K static andBool Id2String(F) =/=String "install"

  rule <k> M:Modifier Fi:Final St:Static T:Type F:Id (Ps:Params) throws EsT:Types S => . ...</k>
      <crntApplet>
        appletInfo(C:Id, Rid:Int, Pix:Int)
      </crntApplet>
      <className> C </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> Env => Env[L/F] </staticEnv>
      <nextLoc> L => L +Int 1 </nextLoc>
      <store> ... . => L |-> methodClosure(getTypes(Ps)->T,appletInfo(C,Rid,Pix),-1,Ps,S, M,Fi, St) ...</store>      
      <parsing> true </parsing>
      when St ==K static andBool Id2String(F) =/=String "install" 

endmodule