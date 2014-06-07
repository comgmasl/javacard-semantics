module EXP-SYNTAX

	syntax Exp ::= Int | Bool | String | Id | Hexa 
               | "this"                                 
               | "super"                                
               | "(" Exp ")"              [bracket]
               | "++" Exp 				        [strict, prefinc]
               | "--" Exp 				        [strict, prefdec]
               | Exp "++" 				        [strict, postinc]
               | Exp "--" 				        [strict, postdec]
               | Exp "instanceOf" Id      [strict(1)]    
               | "(" Id ")" Exp           [strict(2), cast] 
               | "new" Id "(" Exps ")"    [strict(2)]  
               | Exp "." Id               [objMember]              
               > Exp "[" Exps "]"         [strict]
               > Exp "(" Exps ")"         [strict(2), funcall]    
               | "sizeOf" "(" Exp ")"     [strict]
               | "read" "(" ")"
               > left:
                Exp "*" Exp               [strict, left]
               | Exp "/" Exp              [strict, left]
               | Exp "%" Exp              [strict, left]
               > left:
                Exp "+" Exp               [strict, left]
               | Exp "-" Exp              [strict, left]
               | Exp "&" Exp              [strict, left]       
               | Exp "|" Exp              [strict, left]
               | Exp "^" Exp              [strict, left]
               | Exp ">>" Exp             [strict, left]
               | Exp "<<" Exp             [strict, left]
               > non-assoc:
                Exp "<" Exp               [strict, non-assoc]
               | Exp "<=" Exp             [strict, non-assoc]
               | Exp ">" Exp              [strict, non-assoc]
               | Exp ">=" Exp             [strict, non-assoc]
               | Exp "==" Exp             [strict, non-assoc]
               | Exp "!=" Exp             [strict, non-assoc]
               > "!" Exp                  [strict]
               > left:
                Exp "&&" Exp              [strict(1), left]
               | Exp "||" Exp             [strict(1), left]
               > Exp "=" Exp              [strict(2), right]
               | "~" Exp               
               > Exp "+=" Exp 			      [right, strict, compoundPlus]
               | Exp "-=" Exp 			      [right, strict, compoundMinus]
               | Exp "*=" Exp 			      [right, strict, compoundMultiply]
               | Exp "/=" Exp 			      [right, strict, compoundDivide]

  syntax Exps ::= List{Exp,","}           [strict]

  syntax Exp ::= "("Type")" Exp           [strict(2), conversion] 
              	| "new" Type "[" Exp "]"  [strict(2), new]  
              	| Exp "=" "{" Exps "}"

  rule (T:Type) E:Exp (Es:Exps) => (T) (E(Es))

  rule H:Hexa => HexStringToInt(Hexa2String(H))

  syntax priority objMember > conversion 

    //?maybe some more ... will see

endmodule