require "protocol-correctness/proof/instrumentation-proof.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-PROPOSE-SC-DEPLOY
  imports INSTRUMENTATION-PROOF
  imports PSEUDOCODE

  syntax KItem ::= "split-sc-deploy"
  syntax KItem ::= "split-sc-deploy1"

  rule  preCall
        ~> (.K => split-sc-deploy)
        ~> call(proposeSCDeploy(_:BigUint, _:BoxedBytes, _:Bool, _:Bool, _:Bool, _:ExpressionList))
  [priority(20)]

  rule  <k> split-sc-deploy
            =>  branchK(
                  Caller in_keys(AddressToUserId),
                  makeConcreteValue(Caller, rUsize, AddressToUserId)
                    ~>  split-sc-deploy1,
                  propose-sc-deploy-no-user.k
                )
        ... </k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>Caller:CallerAddress</caller-address>

  rule  <k> split-sc-deploy1
            =>  branchK(
                  AddressToUserId[Caller] in_keys(UserIdToRole),
                  makeConcreteValue(AddressToUserId[Caller], rUserRole, UserIdToRole)
                      ~> propose-sc-deploy-role.k,
                  propose-sc-deploy-no-role.k
                )
        ... </k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-roles> UserIdToRole:Map </user-roles>
        <caller-address>Caller:CallerAddress</caller-address>
endmodule
