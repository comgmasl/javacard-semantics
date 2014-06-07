require "../syntax/jcard-syntax.k"


module PACKAGE-SEMANTICS
	imports JCARD-SYNTAX

/*@
  \section{Packages}
  Package handling is accomplished during the parsing phase of the execution. There are two 
  main points of interests when the issue of packages is at hand. The first matter focuses on
  the process of importing packages. The effect of encountering an "import package" is that a
  new list item containing the identification of the package will be added to the configuration
  "<importing>" cell. Imported packeges are retained in this manner to guarantee a degree of control
  of the future execution.
  The second aspect revolving around packages is the declaration of a package. The Java Card technology 
  has a different package treatment procedure than the Java tecknology. In Java the package is identified by a string name. However, in Java Card, a package has an associated AID which permits  unique identification of the package. 
  In our definition of Java Card, the procedure applied when a package declaration is found is as follows. Firstly, then "package" cell of the configuration is searched. This cell represents a list which holds all the packages found so far in the program in a [package name - AID] format. This initial search is motivated by the limitations which arise when dealing with multiple packages. In order to have a successful execution of the entirety of the program, which may consists of multiple classes in a number of packages, a conjunction of all the involved files is performed. After the files are merged, the probability of having to process the same package declaration is extremely high.
  Taking into consideration the fact that the RID of the package dictates the RID of the classes inside that package and that we have to ensure consistency of this matter in order to guarantee the correctness of our definition, the initial search of the "package" cell is supported by solid reasonings. In order to generate unique AID, two new cell of the configuration where introduced : "rid" cell and "pix" cell, which act similarly to global variables. On the one hand, if the searched of the currently processed package inside the packages list is successful, the "rid" cell value is reset to the current package associated RID. This action secures consistency related to assigned AID for applets and packages (recall that applets share the RID of the package to which they belong).
  On the other hand, if the package is not discovered among the "packages" list, then this signifies that it is a new package. Handling a new package implies assigning a new AID and introducing the all the information neccessary in the configuration cell.
*/

	rule <k> import P:Package; => . ... </k>
     	<importing> ... . => ListItem(P) ... </importing>

  /* ************************************************************************************** */
  /*  First check if the package already exists                                             */ 
  /* ************************************************************************************** */ 
  rule <k> package E:Exp; => . ...</k>
       <package> ... ListItem(aid(E,L1:Int,0)) ... </package>
       <rid> _ => L1 </rid>

  /* ************************************************************************************** */
  /*  Associates a new AID[=RID+PIX] to a package                                           */ 
  /* ************************************************************************************** */  
  rule <k> package E:Exp; => . ... </k>
      <package> ... . => ListItem(aid(E, L1 +Int L2, 0)) ... </package>
      <rid> L1 => L1 +Int L2 </rid>
      <pix> L2 => 1 </pix>
        when L2 <Int 10000000000

endmodule