// timeout = long
// breadth = 2
//@ proof
require "trusted-init-loop-body-no-error.k"  //@ Bazel remove

module PROOF-INIT-LOOP-NO-ERROR
  imports TRUSTED-INIT-LOOP-BODY-NO-ERROR
//@ trusted
// module TRUSTED-INIT-LOOP-NO-ERROR
//@ end
  imports INIT-LOOP-PARTS

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
              evaluate(void),
              K,
              ?UserIdToAddress1:Map,
              ?AddressToUserId1:Map,
              ?UserIdToRole1,
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
        andBool noCommonItem(add(PrevIndex, u(2)), AddressToUserId0, Addresses)
    ensures
        initLoopEnsures(
            add(add(PrevIndex, u(pListLen(Addresses))), u(1)),
            Addresses,
            ?UserIdToAddress1,
            ?AddressToUserId1,
            UserIdToRole0,
            ?UserIdToRole1)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule