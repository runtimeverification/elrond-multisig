// timeout = eternal
// breadth = 2
// 2021-06-10: Failing because of https://github.com/kframework/kore/issues/2515
//@ proof
module PROOF-PROPOSE-ACTION-BOARDMEMBER
//@ trusted
// module TRUSTED-PROPOSE-ACTION-BOARDMEMBER
//@ end

  imports INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> call(proposeAction(Action:Action)) ~> K:K
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
          <k> u(ActionLastIndex +Int 1) ~> K </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(ActionLastIndex +Int 1),
              u(ActionLastIndex +Int 1) |-> Action ActionData,
              (u(ActionLastIndex +Int 1) |-> [{AddressToUserId[CallerAddress]}:>Usize, .]) ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables,
              PerformedActions:List
              ):StateCell
        </TT></T>
    requires true
      andBool isKResult(Action)
      andBool valueIsNotEmpty(Action, rAction)

      andBool mapValuesAreKResult(AddressToUserId)
      andBool mapValuesAreOfType(AddressToUserId, rUsize)
      andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)

      andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool mapValuesAreKResult(UserIdToRole)

      andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
      andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))

      andBool mapKeysAreOfType(ActionData, rUsize)
      andBool mapKeysAreOfType(ActionSigners, rUsize)

      andBool CallerAddress in_keys(AddressToUserId)
      andBool AddressToUserId[CallerAddress] in_keys(UserIdToRole)
      andBool UserIdToRole[AddressToUserId[CallerAddress]] ==K BoardMember
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
