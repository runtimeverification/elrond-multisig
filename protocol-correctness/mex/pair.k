require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running-syntax.k"
require "protocol-correctness/mex/types/token-identifier.k"

module PAIR-BASE-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax PairState ::= "PairState::Inactive" | "PairState::Active" | "PairState::ActiveNoSwaps"
  syntax Value ::= PairState
endmodule

module PAIR-SYNTAX
  syntax Pair ::= pair()
  syntax Record ::= Pair
endmodule

module PSEUDOCODE-FUNCTIONS
  imports FUNCTION-CALL-SYNTAX
  imports MEX-IDENTIFIERS-SYNTAX
  imports RUNNING-SYNTAX

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
        Ok(void);
    )
endmodule
