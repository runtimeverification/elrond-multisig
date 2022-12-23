// breadth = 4
// Fails because of https://github.com/kframework/kore/issues/2828
//@ proof

module PROOF-CALL-INVARIANT-PREFIX-FRAGMENT-SIGN

//@ trusted
// module TRUSTED-CALL-INVARIANT-PREFIX-FRAGMENT-SIGN
//@ end

  imports BASE-TYPES-SYNTAX
  imports CONCRETIZE-VALUE-SYNTAX
  imports INVARIANT
  imports K-EQUAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MAP
  imports PSEUDOCODE-CONFIGURATION
  imports RUNNING-SYNTAX

  claim <T><TT>
          <k> 
              concretizeValue(ActionId:Usize)
              ~> concretizeValue(ActionId in_keys(ActionData:Map))
              ~> concretizeValue(ActionId ==K DeleteActionId:Usize)
              ~> runExternalCall(
                    from MaliciousAddress run sign(ActionId);
                ) #as ExternalCall:KItem
              ~> deleteMaliciousUserActionId(DeleteActionId) #as DeleteId:KItem
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
          <k> ExternalCall ~> DeleteId ~> K:K
          </k>
          invariantState(
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
              PerformedActions):StateCell
        </TT></T>
    requires true
    ensures     (    {ActionId #Equals DeleteActionId}
                #And {ActionId in_keys(ActionData) #Equals true}
                )
            #Or (    #Not({ActionId #Equals DeleteActionId})
                #And {ActionId in_keys(ActionData) #Equals true}
                )
            #Or (    {ActionId #Equals DeleteActionId}
                #And {ActionId in_keys(ActionData) #Equals false}
                )
            #Or (    #Not({ActionId #Equals DeleteActionId})
                #And {ActionId in_keys(ActionData) #Equals false}
                )

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
