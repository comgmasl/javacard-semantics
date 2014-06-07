require "../syntax/jcard-syntax.k"
require "../JCRE/defaultApplets/default-applets-initialization.k"
require "../JCRE/basicLogicalChannel/basic-logical-channel.k"

module PROGRAM-INITIALIZATION-SEMANTICS
	imports JCARD-SYNTAX
  imports DEFAULT-APPLETS-INITIALIZATION
  imports BASIC-LOGICAL-CHANNEL

/*@
\section{Program execution}
  Once the parsing stage has successfully completed, the program reaches the execution phase.
  At the beginning of this phase lays the installation process. As mentioned in the "install" method section, each install method of applets are stored in the "installFunction" cell. The installation process implies
  iterating through all the retained "install" methods and executing them in order to obtain applet instances, through which our CAD emulator will interact with the card.
  After all applets have been installed and registered, we initialize a new Main class. The Main class can be seen as an emulation of a card acceptance device. The overview of the Main class is that it first opens the basic logical channel and sets the default applets for certain logical channels. After the logical channel logic has been completed, the Main class keeps listening for commands, given in the APDU format. The received commands are send to the card, where a command processor interprets them and performs the neccessary actions.  
*/


  /* ************************************************************************************** */
  /*  Each execution has to first initialize the applets by calling the install method      */
  /*  the main method is called                                                             */ 
  /* ************************************************************************************** */  
  syntax K ::= "execute"
	rule <k> execute =>  initializeAllApplets ~>  new Main(.Exps); </k><env>. </env>
      <parsing> true => false </parsing> [structural]
   


  syntax Stmts ::= "initializeAllApplets"  
  /* ************************************************************************************** */
  /*  Instantiate the applets by calling all the install function found while parsing       */
  /* ************************************************************************************** */   
  rule <k> initializeAllApplets => St1 ~> initializeAllApplets ... </k>
      <installFunction> ... L |-> installFunction(St1:Block, Class:Id, Rid:Int, Pix:Int) ...</installFunction>
      <initApplets> L </initApplets>
      <appletNo> No:Int </appletNo>
      <crntApplet> _ => appletInfo(Class, Rid, Pix) </crntApplet>
      when L <Int No 
        
  rule <k> initializeAllApplets => . ...</k> 
     <initApplets> L </initApplets>
     <appletNo> No:Int </appletNo>
     <crntApplet> _ => Object </crntApplet>
       when L ==Int No  

  
endmodule