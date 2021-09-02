require "protocol-correctness/lib/proof/induction/syntax.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"

module INDUCTION-DATA-ITEM-SYNTAX
  imports INDUCTION-SYNTAX

  syntax InductionDataWithError ::= addDataItem(InductionDataItem, InductionData)  [function, functional]
endmodule

module INDUCTION-DATA-ITEM-INTERNAL-SYNTAX
  imports INDUCTION-DATA-ITEM-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX

  syntax InductionDataWithError ::= errorNameAlreadyExistInData(InductionId, InductionData)
                                  | errorNamePairing(InductionDataNames, InductionExpressionList)
                                  | InductionData

  syntax InductionDataWithError ::= prepend(InductionDataItem, InductionDataWithError)  [function, functional]
endmodule

module INDUCTION-DATA-ITEM
  imports BOOL
  imports INDUCTION-DATA-ITEM-INTERNAL-SYNTAX
  imports INDUCTION-DATA-ITEM-SYNTAX
  imports K-EQUAL

  rule addDataItem((Name:InductionId, Value:KItem), (Name1:InductionId, Value1:KItem))
      => (Name1:InductionId, Value1:KItem) <> (Name:InductionId, Value:KItem)
    requires notBool Name1 ==K Name
  rule addDataItem((Name:InductionId, _Value:KItem), (Name1:InductionId, _Value1:KItem) #as Item:InductionDataItem)
      => errorNameAlreadyExistInData(Name:InductionId, Item)
    requires Name1 ==K Name
  rule addDataItem(
              (Name:InductionId, _Value:KItem) #as I:InductionDataItem,
              (Name1:InductionId, Value1:KItem) <> D:InductionData
          )
      => prepend((Name1:InductionId, Value1:KItem), addDataItem(I, D))
    requires notBool Name1 ==K Name
  rule addDataItem(
              (Name:InductionId, _Value:KItem),
              ((Name1:InductionId, _Value1:KItem) <> _:InductionData) #as D:InductionData
          )
      => errorNameAlreadyExistInData(Name, D)
    requires Name1 ==K Name

  rule prepend(Item:InductionDataItem, Data:InductionData) => Item <> Data
  rule prepend(Item:InductionDataItem, errorNameAlreadyExistInData(Name:InductionId, D:InductionData))
      => errorNameAlreadyExistInData(Name, Item <> D)
  rule prepend(_Item:InductionDataItem, errorNamePairing(...) #as Error:InductionDataWithError)
      => Error
endmodule
