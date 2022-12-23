load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-4-execute",
  srcs = ["lemmas-4-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/3:lemmas-3-execute-files",
      ":lemmas-3-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-4-execute-files",
  srcs = ["lemmas-4-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/3:lemmas-3-execute-files",
      ":lemmas-3-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-3-files",
  srcs = ["lemmas-3.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/3/list/contains:trusted-lemma-list-contains-pound-last-pound-remove-last-files",
      "//protocol-correctness/proof/lemmas/3/list/contains:trusted-lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq-files",
      "//protocol-correctness/proof/lemmas/3/list/list-to-map-set:trusted-lemma-list-to-map-set-list-swap-remove-list-find-delete-files",
      "//protocol-correctness/proof/lemmas/3/list/plistlen:trusted-lemma-plistlen-list-swap-remove-list-find-files",
      "//protocol-correctness/proof/lemmas/3:lemmas-2-files",
  ],
  visibility = ["//visibility:public"],
)

