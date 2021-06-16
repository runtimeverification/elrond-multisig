require "protocol-correctness/proof/instrumentation-proof.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-FUNCTIONS
  imports INSTRUMENTATION-PROOF
  imports PSEUDOCODE

  syntax KItem ::= "split-propose-action"
  syntax KItem ::= "split-propose-action1"

  rule preCall ~> (.K => split-propose-action) ~> call(proposeAction(_Action:Action))
  [priority(20)]

  rule  <k> split-propose-action
            =>  branchK(
                  Caller in_keys(AddressToUserId),
                  makeConcreteValue(Caller, rUsize, AddressToUserId)
                    ~>  split-propose-action1,
                  .K
                )
        ... </k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>Caller:KItem</caller-address>

  rule  <k> split-propose-action1
            =>  branchK(
                  AddressToUserId[Caller] in_keys(UserIdToRole),
                  makeConcreteValue(AddressToUserId[Caller], rUserRole, UserIdToRole),
                  .K
                )
        ... </k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-roles> UserIdToRole:Map </user-roles>
        <caller-address>Caller:KItem</caller-address>

  rule  preCall
      ~> (.K => concretizeValue(Role))
      ~> call(canSign(Role:UserRole))
  [priority(20)]

endmodule
