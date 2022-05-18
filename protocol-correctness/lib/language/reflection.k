module REFLECTION-SYNTAX
  imports STRING

  // This module allows implementing some sort of reflection for K symbols.
  //
  // For each symbol for which reflection is supposed to work:
  //
  // 1. If the symbol is called `mySymbol`, then, by convention, the
  //    name used for reflection is `$mySymbol`, which is a SymbolReflection
  //    token.
  //
  // 2. The user needs to write a rule that applies the symbol to its arguments.
  //    This should have the same meaning as one of the following:
  //
  //    No arguments:
  //    rule reflectionApply0($mySymbol) => mySymbol()
  //      requries #Ceil(mySymbol())
  //
  //    With arguments:
  //    rule reflectionApply(
  //             $mySymbol,
  //             reflectionArgument(Arg1:Type1),
  //             reflectionArgument(Arg2:Type2),
  //             ...,
  //             reflectionArgument(Argn:Typen))
  //       => mySymbol(Arg1, Arg2, ..., Argn)
  //       requires #Ceil(mySymbol(Arg1, Arg2, ..., Argn))


  // This module also defines syntax for pattern matching on K symbols.
  //
  // ReflectionPattern is a matching pattern, and matchPatternOrElse implements
  // the actual matching. Right now, patterns are overloaded, e.g.
  // depending on the actual type of the KItem argument to matchPatternOrElse,
  // `.` can mean either an empty map or an empty list.
  //
  // Implementing matchPatternOrElse for a given pattern and type requires
  // defining two rules:
  //
  // rule matchPatternOrElse(<pattern>, <value>:Type, Matched:K, _NotMatched:K)
  //    => ReflectionData-extracted-by-the-pattern ~> Matched
  // rule matchPatternOrElse(<pattern>, _:Type, _Matched:K, NotMatched:K)
  //    => NotMatched
  //    [priority(200)]


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