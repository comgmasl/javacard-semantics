require "../syntax/jcard-syntax.k"

module SUPER-CONSTRUCTOR-INVOKING-SEMANTICS
	imports JCARD-SYNTAX
	
	rule <k> (super => SuperClass)(_:Exps)... </k>
       <crntObj>
          <crntClass>
            appletInfo(Class:Id, Rid:Int, Pix:Int)
          </crntClass>
          ...
       </crntObj>
       <className>
          Class
       </className>
       <classRid>
          Rid
       </classRid>
       <classPix>
          Pix
       </classPix>
       <extends>
          SuperClass:Id
       </extends>

endmodule