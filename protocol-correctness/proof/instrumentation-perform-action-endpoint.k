require "protocol-correctness/proof/execution-proof-helpers.k"
require "protocol-correctness/proof/instrumentation-perform-split-action.k"
require "protocol-correctness/proof/instrumentation-proof.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-PERFORM-ACTION-ENDPOINT-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP
  imports MULTISIG-SYNTAX

  syntax KItem ::= splitPerformActionEndpoint(actionId:Usize)
  syntax KItem ::= splitPerformActionEndpoint1(actionId:Usize)
  syntax KItem ::= splitPerformActionEndpoint1a(actionId:Usize)
  syntax KItem ::= splitPerformActionEndpoint2(actionId:Usize)
  syntax KItem ::= splitPerformActionEndpoint3(action:Action)
  syntax KItem ::= splitPerformActionEndpoint4(action:Action)
  syntax KItem ::= splitActionSigners(actionId:Usize, signers:Map)


  syntax KItem ::= splitAddBoardMember(Action)
  syntax KItem ::= splitAddBoardMember1(Address)
  syntax KItem ::= splitAddBoardMember2(Address)
  syntax KItem ::= splitAddBoardMember3(Address)


  syntax KItem ::= splitAddProposer(Action)
  syntax KItem ::= splitAddProposer1(Address)
  syntax KItem ::= splitAddProposer2(Address)
  syntax KItem ::= splitAddProposer3(Address)


  syntax KItem ::= splitRemoveUser(Action)
  syntax KItem ::= splitRemoveUser1(Address)
  syntax KItem ::= splitRemoveUser2(Address)
  syntax KItem ::= splitRemoveUser3(Address)


  syntax KItem ::= splitChangeQuorum(Action)


endmodule

module INSTRUMENTATION-PERFORM-ACTION-ENDPOINT
  // This is a diagram of the splits attempted here. The k files have only
  // their suffix. The missing prefix is 'proof-perform-action-endpoint-'.
  //
  // Has caller user?
  // No: New.k
  // Yes: Has caller role?
  //   No: None.k
  //   Yes: Has quorum?
  //     No: TODO: merge no-quorum-has-signers.k + no-quorum-no-signers.k
  //     Yes: Has action?
  //       No: TODO: nothing.k
  //       Yes: split action
  //         action=add-board-member: Is same as caller?
  //           No: New user?
  //             Yes: add-board-member-New.k
  //             No: Has role?
  //               No: add-board-member-None.k
  //               Yes: split role
  //                 role=proposer? add-board-member-Proposer.k
  //                 role=board-member? add-board-member-BoardMember.k
  //           Yes: split role
  //             role=proposer? add-board-member-Proposer-eq.k
  //             role=board-member? add-board-member-BoardMember-eq.k
  //         action=add-proposer: Is same as caller?
  //           No: New user?
  //             Yes: add-proposer-New.k
  //             No: Has role?
  //               No: add-proposer-None.k
  //               Yes: split role
  //                 role=proposer? add-proposer-Proposer.k
  //                 role=board-member? goes-below-quorum?
  //                   Yes: add-proposer-BoardMember-no-quorum.k
  //                   No: add-proposer-BoardMember.k
  //           Yes: split role
  //             role=proposer? add-proposer-Proposer-eq.k
  //             role=board-member? goes-below-quorum?
  //               Yes: add-proposer-BoardMember-no-quorum-eq.k
  //               No: add-proposer-BoardMember-eq.k
  //         action=change-quorum: goes-below-quorum?
  //           Yes: change-quorum-no-quorum.k
  //           No: change-quorum.k
  //         action=remove-user: Is same as caller?
  //           No: New user?
  //             Yes: remove-user-New.k
  //             No: Has role?
  //               No: remove-user-None.k
  //               Yes: split role
  //                 role = proposer: has-people-left?
  //                   Yes: remove-user-Proposer.k
  //                   No: remove-user-Proposer-nobody-left.k
  //                 role = board-member: can-still-vote-execute?
  //                   Yes: remove-user-BoardMember.k
  //                   No: remove-user-BoardMember-too-few.k
  //           Yes: split role
  //             role = proposer: has-people-left?
  //               Yes: remove-user-Proposer-eq.k
  //               No: remove-user-Proposer-nobody-left-eq.k
  //             role = board-member: can-still-vote-execute?
  //               Yes: remove-user-BoardMember-eq.k
  //               No: remove-user-BoardMember-too-few-eq.k
  //         action=sc-call? sc-call.k
  //         action=sc-deploy? sc-deploy.k
  //         action=send-egld? send-egld.k

  imports INSTRUMENTATION-PERFORM-ACTION-ENDPOINT-SYNTAX

  imports INSTRUMENTATION-PERFORM-SPLIT-ACTION
  imports INSTRUMENTATION-PROOF
  imports PSEUDOCODE

  rule  <k> preCall
            ~> (.K => splitPerformActionEndpoint(ActionId))
            ~> call(performActionEndpoint(ActionId:Usize))
            ~> _:KItem
            ~> _:KItem
            ~> clearExternalCallEnv
            ~> (.K => splitActionSigners(ActionId, ActionSigners))
        ...</k>
        <action-signers>ActionSigners:Map</action-signers>
    [priority(20)]

  rule  splitActionSigners(ActionId:Usize, ActionSigners:Map)
        =>  branchK(
                ActionId in_keys(ActionSigners),
                makeConcreteValue(ActionId, rExpressionList, ActionSigners),
                .K
            )

  rule <k> splitPerformActionEndpoint(ActionId:Usize)
          =>  branchK(
                CallerAddress in_keys(AddressToUserId),
                splitPerformActionEndpoint1(ActionId),
                perform-new.k
              )
        ... </k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>

  rule <k> splitPerformActionEndpoint1(ActionId:Usize)
          =>  makeConcreteValue(CallerAddress, rUsize, AddressToUserId)
              ~>  makeConcreteValue(AddressToUserId[CallerAddress], rAddress, UserIdToAddress)
              ~>  branchK(
                    AddressToUserId[CallerAddress] in_keys(UserIdToRole),
                    makeConcreteValue(AddressToUserId[CallerAddress], rUserRole, UserIdToRole)
                      ~>  branchK(
                            ActionId in_keys(ActionSigners),
                            makeConcreteValue(ActionId, rExpressionList, ActionSigners)
                              ~> splitPerformActionEndpoint1a(ActionId),
                            splitPerformActionEndpoint1a(ActionId)
                          ),
                    perform-none.k
                  )
        ... </k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
        <user-roles> UserIdToRole:Map </user-roles>
        <caller-address>CallerAddress:Address</caller-address>
        <action-signers>ActionSigners:Map</action-signers>
    requires CallerAddress in_keys(AddressToUserId)

  rule <k> splitPerformActionEndpoint1a(ActionId:Usize)
          =>  branchK(
                  Quorum <=Int countCanSignFunction({ActionSigners[ActionId] orDefault [.]}:>ExpressionList, UserIdToRole),
                  branchK(
                      ActionId in_keys(ActionData),
                      makeConcreteValue(ActionId, rAction, ActionData)
                        ~> splitPerformActionEndpoint2(ActionId),
                      perform-nothing.k
                  ),
                  perform-no-quorum.k
              )
        ... </k>
        <address-to-user-id>CallerAddress |-> UserId:KItem _AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>
        <quorum>u(Quorum:Int)</quorum>
        <user-roles>(UserId |-> _Role _UserIdToRole:Map) #as UserIdToRole:Map</user-roles>
        <action-signers>ActionSigners:Map</action-signers>
        <action-data>ActionData:Map</action-data>

  syntax Bool ::= isAddBoardMember(Action)  [function, functional]
  rule isAddBoardMember(AddBoardMember(_)) => true
  rule isAddBoardMember(_) => false [owise]

  syntax Bool ::= isAddProposer(Action)  [function, functional]
  rule isAddProposer(AddProposer(_)) => true
  rule isAddProposer(_) => false [owise]

  syntax Bool ::= isChangeQuorum(Action)  [function, functional]
  rule isChangeQuorum(ChangeQuorum(_)) => true
  rule isChangeQuorum(_) => false [owise]

  syntax Bool ::= isRemoveUser(Action)  [function, functional]
  rule isRemoveUser(RemoveUser(_)) => true
  rule isRemoveUser(_) => false [owise]

  syntax Bool ::= isScCall(Action)  [function, functional]
  rule isScCall(SCCall(_, _, _, _)) => true
  rule isScCall(_) => false [owise]

  syntax Bool ::= isScDeploy(Action)  [function, functional]
  rule isScDeploy(SCDeploy(_, _, _, _)) => true
  rule isScDeploy(_) => false [owise]

  syntax Bool ::= isSendEgld(Action)  [function, functional]
  rule isSendEgld(SendEgld(_, _, _)) => true
  rule isSendEgld(_) => false [owise]

  rule  <k> splitPerformActionEndpoint2(ActionId)
          =>  splitPerformActionEndpoint3(Action)
        ...</k>
        <action-data>ActionId |-> Action:Action _ActionData:Map</action-data>

  syntax KItem ::= "action-splitted"
  rule action-splitted => .K

  rule  splitPerformActionEndpoint3(Action:Action)
        =>  splitAction(Action)
            ~> splitPerformActionEndpoint4(Action)

  rule  splitPerformActionEndpoint4(Action:Action)
        =>  branchK(
              isAddBoardMember(Action),
              splitAddBoardMember(Action),
              branchK(
                isAddProposer(Action),
                splitAddProposer(Action),
                branchK(
                  isChangeQuorum(Action),
                  splitChangeQuorum(Action),
                  branchK(
                    isRemoveUser(Action),
                    splitRemoveUser(Action),
                    branchK(
                      isScCall(Action),
                      sc-call.k,
                      branchK(
                        isScDeploy(Action),
                        sc-deploy.k,
                        branchK(
                          isSendEgld(Action),
                          send-egld.k,
                          stuck
                        )
                      )
                    )
                  )
                )
              )
          )

  rule  <k>
          splitAddBoardMember(AddBoardMember(UserAddress:Address))
          =>  branchK(
                UserAddress ==K CallerAddress,
                splitAddBoardMember1(UserAddress),
                branchK(
                  UserAddress in_keys(AddressToUserId),
                  splitAddBoardMember2(UserAddress),
                  add-board-member-New.k
                )
              )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>

  rule  <k>
          splitAddBoardMember1(CallerAddress:Address)
          =>  makeConcreteValue(CallerId, rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[CallerId] ==K BoardMember,
                    add-board-member-BoardMember-eq.k,
                    branchK(
                      UserIdToRole[CallerId] ==K Proposer,
                      add-board-member-Proposer-eq.k,
                      stuck
                    )
                  )
        ...</k>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>CallerAddress |-> CallerId:Usize _AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>
    requires CallerId in_keys(UserIdToRole)

  rule  <k>
          splitAddBoardMember2(UserAddress:Address)
          =>  makeConcreteValue(UserAddress, rUsize, AddressToUserId)
              ~> makeConcreteValue(AddressToUserId[UserAddress], rAddress, UserIdToAddress)
              ~> makeConcreteValue(AddressToUserId[CallerAddress], rAddress, UserIdToAddress)
              ~> branchK(
                AddressToUserId[UserAddress] in_keys(UserIdToRole),
                splitAddBoardMember3(UserAddress),
                add-board-member-None.k
              )
        ...</k>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
        <caller-address>CallerAddress:Address</caller-address>
    requires UserAddress in_keys(AddressToUserId) andBool CallerAddress in_keys(AddressToUserId)

  rule  <k>
          splitAddBoardMember3(UserAddress:Address)
          =>  makeConcreteValue(UserId, rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[UserId] ==K BoardMember,
                    add-board-member-BoardMember.k,
                    branchK(
                      UserIdToRole[UserId] ==K Proposer,
                      add-board-member-Proposer.k,
                      stuck
                    )
              )
        ...</k>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>UserAddress |-> UserId _AddressToUserId:Map</address-to-user-id>
    requires UserId in_keys(UserIdToRole)


  rule  <k>
          splitAddProposer(AddProposer(UserAddress:Address))
          =>  branchK(
                UserAddress ==K CallerAddress,
                splitAddProposer1(UserAddress),
                branchK(
                  UserAddress in_keys(AddressToUserId),
                  splitAddProposer2(UserAddress),
                  add-proposer-New.k
                )
              )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>

  rule  <k>
          splitAddProposer1(CallerAddress:Address)
          =>  makeConcreteValue(CallerId, rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[CallerId] ==K BoardMember,
                    branchK(
                      Quorum ==K NumBoardMembers,
                      add-proposer-BoardMember-no-quorum-eq.k,
                      branchK(
                        Quorum <=Int NumBoardMembers -Int 1,
                        add-proposer-BoardMember-eq.k,
                        stuck
                      )
                    ),
                    branchK(
                      UserIdToRole[CallerId] ==K Proposer,
                      add-proposer-Proposer-eq.k,
                      stuck
                    )
              )
        ...</k>
        <num-board-members>u(NumBoardMembers)</num-board-members>
        <quorum>u(Quorum)</quorum>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>CallerAddress |-> CallerId:Usize _AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>
    requires CallerId in_keys(UserIdToRole)

  rule  <k>
          splitAddProposer2(UserAddress:Address)
          =>  makeConcreteValue(UserAddress, rUsize, AddressToUserId)
              ~> makeConcreteValue(AddressToUserId[UserAddress], rAddress, UserIdToAddress)
              ~> makeConcreteValue(AddressToUserId[CallerAddress], rAddress, UserIdToAddress)
              ~>  branchK(
                    AddressToUserId[UserAddress] in_keys(UserIdToRole),
                    splitAddProposer3(UserAddress),
                    add-proposer-None.k
                  )
        ...</k>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
        <caller-address>CallerAddress:Address</caller-address>
    requires UserAddress in_keys(AddressToUserId) andBool CallerAddress in_keys(AddressToUserId)

  rule  <k>
          splitAddProposer3(UserAddress:Address)
          =>  makeConcreteValue(UserId, rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[UserId] ==K BoardMember,
                    branchK(
                      Quorum ==K NumBoardMembers,
                      add-proposer-BoardMember-no-quorum.k,
                      add-proposer-BoardMember.k
                    ),
                    branchK(
                      UserIdToRole[UserId] ==K Proposer,
                      add-proposer-Proposer.k,
                      stuck
                    )
                  )
        ...</k>
        <num-board-members>u(NumBoardMembers:Int)</num-board-members>
        <quorum>u(Quorum:Int)</quorum>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>UserAddress |-> UserId:Usize _AddressToUserId:Map</address-to-user-id>
    requires UserId in_keys(UserIdToRole)

  rule  <k>
          splitChangeQuorum(ChangeQuorum(u(NewQuorum:Int)))
          => branchK(
              NewQuorum >Int NumBoardMembers,
              change-quorum-no-quorum.k,
              change-quorum.k
          )
        ...</k>
        <num-board-members>u(NumBoardMembers:Int)</num-board-members>

  rule  <k>
          splitRemoveUser(RemoveUser(UserAddress:Address))
          =>  branchK(
                UserAddress ==K CallerAddress,
                splitRemoveUser1(UserAddress),
                branchK(
                  UserAddress in_keys(AddressToUserId),
                  splitRemoveUser2(UserAddress),
                  remove-user-New.k
                )
              )
        ...</k>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>

  rule  <k>
          splitRemoveUser1(CallerAddress:Address)
          =>  makeConcreteValue(CallerId, rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[CallerId] ==K BoardMember,
                    branchK(
                      NumBoardMembers +Int NumProposers ==Int 1
                          orBool Quorum ==Int NumBoardMembers,
                      remove-user-BoardMember-too-few-eq.k,
                      remove-user-BoardMember-eq.k
                    ),
                    branchK(
                      UserIdToRole[CallerId] ==K Proposer,
                      branchK(
                        NumBoardMembers +Int NumProposers ==Int 1,
                        remove-user-Proposer-nobody-left-eq.k,
                        remove-user-Proposer-eq.k
                      ),
                      stuck
                    )
                  )
        ...</k>
        <num-board-members>u(NumBoardMembers)</num-board-members>
        <num-proposers>u(NumProposers)</num-proposers>
        <quorum>u(Quorum)</quorum>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>CallerAddress |-> CallerId:Usize _AddressToUserId:Map</address-to-user-id>
        <caller-address>CallerAddress:Address</caller-address>
    requires CallerId in_keys(UserIdToRole)

  rule  <k>
          splitRemoveUser2(UserAddress:Address)
          =>  makeConcreteValue(UserAddress, rUsize, AddressToUserId)
              ~> makeConcreteValue(AddressToUserId[CallerAddress], rAddress, UserIdToAddress)
              ~> makeConcreteValue(AddressToUserId[UserAddress], rAddress, UserIdToAddress)
              ~>  branchK(
                    AddressToUserId[UserAddress] in_keys(UserIdToRole),
                    splitRemoveUser3(UserAddress),
                    remove-user-None.k
                  )
        ...</k>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>AddressToUserId:Map</address-to-user-id>
        <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
        <caller-address>CallerAddress:Address</caller-address>
    requires UserAddress in_keys(AddressToUserId) andBool CallerAddress in_keys(AddressToUserId)

  rule  <k>
          splitRemoveUser3(UserAddress:Address)
          =>  makeConcreteValue(UserId, rUserRole, UserIdToRole)
              ~>  branchK(
                    UserIdToRole[UserId] ==K BoardMember,
                    branchK(
                      NumBoardMembers +Int NumProposers ==Int 1
                          orBool Quorum ==Int NumBoardMembers,
                      remove-user-BoardMember-too-few.k,
                      remove-user-BoardMember.k
                    ),
                    branchK(
                      UserIdToRole[UserId] ==K Proposer,
                      branchK(
                        NumBoardMembers +Int NumProposers ==Int 1,
                        remove-user-Proposer-nobody-left.k,
                        remove-user-Proposer.k
                      ),
                      stuck
                    )
                  )
        ...</k>
        <num-board-members>u(NumBoardMembers:Int)</num-board-members>
        <num-proposers>u(NumProposers:Int)</num-proposers>
        <quorum>u(Quorum:Int)</quorum>
        <user-roles>UserIdToRole:Map</user-roles>
        <address-to-user-id>UserAddress |-> UserId:Usize _AddressToUserId:Map</address-to-user-id>
    requires UserId in_keys(UserIdToRole)
endmodule
