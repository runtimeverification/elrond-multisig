load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-execute",
  srcs = ["lemmas-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/5:lemmas-5-execute-files",
      ":lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-execute-files",
  srcs = ["lemmas-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/5:lemmas-5-execute-files",
      ":lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-files",
  srcs = ["lemmas.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/4:lemmas-3-files",
  ],
  visibility = ["//visibility:public"],
)

