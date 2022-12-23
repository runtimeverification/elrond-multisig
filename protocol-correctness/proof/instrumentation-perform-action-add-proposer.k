require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/proof/instrumentation-perform-split-action.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-PERFORM-ACTION-ADD-PROPOSER
  // TODO: Do I need this?
  imports INSTRUMENTATION-MAP

  imports INSTRUMENTATION-PERFORM-SPLIT-ACTION
  imports PSEUDOCODE

  syntax KItem ::= splittingActionProposer(Address)

  rule  <k> (
              splitting-action
              =>  branchK(
                    A1 in_keys(AddressToUserId),
                    splittingActionProposer(A1),
                    .K
                  )
            )
            ~> call(performAction(AddProposer(A1:Address)))
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
    [priority(10)]

  rule  <k> splittingActionProposer(A1:Address)
            =>    makeConcreteValue(A1, rUsize, AddressToUserId)
              ~>  branchK(
                    AddressToUserId[A1] in_keys(UserIdToRole),
                    makeConcreteValue(AddressToUserId[A1], rUserRole, UserIdToRole),
                    .K
                  )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-roles> UserIdToRole:Map </user-roles>
    requires A1 in_keys(AddressToUserId)
      // TODO: Do I need AddressToUserId[A1] in_keys(UserIdToRole)?
endmodule
