// timeout = eternal
// breadth = 6
//@ proof
require "trusted-count-can-sign.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-FRAGMENT-PERFORMS
  imports TRUSTED-COUNT-CAN-SIGN
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-FRAGMENT-PERFORMS
//@ end

  imports INVARIANT

  claim <T><TT>
          <k> runPseudoCode(
                  caller_address = getCaller();
                  caller_id = getUserId(caller_address);
                  caller_role = getUserIdToRole(caller_id);
                  require(userRoleCanPerformAction(caller_role));
                  require(quorumReached(ActionId:Usize));
                  performActionFromId(ActionId);
              )
              ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (UserId |-> Role:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
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
          <k> runPseudoCode(
                  performActionFromId(ActionId);
              )
              ~> K:K
          </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              ActionLastIndex,
              ActionData,
              ActionSigners,
              CallerAddress,
              Stack,
              caller_address |-> CallerAddress
                caller_id |-> UserId
                caller_role |-> Role,
              PerformedActions
              )
        </TT></T>
    requires true
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionSignersInvariant(ActionSigners)

        andBool (Role ==K BoardMember orBool Role ==K Proposer)
        andBool Quorum
                <=Int countCanSignFunction(
                    toExpressionListOrDefault(ActionSigners[ActionId] orDefault [.], [void, .]),
                    UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
