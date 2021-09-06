// breadth = 3
// Not working because of https://github.com/kframework/kore/issues/2828
//@ proof
module PROOF-MAP-SEMANTICS
//@ trusted
// module TRUSTED-MAP-SEMANTICS
//@ end

  imports MAP-EXECUTE

  claim mapSelectProperty(M:Map, Property:MapElementProperty)
      => mapSelected(?Key:KItem, ?Value:KItem, ?M:Map)
    requires mapCount(M, Property) >Int 0
    ensures applyMapElementProperty(Property, ?Key, ?Value)
        andBool M ==K (?Key |-> ?Value ?M)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim mapSelectProperty(M:Map, Property:MapElementProperty)
      => mapNotFound
    requires notBool (mapCount(M, Property) >Int 0)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  //@ proof
  claim #mapSelectProperty(M:Map, Property:MapElementProperty, Processed:Map)
      => mapSelected(?Key:KItem, ?Value:KItem, ?M:Map)
    requires mapCount(M, Property) >Int 0
    ensures applyMapElementProperty(Property, ?Key, ?Value)
        andBool (?Key |-> ?Value ?M) ==K (M Processed)

  claim #mapSelectProperty(M:Map, Property:MapElementProperty, _Processed:Map)
      => mapNotFound
    requires notBool (mapCount(M, Property) >Int 0)

  claim lazyMapSelectProperty(M:Map, MEP.IsValue(2) #as Property:MapElementProperty)
      => mapSelected(?Key:KItem, 2, ?N:Map)
    requires mapCount(M, Property) >Int 0
    ensures M ==K (?Key:KItem |-> 2 ?N)
  claim lazyMapSelectProperty(M:Map, MEP.IsValue(2) #as Property:MapElementProperty)
      => mapNotFound
    requires notBool mapCount(M, Property) >Int 0

  claim lazyMapSelectProperty(
          (2|->2 N:Map) #as M:Map,
          MEP.IsValue(2) #as Property:MapElementProperty)
      => mapSelected(2, 2, N)
    requires mapCount(M, Property) >Int 0
  //@ trusted
  //@ end

endmodule
