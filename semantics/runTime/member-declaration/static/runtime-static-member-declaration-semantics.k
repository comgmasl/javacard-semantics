require "../../../../syntax/jcard-syntax.k"

module RUNTIME-STATIC-MEMBER-DECLARATION-SEMANTICS
	imports JCARD-SYNTAX

  rule <k> var M:Modifier Fi:Final St:Static T:Type X:Id; => . ...</k>
      <parsing> false </parsing>
      when St ==K static

  rule <k> M:Modifier Fi:Final St:Static T:Type X:Id[N:Int]; => . ...</k>
      <parsing> false </parsing>
      when St ==K static

endmodule