require "../syntax/jcard-syntax.k"

module IMPLEMENTS-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section{Processing implementations}
  Java Card technology enables the multiple implementation of interfaces. To support this feature and impose
  correctness, each class that implements interfaces should be aware of this fact. In our definition awareness arises from storing each interface identifier into a special cell of the "class" cell, more exactly the "implements" cell. The rule for processing implementations takes as arguments the list of the interfaces names and also the information regarding the class implementing this list (class name, aid format). An iteration is performed on the list of interfaces, at each step the first element of the list is extracted and stored into the appropiate "implements" cell of the class at hand.
*/

	/* ************************************************************************************************ */
	/*			  Processing each implement at a time by adding the implement to the list                   */
	/* ************************************************************************************************ */
	rule <k> 'processImplements [E1:Exp, Es:Exps, Class:Id, Rid:Int, Pix:Int] => 'processImplements[Es, Class, Rid, Pix] ...</k>
        <class>
          ...
          <className>
            Class
          </className>
          <classRid>
            Rid
          </classRid>
          <classPix>
            Pix
          </classPix>
          <implements>
            ... . => ListItem(E1) ...
          </implements>
          ...
        </class>        

  rule <k> 'processImplements [.Exps, Class:Id, Rid:Int, Pix:Int] => . ...</k>

endmodule