// timeout = long
// breadth = 2
//@ proof
module PROOF-INIT-LOOP-ERROR
//@ trusted
// module TRUSTED-INIT-LOOP-ERROR
//@ end
  imports INIT-LOOP-PARTS
  imports LIST-NO-COMMON-ITEM-SYNTAX

  claim <T> initLoopLhs(
              PrevIndex:Usize,
              Addresses:ExpressionList,
              K:K,
              UserIdToAddress0:Map,
              AddressToUserId0:Map,
              UserIdToRole0:Map,
              Quorum:Usize,
              ActionState:ActionStateCell,
              .Map,  // TODO: Variables:Map,
              Stack:Stack,
              ExternalCallEnv:ExternalCallEnvCell,
              _Address0:Expression,
              _UserId0:Usize)
        </T>
      =>
        <T> initLoopRhs(
              error,
              K,
              ?_UserIdToAddress1:Map,
              ?_AddressToUserId1:Map,
              ?_UserIdToRole1,
              Quorum,
              ActionState,
              .Map,  // TODO: Variables,
              Stack,
              ExternalCallEnv,
              add(PrevIndex, u(pListLen(Addresses))),
              ?_Address1:Expression,
              ?_UserId1:Usize)
        </T>
    requires
        initLoopRequires(
            PrevIndex,
            Addresses,
            UserIdToAddress0,
            AddressToUserId0,
            UserIdToRole0)
        andBool notBool listNoCommonItem(add(PrevIndex, u(2)), AddressToUserId0, Addresses)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
