require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/pseudocode.k"
require "protocol-correctness/proof/instrumentation/pushlist/pushlist-instrumentation.k"

module INSTRUMENTATION-SIGN
  // TODO: Do I need this?
  imports INSTRUMENTATION-MAP

  imports PSEUDOCODE
  imports PUSHLIST-INSTRUMENTATION-SYNTAX

  syntax KItem ::= splitSign(Usize)
  syntax KItem ::= splitSign2(Usize)
  syntax KItem ::= splitSign3(Usize)
  syntax KItem ::= splitSign4(Usize)

  rule  preCall
        ~> (.K => splitSign(ActionId))
        ~> call(sign(ActionId:Usize))
  [priority(20)]

  rule  <k> splitSign(ActionId:Usize)
            =>  branchK(
                    ActionId in_keys(ActionData),
                    branchK(
                      CallerAddress in_keys(AddressToUserId),
                      splitSign2(ActionId),
                      .K
                    ),
                    .K
                  )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <caller-address>CallerAddress:CallerAddress</caller-address>
        <action-data>ActionData:Map</action-data>

  rule  <k> splitSign2(ActionId:Usize)
            =>    makeConcreteValue(CallerAddress, rUsize, AddressToUserId)
              ~>  branchK(
                    AddressToUserId[CallerAddress] in_keys(UserIdToRole),
                    splitSign3(ActionId),
                    .K
                  )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <user-roles>UserIdToRole:Map</user-roles>
        <caller-address>CallerAddress:CallerAddress</caller-address>
    requires CallerAddress in_keys(AddressToUserId)

  rule  <k> splitSign3(ActionId:Usize)
            =>    makeConcreteValue(AddressToUserId[CallerAddress], rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[AddressToUserId[CallerAddress]] ==K BoardMember,
                    branchK(
                      ActionId in_keys(ActionSigners),
                      makeConcreteValue(ActionId, rExpressionList, ActionSigners)
                        ~> splitSign4(ActionId),
                      .K
                    ),
                    .K
                  )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <user-roles>UserIdToRole:Map</user-roles>
        <caller-address>CallerAddress:CallerAddress</caller-address>
        <action-signers>ActionSigners:Map</action-signers>
    requires CallerAddress in_keys(AddressToUserId)
      andBool AddressToUserId[CallerAddress] in_keys(UserIdToRole)

  rule  <k> splitSign4(ActionId:Usize)
            =>    lemmaPushListNotEmpty(Signers, CallerId)
        ...</k>
        <address-to-user-id> CallerAddress |-> CallerId _AddressToUserId:Map </address-to-user-id>
        <caller-address>CallerAddress:CallerAddress</caller-address>
        <action-signers>ActionId |-> [Signers:ExpressionCSV] _ActionSigners:Map</action-signers>
endmodule
