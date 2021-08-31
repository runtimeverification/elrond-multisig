module MEX-IDENTIFIERS-SYNTAX
  syntax Variable ::= "caller"  [token]
                    | "first_token_id"  [token]
                    | "lp_token_id"  [token]
                    | "second_token_id"  [token]
                    | "state"  [token]
                    | "temporary_funds"  [token]

  syntax FunctionTag  ::= "accept_esdt_payment"
                        | "blockchain"
                        | "call_value"
                        | "esdt_token_nonce"
                        | "esdt_value"
                        | "extern_swap_gas_limit"
                        | "first_token_id"
                        | "get_caller"
                        | "is_active"
                        | "is_valid_esdt_identifier"
                        | "lp_token_identifier"
                        | "router_address"
                        | "router_owner_address"
                        | "second_token_id"
                        | "special_fee_percent"
                        | "state"
                        | "temporary_funds"
                        | "token"
                        | "total_fee_percent"
                        | "transfer_exec_gas_limit"

  syntax EndpointTag  ::= "accept_esdt_payment_endpoint"
                        | "init"

endmodule
