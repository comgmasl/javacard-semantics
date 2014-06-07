require "../../syntax/jcard-syntax.k"

module PROCESS-METHOD-SEMANTICS
	imports JCARD-SYNTAX


  /* ********************************************************************************** */
  /*  When parsing the program, the process method is parsed instructions by instruction */ 
  /*  so the applets instruction (from the switch) can be gathered                      */
  /* ********************************************************************************** */
  rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) Bl:Block => Bl ~> getIns ... </k> 
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
        Applet
      </extends>
        when Id2String(X) ==String "process"

   rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) Bl:Block => . ... </k> 
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
        when Id2String(X) ==String "process" andBool SuperClass =/=K Applet

  rule <k> M:Modifier Fi:Final St:Static T:Type X:Id (Ps:Params) throws EsT:Types Bl:Block => Bl ~> getIns ... </k> 
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
        Applet
      </extends>
        when Id2String(X) ==String "process"

  /* ************************************************************************************ */
  /*  When parsing the program, switch statements have a particular behaviour             */ 
  /*  so the applets instruction (from the switch) can be gathered in the globalIns cell  */
  /* ************************************************************************************ */
  rule <k> switch(E1:Exp) {case E2:Exp : E3:Exp; } => . ...</k>
      <globalnoIns> L => L +Int 1 </globalnoIns>
      <globalIns> ... . => L |-> E2 ...</globalIns>
      <parsing> true </parsing>
    
  rule <k> switch (E1:Exp) { case E2:Exp : E3:Exp ; break; default : S:Stmt } => . ...</k>
    <globalnoIns> L => L +Int 1 </globalnoIns>
    <globalIns> ... . => L |-> E2 ...</globalIns>
    <parsing> true </parsing>

  /* ************************************************************************************** */
  /*  After the switch statement has been completely parsed, all the gathered instructions  */ 
  /*  are positioned into the correct class                                                 */
  /* ************************************************************************************** */  
  rule <k> getIns => . ...</k>
    <globalnoIns> L => 0 </globalnoIns>
    <globalIns> Ins:Map => .Map </globalIns>
    <classes>  ... <class>
              ...
              <className> Class </className>
              <classRid> Rid </classRid>
              <classPix> Pix </classPix>
              <instructions> . => Ins </instructions>
              <noIns> _ => L </noIns>
              ...
                      
            </class>
        ...</classes>         
    <crntApplet> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntApplet>


endmodule