#!/usr/bin/env python3

"""
Allows using the same claim for proofs or as trusted or as a simplification rule.

This tool works with two types of claims: regular claims and proofs for
simplification rules.

Regular claims
==============

This tool takes an input file containing one or more provable claims and
produces a file containing claims that can be trusted.

This is done with the help of special comments that select which code should
be used for proving, and which code should be used when the claim is trusted.

These comments have the following format:
//@ proof
<code-to-be-used-when-proving>
//@ trusted
// <commented-out-code-to-be-used-when-trusted>
//@ end

This tool comments out the code after //@ proof and uncomments the code after
//@ trusted.


Example:

proof-file.k

//@ proof
module PROOF-FILE
//@ trusted
// require "syntax.k"
// module TRUSTED-FILE
//@ end

  imports SYNTAX

  claim
      start => .K
    requires
      whatever()
    ensures
      something()
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule


Command line:

make-trusted.py trusted proof-file.k trusted-file.k


Output:
trusted-file.k

//@ proof
// module PROOF-FILE
//@ trusted
require "syntax.k"
module TRUSTED-FILE
//@ end

  imports SYNTAX

  claim
      start => .K
    requires
      whatever()
    ensures
      something()
    //@ proof
    //@ trusted
    [trusted]
    //@ end
endmodule

The user can run `kprove proof-file.k` and import the trusted file with
`require trusted-file.k`

Simplification rules
====================

This tool also allows proving a claim and using the proved result as a
simplification rule. This also use the
//@ proof ... //@ trusted ... //@ end comments as above, but it has some
additional features.

The simplification rule proof must be written using the following format:
lemma
    start(Args) => .K
  proves
    myFunction(Args) => result
  requires
    myRequires()
  [attributes-e-g-simplification]
endlemma

The tool can transform the above to one of:

claim 
    start(Args) => .K
  ensures
    myFunction(Args) ==K result
  requires
    myRequires()

and

rule
    myFunction(Args) => result
  requires
    myRequires()
  [attributes-e-g-simplification]

Example:

lemma-bool-to-int.k

//@ proof
module LEMMA-BOOL-TO-INT
  imports SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "bool-to-int.k"
// module TRUSTED-LEMMA-BOOL-TO-INT
//@ end

  imports BOOL-TO-INT-SYNTAX

  lemma
      start(B) => .K
    proves
      0 <=Int boolToInt(B) => true
    requires
      true
    [simplification, smt-lemma]
    endlemma

endmodule


Command line:

make-trusted.py proof lemma-bool-to-int.k lemma-bool-to-int.proof.k


Output:
lemma-bool-to-int.proof.k

//@ proof
module LEMMA-BOOL-TO-INT
  imports SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "bool-to-int.k"
// module TRUSTED-LEMMA-BOOL-TO-INT
//@ end

  imports BOOL-TO-INT-SYNTAX

  claim
      start(B) => .K
    ensures
      0 <=Int boolToInt(B) ==K true
    requires
      true



endmodule


Command line:

make-trusted.py trusted lemma-bool-to-int.k trusted-lemma-bool-to-int.k


Output:
trusted-lemma-bool-to-int.k

//@ proof
// module LEMMA-BOOL-TO-INT
//   imports SYNTAX
//   imports K-EQUAL-SYNTAX
//@ trusted
require "bool-to-int.k"
module TRUSTED-LEMMA-BOOL-TO-INT
//@ end

  imports BOOL-TO-INT-SYNTAX

  rule


      0 <=Int boolToInt(B) => true
    requires
      true
    [simplification, smt-lemma]


endmodule


The user can now run `kprove lemma-bool-to-int.proof.k` and can
`require "trusted-lemma-bool-to-int"`

"""

import sys

import trusted

def naturalNumbers():
  i = 1
  while True:
    yield i
    i += 1

def makeProof(file_name, lines):
  lemma_parser = trusted.LemmaParser(file_name)
  for (line_number, line) in lines:
    normalized = line.strip()

    lemma_parser.processLine(line, normalized, line_number)
    if lemma_parser.isParsing():
      if lemma_parser.finishedParsing():
        yield lemma_parser.toClaim()
        lemma_parser.reset()
      continue

    yield line

def main(argv):
  if len(argv) != 3:
    raise Exception('Wrong number of arguments, expected: trusted/proof, an input and an output file name.')
  if argv[0] == 'trusted':
    with open(argv[1], 'r') as f:
      with open(argv[2], 'w') as g:
        g.writelines(trusted.makeTrusted(argv[1], zip(naturalNumbers(), f)))
  elif argv[0] == 'proof':
    with open(argv[1], 'r') as f:
      with open(argv[2], 'w') as g:
        g.writelines(makeProof(argv[1], zip(naturalNumbers(), f)))
  else:
    raise Exception('The first argument must be one of "trusted" and "proof".')

if __name__ == '__main__':
  main(sys.argv[1:])
