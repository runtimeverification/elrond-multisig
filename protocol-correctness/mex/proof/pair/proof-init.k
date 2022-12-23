// timeout = long
// breadth = 8

module PROOF-INIT
    imports BASE-TYPES-SYNTAX
    imports LANGUAGE-CONFIGURATION
    imports MEX-IDENTIFIERS-SYNTAX
    imports PAIR-CONFIGURATION
    imports PAIR-SYNTAX
    imports RUNNING-SYNTAX
    imports TOKEN-IDENTIFIER-SYNTAX

    claim
        <k>
            runExternalCalls(
                (   from _:Address run init(
                        Self:Pair,
                        _FirstTokenId:TokenIdentifier,
                        _SecondTokenId:TokenIdentifier,
                        _RouterAddress:Address,
                        _RouterOwnerAddress:Address,
                        _TotalFeePercent:Usize,
                        _SpecialFeePercent:Usize);
                    EC:ExternalCommands
                )
            )
            => runExternalCalls(EC)
        </k>
        <caller-address> uninitialized => ?_NewCallerAddress </caller-address>
        <pair>
            <pair-id>Self</pair-id>
            <lp-token-identifier>_OldLpTokenId:TokenIdentifier => ?_NewLpTokenId:TokenIdentifier</lp-token-identifier>
            <first-token-id>_OldFirstTokenId:TokenIdentifier => ?_NewFirstTokenId:TokenIdentifier</first-token-id>
            <second-token-id>_OldSecondTokenId:TokenIdentifier => ?_NewSecondTokenId:TokenIdentifier</second-token-id>
            <pair-state>_OldPairState:PairState => ?_NewPairState:PairState</pair-state>
            <transfer-exec-gas-limit>_OldTransferGasLimit:Usize => ?_NewTransferGasLimit:Usize</transfer-exec-gas-limit>
            <extern-swap-gas-limit>_OldExternSwapGasLimit:Usize => ?_NewExternSwapGasLimit:Usize</extern-swap-gas-limit>
            <router-address>_OldRouterAddress:Address => ?_NewRouterAddress:Address</router-address>
            <router-owner-address>_OldRouterOwnerAddress:Address => ?_NewRouterOwnerAddress:Address</router-owner-address>
            <total-fee-percent>_OldTotalFeePercent:Usize => ?_NewTotalFeePercent:Usize</total-fee-percent>
            <special-fee-percent>_OldSpecialFeePercent:Usize => ?_NewSpecialFeePercent:Usize</special-fee-percent>
        </pair>
endmodule
