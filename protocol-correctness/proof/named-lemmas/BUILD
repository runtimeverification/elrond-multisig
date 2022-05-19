load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "named-lemmas-execute",
  srcs = ["named-lemmas-execute.k"],
  deps = [
      ":named-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "named-lemmas-execute-files",
  srcs = ["named-lemmas-execute.k"],
  deps = [
      ":named-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "bool-to-int-sum-and-not-files",
  srcs = ["bool-to-int-sum-and-not.k"],
  deps = [
      "//protocol-correctness/lib/functions:concretize-value-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "count-can-sign-list-to-map-set-square-bracket-3-files",
  srcs = ["count-can-sign-list-to-map-set-square-bracket-3.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/proof/induction:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "count-can-sign-map-files",
  srcs = ["count-can-sign-map.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/proof/induction:syntax-files",
      "//protocol-correctness/multisig/lib/language:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "in-keys-square-bracket-square-bracket-files",
  srcs = ["in-keys-square-bracket-square-bracket.k"],
  deps = [
      "//protocol-correctness/lib/proof/induction:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "in-keys-substitution-files",
  srcs = ["in-keys-substitution.k"],
  deps = [
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-contains-unsafe-change-list-3-files",
  srcs = ["list-contains-unsafe-change-list-3.k"],
  deps = [
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
      ":in-keys-substitution-files",
      ":list-contains-unsafe-to-in-keys-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-contains-unsafe-list-to-map-set-square-bracket-files",
  srcs = ["list-contains-unsafe-list-to-map-set-square-bracket.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/proof/induction:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-contains-unsafe-to-in-keys-files",
  srcs = ["list-contains-unsafe-to-in-keys.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/proof/induction:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-to-map-set-concretize-files",
  srcs = ["list-to-map-set-concretize.k"],
  deps = [
      "//protocol-correctness/lib/functions:concretize-expression-list-files",
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/proof/induction:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "named-lemmas-files",
  srcs = ["named-lemmas.k"],
  deps = [
      "//protocol-correctness/lib/language:map-utils-files",
      "//protocol-correctness/lib/language:reflection-files",
      "//protocol-correctness/lib/proof/unsorted:formula-expansion-files",
      "//protocol-correctness/proof:instrumentation-proof-files",
      ":bool-to-int-sum-and-not-files",
      ":count-can-sign-list-to-map-set-square-bracket-3-files",
      ":count-can-sign-map-files",
      ":in-keys-square-bracket-square-bracket-files",
      ":in-keys-substitution-files",
      ":list-contains-unsafe-change-list-3-files",
      ":list-contains-unsafe-list-to-map-set-square-bracket-files",
      ":list-contains-unsafe-to-in-keys-files",
      ":list-to-map-set-concretize-files",
      ":only-this-signer-diffs-transitive-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "only-this-signer-diffs-transitive-files",
  srcs = ["only-this-signer-diffs-transitive.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

