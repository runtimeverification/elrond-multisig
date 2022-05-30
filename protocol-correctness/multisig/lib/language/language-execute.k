require "protocol-correctness/multisig/lib/language/language.k"

module LANGUAGE-EXECUTE-SYNTAX
  imports MULTISIG-LANGUAGE-SYNTAX
endmodule

module LANGUAGE-EXECUTE
  imports LANGUAGE-EXECUTE-SYNTAX
  imports MULTISIG-LANGUAGE
endmodule
