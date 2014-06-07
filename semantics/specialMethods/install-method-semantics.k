require "../../syntax/jcard-syntax.k"

module INSTALL-METHOD-SEMANTICS
	imports JCARD-SYNTAX

/*@
  \section{Applet Lifetime - Install method}
    One of the crucial methods that needs to be called in order to create applets and be able to interact with them is the "install" method. The Java Card Runtime Environment should not directly instantiate applets by usage of the constructors, instead the "install" method is used. 
    The main task of this method within the applet is to create an instance of the Applet subclass using its constructor, and to register the instance.
    At the time of the installation, other objects that the applet needs during its lifetime are created as well. Due to this requirement, it becomes evident that all the source code of the given program should have been inspected in order to have a complete picture of all the classes that participate in the execution. Therefore a mechanism was introduced, that allows us to achieve the desire behaviour. As we discussed, during the parsing phase, the code of the classes is crossed over to store essential information. Apart from the static members and methods which have to be stored, the "install" method of an applet needs special treatment as well. The treatment is that when, during inspection, the current computational step is the "install" method of an applets subclass, the body of the methos along with the identifiers of the applets subclass are position inside the "installFunction" cell. Because the method is also static, it gets referenced in the "staticEnv" cell of the class as well. 
    By storing the "install" method in the "installFunction" cell there is no loss of information and the process of installation becomes a trivial matter. The parsing phase continues and information regarding the entities of the program is collected. Once everything inside the program has been inspected, the installation phase can proceed because all the neccessary "install" methods are available in the "installFunction" cell.
    Another aspect that was not overlooked is the fact that a class which is not a subclass of an applet can present a method with the same constructional pattern as the "install" method of an applet. In these conditions, the "installFunction" is not updated, since we don't deal with an applet instance.  

*/

  /* ********************************************************************************* */
  /*         It is placed in the installFunction cell so it can be later invoked       */ 
  /* ********************************************************************************* */
  rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) Bl:Block => . ...</k>
     	<parsing> true </parsing>
     	<installFunction> ... . => L |-> installFunction( Bl, Class, Rid, Pix ) ... </installFunction>
     	<appletNo> L => L +Int 1 </appletNo>
      <crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>
      <className> 
        Class
      </className>
      <classRid>
        Rid
      </classRid>
      <classPix>
        Pix
      </classPix>
      <extends>
        Applet
      </extends>
      <staticEnv> Env => Env[NL/X] </staticEnv>
      <nextLoc> NL:Int => NL +Int 1 </nextLoc>
      <store> ... . => NL |-> methodClosure(getTypes(Ps)->T,appletInfo(Class,Rid,Pix),-1,Ps, Bl, M,Fi, St) ...</store>  
     	when Id2String(X) ==String "install" andBool St ==K static

   rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) throws EsT:Types Bl:Block  => . ...</k>
      <parsing> true </parsing>
      <installFunction> ... . => L |-> installFunction( Bl, Class, Rid, Pix ) ... </installFunction>
      <appletNo> L => L +Int 1 </appletNo>
      <crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>
      <className> 
        Class
      </className>
      <classRid>
        Rid
      </classRid>
      <classPix>
        Pix
      </classPix>
      <extends>
        Applet
      </extends>
      <staticEnv> Env => Env[NL/X] </staticEnv>
      <nextLoc> NL:Int => NL +Int 1 </nextLoc>
      <store> ... . => NL |-> methodClosure(getTypes(Ps)->T,appletInfo(Class,Rid,Pix),-1,Ps, Bl, M,Fi, St) ...</store>  
      when Id2String(X) ==String "install" andBool St ==K static


  rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) S => . ...</k>
      <parsing> true </parsing>
      <crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>
      <className> 
        Class
      </className>
      <classRid>
        Rid
      </classRid>
      <classPix>
        Pix
      </classPix>
      <extends>
        SuperClass:Id
      </extends>
      <staticEnv> Env => Env[L/X] </staticEnv>
      <nextLoc> L => L +Int 1 </nextLoc>
      <store> ... . => L |-> methodClosure(getTypes(Ps)->T,appletInfo(Class,Rid,Pix),-1,Ps, S, M,Fi, St) ...</store>  
      when Id2String(X) ==String "install" andBool SuperClass =/=K Applet andBool St ==K static


  rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) throws EsT:Types S  => . ...</k>
      <parsing> true </parsing>
      <crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>
      <className> 
        Class
      </className>
      <classRid>
        Rid
      </classRid>
      <classPix>
        Pix
      </classPix>
      <extends>
        SuperClass:Id
      </extends>
      <staticEnv> Env => Env[L/X] </staticEnv>
      <nextLoc> L => L +Int 1 </nextLoc>
      <store> ... . => L |-> methodClosure(getTypes(Ps)->T,appletInfo(Class,Rid,Pix),-1,Ps, S, M, Fi, St) ...</store>   
      when Id2String(X) ==String "install" andBool SuperClass =/=K Applet andBool St ==K static


     	 
endmodule