Elrond multisig proofs
======================

This repository contains proofs for the Elrond Multisig protocol. Note that
these proofs verify the protocol itself, and not the contract that is/will be
deployed.

This repository defines its own language, and defines the protocol as it was
implemented by the Elrond Multisig code in May-June 2021.

The proofs do not check what happens when reentrant calls are being made.
In the Multisig implementation mentioned above, the contract state is not
read nor written after external calls, so these were considered to be safe.

The repository contains the following proofs:
1. The contract maintains a certain invariant:
   [protocol-correctness/proof/invariant/proof-*.k](https://github.com/runtimeverification/elrond-multisig/tree/master/protocol-correctness/proof/invariant)
1. The contract cannot get stuck:
   [protocol-correctness/proof/properties/proof-can-propose-and-execute.k](https://github.com/runtimeverification/elrond-multisig/blob/master/protocol-correctness/proof/properties/proof-can-propose-and-execute.k)
1. If the quorum is at least 2, a malicious user cannot do anything without help
   from someone else:
   [protocol-correctness/proof/malicious-user/proofs/proof-cannot-perform.k](https://github.com/runtimeverification/elrond-multisig/blob/master/protocol-correctness/proof/malicious-user/proofs/proof-cannot-perform.k)
1. (in progress) If a single user is malicious, the quorum is at least 2 and
   the quorum can be met without the malicious user, then that user can be
   deleted:
   [protocol-correctness/proof/malicious-user/can-be-deleted/proof-can-be-deleted.k](https://github.com/runtimeverification/elrond-multisig/blob/master/protocol-correctness/proof/malicious-user/can-be-deleted/proof-can-be-deleted.k)

Table of contents
-----------------
* Setup
* Repository outline
* Running the proofs

Setup
-----

* Install [Bazel](https://docs.Bazel.build/versions/4.0.0/install.html)
* Install rlwrap (for debugging)
  ```
  sudo apt install rlwrap
  ```
* Install [K](https://github.com/kframework/k/releases)
  Last tested version:
  - K release: v5.2.103-1-gdbd4429473

  Or, if you want to build K manually:
  - K commit: dbd4429473b7ae6f34f654fee37d9b602c9a1ece
  - Haskell backend commit: ed00c99446ef93d291ef651719ae5c634b7cf36e
* Clone this repository
  ```
  git clone git@github.com:runtime-verification/elrond-multisig
  ```
* Setup Bazel's copy of K (make sure that the `K`'s `bin` directory is in `$PATH`)
  ```
  cd elrond-multisig
  cd kompile-tool
  ./prepare-k.sh
  cd ..
  ```

Unless specified otherwise, all following commands should be run in the
`elrond-multisig` directory.

Repository outline
------------------

This is a work in progress, so some parts will not work, and there are things
that are not organized properly.

* `kompile-tool`
        Contains the tools that help Bazel compile and run the proofs
* `protocol-correctness`
        Contains the Multisig semantics and proofs
  * `pseudocode-*.k`
        Semantics for the language used in the Multisig proofs
  * `lib`:
        Various pieces of the main language used in this repository
    * `functions`:
          Function definitions, usually one function per file
    * `language`:
          The building blocks of the language
    * `proof`
      * `induction`:
          helpers for running lemma proofs, usually by coinduction
      * `unsorted`:
          random things used in proofs
  * `mex`:
        work in progress
  * `multisig/lib`:
        language extensions for the multisig contract
    * `functions`:
        function definitions for the multisig contract
    * `language`:
        language extensions for the multisig contract (e.g. specific data types)
  * `proof`:
        Proofs and semantics for the proofs. Also contains random
        proof-related things. Most simplification rules in this directory should
        be moved to the `lemmas` directory and should have proofs.
    * `fragments`:
        should contain fragments of proof execution that are extracted here
        in order to make proofs faster.
    * `functions`:
        proofs describing all methods defined in the Multisig contract.
    * `instrumentation`:
        should be refactored
    * `invariant`:
        proofs that executing any endpoint preserves the main multisig
        invariant
    * `lemmas`:
        lemmas used in the multisig proofs. They are organized in numbered
        directories; proofs for lemmas in a given directory have access to
        all lemmas in lower-numbered directories.

        Unproven lemmas start in the `0` directory and move to higher numbered
        ones when dependencies are discovered.

        Currently this direcotry contains unproven lemmas.
    * `malicious-user`:
        semantics and proofs for the case when one user behaves maliciously
      * `can-be-deleted`:
        proofs that, under certain conditions, a single malicious user
        can be deleted (currently under construction)
      * `proofs`: proofs that, under certain conditions, a single malicious user
        cannot do anything without help from someone else.
    * `map`:
        proofs related to the `K` language `Map`
    * `named-lemmas`:
        symbols for lemmas that are used on-demand (the Haskell backend will
        not apply them automatically)
    * `properties`:
        proofs that, when the main invariant holds, the contract is not
        "stuck", i.e. actions can be proposed and executed.
  * `tests`: (kind of obsolete) tests for the multisig contract.

Running the proofs
------------------

All proofs have timeouts and they are heavy processor users, so you should
consider restricting Bazel to full cores only by adding `--jobs=n` to the
command line, e.g. `bazel test //... --jobs=8` if you have 8 cores.

Running all proofs as tests (default option):
```
bazel build //... && bazel test //...
```

Running specific proof as test:
```
bazel test //protocol-correctness/proof/functions:proof-count-can-sign
```

If your hardware is different enough from the one where test timeouts were
configured, or if you run one of the tests not optimized yet, you may
get timeouts. If that happens, you can run proofs one by one like this:
```
(Bazel run //protocol-correctness/proof/functions:proof-count-can-sign && echo "PASSED") || echo "FAILED"
```
