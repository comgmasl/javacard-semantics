require "package-syntax.k"
require "/declarations/declarations-syntax.k"

module STATEMENT-SYNTAX
	imports PACKAGE-SYNTAX
	imports DECLARATIONS-SYNTAX

	syntax Block ::= "{" "}"
                  | "{" Stmts "}"

  syntax Stmt ::= Decl | Block | PackageHandling
                | Exp ";"                               	  [strict]
                | "return" Exp ";"                      	  [strict]
                | "return" ";"
                | "try" Block "catch" "(" Param ")" Block
                | "throw" Exp ";"                       	  [strict]

  syntax Stmts ::= Stmt
                 | Stmts Stmts                          	[right]


  syntax Stmt ::=  "if" "("Exp")" Stmt "else" Stmt     	[strict(1)]     
                | "if" "("Exp")"  Stmt                 	[strict(1)]    
                | "while" "("Exp")" Stmt                 
                | "do" Stmt "while""("Exp")"";"        
                | "for" "(" Stmt Exp ";" Exp ")" Stmt   
                | "finally"  Stmt
                | "switch" "("Exp")" "{" CaseStmts "default" ":" Stmt "}" 
                | "switch" "("Exp")" "{" "case" Exp ":" Exp ";"  "}"
                | "continue"";"
                | "break"";"  

  syntax CaseStmt ::= "case" Exp ":" Exp ";"    
 	syntax CaseStmts ::= CaseStmt "break;"
                     | CaseStmt "break;" CaseStmts  
  

  // STATEMENT MACROS                    
  
  rule if (E1:Exp) S:Stmt => if (E1) S else {}
  
  rule switch(E1:Exp) { case E2:Exp : E3:Exp; break; Cs:CaseStmts default : S:Stmt} => switch(E1) {case E2 : E3;} switch(E1) {Cs default: S} 
  
  rule do S:Stmt while(E1:Exp); => S while (E1) S
  
 	rule for (X:Id = E1:Exp; E2:Exp; E3:Exp) S:Stmt => { X = E1; while(E2) { S E3;}}
  
  rule for (T:Type X:Id = E1:Exp; E2:Exp; E3:Exp) S:Stmt =>  { private nonfinal nonstatic T X; X =E1; while(E2) { S E3;}}

  rule if (E) S => if (E) S else {}                                     
  rule for(Start Cond; Step) {S:Stmts} => {Start while(Cond){S Step;}}  

endmodule