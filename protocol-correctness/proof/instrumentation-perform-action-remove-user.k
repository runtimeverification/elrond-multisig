require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/proof/instrumentation-perform-split-action.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-PERFORM-ACTION-REMOVE-USER
  // TODO: Do I need this?
  imports INSTRUMENTATION-MAP
  
  imports INSTRUMENTATION-PERFORM-SPLIT-ACTION
  imports PSEUDOCODE

  syntax KItem ::= splittingDeleteCaller(Address)
  syntax KItem ::= splittingDeleteCaller1(Address)
  syntax KItem ::= splittingDeleteCaller2(Usize)
  rule  (splitting-action => splittingDeleteCaller(A))
        ~> call(performAction(RemoveUser(A:Address)))
    [priority(10)]

  rule  <k> splittingDeleteCaller(A:Address)
            =>  branchK(
                  A in_keys(AddressToUserId),
                  splittingDeleteCaller1(A),
                  .K
                )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
  rule  <k> (
              splittingDeleteCaller1(A:Address)
              => makeConcreteValue(A, rUsize, AddressToUserId)
                ~> branchK(
                      AddressToUserId[A] in_keys(UserIdToRole),
                      splittingDeleteCaller2({AddressToUserId[A]}:>Usize),
                      .K
                )
            )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-roles>UserIdToRole:Map</user-roles>
    requires A in_keys(AddressToUserId)

  rule  <k> (
              splittingDeleteCaller2(UserId:Usize)
              => makeConcreteValue(UserId, rUserRole, UserIdToRole)
                ~> lazyConcretizeKeys(UserIdToRole)  // TODO: Likely not needed.
                ~> branchK(
                      UserIdToRole[UserId] ==K BoardMember,
                      splitBoolean(Quorum <=Int NumBoardMembers -Int 1),
                      splitBoolean(Quorum <=Int NumBoardMembers)
                  )
                ~> splitBoolean(NumBoardMembers -Int 1 +Int NumProposers >Int 0)
            )
        ...</k>
        <user-roles>UserIdToRole:Map</user-roles>
        <num-board-members>u(NumBoardMembers:Int)</num-board-members>
        <num-proposers>u(NumProposers:Int)</num-proposers>
        <quorum>u(Quorum:Int)</quorum>
    requires UserId in_keys(UserIdToRole)
endmodule
