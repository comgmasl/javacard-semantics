require "../../syntax/jcard-syntax.k"

module REGISTER-METHOD-SEMANTICS
	imports JCARD-SYNTAX


/*@
\section {Register method}
    In order for a installation to be considered successful, the "register" method of the applet needs to be performed. Typically, an applet will have an install method which will call the constructor of the applet.
    Inside the constructor, a number of other initializations can be made, but also the register method is called. The main task of the register method is to assign a unique AID to the new applet object being created and store the information in the internal applets table. Our definition respects the specification. When the current computational instruction is represented by the "register" method of an applet, the 
    map inside the "tableApplets" cell is updated with the pair entry  (number of the applet, value specific for the applet). The value specific for the applet is a construction of form aid(AppletName, Rid, Pix, state). The first three parameters of the construction are self explanatory : the name of the applet, the associated AID ( formed from the Rid and Pix part). The last element "state" indicates whether in the current session with  the card acceptance device, the applet is selected or not for interactions. There are certain rules that the Java Card technology imposes on applets state and how they can be used for interactions. The rules are better presented and more detailed in the "Command Processor" section.  
*/

    /* ************************************************************************************ */
    /*  During register the applet gets associated with an AID and placed in the            */
    /*  internal applets table                                                              */ 
    /* ************************************************************************************ */
    rule <k> X:Id(_:Exps) => null ...</k>
        <crntObj> 
            <crntClass> appletInfo(Class,R,Px) </crntClass>
            ...
        </crntObj>
        <className> 
            Class
        </className>
        <classRid>
          R
        </classRid>
        <classPix>
          P
        </classPix>
        <extends>
          Applet
        </extends>
        <tableApplets> ... . => L |-> aid(Class,R,Px,"inactive") ...</tableApplets>
        <initApplets> L => L +Int 1 </initApplets>
        when Id2String(X) ==String "register"
        

endmodule