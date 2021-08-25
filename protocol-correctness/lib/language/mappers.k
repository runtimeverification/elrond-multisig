require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/function-call.k"
require "protocol-correctness/lib/language/running-syntax.k"
require "protocol-correctness/lib/language/type-reflection.k"

module MAPPERS-SYNTAX
    imports BASE-TYPES-SYNTAX

    syntax KItem ::= computeMappedValue(Record, FunctionTag)
    syntax KItem ::= updateMappedValue(Record, FunctionTag, Expression)
endmodule

module MAPPERS-IDENTIFIERS-SYNTAX
    syntax FunctionTag ::= "get" | "set" | "set_if_empty"
endmodule

module MAPPERS
    imports MAPPERS-INTERNAL
    imports SINGLE-VALUE-MAPPER
endmodule

module MAPPERS-INTERNAL-SYNTAX
    imports BASE-TYPES-SYNTAX

    syntax Expression ::= extractValue0(ValueMapperType)
                        | extractValue(ValueMapperType, ArgumentCSV)
    syntax KItem ::= updateValueIfEmpty0(Record, FunctionTag, ValueMapperType, Expression)
    syntax KItem ::= updateValue0(Record, FunctionTag, ValueMapperType, Expression)
endmodule

module MAPPERS-INTERNAL
    imports BASE-TYPES-SYNTAX
    imports FUNCTION-CALL-SYNTAX
    imports MAPPERS-IDENTIFIERS-SYNTAX
    imports MAPPERS-INTERNAL-SYNTAX
    imports MAPPERS-SYNTAX
    imports RUNNING-SYNTAX

    context evaluate(valueMapper(
                {HOLE:Record => evaluate(HOLE)}:>Record,
                _:FunctionTag,
                _:ValueMapperType))
    rule isKResultExpression(
            valueMapper(R:Record, _:FunctionTag, _:ValueMapperType) => R
        )

    rule
        call(get(valueMapper(R:Record, F:FunctionTag, T:ValueMapperType) #as Args:ArgumentCSV))
        => computeMappedValue(R, F) ~> extractValue0(T)
      requires isKResult(Args)
    rule call(get((valueMapper(R:Record, F:FunctionTag, T:ValueMapperType), Args:ArgumentCSV) #as AllArgs:ArgumentCSV))
        => computeMappedValue(R, F) ~> extractValue(T, Args)
      requires isKResult(AllArgs)

    rule
        call(set_if_empty(
                ( valueMapper(R:Record, F:FunctionTag, T:ValueMapperType)
                , NewValue:Expression
                ) #as Args:ArgumentCSV
            ))
        => computeMappedValue(R, F) ~> updateValueIfEmpty0(R, F, T, NewValue) ~> void
      requires isKResult(Args)

    rule
        call(set(
                ( valueMapper(R:Record, F:FunctionTag, _T:ValueMapperType)
                , NewValue:Expression
                ) #as Args:ArgumentCSV
            ))
        => updateMappedValue(R, F, NewValue) ~> void
      requires isKResult(Args)
endmodule

module SINGLE-VALUE-MAPPER
    imports BASE-TYPES-SYNTAX
    imports MAPPERS-INTERNAL-SYNTAX
    imports TYPE-REFLECTION-SYNTAX
    imports MAPPERS-SYNTAX

    rule E:Expression ~> extractValue0(SingleValue(_:ReflectionType)) => E
    rule
        (  E:Expression
        ~> updateValueIfEmpty0(
            R:Record,
            F:FunctionTag,
            SingleValue(T:ReflectionType),
            NewValue:Expression)
        )
        => updateMappedValue(R, F, NewValue)
      requires notBool isDefaultValue(E, T)
    rule
        (  E:Expression
        ~> updateValueIfEmpty0(
            _:Record,
            _:FunctionTag,
            SingleValue(T:ReflectionType),
            _NewValue:Expression)
        ) => .K
      requires isDefaultValue(E, T)
endmodule