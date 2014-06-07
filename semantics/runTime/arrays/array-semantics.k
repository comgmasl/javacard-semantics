require "../../../syntax/jcard-syntax.k"

module ARRAY-SEMANTICS
	imports JCARD-SYNTAX

	rule <k> new T:Type [N:Int] => array (T, L +Int 1, N) ...</k>
       <store>... . => L |-> array(T, L +Int 1, N)
                       (L +Int 1)...(L +Int N) |-> undefined(T) ...</store>
       <nextLoc> L:Int => L +Int 1 +Int N </nextLoc>
      	when N >=Int 0

  rule array(_:Type, L:Int, M:Int)[N:Int] => lookup(L +Int N)
     when N >=Int 0 andBool N <Int M  [structural, anywhere]

  
  rule sizeOf(array(_,_,N)) => N

endmodule