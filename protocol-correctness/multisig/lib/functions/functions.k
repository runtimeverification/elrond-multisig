require "protocol-correctness/multisig/lib/functions/can-sign-function.k"
require "protocol-correctness/multisig/lib/functions/code-metadata-function.k"
require "protocol-correctness/multisig/lib/proof/unsorted/concretize-value.k"
require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
require "protocol-correctness/multisig/lib/functions/metadata-to-int.k"
require "protocol-correctness/multisig/lib/functions/only-this-signer-diffs.k"
require "protocol-correctness/multisig/lib/functions/pound-at-most-this-signer-list.k"

module MULTISIG-FUNCTIONS-SYNTAX
endmodule

module MULTISIG-FUNCTIONS
  imports MULTISIG-FUNCTIONS-SYNTAX

  imports CAN-SIGN-FUNCTION
  imports CODE-METADATA-FUNCTION
  imports COUNT-CAN-SIGN-FUNCTION
  imports METADATA-TO-INT
  imports MULTISIG-CONCRETIZE-VALUE
  imports ONLY-THIS-SIGNER-DIFFS
  imports POUND-AT-MOST-THIS-SIGNER-LIST
endmodule

