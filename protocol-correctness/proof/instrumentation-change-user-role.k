require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/proof/instrumentation-perform-split-action.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-CHANGE-USER-ROLE
  // TODO: Do I need this?
  imports INSTRUMENTATION-MAP

  imports PSEUDOCODE

  syntax KItem ::= splitChangeUserRole(Address)
  syntax KItem ::= splitChangeUserRole2(Address)
  syntax KItem ::= splitChangeUserRole3(Usize)

  rule  preCall
        ~> (.K => splitChangeUserRole(UserAddress))
        ~> call(changeUserRole(UserAddress:Address, _NewRole:UserRole))
  [priority(20)]

  rule  <k> splitChangeUserRole(Address:Address)
            =>  branchK(
                  Address in_keys(AddressToUserId),
                  splitChangeUserRole2(Address),
                  .K
                )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>

  rule  <k> splitChangeUserRole2(Address:Address)
            =>    makeConcreteValue(Address, rUsize, AddressToUserId)
              ~>  branchK(
                    AddressToUserId[Address] in_keys(UserIdToRole),
                    makeConcreteValue(AddressToUserId[Address], rUserRole, UserIdToRole),
                    .K
                  )
        ... </k>
        <address-to-user-id> AddressToUserId:Map </address-to-user-id>
        <user-roles>UserIdToRole:Map</user-roles>
    requires Address in_keys(AddressToUserId)
endmodule
