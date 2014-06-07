require "../io/write-output.k"
require "../../syntax/jcard-syntax.k"
require "../../semantics/jcard-semantics.k"

module RESPONSE-HANDLER
	imports WRITE-OUTPUT
  imports JCARD-SYNTAX
  imports JCARD-SEMANTICS

	syntax Stmts ::= "'response"
	syntax Val ::= "'sendingResponse"
  syntax Stmts ::= "'setDataResponse" "[" Exp "]" ";" [strict]

	rule <k> 'response => print("\n"); ~> print("\n"); ~> print("Response:"); ~> print(Response); ~> print("SW1:"); ~> print(SW); ~> print("SW2:"); ~> print(SW2); ~> 'sendingResponse ...</k>
        <response>
          <datalength> _:Int </datalength>
          <dataResponse> Response:String => "" </dataResponse>
          <sw1> SW:String => "90" </sw1>
          <sw2> SW2:String => "00"</sw2>
        </response>


  rule <k> 'setDataResponse[Response:Int]; => . ...</k>
       <response>
        ...
          <dataResponse> ReceivedResponse:String => ReceivedResponse +String Int2String(Response) ...</dataResponse>
        ...
       </response>

endmodule