require "protocol-correctness/multisig/lib/language/cast.k"
require "protocol-correctness/multisig/lib/language/kresult.k"
require "protocol-correctness/multisig/lib/language/syntax.k"
require "protocol-correctness/multisig/lib/language/type-reflection.k"

module MULTISIG-LANGUAGE-SYNTAX
  imports MULTISIG-SYNTAX
endmodule

module MULTISIG-LANGUAGE
  imports MULTISIG-LANGUAGE-SYNTAX

  imports MULTISIG-CAST
  imports MULTISIG-KRESULT
  imports MULTISIG-TYPE-REFLECTION
endmodule
