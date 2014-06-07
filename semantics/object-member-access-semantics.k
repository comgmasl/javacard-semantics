require "../syntax/jcard-syntax.k"

module OBJECT-MEMBER-ACCESS-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Object member access}

  The situation when access to a certain object member is demanded has been separated into three major possibilities within our definition.
  The first case considers the possibility of accessing a local member. Since it is a local member, its location must be stored alongside its name inside the "env" cell. If that happens, then the procedure is to extract its location and with that location, find the value to which it maps inside the "store" cell.

  Next we focus on the matter of accessing static members. A static member can be requested either using the dot notation or without this notation. 
    The dot notation indicates the fact that the static member of another class is asked for. Therefore, the first element of the construction represents the name of the class and the element after the dot the name of the member. Knowledge of this information enables the inspection of the specified class "staticEnv" cell to locate the position of the wanted member. With that location received the value of the member can be easily obtained from the "store" cell.
    If a static member is accessed without the dot notation, the class of the current object is reviewed to discover the location of the member from the "staticEnv" cell. Consequently, the value neccessary is extracted from the "store".

  The focus is now being placed on instance memebers. The existence of instance entities determines the introduction of a new context "context HOLE . _"  when (HOLE =/=K super)", which imposes the evaluation of the first term. The motivation of the need for this context is evident, since we are dealing with instance members. The first term will represent the name of the object (be it "this", or a user given identifier) and the second the name of the member that is being requested. The name of the object needs to be evaluated in order to be able to proceed. That means replacing the name of the instance with the object closure stored in the configuration. After obtaining the value for the object which includes the "envStack" cell, a lookupMember operation is performed that will have as result the value of the accessed member.
  More details regarding the lookupMember operation can be found in the "lookupMember" section.
*/ 

  rule <k> X:Id => V ...</k>
      <env>... X |-> L ...</env>
      <store>... L |-> V:Val ...</store>  
      <parsing> false </parsing> 
      [lookup] 

  rule <k> X:Id => V ...</k> 
      <crntObj>
        <crntClass> appletInfo(Class,Rid,Pix) </crntClass>
         ...
      </crntObj>
      <className> Class </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv>... X |-> L ...</staticEnv> 
      <store> ... L |-> V ...</store>
      <parsing> false </parsing>  
      [lookupStatic]

  // rule for static accessing from a static function
  rule <k> X:Id => staticAccessing(X) ...</k>
       <crntObj> . </crntObj>
       <env> Env:Map </env>
       when notBool(X in keys(Env))

  rule <k> staticAccessing(Class:Id).X:Id => V ...</k>
      <className> Class </className>
      <staticEnv> ... X |-> L:Int ... </staticEnv>
      <store> ... L |-> V:Val ...</store>

  rule <k> X:Id => this . X ...</k> 
      <env> Env:Map </env>  
      <crntObj>
        <crntClass> appletInfo(Class,Rid,Pix) </crntClass>
        ...
      </crntObj>
      <className> Class </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> StEnv:Map </staticEnv> 
      when notBool(X in keys(Env)) andBool notBool(X in keys(StEnv)) [structural]


 context HOLE . _ when (HOLE =/=K super )

 rule objectClosure(<crntClass> Info:AppletInfo</crntClass>
                     <envStack>... ListItem((Info,EnvC:Bag)) EStack </envStack>). X:Id
    => lookupMember(<envStack> ListItem((Info,EnvC)) EStack </envStack>, X) 
    [structural]


	rule <k> super . X => lookupMember(<envStack>EStack</envStack>, X) ...</k>
       <crntClass> Info:AppletInfo </crntClass>
       <envStack>... ListItem((Info,EnvC:Bag)) EStack </envStack>
    	[structural]

  /* ************************************************************************************ */
  /*  Look up value by location                                                           */
  /* ************************************************************************************ */
  rule <k> lookup(L) => V ...</k> <store>... L |-> V:Val ...</store>  [lookup]
    	
endmodule