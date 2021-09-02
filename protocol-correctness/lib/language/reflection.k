module REFLECTION-SYNTAX
  syntax SymbolReflection ::= r"$[A-Za-z_#][A-Za-z_0-9]*" [token]
  syntax ReflectionArgument ::= reflectionArgument(KItem)
  syntax ReflectionArguments  ::= ReflectionArgument
                                | ReflectionArgument "," ReflectionArguments
  syntax KItem ::= reflectionApply0(SymbolReflection)  [function, functional]
  syntax KItem ::= reflectionApply(SymbolReflection, ReflectionArguments)  [function, functional]

  syntax ReflectionError  ::= cannotApply(SymbolReflection, ReflectionArguments)
                            | cannotApply0(SymbolReflection)
endmodule

module REFLECTION
  imports REFLECTION-SYNTAX

  rule reflectionApply(S:SymbolReflection, A:ReflectionArguments)
      => cannotApply(S, A)  [owise]
  rule reflectionApply0(S:SymbolReflection) => cannotApply0(S)  [owise]
endmodule