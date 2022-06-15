// timeout = eternal
// breadth = 26
//@ proof
require "trusted-perform-parts-1.k"  //@ Bazel remove
require "trusted-perform-parts-2.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-New-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-no-quorum-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-None-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-nothing-marker.k"  //@ Bazel remove
require "../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT
  imports INVARIANT-EXECUTE

  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
  imports TRUSTED-PERFORM-PARTS-1
  imports TRUSTED-PERFORM-PARTS-2
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NEW-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NO-QUORUM-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NONE-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NOTHING-MARKER
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT
//   imports INVARIANT-FUNCTIONS
//@ end

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run performActionEndpoint(_ActionId:Usize);
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
              _PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              ?NumUsers1:Usize,
              ?UserIdToAddress1:Map,
              ?AddressToUserId1:Map,
              ?NumBoardMembers1:Usize,
              ?NumProposers1:Usize,
              ?UserRoles1:Map,
              ?Quorum1:Usize,
              ?ActionLastIndex1:Usize,
              ?ActionData1:Map,
              ?ActionSigners1:Map,
              ?_PerformedActions:List):StateCell
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
    ensures invariant(
        no-data,
        ?NumUsers1:Usize,
        ?UserIdToAddress1:Map,
        ?AddressToUserId1:Map,
        ?NumBoardMembers1:Usize,
        ?NumProposers1:Usize,
        ?UserRoles1:Map,
        ?Quorum1:Usize,
        ?ActionLastIndex1:Usize,
        ?ActionData1:Map,
        ?ActionSigners1:Map,
        usesExpanded)
  /*
  claim <T><TT>
          <k> call(getActionSignerIds(ActionId:Usize)) ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
      =>
        <T><TT>
          <k> ActionSigners[ActionId] orDefault [.] ~> K </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
  */
endmodule
