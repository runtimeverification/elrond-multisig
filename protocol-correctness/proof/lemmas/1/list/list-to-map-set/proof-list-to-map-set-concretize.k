// breadth = 4
//@ proof
require "../../../0/map/unification/trusted-two-element-vs-one-element.k"  //@ Bazel remove

module PROOF-LIST-TO-MAP-SET-CONCRETIZE
  imports  TRUSTED-TWO-ELEMENT-VS-ONE-ELEMENT
//@ trusted
// module TRUSTED-LIST-TO-MAP-SET-CONCRETIZE
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMA-LIST-TO-MAP-SET-CONCRETIZE-SYNTAX

  claim lemmaListToMapSetConcretize(L:ExpressionCSV, E1:Expression, E2:Expression) => .K
    requires true
        andBool listToMapSet([L])[E1 <- 0][E2 <- undef]
            ==K E1 |-> 0
        andBool notBool #listContainsUnsafe([L], E1)
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
    ensures [E1, L] ==K [E1, .] orBool [E1, L] ==K [E1, E2, .]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule

/*
  L --- es
  e1 --- toadd
  e2 --- toremove
  e3 --- e1
  es3 --- es1
  [L] ==K [.] orBool [L] ==K [E2, .]
    requires true
        andBool listToMapSet([L])[E1 <- 0][E2 <- undef]
            ==K E1 |-> 0
        andBool notBool #listContainsUnsafe([L], E1)
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
  *** notBool e1 in_keys(listToMapSet([L])) requires notBool #listContainsUnsafe([L], E1)
  [L] ==K [.] orBool [L] ==K [E2, .]
    requires true
        andBool listToMapSet([L])[E1 <- 0][E2 <- undef]
            ==K E1 |-> 0
        andBool notBool #listContainsUnsafe([L], E1)
        andBool notBool e1 in_keys(listToMapSet([L]))
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
  [L] ==K [.] orBool [L] ==K [E2, .]
    requires true
        andBool (listToMapSet([L]) E1 |-> 0)[E2 <- undef]
            ==K E1 |-> 0
        andBool notBool #listContainsUnsafe([L], E1)
        andBool notBool e1 in_keys(listToMapSet([L]))
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
  [L] ==K [.] orBool [L] ==K [E2, .]
    requires true
        andBool (listToMapSet([L])[E2 <- undef] E1 |-> 0)
            ==K E1 |-> 0
        andBool notBool #listContainsUnsafe([L], E1)
        andBool notBool e1 in_keys(listToMapSet([L]))
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
  [L] ==K [.] orBool [L] ==K [E2, .]
    requires true
        andBool listToMapSet([L])[E2 <- undef] ==K .Map
        andBool notBool #listContainsUnsafe([L], E1)
        andBool notBool e1 in_keys(listToMapSet([L]))
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
case $firstOrDefault("L", "e2") == "e2" of
  true ->
    [L] ==K [.] orBool [L] ==K [E2, .]
      requires true
          andBool listToMapSet([L])[E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([L], E1)
          andBool notBool e1 in_keys(listToMapSet([L]))
          andBool listElementsAreDistinctUnsafe([L])
          andBool notBool E1 ==K E2
          andBool firstOrDefault(L, e2) == e2
    case L of
      . ->
        [.] ==K [.] orBool [.] ==K [E2, .]
          requires true
              andBool listToMapSet([.])[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([.], E1)
              andBool notBool e1 in_keys(listToMapSet([.]))
              andBool listElementsAreDistinctUnsafe([.])
              andBool notBool E1 ==K E2
              andBool firstOrDefault(., e2) == e2
        ok
      e3 <> es3 ->
        [e3 <> es3] ==K [.] orBool [e3 <> es3] ==K [E2, .]
          requires true
              andBool listToMapSet([e3 <> es3])[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([e3 <> es3]))
              andBool listElementsAreDistinctUnsafe([e3 <> es3])
              andBool notBool E1 ==K E2
              andBool firstOrDefault(e3 <> es3, e2) == e2
        [e3 <> es3] ==K [E2, .]
          requires true
              andBool listToMapSet([es3])[e3 <- 0][E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3])[e3 <- 0])
              andBool notBool #listContainsUnsafe([es3], e3)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool e3 == e2
        [e2 <> es3] ==K [E2, .]
          requires true
              andBool listToMapSet([es3])[e2 <- 0][E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e2 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3])[e2 <- 0])
              andBool notBool #listContainsUnsafe([es3], e2)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
        es3 ==K .
          requires true
              andBool listToMapSet([es3])[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3]) e2 |-> 0)
              andBool notBool #listContainsUnsafe([es3], e2)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
        es3 ==K .
          requires true
              andBool listToMapSet([es3])[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3]))
              andBool notBool #listContainsUnsafe([es3], e2)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
        *** listToMapSet([es3])[E2 <- undef] == listToMapSet([es3])
              requires notBool #listContainsUnsafe([es3], e2)
        es3 ==K .
          requires true
              andBool listToMapSet([es3]) ==K .Map
              andBool notBool #listContainsUnsafe([es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3]))
              andBool notBool #listContainsUnsafe([es3], e2)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
        case es3 of
          . ->
            . ==K .
              requires true
                  andBool listToMapSet([.]) ==K .Map
                  andBool notBool #listContainsUnsafe([.], E1)
                  andBool notBool e1 in_keys(listToMapSet([.]))
                  andBool notBool #listContainsUnsafe([.], e2)
                  andBool listElementsAreDistinctUnsafe([.])
                  andBool notBool E1 ==K E2
            ok
          e4 <> es4 ->
            e4 <> es4 ==K .
              requires true
                  andBool listToMapSet([e4 <> es4]) ==K .Map
                  andBool notBool #listContainsUnsafe([e4 <> es4], E1)
                  andBool notBool e1 in_keys(listToMapSet([e4 <> es4]))
                  andBool notBool #listContainsUnsafe([e4 <> es4], e2)
                  andBool listElementsAreDistinctUnsafe([e4 <> es4])
                  andBool notBool E1 ==K E2
            false
              requires true
                  andBool listToMapSet([es4])[e4 <- 0] ==K .Map
                  andBool notBool #listContainsUnsafe([e4 <> es4], E1)
                  andBool notBool e1 in_keys(listToMapSet([e4 <> es4]))
                  andBool notBool #listContainsUnsafe([e4 <> es4], e2)
                  andBool notBool #listContainsUnsafe([es4], e4)
                  andBool listElementsAreDistinctUnsafe([es4])
                  andBool notBool E1 ==K E2
            false
              requires true
                  andBool listToMapSet([es4]) e4 |-> 0 ==K .Map  *
                  andBool notBool #listContainsUnsafe([e4 <> es4], E1)
                  andBool notBool e1 in_keys(listToMapSet([e4 <> es4]))
                  andBool notBool #listContainsUnsafe([e4 <> es4], e2)
                  andBool notBool #listContainsUnsafe([es4], e4)
                  andBool listElementsAreDistinctUnsafe([es4])
                  andBool notBool E1 ==K E2
            ok
  false ->
    [L] ==K [.] orBool [L] ==K [E2, .]
      requires true
          andBool listToMapSet([L])[E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([L], E1)
          andBool notBool e1 in_keys(listToMapSet([L]))
          andBool listElementsAreDistinctUnsafe([L])
          andBool notBool E1 ==K E2
          andBool firstOrDefault(L, e2) =/= e2
    case L of
      . ->
        [.] ==K [.] orBool [.] ==K [E2, .]
          requires true
              andBool listToMapSet([.])[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([.], E1)
              andBool notBool e1 in_keys(listToMapSet([.]))
              andBool listElementsAreDistinctUnsafe([.])
              andBool notBool E1 ==K E2
              andBool firstOrDefault(., e2) =/= e2
        true *
          requires true
              andBool .Map ==K .Map
              andBool notBool false
              andBool notBool false
              andBool true
              andBool notBool E1 ==K E2
              andBool false *
        ok
      e3 <> es3 ->
        [e3 <> es3] ==K [.] orBool [e3 <> es3] ==K [E2, .]
          requires true
              andBool listToMapSet([e3 <> es3])[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([e3 <> es3]))
              andBool listElementsAreDistinctUnsafe([e3 <> es3])
              andBool notBool E1 ==K E2
              andBool firstOrDefault(e3 <> es3, e2) =/= e2
        [e3 <> es3] ==K [E2, .]
          requires true
              andBool listToMapSet(es3)[e3 <- 0][E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3])[e3 <- 0])
              andBool notBool #listContainsUnsafe([es3], E3)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool e3 =/= e2
        e3 == e2 andBool es3] ==K .
          requires true
              andBool (listToMapSet(es3) e3 |-> 0)[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3]) e3 |-> 0)
              andBool notBool #listContainsUnsafe([es3], E3)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool e3 =/= e2
        false andBool es3] ==K .
          requires true
              andBool listToMapSet(es3)[E2 <- undef] e3 |-> 0 ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3]) e3 |-> 0)
              andBool notBool #listContainsUnsafe([es3], E3)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool e3 =/= e2
        false
          requires true
              andBool false *
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool e1 in_keys(listToMapSet([es3]) e3 |-> 0)
              andBool notBool #listContainsUnsafe([es3], E3)
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool e3 =/= e2
        ok
==================================
case L of
  . -> 
    [.] ==K [.] orBool [.] ==K [E2, .]
      requires true
          andBool listToMapSet([.])[E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([.], E1)
          andBool listElementsAreDistinctUnsafe([.])
          andBool notBool E1 ==K E2
    true
      requires true  *
          andBool .Map[E2 <- undef]
              ==K E1 |-> 0
          andBool notBool false
          andBool true
          andBool notBool E1 ==K E2
      ok
  e3 <> es3 ->
    [e3 <> es3] ==K [.] orBool [e3 <> es3] ==K [E2, .]
      requires true
          andBool listToMapSet([e3 <> es3])[E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([e3 <> es3], E1)
          andBool notBool e1 in_keys(listToMapSet([e3 <> es3]))
          andBool listElementsAreDistinctUnsafe([e3 <> es3])
          andBool notBool E1 ==K E2
    false orBool (e3 == e2 andBool es3 ==K .)
      requires true
          andBool listToMapSet([es3])[E3 <- 0][E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([e3 <> es3], E1)
          andBool notBool e1 in_keys(listToMapSet([es3])[e3 <- 0])
          andBool notBool #listContainsUnsafe([es3], e3)
          andBool listElementsAreDistinctUnsafe([es3])
          andBool notBool E1 ==K E2
    *** notBool e3 in_keys(listToMapSet([es3])) requires notBool #listContainsUnsafe([es3], E3)
    e3 == e2 andBool es3 ==K .
      requires true
          andBool listToMapSet([es3])[E3 <- 0][E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([e3 <> es3], E1)
          andBool notBool #listContainsUnsafe([es3], e3)
          andBool notBool e1 in_keys(listToMapSet([es3])[e3 <- 0])
          andBool notBool e3 in_keys(listToMapSet([es3]))
          andBool listElementsAreDistinctUnsafe([es3])
          andBool notBool E1 ==K E2
    e3 == e2 andBool es3 ==K .
      requires true
          andBool (listToMapSet([es3]) E3 |-> 0)[E2 <- undef] ==K .Map
          andBool notBool #listContainsUnsafe([e3 <> es3], E1)
          andBool notBool #listContainsUnsafe([es3], e3)
          andBool notBool e1 in_keys(listToMapSet([es3]) e3 |-> 0))
          andBool notBool e3 in_keys(listToMapSet([es3]))
          andBool listElementsAreDistinctUnsafe([es3])
          andBool notBool E1 ==K E2
    case e3 == e1 of
      true ->
        e1 == e2 andBool es3 ==K .
          requires true
              andBool (listToMapSet([es3]) E1 |-> 0)[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e1 <> es3], E1)
              andBool notBool #listContainsUnsafe([es3], e1)
              andBool notBool e1 in_keys(listToMapSet([es3]) e1 |-> 0))
              andBool notBool e1 in_keys(listToMapSet([es3]))
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
        false andBool es3 ==K .
          requires true
              andBool (listToMapSet([es3]) E1 |-> 0)[E2 <- undef] ==K .Map
              andBool notBool true
              andBool notBool #listContainsUnsafe([es3], e1)
              andBool notBool true  *
              andBool notBool e1 in_keys(listToMapSet([es3]))
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
        ok .
      false ->
        e3 == e2 andBool es3 ==K .
          requires true
              andBool (listToMapSet([es3]) E3 |-> 0)[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([e3 <> es3], E1)
              andBool notBool #listContainsUnsafe([es3], e3)
              andBool notBool e1 in_keys(listToMapSet([es3]) e3 |-> 0))
              andBool notBool e3 in_keys(listToMapSet([es3]))
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool notBool E1 ==K E3
        e3 == e2 andBool es3 ==K .
          requires true
              andBool (listToMapSet([es3]) E3 |-> 0)[E2 <- undef] ==K .Map
              andBool notBool #listContainsUnsafe([es3], E1)
              andBool notBool #listContainsUnsafe([es3], e3)
              andBool notBool e1 in_keys(listToMapSet([es3])))
              andBool notBool e3 in_keys(listToMapSet([es3]))
              andBool listElementsAreDistinctUnsafe([es3])
              andBool notBool E1 ==K E2
              andBool notBool E1 ==K E3
        case e3 == e2 of
          false ->
            e3 == e2 andBool es3 ==K .
              requires true
                  andBool (listToMapSet([es3]) E3 |-> 0)[E2 <- undef] ==K .Map
                  andBool notBool #listContainsUnsafe([es3], E1)
                  andBool notBool #listContainsUnsafe([es3], e3)
                  andBool notBool e1 in_keys(listToMapSet([es3])))
                  andBool notBool e3 in_keys(listToMapSet([es3]))
                  andBool listElementsAreDistinctUnsafe([es3])
                  andBool notBool E1 ==K E2
                  andBool notBool E1 ==K E3
                  andBool notBool E2 ==K E3
            false andBool es3 ==K .
              requires true
                  andBool listToMapSet([es3])[E2 <- undef] E3 |-> 0 ==K .Map
                  andBool notBool #listContainsUnsafe([es3], E1)
                  andBool notBool #listContainsUnsafe([es3], e3)
                  andBool notBool e1 in_keys(listToMapSet([es3])))
                  andBool notBool e3 in_keys(listToMapSet([es3]))
                  andBool listElementsAreDistinctUnsafe([es3])
                  andBool notBool E1 ==K E2
                  andBool notBool E1 ==K E3
                  andBool notBool E2 ==K E3
            false andBool es3 ==K .
              requires true
                  andBool false  *
                  andBool notBool #listContainsUnsafe([es3], E1)
                  andBool notBool #listContainsUnsafe([es3], e3)
                  andBool notBool e1 in_keys(listToMapSet([es3])))
                  andBool notBool e3 in_keys(listToMapSet([es3]))
                  andBool listElementsAreDistinctUnsafe([es3])
                  andBool notBool E1 ==K E2
                  andBool notBool E1 ==K E3
                  andBool notBool E2 ==K E3
            ok
          true ->
            e2 == e2 andBool es3 ==K .
              requires true
                  andBool (listToMapSet([es3]) E2 |-> 0)[E2 <- undef] ==K .Map
                  andBool notBool #listContainsUnsafe([es3], E1)
                  andBool notBool #listContainsUnsafe([es3], e2)
                  andBool notBool e1 in_keys(listToMapSet([es3])))
                  andBool notBool e3 in_keys(listToMapSet([es3]))
                  andBool listElementsAreDistinctUnsafe([es3])
                  andBool notBool E1 ==K E2
                  andBool notBool E1 ==K E2
            true andBool es3 ==K .
              requires true
                  andBool listToMapSet([es3]) ==K .Map
                  andBool notBool #listContainsUnsafe([es3], E1)
                  andBool notBool #listContainsUnsafe([es3], e2)
                  andBool notBool e1 in_keys(listToMapSet([es3])))
                  andBool notBool e3 in_keys(listToMapSet([es3]))
                  andBool listElementsAreDistinctUnsafe([es3])
                  andBool notBool E1 ==K E2
            es3 ==K .
              requires true
                  andBool listToMapSet([es3]) ==K .Map
                  andBool notBool #listContainsUnsafe([es3], E1)
                  andBool notBool #listContainsUnsafe([es3], e2)
                  andBool notBool e1 in_keys(listToMapSet([es3])))
                  andBool notBool e3 in_keys(listToMapSet([es3]))
                  andBool listElementsAreDistinctUnsafe([es3])
                  andBool notBool E1 ==K E2
            case es3 of
              . ->
                . ==K .  *
                  requires true
                      andBool listToMapSet([.]) ==K .Map
                      andBool notBool #listContainsUnsafe([.], E1)
                      andBool notBool #listContainsUnsafe([.], e2)
                      andBool notBool e1 in_keys(listToMapSet([.])))
                      andBool notBool e3 in_keys(listToMapSet([.]))
                      andBool listElementsAreDistinctUnsafe([.])
                      andBool notBool E1 ==K E2
                ok
              e4 <> es4 ->
                e4 <> es4 ==K .
                  requires true
                      andBool listToMapSet([e4 <> es4]) ==K .Map
                      andBool notBool #listContainsUnsafe([e4 <> es4], E1)
                      andBool notBool #listContainsUnsafe([e4 <> es4], e2)
                      andBool notBool e1 in_keys(listToMapSet([e4 <> es4])))
                      andBool notBool e3 in_keys(listToMapSet([e4 <> es4]))
                      andBool listElementsAreDistinctUnsafe([e4 <> es4])
                      andBool notBool E1 ==K E2
                false
                  requires true
                      andBool listToMapSet([es4])[e4 <- 0] ==K .Map
                      andBool notBool #listContainsUnsafe([e4 <> es4], E1)
                      andBool notBool #listContainsUnsafe([e4 <> es4], e2)
                      andBool notBool e1 in_keys(listToMapSet([es4])[e4 <- 0])
                      andBool notBool e3 in_keys(listToMapSet([es4])[e4 <- 0])
                      andBool notBool #listContainsUnsafe([es4], e4)
                      andBool listElementsAreDistinctUnsafe([es4])
                      andBool notBool E1 ==K E2
                *** listToMapSet([es4])[e4 <- 0] => listToMapSet([es4]) e4 |-> 0
                        requires notBool #listContainsUnsafe([es4], e4)

 */
