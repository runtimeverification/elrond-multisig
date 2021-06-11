// timeout = eternal
// breadth = 1
//@ proof
require "../functions/trusted-propose-sc-deploy-Proposer.k"  //@ Bazel remove

module PROOF-PROPOSE-SC-DEPLOY-4
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-PROPOSE-SC-DEPLOY-PROPOSER
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY-4
//   imports INVARIANT-FUNCTIONS
//   imports PERFORM-ACTION-ENDPOINT-INSTRUMENTATION
//@ end

  claim <T><TT>
          <k> propose-sc-deploy-role.k
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
              (CallerAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> Proposer _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              stack(
                  invariantMultisigState(
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
                  .Map,
                  PerformedActions,
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
