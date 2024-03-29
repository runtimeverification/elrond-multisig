// timeout = long
// breadth = 3
//@ proof
require "trusted-perform-action-remove-user-New.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ID-REMOVE-USER-NEW
  imports TRUSTED-PERFORM-ACTION-REMOVE-USER-NEW
//@ trusted
// module TRUSTED-PERFORM-ACTION-ID-REMOVE-USER-NEW
//@ end

    imports PSEUDOCODE
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX

  claim
      <T> <TT>
          <k> call(performActionFromId(ActionId:Usize)) ~> K:K </k>
          <state>
            <contract-state>
              <users>
                <num-users>u(NumUsers:Int)</num-users>
                <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
                <address-to-user-id>AddressToUserId:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(NumBoardMembers:Int)</num-board-members>
                <num-proposers>u(NumProposers:Int)</num-proposers>
                <user-roles>UserIdToRole:Map</user-roles>
                <quorum>u(Quorum:Int)</quorum>
              </board-state>
              <action-state>
                <action-last-index>ActionLastIndex:Usize</action-last-index>
                <actions>
                  <action-data>
                      ActionId |-> RemoveUser(UserAddress:Address) #as Action:Action
                      ActionData:Map
                  </action-data>
                  <action-signers>ActionSigners:Map</action-signers>
                </actions>
              </action-state>
            </contract-state>
            <pseudocode-state>
              <variables>.Map</variables>
              <stack>Stack:Stack</stack>
            </pseudocode-state>
            <external-call-env>
              <caller-address>CallerAddress:Address</caller-address>
            </external-call-env>
            <log>
              <performed-actions>PerformedActions:List</performed-actions>
            </log>
          </state>
      </TT> </T>
      =>
      <T> <TT>
          <k> evaluate(void) ~> K </k>
          <state>
            <contract-state>
              <users>
                <num-users>u(NumUsers +Int 1)</num-users>
                <user-id-to-address>u(NumUsers +Int 1) |-> UserAddress UserIdToAddress</user-id-to-address>
                <address-to-user-id>UserAddress |-> u(NumUsers +Int 1) AddressToUserId</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(NumBoardMembers)</num-board-members>
                <num-proposers>u(NumProposers)</num-proposers>
                <user-roles>UserIdToRole</user-roles>
                <quorum>u(Quorum)</quorum>
              </board-state>
              <action-state>
                <action-last-index>ActionLastIndex</action-last-index>
                <actions>
                  <action-data>ActionData</action-data>
                  <action-signers>ActionSigners[ActionId <- undef]</action-signers>
                </actions>
              </action-state>
            </contract-state>
            <pseudocode-state>
              <variables>?_Variables:Map</variables>
              <stack>Stack</stack>
            </pseudocode-state>
            <external-call-env>
              <caller-address>CallerAddress</caller-address>
            </external-call-env>
            <log>
              <performed-actions>ListItem(Action) PerformedActions</performed-actions>
            </log>
          </state>
      </TT> </T>
    requires true
      andBool isKResult(Action)
      andBool NumUsers >=Int 0
      // TODO: Perhaps replace with unusedIdsInMapValues(AddressToUserId) +
      // something to map values to keys.
      andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToAddress), expand(expanded))
      andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToRole), expand(expanded))

      andBool mapKeysAreOfType(UserIdToAddress, rUsize)
      andBool mapKeysAreOfType(UserIdToRole, rUsize)

      andBool NumBoardMembers +Int NumProposers >Int 0
      andBool Quorum <=Int NumBoardMembers

      andBool notBool (UserAddress in_keys(AddressToUserId))
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
