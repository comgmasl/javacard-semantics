require "../syntax/jcard-syntax.k"

module TYPEOF-SEMANTICS
	imports JCARD-SYNTAX


  /* ************************************************************************************ */
  /*                Auxiliary function which return the type of a variable                */
  /* ************************************************************************************ */
  rule typeOf(_:Int) => int
  rule typeOf(_:Bool) => boolean
  rule typeOf(_:String) => string
  rule typeOf(array(T,_,_)) => (T[])
  rule typeOf(undefined(T)) => T
  rule typeOf(nothing(T)) => T

	rule typeOf(objectClosure(_ <crntClass> appletInfo(C,_,_) </crntClass>)) => C
  	rule typeOf(methodClosure(T:Type,_,_,Ps:Params,_,_,_,_)) => T

  	
endmodule