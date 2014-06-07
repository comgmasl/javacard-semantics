require "../../../../syntax/jcard-syntax.k"

module COMPILE-NONSTATIC-MEMBER-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX

/*@
  \Section(Parsing phase)
  During the parsing phase the packages and applets are assigned AID, the class information is stored
  and the static environment of each class is gathered. Therefore, the declarations of members which do not present the static modifier are simply ignored during this phase.
*/

  /* ************************************************************************************************ */
  /*            While parsing the declarations of nonstatic members are ignored                       */
  /* ************************************************************************************************ */
  
  rule <k> var M:Modifier Fi:Final St:Static T:Type X:Id; => . ...</k>
      <parsing> true </parsing>
      when St =/=K static

  rule <k>M:Modifier Fi:Final St:Static T:Type X:Id[N:Int]; => . ...</k> 
      <parsing> true </parsing>
      when St =/=K static


endmodule