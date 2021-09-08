load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-3-execute",
  srcs = ["lemmas-3-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-2:lemmas-2-execute-files",
      ":lemmas-2-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-3-execute-files",
  srcs = ["lemmas-3-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-2:lemmas-2-execute-files",
      ":lemmas-2-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-2-files",
  srcs = ["lemmas-2.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-2/list/contains:trusted-lemma-list-contains-pound-list-swap-remove-files",
      "//protocol-correctness/proof/lemmas-2/list/contains:trusted-lemma-list-contains-pound-list-swap-remove-2-files",
      "//protocol-correctness/proof/lemmas-2/list/contains:trusted-lemma-list-contains-pound-remove-last-files",
      "//protocol-correctness/proof/lemmas-2/list/contains:trusted-lemma-list-contains-pound-remove-last-pound-last-files",
      "//protocol-correctness/proof/lemmas-2/list/contains:trusted-lemma-list-contains-remove-last-files",
      "//protocol-correctness/proof/lemmas-2/list/list-to-map-set:trusted-lemma-list-to-map-set-last-to-start-files",
      "//protocol-correctness/proof/lemmas-2/list/plistlen:trusted-lemma-plistlen-last-to-start-files",
      "//protocol-correctness/proof/lemmas-2:lemmas-1-files",
  ],
  visibility = ["//visibility:public"],
)

