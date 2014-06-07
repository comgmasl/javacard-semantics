require "abstract-method-declaration-syntax.k"
require "constructor-declaration-syntax.k"

module METHOD-DECLARATION-SYNTAX
	imports ABSTRACT-METHOD-DECLARATION-SYNTAX
	imports CONSTRUCTOR-DECLARATION-SYNTAX
	
	syntax Decl ::= FunctionDecl 
				  | ConstructorDecl
				  | AbstracFctDecl

endmodule