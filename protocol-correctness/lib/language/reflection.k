module REFLECTION-SYNTAX
  imports STRING

  syntax SymbolReflection ::= r"$[A-Za-z_#][A-Za-z_0-9]*" [token]
  syntax SymbolReflection ::= "$"String [token]
  syntax ReflectionArgument ::= reflectionArgument(KItem)
  syntax ReflectionArguments  ::= ReflectionArgument
                                | ReflectionArgument "," ReflectionArguments
  syntax KItem ::= reflectionApply0(SymbolReflection)  [function, functional]
  syntax KItem ::= reflectionApply(SymbolReflection, ReflectionArguments)  [function, functional]
  syntax KItem ::= reflectionKey(KItem, KItem)

  syntax ReflectionError  ::= cannotApply(SymbolReflection, ReflectionArguments)
                            | cannotApply0(SymbolReflection)

  syntax ReflectionIdToken ::= r"[A-Za-z_#][A-Za-z_0-9]*" [token]
  syntax ReflectionId ::= ReflectionIdToken | String
  syntax ReflectionPattern  ::= "."
                              | ReflectionId "<>" ReflectionId
                              | ReflectionId "[" ReflectionId "<-" ReflectionId "]"
                              | "True"
                              | "False"
                              | "=" KItem
                              | "<" KItem
                              | ">" KItem
  syntax KItem ::= matchPatternOrElse(ReflectionPattern, KItem, matched:K, notMatched:K)

  syntax ReflectionDataItem ::= "(" ReflectionId "," KItem ")"
  syntax ReflectionData ::= List{ReflectionDataItem, "<>"}
endmodule

module REFLECTION
  imports REFLECTION-SYNTAX

  rule reflectionApply(S:SymbolReflection, A:ReflectionArguments)
      => cannotApply(S, A)  [owise]
  rule reflectionApply0(S:SymbolReflection) => cannotApply0(S)  [owise]
endmodule