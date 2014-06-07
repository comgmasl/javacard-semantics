require "../syntax/jcard-syntax.k"

module LOOKUPMEMBER-SEMANTICS
	imports JCARD-SYNTAX
	
/*@
\section{Lookup member}
 Inheritance is an available feature, so each object must contain information about the class it extends of the interfaces it implements. Creating a new object implies a number of operations such as creating the super object. These operations are more comprehensively discussed in the "new" section. The important aspect to have in mind is that an object is aware and has access to fields and methods of the super class due to the
 "envStack" cell. Whenever a member or method of an object is accessed/called the list stored in the "envStack" is searched item by item to find the location of the specified member/method. When the member/method is found it is replaced with a construction that contains its store location "lookup(L)".	
*/	
	
	rule lookupMember(<envStack> ListItem((_, <env>... X |-> L ...</env>))
                    ...</envStack>, X) => lookup(L) 

  	rule lookupMember(<envStack> ListItem((_, <env> Env </env>)) => .
                    ...</envStack>, X)  when notBool(X in keys(Env)) 

    rule <k> lookupMember(<envStack> . </envStack>, X) => staticAccessing(X) ... </k>
         <className>
         	X
         </className>

endmodule