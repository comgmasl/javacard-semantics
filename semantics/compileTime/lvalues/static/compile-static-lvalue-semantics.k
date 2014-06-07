require "../../../../syntax/jcard-syntax.k"

module COMPILE-STATIC-LVALUE-SEMANTICS
  imports JCARD-SYNTAX

/*@
\section{Parsing phase}
  Static members are handled completely the opposite way(than the non-static ones) in the parsing process. 
  The goal is to store these kinds of fields and also take into consideration the initial value attributed to them (if any). 
*/
  
  rule <k> lvalue(X:Id => loc(L)) ...</k> 
      <crntApplet>
        appletInfo(Class:Id, Rid:Int, Pix:Int)
      </crntApplet>
      <className> 
        Class
      </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv>... X |-> L ...</staticEnv> 
      <parsing> true </parsing>  
    
endmodule