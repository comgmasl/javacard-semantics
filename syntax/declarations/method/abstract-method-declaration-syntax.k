require "general-method-declaration-syntax.k"

module ABSTRACT-METHOD-DECLARATION-SYNTAX
	imports GENERAL-METHOD-DECLARATION-SYNTAX

	syntax AbstracFctDecl ::= "abstract" Type Id"(" Params ")" ";" 
		          			| Modifier "abstract" Type Id"("Params")" ";" 
		          			| "abstract" Type Id"(" Params ")" "throws" Types ";" 
		          			| Modifier "abstract" Type Id"("Params")" "throws" Types ";"

	// ABSTRACT FUNCTION MACROS
	rule abstract T X(Ps); => public nonfinal nonstatic T X(Ps){} 
  	rule M abstract T X(Ps); => M nonfinal nonstatic T X(Ps){} 
  	rule abstract T X(Ps) throws Ts:Types; => public nonfinal nonstatic T X(Ps) throws Ts{} 
  	rule M abstract T X(Ps) throws Ts; => M nonfinal nonstatic T X(Ps) throws Ts {} 


endmodule