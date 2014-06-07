require "exp-syntax.k"

module PACKAGE-SYNTAX
	imports EXP-SYNTAX

	syntax Package ::= Exp	
					 | Exp "." "*"	  

	syntax PackageHandling ::= "import" Package ";"
                        	 | "package" Exp ";"

endmodule