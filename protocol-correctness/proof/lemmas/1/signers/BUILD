load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-at-most-this-signer-0-count-can-sign-function",
  srcs = ["lemma-at-most-this-signer-0-count-can-sign-function.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/1:lemmas-1-execute",
  timeout = "long",
  breadth = "12",
)

ktrusted(
  name = "trusted-lemma-at-most-this-signer-0-count-can-sign-function",
  srcs = ["lemma-at-most-this-signer-0-count-can-sign-function.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-at-most-this-signer-0-count-can-sign-function-files",
  srcs = [":trusted-lemma-at-most-this-signer-0-count-can-sign-function"],
  deps = [
      "//protocol-correctness/lib/functions:list-elements-are-usize-files",
      "//protocol-correctness/lib/functions:map-values-are-kresult-files",
      "//protocol-correctness/lib/functions:map-values-are-of-type-files",
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      "//protocol-correctness/multisig/lib/functions:pound-at-most-this-signer-list-files",
      "//protocol-correctness/multisig/lib/language:type-reflection-files",
      ":trusted-lemma-at-most-this-signer-0-count-can-sign-function",
  ],
  visibility = ["//visibility:public"],
)

