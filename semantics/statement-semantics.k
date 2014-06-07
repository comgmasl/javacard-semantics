require "../syntax/jcard-syntax.k"
require "../JCRE/io/write-output.k"

module STATEMENT-SEMANTICS
	imports JCARD-SYNTAX
	imports WRITE-OUTPUT
/*@
\section{Blocks}
  Blocks inside a context have knowledge of the outter environment, but also present additional environment properties of their own according to the instruction codes it contains. Once the block has finished execution the variables declared inside the block are discarded and the environment prior to the block is restored. 
*/
	rule {} => .  [structural]
  rule <k> { S } => S ~> env(Env) ...</k>  <env> Env </env>  [structural]

/*@
\section{Sequential execution}
  Statement are translated into computational steps.
*/
  rule S1:Stmts S2:Stmts => S1 ~> S2  [structural]


  rule V:Val; => .  

  rule if (true) S else _ => S
  rule if (false) _ else S => S


  rule while (E) S => if (E) {S while(E)S}  [structural]

  rule <k> switch (E1:Exp) { case E2:Exp : E3:Exp ; break; default : S:Stmt }  => if ( E1 == E2) E3; else {S} ...</k>
    <parsing> false </parsing>

  rule <k> switch (E1:Exp) { case E2:Exp : E3:Exp; } => if (E1 == E2) { E3; return;} else {} ...</k>
     	<parsing> false </parsing> 


  rule <k> print(V:Val, Es => Es); ...</k> <out>... . => ListItem(V) </out> <parsing> false </parsing>
    	when typeOf(V) ==K int orBool typeOf(V) ==K string  [print]

  rule <k> print(Es); => . ...</k> <parsing> true </parsing>
  rule print(.Vals); => .  [structural]


endmodule