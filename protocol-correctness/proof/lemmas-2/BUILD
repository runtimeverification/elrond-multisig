load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-2-execute",
  srcs = ["lemmas-2-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-1:lemmas-1-execute-files",
      ":lemmas-1-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-2-execute-files",
  srcs = ["lemmas-2-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-1:lemmas-1-execute-files",
      ":lemmas-1-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-1-files",
  srcs = ["lemmas-1.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-1:lemmas-0-files",
      "//protocol-correctness/proof/lemmas-1/list/contains:trusted-lemma-list-contains-last-to-start-files",
      "//protocol-correctness/proof/lemmas-1/list/contains:trusted-lemma-list-contains-pound-last-files",
      "//protocol-correctness/proof/lemmas-1/list/contains:trusted-lemma-list-contains-remove-last-not-pound-last-files",
      "//protocol-correctness/proof/lemmas-1/list/list-to-map-set:trusted-lemma-list-to-map-set-pound-remove-last-pound-last-files",
      "//protocol-correctness/proof/lemmas-1/list/plistlen:trusted-lemma-plistlen-remove-last-files",
      "//protocol-correctness/proof/lemmas-1/map/square-bracket:trusted-lemma-square-bracket-sq-b-sq-b-undef-files",
  ],
  visibility = ["//visibility:public"],
)

