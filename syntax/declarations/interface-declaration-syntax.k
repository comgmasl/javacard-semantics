require "../modifiers-syntax.k"
require "../exp-syntax.k"
require "../statement-syntax.k"

module INTERFACE-DECLARATION-SYNTAX
	imports MODIFIERS-SYNTAX
	imports EXP-SYNTAX
	imports STATEMENT-SYNTAX

	syntax Decl ::= Modifier "interface" Id Block
	              | Modifier "interface" Id "extends" Exps Block
	              | "interface" Id Block
	              | "interface" Id "extends" Exps Block

    rule interface X Bl:Block => public interface X Bl
    rule interface X extends Es Bl => public interface X extends Es Bl

endmodule