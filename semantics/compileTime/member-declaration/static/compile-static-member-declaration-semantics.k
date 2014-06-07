require "../../../../syntax/jcard-syntax.k"

module COMPILE-STATIC-MEMBER-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Parsing phase}
  Static member declarations represent one of the reasons why class statements are computed in the parsing phase. Because of the prerequisites a static member is associated with, the content of a class is searched. Whenever a static member is encountered as the current computational step, that member is positioned into the static environment cell of the applet that is currently parsed.
*/

  /* ************************************************************************************************ */
  /*                      While parsing static members are "gathered"   (COMPILE TIME)                */
  /* ************************************************************************************************ */

  rule <k> var M:Modifier Fi:Final St:Static T:Type X:Id; => . ...</k>
      <crntApplet>
        appletInfo(C:Id, Rid:Int, Pix:Int)
      </crntApplet>
      <className> C </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> Env => Env[L/X] </staticEnv>
      <nextLoc> L => L +Int 1 </nextLoc>
      <store> ... . => L |-> undefined(T) ...</store>      
      <parsing> true </parsing>
      when St ==K static 

  rule <k>M:Modifier Fi:Final St:Static T:Type X:Id[N:Int]; => . ...</k> 
      <crntApplet>
        appletInfo(C:Id, Rid:Int, Pix:Int)
      </crntApplet>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> Env => Env[L/X] </staticEnv>
      <nextLoc> L => L +Int 1 </nextLoc>
      <store>... . => L |-> array(T, L +Int 1, N)
                      (L +Int 1)...(L +Int N) |-> undefined(T) ...</store>   
      <parsing> true </parsing>
      when St ==K static andBool N >=Int 0



endmodule