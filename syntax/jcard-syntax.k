require "statement-syntax.k"
require "predefined-id-syntax.k"
require "../JCRE/io/write-output.k"
require "../JCRE/commandProcessor/command-processor.k"

module JCARD-SYNTAX
	imports STATEMENT-SYNTAX
	imports PREDEFINED-ID-SYNTAX
  imports WRITE-OUTPUT
  imports COMMAND-PROCESSOR

	syntax Val ::= Int | Bool | String 
               | array(Type,Int,Int)

  	syntax Vals ::= List{Val,","}
  	syntax Exp ::= Val
  	syntax KResult ::= Val

    syntax Val ::= "staticAccessing" "(" Id ")"

  	syntax K ::= undefined(Type)  [latex(\bot_{#1})]

  	syntax Val ::= nothing(Type)


  	syntax Decl ::= mkDecls(Params,Vals)  [function]


  	syntax K ::= lookup(Int)
  	syntax K ::= "lookupAndReceiveBytes" "(" Int ")"

  	syntax K ::= env(Map)


  	syntax Exp ::= lvalue(K)
  	syntax Val ::= loc(Int)
               | "loc" "(" "parse" ")"

    syntax Type ::= Type "<" Vals ">"  [function]

    syntax Map ::= Int "..." Int "|->" K
    [function, latex({#1}\ldots{#2}\mapsto{#3})]

    syntax Type ::= typeOf(K)  [function]

    syntax Types ::= getTypes(Params)  [function]


    syntax Val ::= objectClosure(CrntObjCellFragment)
                | methodClosure(Type,AppletInfo,Int,Params,Stmt,Modifier,Final,Static)

    syntax K ::=  (Map,K,ControlCellFragment)

    syntax K ::= (Param,Stmt,K,Map,ControlCellFragment)
  	syntax K ::= "popx"

  	syntax Val ::= "null"

    syntax Exp ::= "testing"

  	syntax Stmts ::= "'processImplements" "[" Exps ","  Id "," Int "," Int "]"

  	syntax Stmts ::= "getIns"

  	//syntax K ::= (Id,EnvCellSort)

    syntax K ::= (AppletInfo,EnvCellSort)

    syntax K ::= lookupMember(EnvStackCellSort,Id)  [function]

    syntax Val ::=  "aid" "(" Exp "," Int "," Int ")"


    syntax Val ::= "aid" "(" Exp "," Int "," Int "," String ")"

    syntax Val ::= AppletInfo

    syntax AppletInfo ::= "appletInfo" "(" Id "," Int "," Int ")"

    syntax Val ::= "installFunction" "(" Block "," Id "," Int "," Int ")"

    syntax K ::= "true?"

    syntax Exp ::= subtype(Types,Types)

    syntax Val ::= unsafeCast(Val,Type)  [function]

endmodule