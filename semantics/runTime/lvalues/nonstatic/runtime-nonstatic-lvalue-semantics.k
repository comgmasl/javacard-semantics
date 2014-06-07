require "../../../../syntax/jcard-syntax.k"

module RUNTIME-NONSTATIC-LVALUE-SEMANTICS
	imports JCARD-SYNTAX


  rule <k> lvalue(X:Id => loc(L)) ...</k>  
      <env>... X |-> L:Int ...</env>  
      <parsing> false </parsing>
      [structural]


   // INSTALL PHASE
  rule <k> lvalue(X:Id => this. X) ...</k> <env> Env </env> 
      <crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>
      <className> Class </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> StEnv:Map </staticEnv>
      <parsing> false </parsing> 
      when notBool(X in keys(StEnv)) andBool notBool(X in keys(Env))  [structural]



	rule <k> lvalue(X:Id => this . X) ...</k> 
      <env> Env </env> 
      <crntObj>
        <crntClass> appletInfo(Class,Rid:Int,Pix:Int) </crntClass>
        ...
      </crntObj>
      <className> Class </className>
      <staticEnv> StEnv:Map </staticEnv> 
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <parsing> false </parsing> 
      when notBool(X in keys(Env)) andBool notBool(X in keys(StEnv)) [structural]

  rule <k> lvalue(staticAccessing(StaticClass:Id).X:Id) => lvalue(lookup(L)) ... </k>
       <className> StaticClass </className>
       <staticEnv> ... X |-> L ...</staticEnv>

  context lvalue(HOLE . _)

  rule lvalue(objectClosure(<crntClass> Info:AppletInfo </crntClass>
                            <envStack>... ListItem((Info,EnvC:Bag)) EStack </envStack>)
              . X
              => lookupMember(<envStack> ListItem((Info,EnvC)) EStack </envStack>,
                              X))  [structural]
	

endmodule