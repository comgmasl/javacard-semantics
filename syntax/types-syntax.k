module TYPES-SYNTAX

	syntax Type ::= "void" | "int" | "bool" | "byte" | "short" 
				  | "boolean" 
				  | "string"
                  | Id                              
                  | Type "[" "]"
                  > Types "->" Type
                  | "(" Type ")"           [bracket]

  	syntax Types ::= List{Type,","}  
  	
endmodule