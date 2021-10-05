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

klibrary(
  name = "all-board-members-sign-for-interspersed-files",
  srcs = ["all-board-members-sign-for-interspersed.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-can-be-deleted",
  srcs = ["proof-can-be-deleted.k"],
  trusted = [
      ":trusted-propose-delete-malicious",
      ":trusted-run-external-calls-from-user",
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
  timeout = "long",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-delete-malicious",
  srcs = ["proof-propose-delete-malicious.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-run-external-call-from-user",
  srcs = ["proof-run-external-call-from-user.k"],
  trusted = [
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-fragment-discard-action",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-fragment-sign",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-fragment-unsign",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-perform-action-error",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-add-board-member",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-add-proposer",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-change-quorum",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-remove-user",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-sc-call",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-sc-deploy",
      "//protocol-correctness/proof/malicious-user/can-be-deleted/run-external-call-from-user:trusted-recfu-propose-send-egld",
  ],
  semantics = "can-be-deleted-execute",
  timeout = "eternal",
  breadth = "22",
)

ktrusted(
  name = "trusted-run-external-call-from-user",
  srcs = ["proof-run-external-call-from-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-run-external-calls-from-user",
  srcs = ["proof-run-external-calls-from-user.k"],
  trusted = [
      ":trusted-run-external-call-from-user",
      "//protocol-correctness/proof/lemmas/0/map:trusted-map-keys-are-below-limit-ignore-property-handling",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-only-this-signer-diffs-transitive",
  ],
  semantics = "can-be-deleted-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-run-external-calls-from-user",
  srcs = ["proof-run-external-calls-from-user.k"],
  visibility = ["//visibility:public"],
)

