load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "properties-execute",
  srcs = ["properties-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
      "//protocol-correctness/proof/invariant:invariant-execute-files",
      "//protocol-correctness/proof/map:map-execute-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "properties-execute-files",
  srcs = ["properties-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
      "//protocol-correctness/proof/invariant:invariant-execute-files",
      "//protocol-correctness/proof/map:map-execute-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-board-members-sign-for-2",
  srcs = ["proof-board-members-sign-for-2.k"],
  trusted = [
      "//protocol-correctness/proof/map:trusted-map-semantics",
      "//protocol-correctness/proof/functions:trusted-sign-empty-action",
      "//protocol-correctness/proof/functions:trusted-sign-caller-not-user",
      "//protocol-correctness/proof/functions:trusted-sign-caller-none",
      "//protocol-correctness/proof/functions:trusted-sign-caller-proposer",
      "//protocol-correctness/proof/functions:trusted-sign-no-signers",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
      ":trusted-board-members-sign-for",
  ],
  semantics = "properties-execute",
  timeout = "eternal",
  breadth = "5",
)

ktrusted(
  name = "trusted-board-members-sign-for-2",
  srcs = ["proof-board-members-sign-for-2.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-board-members-sign-for-3",
  srcs = ["proof-board-members-sign-for-3.k"],
  trusted = [
      "//protocol-correctness/proof/map:trusted-map-semantics",
  ],
  semantics = "properties-execute",
  timeout = "long",
  breadth = "3",
)

ktrusted(
  name = "trusted-board-members-sign-for-3",
  srcs = ["proof-board-members-sign-for-3.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-board-members-sign-for",
  srcs = ["proof-board-members-sign-for.k"],
  trusted = [
      "//protocol-correctness/proof/map:trusted-map-semantics",
      "//protocol-correctness/proof/instrumentation/pushlist:trusted-push-list-not-empty",
      "//protocol-correctness/proof/functions:trusted-sign-empty-action",
      "//protocol-correctness/proof/functions:trusted-sign-caller-not-user",
      "//protocol-correctness/proof/functions:trusted-sign-caller-none",
      "//protocol-correctness/proof/functions:trusted-sign-caller-proposer",
      "//protocol-correctness/proof/functions:trusted-sign-no-signers",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
  ],
  semantics = "properties-execute",
  timeout = "eternal",
  breadth = "3",
)

ktrusted(
  name = "trusted-board-members-sign-for",
  srcs = ["proof-board-members-sign-for.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-can-propose-and-execute",
  srcs = ["proof-can-propose-and-execute.k"],
  trusted = [
      ":trusted-board-members-sign-for",
      ":trusted-board-members-sign-for-2",
      ":trusted-board-members-sign-for-3",
      ":trusted-pick-and-call-1",
      ":trusted-pick-and-call-2",
      "//protocol-correctness/proof/map:trusted-map-semantics",
      "//protocol-correctness/proof/functions:trusted-count-can-sign",
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "properties-execute",
  timeout = "eternal",
  breadth = "7",
)

ktrusted(
  name = "trusted-can-propose-and-execute",
  srcs = ["proof-can-propose-and-execute.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-pick-and-call-1",
  srcs = ["proof-pick-and-call-1.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-change-quorum-with-quorum-marker",
      "//protocol-correctness/proof/map:trusted-map-semantics",
  ],
  semantics = "properties-execute",
  timeout = "eternal",
  breadth = "3",
)

ktrusted(
  name = "trusted-pick-and-call-1",
  srcs = ["proof-pick-and-call-1.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-pick-and-call-2",
  srcs = ["proof-pick-and-call-2.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-change-quorum-with-quorum-marker",
      "//protocol-correctness/proof/map:trusted-map-semantics",
  ],
  semantics = "properties-execute",
  timeout = "eternal",
  breadth = "3",
)

ktrusted(
  name = "trusted-pick-and-call-2",
  srcs = ["proof-pick-and-call-2.k"],
  visibility = ["//visibility:public"],
)

