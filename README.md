Elrond multisig proofs
======================

Setup
-----

* Install [Bazel](https://docs.bazel.build/versions/4.0.0/install.html)
* Install [K](https://github.com/kframework/k/releases)
  Last tested version:
  - K release: v5.1.51 (fairly old, not tested recently)

  Or, if you want to build K manually:
  - K commit: 8555efc0656b2a5c25e3db0f8f868fb7a1bca970
  - Haskell backend commit: ed422630f9383b2774f1ec8ea04eee86ea0afe1e
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
