// timeout = moderate
// breadth = 2
//@ proof
require "trusted-propose-action-Proposer.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-fragment.k"  //@ Bazel remove
//@ trusted
//@ end

//@ proof
module PROOF-PROPOSE-SC-DEPLOY-PROPOSER
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY-PROPOSER
//@ end
  imports INVARIANT
  imports CODE-METADATA-FUNCTION-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX

  //@ proof
  imports TRUSTED-PROPOSE-ACTION-PROPOSER
  imports TRUSTED-PROPOSE-SC-DEPLOY-FRAGMENT
  //@ trusted
  //@ end

  claim <T><TT>
          <k> call(proposeSCDeploy(
                    Amount:BigUint,
                    Code:BoxedBytes,
                    Upgradeable:Bool,
                    Payable:Bool,
                    Readable:Bool,
                    Args:ExpressionList))
              ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              u(ActionLastIndex:Int),
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(u(ActionLastIndex +Int 1)) ~> K </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(ActionLastIndex +Int 1),
              u(ActionLastIndex +Int 1)
                      |-> SCDeploy(
                            Amount,
                            Code,
                            codeMetadataFunction(Upgradeable, Payable, Readable),
                            Args)
                  ActionData,
              ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables,
              PerformedActions:List
              ):StateCell
        </TT></T>
    requires true
      andBool isKResult(Args)

      andBool mapValuesAreKResult(AddressToUserId)
      andBool mapValuesAreOfType(AddressToUserId, rUsize)
      andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)

      andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool mapValuesAreKResult(UserIdToRole)

      andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
      andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))

      andBool CallerAddress in_keys(AddressToUserId)
      andBool AddressToUserId[CallerAddress] in_keys(UserIdToRole)
      andBool UserIdToRole[AddressToUserId[CallerAddress]] ==K Proposer
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
