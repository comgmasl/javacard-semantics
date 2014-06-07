require "../../../../syntax/jcard-syntax.k"

module RUNTIME-STATIC-METHOD-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX

  /*--------------------------------------AT RUNTIME---------------------------------------------------*/
  rule <k> M:Modifier Fi:Final St:Static T:Type F:Id (Ps:Params) S => . ...</k>
    	<parsing> false </parsing>
    	when St ==K static

  rule <k> M:Modifier Fi:Final St:Static T:Type F:Id (Ps:Params) throws EsT:Types S => . ...</k>
    	<parsing> false </parsing>
    	when St ==K static

endmodule