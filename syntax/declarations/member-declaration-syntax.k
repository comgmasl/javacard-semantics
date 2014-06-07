require "../modifiers-syntax.k"
require "../exp-syntax.k"
require "../types-syntax.k"
require "../statement-syntax.k"

module MEMBER-DECLARATION-SYNTAX
	imports MODIFIERS-SYNTAX
	imports EXP-SYNTAX
	imports TYPES-SYNTAX
	imports STATEMENT-SYNTAX

	syntax Decl ::= Type Exps ";" [avoid]
				        | "static" Type Exps ";"
            	  | "final" Type Exps ";"
            	  | Final "static" Type Exps ";"
            	  | Static "final" Type Exps ";"
            	  | Modifier Type Exps ";"
	              | Modifier Final Static Type Exps ";"
	              | Modifier "final" Type Exps ";"
	              | Modifier "static" Type Exps ";"
	              | Modifier "static" "final" Type Exps ";"
	              | "var" Modifier Final Static Type Id ";"

  	rule T:Type Es:Exps; => default nonfinal nonstatic T Es;

  	rule static T Es; => default nonfinal static T Es;
  	rule final T Es; => default final nonstatic T Es;

  	rule Fi:Final static T Es; => default Fi static T Es;
  	rule St:Static final T Es; => default final St T Es;

  	rule M:Modifier T Es; => M nonfinal nonstatic T Es;

  	rule M final T Es; => M final nonstatic T Es;
  	rule M:Modifier static T Es; => M nonfinal static T Es;

  	rule M:Modifier static final T Es; => M final static T Es;

  	rule M:Modifier Fi St T E1:Exp, Es:Exp; => M Fi St T E1; M Fi St T Es;

	  rule M:Modifier Fi St T X:Id, .Exps; => var M Fi St T X;

  	rule M:Modifier Fi St T X:Id = E1; => var M Fi St T X; X = E1;


endmodule