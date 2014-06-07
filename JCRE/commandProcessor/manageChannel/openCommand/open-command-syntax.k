module OPEN-COMMAND-SYNTAX

	syntax Stmts ::= "'checkOpenLogicalChannel" "[" Int "," Int "]"
	syntax Stmts ::= "'assignNewLogicalChannelNumber" "[" Int "]" //"," Int "]"
	syntax Stmts ::= "'openAssignedNewLogicalChannel" "[" Int "," Int "]" // when P2 = 0
	syntax Stmts ::= "'openGivenNewLogicalChannel" "[" Int "," Int "]"	  // when P2 =/= 0
	syntax Stmts ::= "'determineAppletForNewChannel" "[" Int "," Int "]"
	syntax Stmts ::= "'verifyCandidateAppletFromOriginChannel" "[" Int  "," Int "]"

endmodule