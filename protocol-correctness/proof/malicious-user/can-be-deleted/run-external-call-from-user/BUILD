load("//:proof.bzl", "kprove_test", "ktrusted")

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
  breadth = "1",
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

