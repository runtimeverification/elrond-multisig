load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-call-invariant",
  srcs = ["proof-call-invariant.k"],
  trusted = [
      ":trusted-discard-action",
      ":trusted-perform-action",
      ":trusted-propose-add-board-member",
      ":trusted-propose-add-proposer",
      ":trusted-propose-change-quorum",
      ":trusted-propose-remove-user",
      ":trusted-propose-sc-call",
      ":trusted-propose-sc-deploy",
      ":trusted-propose-send-egld",
      ":trusted-sign",
      ":trusted-unsign",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "20",
)

ktrusted(
  name = "trusted-call-invariant",
  srcs = ["proof-call-invariant.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-cannot-perform",
  srcs = ["proof-cannot-perform.k"],
  trusted = [
      ":trusted-call-invariant",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-cannot-perform",
  srcs = ["proof-cannot-perform.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-1",
  srcs = ["proof-discard-action-1.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers-no-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "4",
)

ktrusted(
  name = "trusted-discard-action-1",
  srcs = ["proof-discard-action-1.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-2",
  srcs = ["proof-discard-action-2.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers-no-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "4",
)

ktrusted(
  name = "trusted-discard-action-2",
  srcs = ["proof-discard-action-2.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-3",
  srcs = ["proof-discard-action-3.k"],
  trusted = [
      ":trusted-discard-action-1",
      ":trusted-discard-action-2",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers-no-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "9",
)

ktrusted(
  name = "trusted-discard-action-3",
  srcs = ["proof-discard-action-3.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action",
  srcs = ["proof-discard-action.k"],
  trusted = [
      ":trusted-discard-action-3",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-role-marker",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-user-marker",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "long",
  breadth = "3",
)

ktrusted(
  name = "trusted-discard-action",
  srcs = ["proof-discard-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action",
  srcs = ["proof-perform-action.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-New-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-no-quorum-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-None-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-nothing-marker",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "13",
)

ktrusted(
  name = "trusted-perform-action",
  srcs = ["proof-perform-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-add-board-member",
  srcs = ["proof-propose-add-board-member.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-add-board-member",
  srcs = ["proof-propose-add-board-member.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-add-proposer",
  srcs = ["proof-propose-add-proposer.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-add-proposer",
  srcs = ["proof-propose-add-proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-change-quorum",
  srcs = ["proof-propose-change-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-change-quorum",
  srcs = ["proof-propose-change-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-remove-user",
  srcs = ["proof-propose-remove-user.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-remove-user",
  srcs = ["proof-propose-remove-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-call",
  srcs = ["proof-propose-sc-call.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-sc-call",
  srcs = ["proof-propose-sc-call.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-1",
  srcs = ["proof-propose-sc-deploy-1.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-error-no-user",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "1",
)

ktrusted(
  name = "trusted-propose-sc-deploy-1",
  srcs = ["proof-propose-sc-deploy-1.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-2",
  srcs = ["proof-propose-sc-deploy-2.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "1",
)

ktrusted(
  name = "trusted-propose-sc-deploy-2",
  srcs = ["proof-propose-sc-deploy-2.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-3",
  srcs = ["proof-propose-sc-deploy-3.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-BoardMember",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "1",
)

ktrusted(
  name = "trusted-propose-sc-deploy-3",
  srcs = ["proof-propose-sc-deploy-3.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-4",
  srcs = ["proof-propose-sc-deploy-4.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-Proposer",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "1",
)

ktrusted(
  name = "trusted-propose-sc-deploy-4",
  srcs = ["proof-propose-sc-deploy-4.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy",
  srcs = ["proof-propose-sc-deploy.k"],
  trusted = [
      ":trusted-propose-sc-deploy-1",
      ":trusted-propose-sc-deploy-2",
      ":trusted-propose-sc-deploy-3",
      ":trusted-propose-sc-deploy-4",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-sc-deploy",
  srcs = ["proof-propose-sc-deploy.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-send-egld",
  srcs = ["proof-propose-send-egld.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-send-egld",
  srcs = ["proof-propose-send-egld.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign",
  srcs = ["proof-sign.k"],
  trusted = [
      "//protocol-correctness/proof/instrumentation/pushlist:trusted-push-list-not-empty",
      "//protocol-correctness/proof/functions:trusted-sign-empty-action",
      "//protocol-correctness/proof/functions:trusted-sign-caller-not-user",
      "//protocol-correctness/proof/functions:trusted-sign-caller-none",
      "//protocol-correctness/proof/functions:trusted-sign-caller-proposer",
      "//protocol-correctness/proof/functions:trusted-sign-no-signers",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "9",
)

ktrusted(
  name = "trusted-sign",
  srcs = ["proof-sign.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign",
  srcs = ["proof-unsign.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-action",
      "//protocol-correctness/proof/functions:trusted-unsign-only-signer",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-not-first",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-first",
      "//protocol-correctness/proof/functions:trusted-unsign-not-signed",
      "//protocol-correctness/proof/functions:trusted-unsign-no-signers",
      "//protocol-correctness/proof/functions:trusted-unsign-Proposer",
      "//protocol-correctness/proof/functions:trusted-unsign-no-role-marker",
      "//protocol-correctness/proof/functions:trusted-unsign-no-user-marker",
  ],
  semantics = "//protocol-correctness/proof/malicious-user:malicious-user-execute",
  timeout = "eternal",
  breadth = "10",
)

ktrusted(
  name = "trusted-unsign",
  srcs = ["proof-unsign.k"],
  visibility = ["//visibility:public"],
)

