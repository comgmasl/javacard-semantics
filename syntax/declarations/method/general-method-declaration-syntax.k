require "../../types-syntax.k"
require "../../modifiers-syntax.k"
require "../../statement-syntax.k"

module GENERAL-METHOD-DECLARATION-SYNTAX
	imports TYPES-SYNTAX
	imports MODIFIERS-SYNTAX
	imports STATEMENT-SYNTAX


	syntax Param  ::= Type Id [param]
  	syntax Params ::= List{Param,","}


	syntax FunctionDecl ::=  Type Id "(" Params ")" Block
						  | Modifier Type Id "(" Params ")" Block 
		          		  | Modifier Static Type Id  "(" Params ")" Block
		          		  | Modifier "final" Type Id "(" Params ")" Block
		             	  | Modifier Static "final" Type Id "(" Params ")" Block
		                  | Modifier Final Static Type Id "(" Params ")" Block
		                  // ------------------------------------------------------
		                  // EXCEPTIONS
		                  //------------------------------------------------------
		                  | Type Id "(" Params ")" "throws" Types Block 
						  | Modifier Type Id "(" Params ")" "throws" Types Block 
		          		  | Modifier Static Type Id  "(" Params ")" "throws" Types Block  
		          		  | Modifier "final" Type Id "(" Params ")" "throws" Types Block
		          		  | Modifier Static "final" Type Id "(" Params ")" "throws" Types Block
		          		  | Modifier Final Static Type Id "(" Params ")" "throws" Types Block

	rule T:Type X:Id (Ps) Bl:Block => default nonfinal nonstatic T X(Ps) Bl

	rule T:Type X:Id (Ps) throws Ts:Types Bl => default nonfinal nonstatic T X(Ps) throws Ts Bl
           
  	rule M T X (Ps:Params) Bl => M nonfinal nonstatic T X (Ps) Bl
  	rule M static T X:Id(Ps) Bl => M nonfinal static T X(Ps) Bl
  	rule M final T X:Id(Ps) Bl => M final nonstatic T X(Ps) Bl
  	rule M static final T X (Ps) Bl => M final static T X(Ps) Bl
	rule M final static T X (Ps) Bl => M final static T X(Ps) Bl       

	rule M T X (Ps) throws Ts Bl => M nonfinal nonstatic T X(Ps) throws Ts Bl
	rule M static T X (Ps) throws Ts Bl => M nonfinal static T X(Ps) throws Ts Bl
	rule M final T X (Ps) throws Ts Bl => M final nonstatic T X(Ps) throws Ts Bl
	rule M final static T X (Ps) throws Ts Bl => M final static T X(Ps) throws Ts Bl
  	rule M static final T X (Ps) throws Ts Bl => M final static T X(Ps) throws Ts Bl

endmodule
