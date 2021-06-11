// timeout = eternal
// breadth = 6
//@ proof
require "trusted-propose-sc-deploy-1.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-2.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-3.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-4.k"  //@ Bazel remove

module PROOF-PROPOSE-SC-DEPLOY
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-PROPOSE-SC-DEPLOY-1
  imports TRUSTED-PROPOSE-SC-DEPLOY-2
  imports TRUSTED-PROPOSE-SC-DEPLOY-3
  imports TRUSTED-PROPOSE-SC-DEPLOY-4
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY
//   imports INVARIANT-FUNCTIONS
//   imports PERFORM-ACTION-ENDPOINT-INSTRUMENTATION
//@ end

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run proposeSCDeploy(
                                _Amount:BigUint,
                                _Code:BoxedBytes,
                                _Upgradeable:Bool,
                                _Payable:Bool,
                                _Readable:Bool,
                                Args:ExpressionList);
                      EC:ExternalCommands
                  )
              )
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ActionLastIndex0:Usize,
              ActionData0:Map,
              ActionSigners0:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ?ActionLastIndex1:Usize,
              ?ActionData1:Map,
              ?ActionSigners1:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires invariant(
            no-data,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserRoles:Map,
            Quorum:Usize,
            ActionLastIndex0:Usize,
            ActionData0:Map,
            ActionSigners0:Map,
            expand(expanded))
        andBool isKResult(Args)
    ensures invariant(
        no-data,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserRoles:Map,
            Quorum:Usize,
            ?ActionLastIndex1:Usize,
            ?ActionData1:Map,
            ?ActionSigners1:Map,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
