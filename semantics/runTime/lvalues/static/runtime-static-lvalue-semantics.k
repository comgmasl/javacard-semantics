require "../../../../syntax/jcard-syntax.k"

module RUNTIME-STATIC-LVALUE-SEMANTICS
	imports JCARD-SYNTAX

	//INSTALL PHASE
	rule <k> lvalue(X:Id) ~> K1:K => loc(parse) ...</k>
		<crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>
		<className> Class </className>
		<classRid> Rid </classRid>
		<classPix> Pix </classPix>
		<staticEnv> ... X |-> L ... </staticEnv>
		<parsing> false </parsing>

	rule  <k> lvalue(X:Id) ~> K1:K => loc(parse) ...</k> 
        <crntObj>
          <crntClass> appletInfo(Class, Rid:Int, Pix:Int) </crntClass>
          ...
        </crntObj>
        <className> Class </className>
        <classRid> Rid </classRid>
        <classPix> Pix </classPix>
        <staticEnv>... X |-> L ...</staticEnv> 
        <parsing> false </parsing>   

endmodule