require "../syntax/jcard-syntax.k"

module UNSAFE-CASTING-SEMANTICS
	imports JCARD-SYNTAX
	
	rule unsafeCast(objectClosure(<crntClass>appletInfo(Class:Id, Rid:Int, Pix:Int)</crntClass> Obj), C:Id)
    => objectClosure(<crntClass> appletInfo(Class:Id, Rid:Int, Pix:Int) </crntClass> Obj)

  rule unsafeCast(methodClosure(T',C,OL,Ps,S,M,Fi,St), T) => methodClosure(T,C,OL,Ps,S,M,Fi,St)

  rule unsafeCast(V:Val, T:Type) => V  when typeOf(V) ==K T
  
  rule unsafeCast(V:Val, byte) => V when typeOf(V) ==K int
  rule unsafeCast(V:Val, short) => V when typeOf(V) ==K int

endmodule