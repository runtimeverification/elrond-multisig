require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running-syntax.k"
require "protocol-correctness/mex/identifiers.k"
require "protocol-correctness/mex/types/token-identifier.k"

module PAIR-BASE-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax PairState ::= "PairState::Inactive" | "PairState::Active" | "PairState::ActiveNoSwaps"
  syntax Value ::= PairState
endmodule

module PAIR-SYNTAX
  imports INT

  syntax Pair ::= pair(Int)
  syntax Record ::= Pair
endmodule

module PAIR
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports PAIR-FUNCTIONS
  imports PAIR-SYNTAX

  rule isKResultExpression(pair(_:Int)) => true
endmodule

module PAIR-TYPE-REFLECTION
    import PAIR-BASE-SYNTAX
    import TYPE-REFLECTION-SYNTAX

    syntax ReflectionType ::= "rPairState"

    rule defaultValue(rPairState) => PairState::Inactive
endmodule

module PAIR-FUNCTIONS
    imports FUNCTION-CALL-SYNTAX
    imports LANGUAGE-CONFIGURATION
    imports MAPPERS-IDENTIFIERS-SYNTAX
    imports MAPPERS-SYNTAX
    imports MEX-IDENTIFIERS-SYNTAX
    imports PAIR-BASE-SYNTAX
    imports PAIR-CONFIGURATION
    imports PAIR-SYNTAX
    imports PAIR-TYPE-REFLECTION
    imports RUNNING-SYNTAX
    imports TOKEN-IDENTIFIER-SYNTAX
    imports TOKEN-IDENTIFIER-TYPE-REFLECTION
    imports TYPE-REFLECTION-SYNTAX

    syntax Usize ::= "DEFAULT_TRANSFER_EXEC_GAS_LIMIT"  [function]
    rule DEFAULT_TRANSFER_EXEC_GAS_LIMIT => u(35000000)

    syntax Usize ::= "DEFAULT_EXTERN_SWAP_GAS_LIMIT"  [function]
    rule DEFAULT_EXTERN_SWAP_GAS_LIMIT => u(50000000)

    rule call(init(
                  Self:Pair,
                  FirstTokenId:TokenIdentifier,
                  SecondTokenId:TokenIdentifier,
                  RouterAddress:Address,
                  RouterOwnerAddress:Address,
                  TotalFeePercent:Usize,
                  SpecialFeePercent:Usize))
        => runPseudoCode(
            require(
                FirstTokenId.is_valid_esdt_identifier()
            );
            require(
                SecondTokenId.is_valid_esdt_identifier()
            );
            require(
                TotalFeePercent >= SpecialFeePercent && TotalFeePercent < u(100000)  // >
            );
            require(
                FirstTokenId != SecondTokenId
            );
            let lp_token_id = Self.lp_token_identifier().get();
            require(
                FirstTokenId != lp_token_id
            );
            require(
                SecondTokenId != lp_token_id
            );

            Self.state().set_if_empty(PairState::ActiveNoSwaps);
            Self.transfer_exec_gas_limit()
                .set_if_empty(DEFAULT_TRANSFER_EXEC_GAS_LIMIT);
            Self.extern_swap_gas_limit()
                .set_if_empty(DEFAULT_EXTERN_SWAP_GAS_LIMIT);

            Self.router_address().set(RouterAddress);
            Self.router_owner_address().set(RouterOwnerAddress);
            Self.first_token_id().set(FirstTokenId);
            Self.second_token_id().set(SecondTokenId);
            Self.total_fee_percent().set(TotalFeePercent);
            Self.special_fee_percent().set(SpecialFeePercent);
            ok(void);
        )

    rule call(lp_token_identifier(Self:Pair))
        => valueMapper(Self, lp_token_identifier, SingleValue(rTokenIdentifier))
    rule
        <k>
            computeMappedValue(Self:Pair, lp_token_identifier) => E
        ...</k>
        <pair-id>Self</pair-id>
        <lp-token-identifier>E:TokenIdentifier</lp-token-identifier>
    rule
        <k>
            updateMappedValue(Self:Pair, lp_token_identifier, E:TokenIdentifier) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <lp-token-identifier>_:TokenIdentifier => E</lp-token-identifier>

    rule call(first_token_id(Self:Pair))
        => valueMapper(Self, first_token_id, SingleValue(rTokenIdentifier))
    rule
        <k>
            computeMappedValue(Self:Pair, first_token_id) => E
        ...</k>
        <pair-id>Self</pair-id>
        <first-token-id>E:TokenIdentifier</first-token-id>
    rule
        <k>
            updateMappedValue(Self:Pair, first_token_id, E:TokenIdentifier) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <first-token-id>_:TokenIdentifier => E</first-token-id>

    rule call(second_token_id(Self:Pair))
        => valueMapper(Self, second_token_id, SingleValue(rTokenIdentifier))
    rule
        <k>
            computeMappedValue(Self:Pair, second_token_id) => E
        ...</k>
        <pair-id>Self</pair-id>
        <second-token-id>E:TokenIdentifier</second-token-id>
    rule
        <k>
            updateMappedValue(Self:Pair, second_token_id, E:TokenIdentifier) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <second-token-id>_:TokenIdentifier => E</second-token-id>

    rule call(state(Self:Pair))
        => valueMapper(Self, state, SingleValue(rPairState))
    rule
        <k>
            computeMappedValue(Self:Pair, state) => E
        ...</k>
        <pair-id>Self</pair-id>
        <pair-state>E:PairState</pair-state>
    rule
        <k>
            updateMappedValue(Self:Pair, state, E:PairState) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <pair-state>_:PairState => E</pair-state>


    rule call(transfer_exec_gas_limit(Self:Pair))
        => valueMapper(Self, transfer_exec_gas_limit, SingleValue(rUsize))
    rule
        <k>
            computeMappedValue(Self:Pair, transfer_exec_gas_limit) => E
        ...</k>
        <pair-id>Self</pair-id>
        <transfer-exec-gas-limit>E:Usize</transfer-exec-gas-limit>
    rule
        <k>
            updateMappedValue(Self:Pair, transfer_exec_gas_limit, E:Usize) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <transfer-exec-gas-limit>_:Usize => E</transfer-exec-gas-limit>


    rule call(extern_swap_gas_limit(Self:Pair))
        => valueMapper(Self, extern_swap_gas_limit, SingleValue(rUsize))
    rule
        <k>
            computeMappedValue(Self:Pair, extern_swap_gas_limit) => E
        ...</k>
        <pair-id>Self</pair-id>
        <extern-swap-gas-limit>E:Usize</extern-swap-gas-limit>
    rule
        <k>
            updateMappedValue(Self:Pair, extern_swap_gas_limit, E:Usize) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <extern-swap-gas-limit>_:Usize => E</extern-swap-gas-limit>


    rule call(router_address(Self:Pair))
        => valueMapper(Self, router_address, SingleValue(rAddress))
    rule
        <k>
            computeMappedValue(Self:Pair, router_address) => E
        ...</k>
        <pair-id>Self</pair-id>
        <router-address>E:Address</router-address>
    rule
        <k>
            updateMappedValue(Self:Pair, router_address, E:Address) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <router-address>_:Address => E</router-address>


    rule call(router_owner_address(Self:Pair))
        => valueMapper(Self, router_owner_address, SingleValue(rAddress))
    rule
        <k>
            computeMappedValue(Self:Pair, router_owner_address) => E
        ...</k>
        <pair-id>Self</pair-id>
        <router-owner-address>E:Address</router-owner-address>
    rule
        <k>
            updateMappedValue(Self:Pair, router_owner_address, E:Address) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <router-owner-address>_:Address => E</router-owner-address>


    rule call(total_fee_percent(Self:Pair))
        => valueMapper(Self, total_fee_percent, SingleValue(rUsize))
    rule
        <k>
            computeMappedValue(Self:Pair, total_fee_percent) => E
        ...</k>
        <pair-id>Self</pair-id>
        <total-fee-percent>E:Usize</total-fee-percent>
    rule
        <k>
            updateMappedValue(Self:Pair, total_fee_percent, E:Usize) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <total-fee-percent>_:Usize => E</total-fee-percent>


    rule call(special_fee_percent(Self:Pair))
        => valueMapper(Self, special_fee_percent, SingleValue(rUsize))
    rule
        <k>
            computeMappedValue(Self:Pair, special_fee_percent) => E
        ...</k>
        <pair-id>Self</pair-id>
        <special-fee-percent>E:Usize</special-fee-percent>
    rule
        <k>
            updateMappedValue(Self:Pair, special_fee_percent, E:Usize) => .K
        ...</k>
        <pair-id>Self</pair-id>
        <special-fee-percent>_:Usize => E</special-fee-percent>
endmodule

module PAIR-CONFIGURATION
    imports PAIR-BASE-SYNTAX
    imports PAIR-SYNTAX
    imports TOKEN-IDENTIFIER-SYNTAX

    configuration
        <pairs>
            <pair multiplicity="*" type="Map">
                <pair-id> pair(0) </pair-id>
                <pair-data>
                    <lp-token-identifier> tokenIdentifier(bytes("")) </lp-token-identifier>
                    <first-token-id> tokenIdentifier(bytes("")) </first-token-id>
                    <second-token-id> tokenIdentifier(bytes("")) </second-token-id>
                    <pair-state> PairState::Inactive </pair-state>
                    <transfer-exec-gas-limit>u(0)</transfer-exec-gas-limit>
                    <extern-swap-gas-limit>u(0)</extern-swap-gas-limit>
                    <router-address>address(0)</router-address>
                    <router-owner-address>address(0)</router-owner-address>
                    <total-fee-percent>u(0)</total-fee-percent>
                    <special-fee-percent>u(0)</special-fee-percent>
                </pair-data>
            </pair>
        </pairs>

endmodule
