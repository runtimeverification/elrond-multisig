require "protocol-correctness/multisig/lib/language/syntax.k"

module METADATA-TO-INT-SYNTAX
  imports MULTISIG-SYNTAX

  syntax Int ::= metadataToInt(CodeMetadata)  [function, functional]
endmodule

module METADATA-TO-INT
  imports METADATA-TO-INT-SYNTAX

  rule metadataToInt(meta(Value:Int)) => Value
endmodule

