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
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-contains-unsafe-list-to-map-set-square-bracket-files",
  srcs = ["list-contains-unsafe-list-to-map-set-square-bracket.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
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
      ":list-contains-unsafe-list-to-map-set-square-bracket-files",
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

