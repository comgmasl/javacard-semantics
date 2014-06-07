require "../syntax/jcard-syntax.k"

module TYPED-EXCEPTION-SEMANTICS
	imports JCARD-SYNTAX

	rule <k> (try S1 catch(P) S2 => S1 ~> popx) ~> K </k>
       	<control>
         <xstack> . => ListItem((P, S2, K, Env, C)) ...</xstack>
         C
       	</control>
       	<env> Env </env>

  	rule <k> popx => . ...</k>
       	<xstack> _:ListItem => . ...</xstack>

  	rule <k> throw V:Val; ~> _
        	=> if (subtype(typeOf(V),T)) { T X = V; S2 } else { throw V; } ~> K
       	</k>
       	<control>
         <xstack> ListItem((T:Type X:Id, S2, K, Env, C)) => . ...</xstack>
         (_ => C)
       	</control>
       	<env> _ => Env </env>

    rule <k> finally St:Stmt => St ...</k>

endmodule