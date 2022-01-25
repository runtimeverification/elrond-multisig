// timeout = moderate
// breadth = 3

require "trusted-sign-existing-signers-not-in-list.k"  //@ Bazel remove
require "../instrumentation/pushlist/trusted-push-list-not-empty.k"  //@ Bazel remove

//@ proof
module PROOF-RUN-EXTERNAL-CALL-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
  imports TRUSTED-PUSH-LIST-NOT-EMPTY
  imports TRUSTED-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
//@ end
    imports INVARIANT
    imports LIST-CONTAINS-SYNTAX

  claim <T><TT>
          <k>
              runExternalCall
                  (from CallerAddress run sign(ActionId:Usize);)
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
              ActionId |-> [Signers:ExpressionCSV] ActionSigners:Map,
              uninitialized,
              .stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
        =>
        <T><TT>
          <k>
              K
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
              ActionId |->
                      [ #pushList
                          ( Signers
                          , toUsizeOrDefault
                              ( AddressToUserId[CallerAddress] orDefault void
                              , u(0)
                              )
                          )
                      ]
                  ActionSigners:Map,
              uninitialized,
              .stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
    requires true
      andBool CallerAddress in_keys(AddressToUserId)
      andBool AddressToUserId[CallerAddress] orDefault void in_keys(UserIdToRole)
      andBool UserIdToRole[AddressToUserId[CallerAddress] orDefault void] orDefault void
              ==K BoardMember
      andBool notBool #listContainsSafe
                  ( [Signers]
                  , toUsizeOrDefault
                      ( AddressToUserId[CallerAddress] orDefault void
                      , u(0)
                      )
                  )

      andBool notBool u(0) in_keys(UserIdToRole)
      andBool actionDataInvariant(ActionData)
      andBool userIdToRoleInvariant(UserIdToRole)

      andBool mapValuesAreKResult(AddressToUserId)
      andBool mapValuesAreOfType(AddressToUserId, rUsize)

      andBool ActionId in_keys(ActionData)
      andBool isKResult(Signers)

    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
