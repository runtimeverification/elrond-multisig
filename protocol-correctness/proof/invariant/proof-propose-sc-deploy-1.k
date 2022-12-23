// timeout = eternal
// breadth = 1
//@ proof
require "../functions/trusted-propose-sc-deploy-error-no-user.k"  //@ Bazel remove

module PROOF-PROPOSE-SC-DEPLOY-1
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-PROPOSE-SC-DEPLOY-ERROR-NO-USER
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY-1
//   imports INVARIANT-FUNCTIONS
//   imports INSTRUMENTATION-PERFORM-ACTION-ENDPOINT
//@ end

  claim <T><TT>
          <k> propose-sc-deploy-no-user.k
              ~> call(proposeSCDeploy(
                  _Amount:BigUint,
                  _Code:BoxedBytes,
                  _Upgradeable:Bool,
                  _Payable:Bool,
                  _Readable:Bool,
                  Args:ExpressionList))
              ~> popContext
              ~> evaluateReturnValue
              ~> clearExternalCallEnv
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
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              stack(
                  customStackState(
                    invariantContractState(
                        NumUsers,
                        UserIdToAddress,
                        AddressToUserId,
                        NumBoardMembers,
                        NumProposers,
                        UserIdToRole,
                        Quorum,
                        ActionLastIndex,
                        ActionData,
                        ActionSigners),
                    <log><performed-actions>PerformedActions</performed-actions></log>
                  ),
                  .Map,
                  .stack
              ),
              .Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(?ActionLastIndex:Int),
              ?ActionData:Map,
              ?ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool invariant(
            no-data,
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
            expand(expanded))
        andBool isKResult(Args)
        andBool notBool CallerAddress in_keys(AddressToUserId)
    ensures true
        andBool invariant(
            no-data,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            u(?ActionLastIndex),
            ?ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
