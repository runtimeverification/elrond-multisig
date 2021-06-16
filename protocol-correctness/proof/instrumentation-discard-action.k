require "protocol-correctness/proof/execution-proof-helpers.k"
require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/proof/instrumentation-proof.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-DISCARD-ACTION
  imports INSTRUMENTATION-MAP
  imports INSTRUMENTATION-PROOF
  imports EXECUTION-PROOF-HELPERS
  imports PSEUDOCODE

  syntax KItem ::= splitDiscardAction(actionId:Usize)
  syntax KItem ::= splitDiscardAction1(actionId:Usize)
  syntax KItem ::= splitDiscardAction2(actionId:Usize)
  syntax KItem ::= splitDiscardAction3(actionId:Usize)
  syntax KItem ::= splitDiscardAction4(actionId:Usize)

  rule  preCall
        ~> (.K => splitDiscardAction(ActionId))
        ~> call(discardAction(ActionId:Usize))
    [priority(20)]

  rule  <k> splitDiscardAction(ActionId:Usize)
            =>  branchK(
                  Caller in_keys(AddressToUserId),
                  splitDiscardAction1(ActionId),
                  discard-action-no-user.k
                )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>Caller:KItem</caller-address>

  rule  <k> splitDiscardAction1(ActionId:Usize)
            =>    makeConcreteValue(Caller, rUsize, AddressToUserId)
              ~>  branchK(
                    AddressToUserId[Caller] in_keys(UserIdToRole),
                    splitDiscardAction2(ActionId),
                    discard-action-no-role.k
                  )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-roles> UserIdToRole:Map </user-roles>
        <caller-address>Caller:KItem</caller-address>
    requires Caller in_keys(AddressToUserId)

  rule  <k> splitDiscardAction2(ActionId:Usize)
            =>    makeConcreteValue(AddressToUserId[Caller], rUserRole, UserIdToRole)
              ~>  branchK(
                    ActionId in_keys(ActionSigners),
                    splitDiscardAction3(ActionId),
                    branchK(
                      ActionId in_keys(ActionData),
                      makeConcreteValue(ActionId, rAction, ActionData),
                      .K
                    )
                  )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-roles> UserIdToRole:Map </user-roles>
        <caller-address>Caller:KItem</caller-address>
        <action-signers>ActionSigners:Map</action-signers>
        <action-data>ActionData</action-data>
    requires Caller in_keys(AddressToUserId)

  rule  <k> splitDiscardAction3(ActionId:Usize)
            =>    makeConcreteValue(ActionId, rExpressionList, ActionSigners)
              ~>  branchK(
                    ActionId in_keys(ActionData),
                    makeConcreteValue(ActionId, rAction, ActionData),
                    splitDiscardAction4(ActionId)
                  )
        ...</k>
        <action-data>ActionData</action-data>
        <action-signers>ActionSigners</action-signers>
    requires ActionId in_keys(ActionSigners)
  rule  <k> splitDiscardAction4(ActionId:Usize)
            =>    branchK(
                    countCanSignFunction({ActionSigners[ActionId]}:>ExpressionList, UserIdToRole) >Int 0,
                    .K,
                    .K
                  )
        ...</k>
        <action-signers>ActionSigners</action-signers>
        <user-roles> UserIdToRole:Map </user-roles>
    requires ActionId in_keys(ActionSigners)
      andBool isExpressionList(ActionSigners[ActionId])

endmodule
