require "protocol-correctness/proof/instrumentation-map.k"

module INSTRUMENTATION-UNSIGN
  // TODO: Do I need this?
  imports INSTRUMENTATION-MAP

  syntax KItem ::= splitUnsign(actionId:Usize)
  syntax KItem ::= splitUnsign2(actionId:Usize)
  syntax KItem ::= splitUnsign3(actionId:Usize)
  syntax KItem ::= splitUnsign4(actionId:Usize)
  syntax KItem ::= splitUnsign5(signers:ExpressionList, userId:Usize)

  rule  preCall
        ~> (.K => splitUnsign(ActionId))
        ~> call(unsign(ActionId:Usize))
  [priority(20)]

  rule  <k> splitUnsign(ActionId:Usize)
            =>  branchK(
                    ActionId in_keys(ActionData),
                    makeConcreteValue(ActionId, rAction, ActionData)
                        ~>  branchK(
                              CallerAddress in_keys(AddressToUserId),
                              splitUnsign2(ActionId),
                              unsign-new.k
                            ),
                    .K
                )
        ... </k>
        <action-data>ActionData:Map</action-data>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <caller-address>CallerAddress:CallerAddress</caller-address>

  rule  <k> splitUnsign2(ActionId:Usize)
            =>    makeConcreteValue(CallerAddress, rUsize, AddressToUserId)
              ~>  branchK(
                      AddressToUserId[CallerAddress] in_keys(UserIdToRole),
                      splitUnsign3(ActionId),
                      unsign-no-role.k
                  )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <user-roles>UserIdToRole:Map</user-roles>
        <caller-address>CallerAddress:CallerAddress</caller-address>
    requires CallerAddress in_keys(AddressToUserId)

  rule  <k> splitUnsign3(ActionId:Usize)
            =>    makeConcreteValue(AddressToUserId[CallerAddress], rUserRole, UserIdToRole)
              ~>  branchK(
                      UserIdToRole[AddressToUserId[CallerAddress]] ==K BoardMember,
                      branchK(
                          ActionId in_keys(ActionSigners),
                          makeConcreteValue(ActionId, rExpressionList, ActionSigners)
                            ~>  splitUnsign4(ActionId),
                          .K
                      ),
                      .K
                  )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <user-roles>UserIdToRole:Map</user-roles>
        <caller-address>CallerAddress:CallerAddress</caller-address>
        <action-signers>ActionSigners:Map</action-signers>
    requires true
        andBool CallerAddress in_keys(AddressToUserId)
        andBool AddressToUserId[CallerAddress] in_keys(UserIdToRole)

  rule  <k> splitUnsign4(ActionId:Usize)
            =>  splitUnsign5(
                    {ActionSigners[ActionId]}:>ExpressionList,
                    {AddressToUserId[CallerAddress]}:>Usize
                )
        ...</k>
        <action-signers>ActionSigners:Map</action-signers>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <caller-address>CallerAddress:CallerAddress</caller-address>
    requires true
        andBool ActionId in_keys(ActionSigners)
        andBool isExpressionList(ActionSigners[ActionId])
        andBool CallerAddress in_keys(AddressToUserId)
        andBool isUsize(AddressToUserId[CallerAddress])

  rule  splitUnsign5(Signers:ExpressionList, UserId:Usize)
        =>  branchK(
                #listFind(Signers, UserId) >=Int 0,
                concretizeExpressionList(Signers, 2)
                ~>  branchK(
                        pListLen(Signers) >=Int 1,
                        makeConcrete(expressionListGetOrDefault(Signers, 0, void), rUsize)
                          ~>  branchK(
                                  pListLen(Signers) ==Int 1,
                                  branchK(
                                      expressionListGetOrDefault(Signers, 0, void) ==K UserId,
                                      .K,
                                      .K
                                  ),
                                  branchK(
                                      pListLen(Signers) >=Int 2,
                                      makeConcrete(expressionListGetOrDefault(Signers, 1, void), rUsize)
                                        ~>  branchK(
                                                expressionListGetOrDefault(Signers, 0, void) ==K UserId,
                                                .K,
                                                branchK(
                                                    expressionListGetOrDefault(Signers, 1, void) ==K UserId,
                                                    .K,
                                                    .K
                                                )
                                            ),
                                      stuck
                                  )
                              ),
                        stuck
                    ),
                // branchK(
                //     ActionSigners[ActionId] ==K [?UserId1:Expression, .],
                //     makeConcrete(?UserId1, rUsize)
                //       ~>  branchK(
                //               ?UserId1 ==K AddressToUserId[CallerAddress],
                //               .K,
                //               .K
                //           ),
                //     branchK(
                //         ActionSigners[ActionId] ==K [?UserId2:Expression, ?UserId3:Expression, ?_:ExpressionCSV],
                //         makeConcrete(?UserId2, rUsize)
                //           ~>  makeConcrete(?UserId3, rUsize)
                //           ~>  branchK(
                //                   ?UserId2 ==K AddressToUserId[CallerAddress],
                //                   .K,
                //                   .K
                //               ),
                //         .K
                //     )
                // ),
                .K
            )
    requires true

  // rule  splitUnsign6(ActionId:Usize, Signers:ExpressionList, UserId:Usize)
  //       =>  branchK(
  //               #listFind(Signers, UserId) >=Int 0,
  //               concretizeExpressionList(Signers, 2)
  //               ~>  branchK(
  //                       pListLen(Signers) >=Int 1,
  //                       makeConcrete(expressionListGetOrDefault(Signers, 0, void), rUsize)
  //                         ~>  branchK(
  //                                 pListLen(Signers) ==Int 1,
  //                                 branchK(
  //                                     expressionListGetOrDefault(Signers, 0, void) ==K UserId,
  //                                     .K,
  //                                     .K
  //                                 ),
  //                                 branchK(
  //                                     pListLen(Signers) >=Int 2,
  //                                     makeConcrete(expressionListGetOrDefault(Signers, 1, void), rUsize)
  //                                       ~>  branchK(
  //                                               expressionListGetOrDefault(Signers, 1, void) ==K UserId,
  //                                               .K,
  //                                               .K
  //                                           ),
  //                                     stuck
  //                                 )
  //                             ),
  //                       stuck
  //                   ),
  //               .K
  //           )
  //   requires true
endmodule
