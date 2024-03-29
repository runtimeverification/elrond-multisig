// timeout = moderate
//@ proof
require "trusted-propose-action-error-no-role.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-fragment.k"  //@ Bazel remove
//@ trusted
//@ end

//@ proof
module PROOF-PROPOSE-SC-DEPLOY-ERROR-NO-ROLE
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY-ERROR-NO-ROLE
//@ end
  imports INVARIANT
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX

  //@ proof
  imports TRUSTED-PROPOSE-ACTION-ERROR-NO-ROLE
  imports TRUSTED-PROPOSE-SC-DEPLOY-FRAGMENT
  //@ trusted
  //@ end

  claim <T><TT>
          <k> call(proposeSCDeploy(
                    _Amount:BigUint,
                    _Code:BoxedBytes,
                    _Upgradeable:Bool,
                    _Payable:Bool,
                    _Readable:Bool,
                    Args:ExpressionList))
              ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
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
          <k> error ~> K </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              ActionLastIndex,
              ActionData,
              ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables:Map,
              PerformedActions:List
              ):StateCell
        </TT></T>
    requires true
      andBool isKResult(Args)
      andBool notBool u(0) in_keys(UserIdToRole)

      andBool mapValuesAreKResult(AddressToUserId)
      andBool mapValuesAreOfType(AddressToUserId, rUsize)
      andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)

      andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool mapValuesAreKResult(UserIdToRole)

      andBool notBool UserId in_keys(UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
