module MEX-IDENTIFIERS-SYNTAX
  syntax Variable ::= "lp_token_id"        [token]

  syntax FunctionTag  ::= "is_valid_esdt_identifier"
                        | "extern_swap_gas_limit"
                        | "first_token_id"
                        | "get"
                        | "lp_token_identifier"
                        | "Ok"
                        | "router_address"
                        | "router_owner_address"
                        | "second_token_id"
                        | "set"
                        | "set_if_empty"
                        | "special_fee_percent"
                        | "state"
                        | "transfer_exec_gas_limit"
                        | "total_fee_percent"

  syntax EndpointTag  ::= "init"

endmodule
