require "../syntax/jcard-syntax.k"

module EXP-SEMANTICS
	imports JCARD-SYNTAX

/*@
\section {Exp-Semantics}

*/

	context ++(HOLE => lvalue(HOLE))
  	rule <k> ++loc(L) => I +Int 1 ...</k>
       	<store>... L |-> (I:Int => I +Int 1) ...</store>  
       	<parsing> false </parsing>[increment]

  context (HOLE => lvalue(HOLE))++
  rule <k> loc(L)++ => I ...</k>
       <store> ... L |-> (I:Int => I +Int 1) ...</store>
       <parsing> false </parsing> [incrementPost]

  context --(HOLE => lvalue(HOLE))
    rule <k> --loc(L) => I -Int 1 ...</k>
        <store>... L |-> (I:Int => I -Int 1) ...</store>  
        <parsing> false </parsing>[decrement]

  context (HOLE => lvalue(HOLE))--
  rule <k> loc(L)-- => I ...</k>
       <store> ... L |-> (I:Int => I -Int 1) ...</store>
       <parsing> false </parsing> [decrementPost]

 	rule I1:Int + I2:Int => I1 +Int I2
  rule Str1:String + Str2:String => Str1 +String Str2
  rule I1:Int - I2:Int => I1 -Int I2
  rule I1:Int * I2:Int => I1 *Int I2
  rule I1:Int / I2:Int => I1 /Int I2 when I2 =/=K 0
  rule I1:Int % I2:Int => I1 %Int I2 when I2 =/=K 0
  //rule - I:Int => 0 -Int I
  rule I1:Int < I2:Int => I1 <Int I2
  rule I1:Int <= I2:Int => I1 <=Int I2
  rule I1:Int > I2:Int => I1 >Int I2
  rule I1:Int >= I2:Int => I1 >=Int I2
  rule V1:Val == V2:Val => V1 ==K V2
  rule V1:Val != V2:Val => V1 =/=K V2
  rule ! T:Bool => notBool(T)
  rule true  && E => E
  rule false && _ => false
  rule true  || _ => true
  rule false || E => E

  rule I1:Int & I2:Int => I1 &Int I2
  rule I1:Int | I2:Int => I1 |Int I2
  rule I1:Int ^ I2:Int => I1 xorInt I2
  rule I1:Int >> I2:Int => I1 >>Int I2
  rule I1:Int << I2:Int => I1 <<Int I2

endmodule