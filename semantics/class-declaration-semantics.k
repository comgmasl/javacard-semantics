require "../syntax/jcard-syntax.k"
require "implements-semantics.k"


module CLASS-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX
	imports IMPLEMENTS-SEMANTICS
  
/*@
\section{Class Declaration}
  Class declarations are processed during the parsing phase of the execution. The processing
  involves gathering and retaining mandatory information about that specific class. Similarly to what was mentioned in the Package section, Java Card technology imposes a distinctive policy for identifying applets. Instead of using a string to recognize a certain class, in this context an AID is used. The AID format is more thoroughly presented in the AID section, but essentially the class and it's package must share the same RID. Furthermore, the PIX part must be chosen so as to maintain the uniqueness constraint of the AID. 
  Therefore, the rules matching the patterns of class declaration undertake the following operations:
    - create a new PIX which satisfies the mentioned uniqueness property
    - create a new "class" cell which holds multiple children cell such as : 
        - className
        - modifiers
        - superclassName
        - declarations
        - interfaces implemented "implements" cell
        - AID of the applet
        - initialize an empty static environment cell
    - update the "crntApplet" cell with the currently parsed class information 

    After the details concerning the class have been store, the current computation is change to be the declarations of the class. The reasoning behind this computational change is that the static environment of the class demands initialization, in order to access class properties without having to create an object of the class.    
*/


  /* ***************************************************************************************** */
  /* the class of an "applet" is searched to find the install method & process instructions	 */
  /* plus this classes are assigned an AID this depending on the package as well				 */
  /* ***************************************************************************************** */  

  rule <k> M:Modifier St:Static Fi:Final Ab:Abst class Class1:Id extends Class2:Id {Ss:Stmts} => Ss ...</k> 
      <classes>... 
        ( . =>  <class>
                 	<className> Class1 </className>
              	  <finalM> Fi </finalM>
             			<staticM> St </staticM>
              		<accesM> M </accesM>
              		<abstractM> Ab </abstractM>
                  <extends> Class2 </extends>
                  <declarations> Ss </declarations>
              		<instructions> . </instructions>
              		<noIns> 0 </noIns>
              		<classRid> L1 </classRid>
              		<classPix> L3 </classPix>
              		<implements> . </implements>
              		<staticEnv> . </staticEnv>            
            		</class>
        )
       	...</classes>  
      <rid> L1:Int </rid>
    	<pix> L3 => L3 +Int 1 </pix>
    	<parsing> true </parsing> 
    	<crntApplet> _ => appletInfo(Class1,L1,L3) </crntApplet> 
      		[structural]  
  

  /* ***************************************************************************************** */
  /* registers all the interfaces that were implemented by the class and then proceeds	 	     */
  /* with the same behaviour described at the rule above				 						                   */
  /* ***************************************************************************************** */
  rule <k> M:Modifier St:Static Fi:Final Ab:Abst class Class1:Id extends Class2:Id implements Es:Exps { Ss:Stmts} => 'processImplements[Es,Class1, L1, L3] ~>  Ss ...</k>
     	<classes>... 
        (. => <class>
                <className> Class1 </className>
				        <finalM>  Fi </finalM>
				        <staticM>  St </staticM>
				        <accesM>  M </accesM>
				        <abstractM>  Ab </abstractM>
				        <extends> Class2 </extends>
				        <declarations> Ss </declarations>
				        <instructions> . </instructions>
				        <noIns> 0 </noIns>
				        <classRid> L1 </classRid>
				        <classPix> L3 </classPix>
				        <implements> . </implements>
				        <staticEnv> . </staticEnv>
              </class>
        )
       	...</classes>  
      <rid> L1:Int </rid>
    	<pix> L3 => L3 +Int 1 </pix>
    	<parsing> true </parsing> 
    	<crntApplet> _ => appletInfo(Class1,L1,L3)</crntApplet>  
       		[structural]    		


endmodule
