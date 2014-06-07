require "../syntax/jcard-syntax.k"

module METHOD-APPLICATION-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Method application}
There are two different cases when dealing with the matter of method application. These cases are the equivalent of the two types of methods that can exists, more specifically class and instance methods.
The first rule represents the case of static method application. Any method application implies a context switch. In order for the program to have a successful execution, the current environment map should be retained and then reinitialized for the new context. Moreover, we add a new item at the top of the function stack in which we store the environment of the calling enitity, the computational code that follows the function call, the current object along with the expected return type of the current function being executed.
In this manner, the entire context which was valid when a method was called can be restored and the execution can carry on without interruptions or mistakes. Because we are dealing with static function which do not have an instance with which they are paired, the current object is simply discarded for the context of execution of that method. The "return" cell is updated with the return type of the static method being applied. In addition to these steps that guarantee that a return from the function is successful, a couple of more instructions are needed. The paramenters of the method should be associated with the values given at method call. This association is achieved with the help of the "mkDecls" auxiliary operation which is more thoroughly inspected in the "mkDecls" section. After the parameters have been attributed with values, the function body is is taken from the closure of the method and given as computational instruction. After the method has executed, a return statement is needed in order to restore the previous context.

The second rule handles the case of instance method application. The proceedings for this kind of method are extremely similar to the ones described for the static function. The only noticeable difference comes from the fact that these methods have a instance associated. Therefore, the methods may need information regarding the entire environment of that object. This represents part of the reason for updating the "crntObj" cell with the object to which the called method is associated. Each instance method holds inside its closure the location where its paired object can be found. As for the rest of the execution of an instance method application, the same steps as stated above are made.
*/

  // FOR STATIC FUNCTIONS
  rule <k> methodClosure(_->T,Info:AppletInfo,-1,Ps,S,M:Modifier,Fi:Final,St:Static)(Vs:Vals) ~> K
           => mkDecls(Ps,Vs) S return; </k>
      <env> Env => . </env>
      <control>
        C
        <fstack> . => ListItem((Env, K, C <crntObj> Obj' </crntObj>
                                  <return> T' </return>)) 
        ...</fstack>
        <crntObj> Obj' => . </crntObj>
        <return> T' => T </return>
        </control>
        when St ==K static


  // FOR NONSTATIC FUNCTIONS
	rule <k> methodClosure(_->T,Info:AppletInfo,OL,Ps,S,M:Modifier,Fi:Final,St:Static)(Vs:Vals) ~> K
           => mkDecls(Ps,Vs) S return; </k>
       	<env> Env => . </env>
       	<store>... OL |-> objectClosure(<crntClass>_</crntClass> Obj)...</store>
       	<br/>
       	<control>
          	C
          	<fstack> . => ListItem((Env, K, C <crntObj> Obj' </crntObj>
                                   <return> T' </return>)) ...</fstack>
          	<crntObj> Obj' => <crntClass> Info </crntClass> Obj </crntObj>
          	<return> T' => T </return>
      	</control>

endmodule