// timeout = moderate
//@ proof
require "trusted-perform-action-endpoint-fragment-performs.k"  //@ Bazel remove
require "trusted-perform-action-id-add-proposer-New.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-NEW
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-FRAGMENT-PERFORMS
  imports TRUSTED-PERFORM-ACTION-ID-ADD-PROPOSER-NEW
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-NEW
//@ end
  imports INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX

  claim <T><TT>
          <k> call(performActionEndpoint(ActionId:Usize)) ~> K:K </k>
          invariantStateFull(
              u(NumUsers:Int),
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              (CallerId |-> Role:UserRole
                  _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionId |-> AddProposer(UserAddress:Address) #as Action:Action
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
          <k> evaluate(void) ~> K:K </k>
          invariantStateFull(
              u(NumUsers +Int 1),
              u(NumUsers +Int 1) |-> UserAddress UserIdToAddress,
              UserAddress |-> u(NumUsers +Int 1) AddressToUserId,
              u(NumBoardMembers),
              u(NumProposers +Int 1),
              u(NumUsers +Int 1) |-> Proposer UserIdToRole,
              u(Quorum),
              ActionLastIndex,
              ActionData,
              ActionSigners[ActionId <- undef],
              CallerAddress,
              Stack,
              ?_Variables:Map,
              ListItem(Action) PerformedActions
              )
        </TT></T>
    requires true
        // perform-from-id
        andBool isKResult(Action)

        andBool NumUsers >=Int 0
        // TODO: Perhaps replace with unusedIdsInMapValues(AddressToUserId) +
        // someting to map values to keys.
        andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToAddress), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToRole), expand(expanded))
        andBool mapKeysAreOfType(UserIdToAddress, rUsize)
        andBool Quorum <=Int NumBoardMembers

        andBool notBool UserAddress in_keys(AddressToUserId)

        // perform-fragment
        andBool actionSignersInvariant(ActionSigners)
        andBool userIdToRoleInvariant(UserIdToRole)
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
