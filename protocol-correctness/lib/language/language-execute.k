require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/configuration.k"
require "protocol-correctness/lib/language/flow.k"
require "protocol-correctness/lib/language/running.k"

module LANGUAGE-EXECUTE-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX
endmodule

module LANGUAGE-EXECUTE
  imports LANGUAGE-CONFIGURATION
  imports RUNNING

  configuration
    <T>
      <k />
      <pseudocode-state />
      <external-call-env />
    </T>
endmodule
