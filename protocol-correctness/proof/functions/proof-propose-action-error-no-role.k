// timeout = moderate
//@ proof
module PROOF-PROPOSE-ACTION-ERROR-NO-ROLE
//@ trusted
// module TRUSTED-PROPOSE-ACTION-ERROR-NO-ROLE
//@ end
  imports INVARIANT
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX

  claim <T><TT>
          <k> call(proposeAction(_Action:Action)) ~> K:K
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
