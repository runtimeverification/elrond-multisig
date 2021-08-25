require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/caller-address.k"
require "protocol-correctness/lib/language/running-syntax.k"
require "protocol-correctness/lib/language/stack.k"

module LANGUAGE-CONFIGURATION
    imports BASE-TYPES-SYNTAX
    imports CALLER-ADDRESS-SYNTAX
    imports RUNNING-SYNTAX
    imports STACK-SYNTAX

    configuration
        <k color="green"> runExternalCalls($PGM:ExternalCommands) </k>

    configuration
        <pseudocode-state>
            <variables>.Map</variables>
            <stack> .stack </stack>
        </pseudocode-state>

    configuration
        <external-call-env>
            <caller-address>uninitialized</caller-address>
        </external-call-env>

endmodule
