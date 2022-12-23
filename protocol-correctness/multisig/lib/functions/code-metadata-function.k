require "protocol-correctness/multisig/lib/functions/metadata-to-int.k"

module CODE-METADATA-FUNCTION-SYNTAX
  imports BOOL

  syntax CodeMetadata ::= codeMetadataFunction(upgradeable:Bool, payable:Bool, readable:Bool)
      [function, functional]
endmodule

module CODE-METADATA-FUNCTION
  imports CODE-METADATA-FUNCTION-SYNTAX
  imports METADATA-TO-INT-SYNTAX
  imports K-EQUAL-SYNTAX

  rule codeMetadataFunction(Upgradeable:Bool, Payable:Bool, Readable:Bool)
      => meta(
               metadataToInt(CodeMetadata::DEFAULT)
          |Int #if Upgradeable #then metadataToInt(CodeMetadata::UPGRADEABLE) #else 0 #fi
          |Int #if Payable #then metadataToInt(CodeMetadata::PAYABLE) #else 0 #fi
          |Int #if Readable #then metadataToInt(CodeMetadata::READABLE) #else 0 #fi
        )
endmodule

