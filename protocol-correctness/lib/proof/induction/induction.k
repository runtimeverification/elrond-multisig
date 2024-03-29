require "protocol-correctness/lib/proof/induction/call.k"
require "protocol-correctness/lib/proof/induction/case.k"
require "protocol-correctness/lib/proof/induction/data-item.k"
require "protocol-correctness/lib/proof/induction/expression.k"
require "protocol-correctness/lib/proof/induction/expression-list.k"
require "protocol-correctness/lib/proof/induction/reinduction.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module INDUCTION
  imports INDUCTION-INTERNAL-SYNTAX
  imports INDUCTION-SYNTAX

  imports INDUCTION-CALL
  imports INDUCTION-CASE
  imports INDUCTION-DATA-ITEM
  imports INDUCTION-EXPRESSION
  imports INDUCTION-EXPRESSION-LIST
  imports REINDUCTION

  imports REFLECTION

  rule extractNames((Identifier:InductionId , _Value:KItem)) => Identifier
  rule extractNames((Identifier:InductionId , _Value:KItem) <> Data:InductionData )
      => Identifier , extractNames(Data)

  rule induction(Is:InductionInstructions, D:InductionData)
      => runInduction(Is, D) ~> inductionFreezer(Is, names(extractNames(D)))

  rule runInduction(.Induction, Data:InductionData) => Data

  rule runInduction(I:InductionInstruction, Data:InductionData)
      =>  runInductionInstruction(I, Data)
  rule runInduction(
              I:InductionInstruction ~~> Is:NonEmptyInductionInstructions,
              Data:InductionData)
      =>  (  runInductionInstruction(I, Data)
          ~> runInductionFreezer(Is)
          )
  rule Data:InductionData ~> runInductionFreezer(Is:InductionInstructions)
      => runInduction(Is, Data)

  rule #runInductionFreezer(.Induction) => .K
  rule #runInductionFreezer(Is:NonEmptyInductionInstructions) => runInductionFreezer(Is)

  rule (.ReflectionData ~> mergeDataFreezer(D:InductionData)) => D
  rule ((I:ReflectionId, K:KItem):ReflectionDataItem ~> mergeDataFreezer(D:InductionData))
      => addDataItem((I, K), D)
  // mergeDataFreezer2 is needed in order to allow addDataItem to stop execution
  // when an error occurs.
  rule ((I:ReflectionId, K:KItem) <> Is:ReflectionData ~> mergeDataFreezer(D:InductionData))
      => addDataItem((I, K), D) ~> mergeDataFreezer2(Is)
    [label(xyzzy)]
  rule (D:InductionData ~> mergeDataFreezer2(Is:ReflectionData))
      => Is ~> mergeDataFreezer(D)

  rule  (  _:InductionData
        ~> inductionFreezer(_:InductionInstructions, _:InductionDataNames)
        )
      => .K
endmodule

/*
induction(
  case Es of
    | . --> .Induction,
    | E1 <> Es1 -->
      case E == $#last(E, Es) of
        | true --> .Induction
        | false --> reinduction(E1, Es1)
      esac
      )
  esac,
  (E, E:Expression) <> (Es, Es:ExpressionList)
)

CODE ::= case Es of
    | . --> .Induction,
    | E1 <> Es1 -->
      case E == $#last(E, Es) of
        | true --> .Induction
        | false --> reinduction(E1, Es1)
      )
  esac,

=>

runInduction(
  CODE,
  (E, E:Expression) <> (Es, Es:ExpressionList),
  CODE,
  names(E, Es)
)

=>

runInduction(
  reinduction(x, y),
  (E, E:Expression) <> (Es, Es:ExpressionList) <> (x, X) <> (y, Y),
  CODE,
  names(E, Es)
)

=>

induction(
  CODE,
  (E, X:Expression) <> (Es, Y:ExpressionList)
)

*/