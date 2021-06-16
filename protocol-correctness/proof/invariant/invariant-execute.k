require "protocol-correctness/proof/main-proof-execute.k"

require "protocol-correctness/proof/invariant/init-loop-parts.k"

module INVARIANT-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-SYNTAX
endmodule

module INVARIANT-FUNCTIONS
  imports INVARIANT

  syntax CustomInvariantData ::= "no-data"
  rule  customInvariant(
          no-data,
          _NumUsers:Usize,
          _UserIdToAddress:Map,
          _AddressToUserId:Map,
          _NumBoardMembers:Usize,
          _NumProposers:Usize,
          _UserRoles:Map,
          _Quorum:Usize,
          _ActionLastIndex:Usize,
          _ActionData:Map,
          _ActionSigners:Map,
          _Handling:PropertyHandling)
      => true
endmodule

module INVARIANT-EXECUTE
  imports MAIN-PROOF-EXECUTE

  imports INVARIANT-FUNCTIONS

  imports INIT-LOOP-PARTS
endmodule
