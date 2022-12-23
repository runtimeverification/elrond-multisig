// timeout = eternal
// breadth = 6
//@ proof
require "trusted-propose-sc-deploy-1.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-2.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-3.k"  //@ Bazel remove
require "trusted-propose-sc-deploy-4.k"  //@ Bazel remove

module PROOF-PROPOSE-SC-DEPLOY
  imports TRUSTED-PROPOSE-SC-DEPLOY-1
  imports TRUSTED-PROPOSE-SC-DEPLOY-2
  imports TRUSTED-PROPOSE-SC-DEPLOY-3
  imports TRUSTED-PROPOSE-SC-DEPLOY-4
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCall(from MaliciousAddress run proposeSCDeploy(
                  _Amount:BigUint,
                  _Code:BoxedBytes,
                  _Upgradeable:Bool,
                  _Payable:Bool,
                  _Readable:Bool,
                  Args:ExpressionList);)
              ~> K:K
          </k>
          invariantState(
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
        andBool maliciousInvariant(
            MaliciousAddress,
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
        andBool maliciousInvariant(
            MaliciousAddress,
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
