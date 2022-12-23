load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-no-map-key-in-list-list-to-map-set",
  srcs = ["proof-no-map-key-in-list-list-to-map-set.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-no-map-key-in-list-list-to-map-set",
  srcs = ["proof-no-map-key-in-list-list-to-map-set.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-no-map-key-in-list-push-list-not-in-map",
  srcs = ["lemma-no-map-key-in-list-push-list-not-in-map.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-no-map-key-in-list-push-list-not-in-map",
  srcs = ["lemma-no-map-key-in-list-push-list-not-in-map.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-no-map-key-in-list-push-list-not-in-map-files",
  srcs = [":trusted-lemma-no-map-key-in-list-push-list-not-in-map"],
  deps = [
      "//protocol-correctness/lib/functions:no-map-key-in-list-files",
      "//protocol-correctness/lib/functions:push-list-files",
      ":trusted-lemma-no-map-key-in-list-push-list-not-in-map",
  ],
  visibility = ["//visibility:public"],
)

