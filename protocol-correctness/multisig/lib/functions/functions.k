require "protocol-correctness/multisig/lib/functions/at-most-this-signer-list.k"
require "protocol-correctness/multisig/lib/functions/can-sign-function.k"
require "protocol-correctness/multisig/lib/functions/code-metadata-function.k"
require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
require "protocol-correctness/multisig/lib/functions/metadata-to-int.k"
require "protocol-correctness/multisig/lib/functions/only-this-signer-diffs.k"

module MULTISIG-FUNCTIONS-SYNTAX
endmodule

module MULTISIG-FUNCTIONS
  imports MULTISIG-FUNCTIONS-SYNTAX

  imports AT-MOST-THIS-SIGNER-LIST
  imports CAN-SIGN-FUNCTION
  imports CODE-METADATA-FUNCTION
  imports COUNT-CAN-SIGN-FUNCTION
  imports METADATA-TO-INT
  imports ONLY-THIS-SIGNER-DIFFS
endmodule

