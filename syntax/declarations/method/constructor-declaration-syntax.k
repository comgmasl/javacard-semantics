require "general-method-declaration-syntax.k"

module CONSTRUCTOR-DECLARATION-SYNTAX
	imports GENERAL-METHOD-DECLARATION-SYNTAX

	syntax ConstructorDecl ::= Id "(" Params ")" Block
  				  			 | Modifier Id "(" Params ")" Block  
  				  			 | Modifier Id "(" Params ")" "throws" Types Block      

  	// CONSTRUCTORS - MACRO
  	rule X:Id (Ps) Bl:Block => public nonfinal nonstatic void X (Ps) Bl 
  	rule M:Modifier X (Ps:Params) Bl:Block => M nonfinal nonstatic void X (Ps) Bl
  	rule M X (Ps) throws Ts Bl => M nonfinal nonstatic void X(Ps) throws Ts Bl  

endmodule