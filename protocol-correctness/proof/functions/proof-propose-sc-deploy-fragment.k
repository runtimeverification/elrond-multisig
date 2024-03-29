// breadth = 6
//@ proof
module PROOF-PROPOSE-SC-DEPLOY-FRAGMENT
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY-FRAGMENT
//@ end
    imports INVARIANT
  imports CODE-METADATA-FUNCTION-SYNTAX

  claim <T><TT>
          <k> runPseudoCode(
                  code_metadata = CodeMetadata::DEFAULT;
                  if (Upgradeable) {
                    code_metadata = code_metadata | CodeMetadata::UPGRADEABLE;
                  }
                  if (Payable) {
                    code_metadata = code_metadata | CodeMetadata::PAYABLE;
                  }
                  if (Readable) {
                    code_metadata = code_metadata | CodeMetadata::READABLE;
                  }
                  proposeActionSCDeploy(Amount, Code, code_metadata, Args);
              )
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
          <k> runPseudoCode(
                  proposeActionSCDeploy(Amount, Code, code_metadata, Args);
              )
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
              u(ActionLastIndex:Int),
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              code_metadata |-> codeMetadataFunction(Upgradeable, Payable, Readable),
              PerformedActions:List
              )
        </TT></T>
    requires true
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
