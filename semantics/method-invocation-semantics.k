require "../syntax/jcard-syntax.k"
require "super-constructor-invoking-semantics.k"

module METHOD-INVOCATION-SEMANTICS
	imports JCARD-SYNTAX
  imports SUPER-CONSTRUCTOR-INVOKING-SEMANTICS

/*@
\section{Method invoking}
The efforts involved in the process of method invoking concentrate on discovering the closure of the specific method. Extraordinary caution must also be given to the type of method that we are dealing with.

---NOT CURRENTLY
As happens in most of the cases in our definition, when handling rules related to methods we create a clear separation between static methods and methods which are not static. In order to establish the type of a method (static or not), the intermediary construction objectMethodAccess(K) was introduced. Whenever a method invoking construction is found, the is no way of telling whether it is a static method or not. The mechanism for determining the type of the method is as follows: begin searching for a static function that matches the pattern. If no such static method exists then asses that the method is non static and continue searching for an instance method that has the same pattern. The intermediary construction objectMethodAccess(K) comes into play in the sense of a context. As mentioned, context are ways of imposing a term evaluation when the strictness annotation proves to be insufficient or unefficient for some cases. The means of invoking a static and a non-static method are essentially different (imply totally different configuration cells in the process). When dealing with a static method there is no object instance to be evaluated, but merely an investigation of the "staticEnv" cell of the corresponding class should be performed. Instance methods on the other hand, are very much depended on the object to which they are a part of. Therefore, the term which stands for a certain object needs to be evaluated to obtain a clear picture regarding that instance and the method that is being invoked. More details regarding the mechanisms of method invoking are described below.
---

The case of static method invoking is broken down into two particular instances of the problem.
  The first revolves around the dot notation, utilized when the invoking of the static method of another class is required. The first element of the construction states the name of the class and the element after the dot the name of the static method which we wish to call. If such a construction is being computed, the location where the method closure is found is extracted from the static environment associated with that class.
  The second case covers the calling of one of the static functions of the current object. Information regarding the current class is extracted and based on the extracted information we look in the appropriate static environment to get the methods closure. 
  Once the closure of the method is found, we proceed to apply the method as explained in the section "method application".

Instance methods have a dependency relationship with the object that declares them. In order to accurately and efficiently (smallest number of rewriting rules) invoke methods, the context "HOLE._)(_) when HOLE =/=K super". This states that whenever a construction of form X.Y(Es) is encountered (construction which is defined for method invoking), the first term should be evaluated. More specifically, this can be translated as: rewrite the name identifying an object with its closure, so that the environment stack can be brought into context and inspected. Once we have located the actual value assigned to the name of the object, we proceed with doing a lookupMember operation, searching for the value that corresponds to the name method. Further explanations about the lookupMember operation can be found in the "lookupMember" section. The end results of all these rewriting rules being that the method closure is inserted as the current instruction to compute. Once that happens, the next steps to be taken are described in the "method application" section.


*/


//--------------STATIC METHOD INVOKING


  // invoking the static method of another class
  rule <k> ((staticAccessing(Class:Id)).F:Id => V)(Es:Exps) ... </k>
      <className> Class </className>
      <staticEnv> ... F |-> L:Int ... </staticEnv> 
      <store> ... L |-> V:Val ...</store>

  //own static method
  rule <k> (X:Id => V)(_:Exps)...</k>
      <crntObj>
        <crntClass> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntClass>
        ...
      </crntObj>
      <className> Class </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> ... X |-> L:Int ... </staticEnv> 
      <store> ... L |-> V:Val ...</store>


//--------------NON-STATIC METHOD INVOKING


  // self method (may be inherited)
  rule <k> (X:Id => this . X)(_:Exps) ...</k>
      <crntObj>
        <crntClass> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntClass>
        ...
      </crntObj>
      <className> Class </className>
      <classRid> Rid </classRid>
      <classPix> Pix </classPix>
      <staticEnv> StEnv:Map </staticEnv> 
        when notBool(X in keys(StEnv)) andBool Id2String(X) =/=String "register"  
        [structural]

  
  context (HOLE._)(_) when HOLE =/=K super
 
  rule (objectClosure(Obj:Bag <envStack> EStack </envStack>) . X
           => lookupMember(<envStack> EStack </envStack>, X:Id))(_:Exps) 
      [structural]


  rule <k> (super . X
            => lookupMember(<envStack>EStack</envStack>,X))(_:Exps)...</k>
       <crntClass> Info:AppletInfo </crntClass>
       <envStack>... ListItem((Info,_)) EStack </envStack>
    [structural]

  context HOLE(_:Exps)
    when getKLabel HOLE ==KLabel '_`(_`) orBool getKLabel HOLE ==KLabel '_`[_`]
  

  rule <k> (lookup(L) => V)(_:Exps) ...</k>  <store>... L |-> V:Val ...</store>
    [lookup]

endmodule