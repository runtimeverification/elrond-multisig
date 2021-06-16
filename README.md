Elrond multisig proofs
======================

Setup
-----

* Install [Bazel](https://docs.bazel.build/versions/4.0.0/install.html)
* Install [K](https://github.com/kframework/k/releases)
  Last tested version:
  - K release: v5.1.51

  Or, if you want to build K manually:
  - K commit: 94041a3ded548fb07b52e84751d8e09613275658
  - Haskell backend commit: 1724c5c23afea515f4c58328d1f42abc5de6e15c
* Clone this repository
  ```
  git clone git@github.com:runtime-verification/elrond-multisig
  ```
* Setup K (make sure that the `K`'s `bin` directory is in `$PATH`)
  ```
  cd elrond-multisig
  cd kompile-tool
  ./prepare-k.sh
  cd ..
  ```

Unless specified otherwise, all following commands should be run in the
`elrond-multisig` directory.

Running proofs
--------------

Running all proofs as tests (default option):
```
bazel test //protocol-correctness/...
```

Running specific proof as test:
```
bazel test //protocol-correctness/proof/functions:proof-count-can-sign
```

If your hardware is different enough from the one where test timepouts were
configured, or if you run one of the tests not optimized yet, you may
get timeouts. If that happens, you can run proofs one by one like this:
```
(bazel run //protocol-correctness/proof/functions:proof-count-can-sign && echo "PASSED") || echo "FAILED"
```
