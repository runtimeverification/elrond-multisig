// timeout = moderate
// breadth = 2
//@ proof
module PROOF-INIT-LOOP-BODY-NO-ERROR
//@ trusted
// module TRUSTED-INIT-LOOP-BODY-NO-ERROR
//@ end
  imports INIT-LOOP-PARTS

  claim <T> initLoopBodyLhs(
              u(PrevIndex:Int),
              K:K,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionState:ActionStateCell,
              Variables:Map,
              Stack:Stack,
              ExternalCallEnv:ExternalCallEnvCell,
              Address:Expression,
              _UserId0:Usize)
        </T>
      =>
        <T> initLoopBodyRhs(
              K,
              (u(PrevIndex +Int 1) |-> Address):Map UserIdToAddress:Map,
              Address |-> u(PrevIndex +Int 1) AddressToUserId,
              u(PrevIndex +Int 1) |-> BoardMember UserIdToRole,
              Quorum,
              ActionState,
              Variables,
              Stack,
              ExternalCallEnv,
              u(PrevIndex),
              Address,
              u(PrevIndex +Int 1))
        </T>
    requires true
      andBool isKResult(Address)
      andBool isAddress(Address)
      andBool notBool Address in_keys(AddressToUserId)
      andBool PrevIndex >=Int 0
      andBool notBool u(PrevIndex +Int 1) in_keys(UserIdToAddress)
      andBool notBool u(PrevIndex +Int 1) in_keys(UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
