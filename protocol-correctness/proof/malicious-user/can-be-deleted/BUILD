load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "can-be-deleted-execute",
  srcs = ["can-be-deleted-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
      "//protocol-correctness/proof/invariant:invariant-execute-files",
      "//protocol-correctness/proof/malicious-user:malicious-user-execute-files",
      "//protocol-correctness/proof/properties:properties-execute-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "can-be-deleted-execute-files",
  srcs = ["can-be-deleted-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
      "//protocol-correctness/proof/invariant:invariant-execute-files",
      "//protocol-correctness/proof/malicious-user:malicious-user-execute-files",
      "//protocol-correctness/proof/properties:properties-execute-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-can-be-deleted",
  srcs = ["proof-can-be-deleted.k"],
  trusted = [
      ":trusted-propose-delete-malicious",
  ],
  semantics = "can-be-deleted-execute",
)

ktrusted(
  name = "trusted-can-be-deleted",
  srcs = ["proof-can-be-deleted.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-concretize-board-member",
  srcs = ["proof-concretize-board-member.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/map:trusted-map-semantics",
  ],
  semantics = "can-be-deleted-execute",
  breadth = "4",
)

ktrusted(
  name = "trusted-concretize-board-member",
  srcs = ["proof-concretize-board-member.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-delete-malicious",
  srcs = ["proof-propose-delete-malicious.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/map:trusted-map-semantics",
      ":trusted-concretize-board-member",
  ],
  semantics = "can-be-deleted-execute",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-delete-malicious",
  srcs = ["proof-propose-delete-malicious.k"],
  visibility = ["//visibility:public"],
)

