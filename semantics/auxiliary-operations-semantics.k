require "../syntax/jcard-syntax.k"

module AUXILIARY-OPERATIONS-SEMANTICS
	imports JCARD-SYNTAX

  /* ************************************************************************************ */
  /*  Bind the parameters of the method to the values given at method invocation          */
  /* ************************************************************************************ */
	rule mkDecls((T:Type X:Id, Ps:Params), (V:Val, Vs:Vals))
    => T X=V; mkDecls(Ps,Vs)
  rule mkDecls(.Params,.Vals) => {}




  /* ************************************************************************************ */
  /*  Rule to reset the environment (used for example when a block is executed)           */
  /*  the environment before the block is saved and after the block it is restored        */
  /* ************************************************************************************ */
  rule <k> env(Env) => . ...</k>  <env> _ => Env </env>  [structural]
  rule (env(_) => .) ~> env(_)  [structural]



  /* ************************************************************************************ */
  /*  If the id is on the left side of an expression (e.g. a = 5) then we need to return  */
  /*  the location of that variable not the actual value                                  */
  /* ************************************************************************************ */




  /* For the case of an array element (eg a[b]) */
  context lvalue(_::Exp[HOLE::Exps])
  context lvalue(HOLE::Exp[_::Exps])

  rule lvalue(lookup(L:Int) => loc(L))  [structural]

  //syntax Type ::= Type "<" Vals ">"  [function]
  //rule T:Type<_,Vs:Vals> => T[]<Vs>
  //rule T:Type<.Vals> => T


  /* ************************************************************************************ */
  /*                     Auxiliary function which helps array instantiation               */
  /* ************************************************************************************ */
  //syntax Map ::= Int "..." Int "|->" K
    //[function, latex({#1}\ldots{#2}\mapsto{#3})]
  rule N...M |-> _ => .Map  when N >Int M
  rule N...M |-> K => N |-> K (N +Int 1)...M |-> K  when N <=Int M




  /* ************************************************************************************ */
  /*                Auxiliary function which returns the type of the parameters           */
  /* ************************************************************************************ */
  rule getTypes(T:Type _:Id) => T, .Types
  rule getTypes(T:Type _:Id, P, Ps) => T, getTypes(P,Ps)
  rule getTypes(.Params) => void, .Types

endmodule