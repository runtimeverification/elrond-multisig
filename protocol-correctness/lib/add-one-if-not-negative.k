module ADD-ONE-IF-NOT-NEGATIVE-SYNTAX
  imports INT
  
  syntax Int ::= addOneIfNotNegative(Int)  [function, functional, smtlib(addOneIfNotNegative)]

endmodule

module ADD-ONE-IF-NOT-NEGATIVE
  imports ADD-ONE-IF-NOT-NEGATIVE-SYNTAX

  rule addOneIfNotNegative(X:Int) => X +Int 1
    requires X >=Int 0
  rule addOneIfNotNegative(X) => X
    requires X <Int 0

endmodule