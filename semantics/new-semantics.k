require "../syntax/jcard-syntax.k"

module NEW-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Object creation - New operator}
The process of creating a new object is divided in our definition into three major steps. These steps are as follows: "create" rule, "storeObj" rule and the call to the constructor of the class and returning of the creating object.

"Give the rule then explain":
The new operator produces massive changes to a couple of configuration cells. Firstly, we notice that the current environment (the one where the object creation takes place) is discarded from the "env" cell, in order to have a clean environment for the object that is going to be created. 
Another modification occurs among the "control" cell. The restauration of the context previous to the creation of the object is essential, so to be able to obtain that context, all the information regarding it is pushed at the beginning of the "fstack" cell. This includes the environment, the computational code that follows after the "new" construction, the object itself, the return type expected in that context and also the "xstack". Since the matter at hand is that of creating an instance, and all classes have as super class the Object class, the current object is changed to be a new Object instance. One last action performed in this rewriting rule implies assigning the object that will be created with a store location and then incrementing the "nextLoc" value to point, yet again, to a free location space.

The "create(Id)" rule introduces four new computations to be processed. 
  The first computation regards the creation of the super class of that object. A recursive manner of generating all the super classes for an object is utilized. The exiting condition of this recursion is representing by the creation of an Object, which represents the super class of all the classes in Java Card. This procedure is absolutely essential taking into consideration the principle of inheritance and all that this principle entails.
  The next computation introduced is the "setCrntClass" one, which indicates the class name and the AID associated with it. This rule enables the correct setting of the class name for the current object.

  After setting the current class name, the class declaration are brought from the "declarations" cell to be computed. All the statements of that class are executed in order to create the environment for the object. 

  Lastly, the "addEnvLayer" rule pushes a new item in the "envStack" cell of the current object.
  This insertion is accomplished by taking the environment stored for a class identified by the "crntClass" cell and creating from these two pieces of information a new stack item.

After the object was created as described above, we store the result in the corresponding position of the store. Thus, the store now holds at that position an object closure, which contains all neccessary information regarding the object, its enviroment and the superclasse objects. 

Once the object was store, we call the constructor of the specific class to perform the neccesary initializations and then return the object. Returning a value represents another important aspect of our definition and is more widely described in the "Return" section.

*/

	rule <k> new Class:Id(Vs:Vals) ~> K
           => create(Class) ~> (storeObj ~> ((Class(Vs)); return this;)) </k>
       <env> Env => . </env>
       <nextLoc> L:Int => L +Int 1 </nextLoc>
       <br/>
       <control> C
        <crntObj> Obj
                  => <crntClass> appletInfo(Object,0,0) </crntClass>
                     <envStack> ListItem((appletInfo(Object,0,0), <env>.Map</env>)) </envStack>
                     <location> L </location>
        </crntObj>
        <return> T => Class </return>
        <fstack> . => ListItem((Env, K, C <return>T</return> <crntObj>Obj</crntObj>))
        ...</fstack>
       </control>


  	syntax K ::= create(Id)


    // installing applets ( needed for applets with the same name)
  	rule <k> create(Class:Id)
           => create(Class1) ~> setCrntClass(Class, Rid, Pix) ~> S ~> addEnvLayer ...</k>
       	<className> Class </className>
        <classRid> Rid </classRid>
        <classPix> Pix </classPix>
       	<extends> Class1:Id </extends>
       	<declarations> S </declarations>  
        <crntApplet> appletInfo (Class, Rid:Int, Pix:Int) </crntApplet> 
         [structural]
    
    rule <k> create(Class:Id)
           => create(Class1) ~> setCrntClass(Class, Rid, Pix) ~> S ~> addEnvLayer ...</k>
        <className> Class </className>
        <extends> Class1:Id </extends>
        <classRid> Rid </classRid>
        <classPix> Pix </classPix>
        <declarations> S </declarations>  

         [structural]

  	rule <k> create(Object) => . ...</k>  [structural]

  	syntax K ::= setCrntClass(Id, Int, Int)

  	rule <k> setCrntClass(C, Rid:Int, Pix:Int) => . ...</k>
       	<crntClass> _ => appletInfo(C, Rid, Pix) </crntClass>  [structural]

  	syntax K ::= "addEnvLayer"

  	rule <k> addEnvLayer => . ...</k>
       	<env> Env => . </env>
       	<crntClass> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntClass>
       	<envStack> . => ListItem((appletInfo(Class,Rid,Pix), <env>Env</env>)) ...</envStack>
        [structural]

  	syntax K ::= "storeObj"

  	rule <k> storeObj => . ...</k>
       	<crntObj> Obj (<location> L:Int </location> => .) </crntObj>
       	<store>... . => L |-> objectClosure(Obj) ...</store>



       	
endmodule