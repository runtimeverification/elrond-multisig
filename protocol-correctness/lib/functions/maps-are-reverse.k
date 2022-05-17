module MAPS-ARE-REVERSE-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapsAreReverse(Map, Map) [function, functional]
endmodule

module MAPS-ARE-REVERSE-ADDITIONAL-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapsAreReverseHalf(Map, Map) [function, functional]
endmodule

module MAPS-ARE-REVERSE
  imports MAPS-ARE-REVERSE-SYNTAX
  imports MAPS-ARE-REVERSE-ADDITIONAL-SYNTAX

  imports K-EQUAL-SYNTAX

  rule mapsAreReverse(M:Map, N:Map)
      => mapsAreReverseHalf(M, N) andBool mapsAreReverseHalf(N, M)

  rule mapsAreReverseHalf(.Map, _:Map) => true
  rule mapsAreReverseHalf((K:KItem |-> V:KItem M:Map) #as _:Map, N:Map)
      => V in_keys(N) andBool N[V] ==K K andBool mapsAreReverseHalf(M, N)
    [simplification]
  rule mapsAreReverseHalf(M:Map, (K:KItem |-> V:KItem N:Map) #as _:Map)
      => M[V] orDefault K ==K K andBool mapsAreReverseHalf(M[V <- undef], N)
    [simplification]
endmodule
