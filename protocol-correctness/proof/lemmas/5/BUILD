load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-5-execute",
  srcs = ["lemmas-5-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/4:lemmas-4-execute-files",
      ":lemmas-4-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-5-execute-files",
  srcs = ["lemmas-5-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/4:lemmas-4-execute-files",
      ":lemmas-4-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-4-files",
  srcs = ["lemmas-4.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/4/list/contains:trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq-files",
      "//protocol-correctness/proof/lemmas/4/list/list-to-map-set:trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete-files",
      "//protocol-correctness/proof/lemmas/4:lemmas-3-files",
  ],
  visibility = ["//visibility:public"],
)

