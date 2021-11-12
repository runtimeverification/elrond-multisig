Elrond multisig proofs
======================

Table of contents
-----------------
* Setup
* Repository outline
* Running the proofs

Setup
-----

* Install [Bazel](https://docs.Bazel.build/versions/4.0.0/install.html)
* Install [K](https://github.com/kframework/k/releases)
  Last tested version:
  - K release: v5.1.51 (fairly old, not tested recently)

  Or, if you want to build K manually:
  - K commit: 76e8272b399f81855b5e501854a677c54364642d
  - Haskell backend commit: f5bed2d571628241f68c37e22d0bacb15094b6ee
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
kompile-tool
        - Contains the tools that help Bazel compile and run the proofs
protocol-correctness
        - Contains the Multisig semantics and proofs
  * pseudocode-*.k
        - Semantics for the language used in the Multisig proofs
+- lib
        - Various pieces of the main language used in this repository
  +- functions
        - Function definitions, usually one function per file
  +- language
        - The building blocks of the language
  +- proof
    +- induction
        - Helpers for running lemma proofs, usually by coinduction
    +- unsorted
        - random things used in proofs
+- mex
        - work in progress
+- multisig/lib
        - language extensions for the multisig contract
  +- functions
        - function definitions for the multisig contract
  +- language
        - language extensions for the multisig contract (e.g. specific data types)
+- proof
        - Proofs and semantics for the proofs. Also contains random
          proof-related things.
  +- fragments
        - should contain fragments of proof execution that are extracted here
          in order to make proofs faster.
  +- functions
        - proofs describing all methods defined in the Multisig contract.
  +- instrumentation
        - should be refactored
  +- invariant
        - proofs that executing any endpoint preserves the main multisig
          invariant
  +- lemmas
        - lemmas used in the multisig proofs. They are organized in numbered
          directories; proofs for lemmas in a given directory have access to
          all lemmas in lower-numbered directories.
  +- malicious-user
        - semantics and proofs for the case when one user behaves maliciously
    +- can-be-deleted
        - proofs that, under certain conditions, a single malicious user
          can be deleted (currently under construction)
    +- proofs
        - proofs that, under certain conditions, a single malicious user
          cannot do anything without help from someone else.
  +- map
        - proofs related to the `K` language `Map`
  +- named-lemmas
        - symbols for lemmas that are used on-demand (the Haskell backend will
          not apply them automatically)
  +- properties
        - proofs that, when the main invariant holds, the contract is not
          "stuck", i.e. actions can be proposed and executed.
+- tests
        - (kind of obsolete) tests for the multisig contract.

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
