load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-recfu-unsign-error",
  srcs = ["proof-recfu-unsign-error.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-action",
      "//protocol-correctness/proof/functions:trusted-unsign-no-signers",
      "//protocol-correctness/proof/functions:trusted-unsign-not-signed",
      "//protocol-correctness/proof/functions:trusted-unsign-only-signer",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-first",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-not-first",
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

