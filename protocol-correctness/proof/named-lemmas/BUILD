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
  name = "named-lemma-only-this-signer-diffs-transitive-files",
  srcs = ["named-lemma-only-this-signer-diffs-transitive.k"],
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
      ":named-lemma-only-this-signer-diffs-transitive-files",
  ],
  visibility = ["//visibility:public"],
)

