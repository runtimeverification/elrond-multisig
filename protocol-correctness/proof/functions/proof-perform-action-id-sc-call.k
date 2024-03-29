// timeout = moderate
// breadth = 3
//@ proof
require "trusted-perform-action-sc-call.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ID-SC-CALL
  imports TRUSTED-PERFORM-ACTION-SC-CALL
//@ trusted
// module TRUSTED-PERFORM-ACTION-ID-SC-CALL
//@ end

  imports PSEUDOCODE

  claim
      <T> <TT>
          <k> call(performActionFromId(ActionId:Usize)) ~> K:K
          </k>
          <state>
            <contract-state>
              <users>
                <num-users>NumUsers:Usize</num-users>
                <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
                <address-to-user-id>AddressToUserId:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>NumBoardMembers:Usize</num-board-members>
                <num-proposers>NumProposers:Usize</num-proposers>
                <user-roles>UserIdToRole:Map</user-roles>
                <quorum>Quorum:Usize</quorum>
              </board-state>
              <action-state>
                <action-last-index>ActionLastIndex:Usize</action-last-index>
                <actions>
                  <action-data>
                      ActionId |-> SCCall(
                          _To:Address,
                          _Amount:BigUint,
                          _Function:BoxedBytes,
                          _Arguments:ExpressionList) #as Action:Action
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
                <num-users>NumUsers</num-users>
                <user-id-to-address>UserIdToAddress</user-id-to-address>
                <address-to-user-id>AddressToUserId</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>NumBoardMembers</num-board-members>
                <num-proposers>NumProposers</num-proposers>
                <user-roles>UserIdToRole</user-roles>
                <quorum>Quorum</quorum>
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
              <variables>?_Variables</variables>
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
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule