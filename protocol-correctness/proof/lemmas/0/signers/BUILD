load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-count-can-sign-map",
  srcs = ["proof-count-can-sign-map.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  timeout = "moderate",
  breadth = "10",
)

ktrusted(
  name = "trusted-count-can-sign-map",
  srcs = ["proof-count-can-sign-map.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-only-this-signer-diffs-transitive",
  srcs = ["proof-only-this-signer-diffs-transitive.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-only-this-signer-diffs-transitive",
  srcs = ["proof-only-this-signer-diffs-transitive.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys",
  srcs = ["lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys",
  srcs = ["lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys-files",
  srcs = [":trusted-lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys"],
  deps = [
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      ":trusted-lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-function-element-last-to-start",
  srcs = ["lemma-count-can-sign-function-element-last-to-start.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-function-element-last-to-start",
  srcs = ["lemma-count-can-sign-function-element-last-to-start.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-function-element-last-to-start-files",
  srcs = [":trusted-lemma-count-can-sign-function-element-last-to-start"],
  deps = [
      "//protocol-correctness/lib/functions:last-to-start-files",
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      ":trusted-lemma-count-can-sign-function-element-last-to-start",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-function-last-remove-last",
  srcs = ["lemma-count-can-sign-function-last-remove-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-function-last-remove-last",
  srcs = ["lemma-count-can-sign-function-last-remove-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-function-last-remove-last-files",
  srcs = [":trusted-lemma-count-can-sign-function-last-remove-last"],
  deps = [
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:remove-last-files",
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      ":trusted-lemma-count-can-sign-function-last-remove-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-function-second-element",
  srcs = ["lemma-count-can-sign-function-second-element.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-function-second-element",
  srcs = ["lemma-count-can-sign-function-second-element.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-function-second-element-files",
  srcs = [":trusted-lemma-count-can-sign-function-second-element"],
  deps = [
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      ":trusted-lemma-count-can-sign-function-second-element",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-map-empty",
  srcs = ["lemma-count-can-sign-map-empty.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-map-empty",
  srcs = ["lemma-count-can-sign-map-empty.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-map-empty-files",
  srcs = [":trusted-lemma-count-can-sign-map-empty"],
  deps = [
      "//protocol-correctness/lib/functions:list-elements-are-usize-files",
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      ":trusted-lemma-count-can-sign-map-empty",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-map",
  srcs = ["lemma-count-can-sign-map.k"],
  trusted = [
      ":trusted-count-can-sign-map",
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-map",
  srcs = ["lemma-count-can-sign-map.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-map-files",
  srcs = [":trusted-lemma-count-can-sign-map"],
  deps = [
      "//protocol-correctness/lib/functions:bool-to-int-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-elements-are-usize-files",
      "//protocol-correctness/lib/functions:map-values-are-kresult-files",
      "//protocol-correctness/lib/functions:map-values-are-of-type-files",
      "//protocol-correctness/multisig/lib/functions:can-sign-function-files",
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      "//protocol-correctness/multisig/lib/language:type-reflection-files",
      ":trusted-lemma-count-can-sign-map",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-push-list-2",
  srcs = ["lemma-count-can-sign-push-list-2.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-push-list-2",
  srcs = ["lemma-count-can-sign-push-list-2.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-push-list-2-files",
  srcs = [":trusted-lemma-count-can-sign-push-list-2"],
  deps = [
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      "//protocol-correctness/lib/functions:push-list-files",
      ":trusted-lemma-count-can-sign-push-list-2",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-count-can-sign-push-list",
  srcs = ["lemma-count-can-sign-push-list.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-count-can-sign-push-list",
  srcs = ["lemma-count-can-sign-push-list.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-count-can-sign-push-list-files",
  srcs = [":trusted-lemma-count-can-sign-push-list"],
  deps = [
      "//protocol-correctness/multisig/lib/functions:count-can-sign-function-files",
      "//protocol-correctness/lib/functions:push-list-files",
      ":trusted-lemma-count-can-sign-push-list",
  ],
  visibility = ["//visibility:public"],
)

