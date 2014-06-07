require "../../../../syntax/jcard-syntax.k"

module COMPILE-NONSTATIC-LVALUE-SEMANTICS
  imports JCARD-SYNTAX

/*@
\section{Parsing phase}
  Due to the fact that an initial value can be providen for a field in its declaration and also because of the way such a construction is handled by our definition, unwanted computational instruction arise. Such is the case of the next two rules, which have been introduce to discard the operation of initializing an
  attribute that is not static while the parsing phase is being carried out.
*/

  rule <k> lvalue(X) ~> K1:K => loc(parse)...</k>
      <crntApplet>
        appletInfo(Class:Id, Rid:Int, Pix:Int)
      </crntApplet>
      <className> 
        Class
      </className>
      <classRid>
        Rid
      </classRid>
      <classPix>
        Pix
      </classPix>
      <staticEnv> StEnv:Map </staticEnv> 
      <parsing> true </parsing>  
      when notBool(X in keys(StEnv))        

  rule <k> loc(parse) = V ~> K1:K ~> K2:K => K2  ... </k>
      <parsing> true </parsing>

endmodule