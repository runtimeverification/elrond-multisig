load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "malicious-user-execute",
  srcs = ["malicious-user-execute.k"],
  deps = [
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      "//protocol-correctness/lib/functions:first-or-default-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:remove-first-files",
      "//protocol-correctness/lib/language:cast-files",
      "//protocol-correctness/multisig/lib/functions:only-this-signer-diffs-files",
      "//protocol-correctness/proof:main-proof-execute-files",
      "//protocol-correctness/proof/invariant:invariant-execute-files",
      "//protocol-correctness/proof/named-lemmas:count-can-sign-list-to-map-set-square-bracket-3-files",
      "//protocol-correctness/proof/named-lemmas:list-to-map-set-concretize-files",
      "//protocol-correctness/proof/named-lemmas:named-lemmas-files",
      "//protocol-correctness/proof/named-lemmas:only-this-signer-diffs-transitive-files",
      "//protocol-correctness/proof/properties:properties-execute-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "malicious-user-execute-files",
  srcs = ["malicious-user-execute.k"],
  deps = [
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      "//protocol-correctness/lib/functions:first-or-default-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:remove-first-files",
      "//protocol-correctness/lib/language:cast-files",
      "//protocol-correctness/multisig/lib/functions:only-this-signer-diffs-files",
      "//protocol-correctness/proof:main-proof-execute-files",
      "//protocol-correctness/proof/invariant:invariant-execute-files",
      "//protocol-correctness/proof/named-lemmas:count-can-sign-list-to-map-set-square-bracket-3-files",
      "//protocol-correctness/proof/named-lemmas:list-to-map-set-concretize-files",
      "//protocol-correctness/proof/named-lemmas:named-lemmas-files",
      "//protocol-correctness/proof/named-lemmas:only-this-signer-diffs-transitive-files",
      "//protocol-correctness/proof/properties:properties-execute-files",
  ],
  visibility = ["//visibility:public"],
)

