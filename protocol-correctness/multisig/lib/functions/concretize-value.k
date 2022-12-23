require "protocol-correctness/lib/functions/concretize-value.k"
require "protocol-correctness/multisig/lib/language/syntax.k"

module MULTISIG-CONCRETIZE-VALUE
  imports CONCRETIZE-VALUE-SYNTAX
  imports MULTISIG-SYNTAX

  rule concretizeValue(BoardMember) => .K  [label(concretizeValueBoardMember)]
  rule concretizeValue(Proposer) => .K  [label(concretizeValueProposer)]
  rule concretizeValue(None) => .K  [label(concretizeValueNone)]

  rule concretizeValue(meta(V:Int)) => concretizeValue(V)  [label(concretizeValueMeta)]

endmodule
