load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-recfu-discard-action-error",
  srcs = ["proof-recfu-discard-action-error.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-role",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-user",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "8",
)

ktrusted(
  name = "trusted-recfu-discard-action-error",
  srcs = ["proof-recfu-discard-action-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-discard-action-void",
  srcs = ["proof-recfu-discard-action-void.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers-no-action",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers-no-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "long",
  breadth = "14",
)

ktrusted(
  name = "trusted-recfu-discard-action-void",
  srcs = ["proof-recfu-discard-action-void.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-add-board-member",
  srcs = ["proof-recfu-propose-add-board-member.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-add-board-member",
  srcs = ["proof-recfu-propose-add-board-member.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-add-proposer",
  srcs = ["proof-recfu-propose-add-proposer.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-add-proposer",
  srcs = ["proof-recfu-propose-add-proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-change-quorum",
  srcs = ["proof-recfu-propose-change-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-change-quorum",
  srcs = ["proof-recfu-propose-change-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-remove-user",
  srcs = ["proof-recfu-propose-remove-user.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-remove-user",
  srcs = ["proof-recfu-propose-remove-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-sc-call",
  srcs = ["proof-recfu-propose-sc-call.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-sc-call",
  srcs = ["proof-recfu-propose-sc-call.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-sc-deploy",
  srcs = ["proof-recfu-propose-sc-deploy.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-sc-deploy",
  srcs = ["proof-recfu-propose-sc-deploy.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-propose-send-egld",
  srcs = ["proof-recfu-propose-send-egld.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-propose-send-egld",
  srcs = ["proof-recfu-propose-send-egld.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-sign-error",
  srcs = ["proof-recfu-sign-error.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-sign-caller-proposer",
      "//protocol-correctness/proof/functions:trusted-sign-empty-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-recfu-sign-error",
  srcs = ["proof-recfu-sign-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-sign-void-no-signers",
  srcs = ["proof-recfu-sign-void-no-signers.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-sign-no-signers",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-recfu-sign-void-no-signers",
  srcs = ["proof-recfu-sign-void-no-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-sign-void-signers",
  srcs = ["proof-recfu-sign-void-signers.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
)

ktrusted(
  name = "trusted-recfu-sign-void-signers",
  srcs = ["proof-recfu-sign-void-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-unsign-error",
  srcs = ["proof-recfu-unsign-error.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-action",
      "//protocol-correctness/proof/functions:trusted-unsign-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-recfu-unsign-error",
  srcs = ["proof-recfu-unsign-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-unsign-void",
  srcs = ["proof-recfu-unsign-void.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-signers",
      "//protocol-correctness/proof/functions:trusted-unsign-not-signed",
      "//protocol-correctness/proof/functions:trusted-unsign-only-signer",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-first",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-not-first",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
)

ktrusted(
  name = "trusted-recfu-unsign-void",
  srcs = ["proof-recfu-unsign-void.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-tmp",
  srcs = ["proof-tmp.k"],
  trusted = [
      ":trusted-recfu-discard-action-error",
      ":trusted-recfu-discard-action-void",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
)

ktrusted(
  name = "trusted-tmp",
  srcs = ["proof-tmp.k"],
  visibility = ["//visibility:public"],
)

