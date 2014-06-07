require "../syntax/jcard-syntax.k"

module SUBTYPE-CHECKING-SEMANTICS
	imports JCARD-SYNTAX

	rule subtype(T:Type, T) => true  [structural]

  //recursive manner of testing if a class represent a subclass of another class
  rule <k> subtype(C1:Id, C:Id) => subtype(C2, C) ...</k>
       <className> C1 </className>
       <extends> C2:Id </extends>
    when C1 =/=K C  [structural]

  rule subtype(Object,Class) => false
    when Class =/=K Object  [structural]

  // test the type of two functions
  rule subtype(Ts1->T2,Ts1'->T2') => subtype(((T2)::Type,Ts1'),((T2')::Type,Ts1))  [structural]

  // recursive function to test that two list of types are compatible
  rule subtype((T:Type,Ts),(T':Type,Ts')) => subtype(T,T') && subtype(Ts,Ts')
    when Ts =/=K .Types  [structural]
  rule subtype(.Types,.Types) => true  [structural]


  rule subtype(int, byte) => true
  rule subtype(byte, int) => true
  rule subtype(int, short) => true
  rule subtype(short, int) => true

endmodule