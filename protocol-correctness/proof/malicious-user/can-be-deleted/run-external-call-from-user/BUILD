load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-recfu-discard-action-error-eq",
  srcs = ["proof-recfu-discard-action-error-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-role",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-user",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "long",
  breadth = "8",
)

ktrusted(
  name = "trusted-recfu-discard-action-error-eq",
  srcs = ["proof-recfu-discard-action-error-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-discard-action-error-ne",
  srcs = ["proof-recfu-discard-action-error-ne.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-role",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-user",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "long",
  breadth = "8",
)

ktrusted(
  name = "trusted-recfu-discard-action-error-ne",
  srcs = ["proof-recfu-discard-action-error-ne.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-discard-action-void-ne-fragment",
  srcs = ["proof-recfu-discard-action-void-ne-fragment.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers-no-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-recfu-discard-action-void-ne-fragment",
  srcs = ["proof-recfu-discard-action-void-ne-fragment.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-discard-action-void-ne",
  srcs = ["proof-recfu-discard-action-void-ne.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers-no-action",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers-no-action",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "eternal",
  breadth = "12",
)

ktrusted(
  name = "trusted-recfu-discard-action-void-ne",
  srcs = ["proof-recfu-discard-action-void-ne.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-fragment-discard-action",
  srcs = ["proof-recfu-fragment-discard-action.k"],
  trusted = [
      ":trusted-recfu-discard-action-error-eq",
      ":trusted-recfu-discard-action-error-ne",
      ":trusted-recfu-discard-action-void-ne",
      "//protocol-correctness/proof/fragments:trusted-make-concrete-value-fragment",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "long",
  breadth = "6",
)

ktrusted(
  name = "trusted-recfu-fragment-discard-action",
  srcs = ["proof-recfu-fragment-discard-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-fragment-sign",
  srcs = ["proof-recfu-fragment-sign.k"],
  trusted = [
      ":trusted-recfu-sign-error",
      ":trusted-recfu-sign-void-no-signers",
      ":trusted-recfu-sign-void-signers-eq",
      ":trusted-recfu-sign-void-signers-neq",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "eternal",
  breadth = "10",
)

ktrusted(
  name = "trusted-recfu-fragment-sign",
  srcs = ["proof-recfu-fragment-sign.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-fragment-unsign",
  srcs = ["proof-recfu-fragment-unsign.k"],
  trusted = [
      ":trusted-recfu-unsign-error",
      ":trusted-recfu-unsign-void-eq",
      ":trusted-recfu-unsign-void-neq",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "eternal",
  breadth = "8",
)

ktrusted(
  name = "trusted-recfu-fragment-unsign",
  srcs = ["proof-recfu-fragment-unsign.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-perform-action-error",
  srcs = ["proof-recfu-perform-action-error.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-no-quorum",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "moderate",
  breadth = "10",
)

ktrusted(
  name = "trusted-recfu-perform-action-error",
  srcs = ["proof-recfu-perform-action-error.k"],
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
  timeout = "long",
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
  timeout = "long",
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
  timeout = "long",
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
  timeout = "long",
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
  timeout = "long",
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
  timeout = "long",
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
  timeout = "long",
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
  timeout = "moderate",
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
  timeout = "long",
)

ktrusted(
  name = "trusted-recfu-sign-void-no-signers",
  srcs = ["proof-recfu-sign-void-no-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-sign-void-signers-eq",
  srcs = ["proof-recfu-sign-void-signers-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "long",
  breadth = "3",
)

ktrusted(
  name = "trusted-recfu-sign-void-signers-eq",
  srcs = ["proof-recfu-sign-void-signers-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-sign-void-signers-neq",
  srcs = ["proof-recfu-sign-void-signers-neq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "long",
  breadth = "5",
)

ktrusted(
  name = "trusted-recfu-sign-void-signers-neq",
  srcs = ["proof-recfu-sign-void-signers-neq.k"],
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
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-recfu-unsign-error",
  srcs = ["proof-recfu-unsign-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-unsign-void-eq",
  srcs = ["proof-recfu-unsign-void-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-signers",
      "//protocol-correctness/proof/functions:trusted-unsign-not-signed",
      "//protocol-correctness/proof/functions:trusted-unsign-only-signer",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-first",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-not-first",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-pound-list-swap-remove-2",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-neq",
      "//protocol-correctness/proof/lemmas/2/list/list-to-map-set:trusted-lemma-list-to-map-set-last-to-start",
      "//protocol-correctness/proof/lemmas/4/list/list-to-map-set:trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "eternal",
  breadth = "8",
)

ktrusted(
  name = "trusted-recfu-unsign-void-eq",
  srcs = ["proof-recfu-unsign-void-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-recfu-unsign-void-neq",
  srcs = ["proof-recfu-unsign-void-neq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-signers",
      "//protocol-correctness/proof/functions:trusted-unsign-not-signed",
      "//protocol-correctness/proof/functions:trusted-unsign-only-signer",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-first",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-not-first",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-pound-list-swap-remove-2",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-pound-remove-last-pound-last",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-eq",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-neq",
      "//protocol-correctness/proof/lemmas/2/list/list-to-map-set:trusted-lemma-list-to-map-set-last-to-start",
      "//protocol-correctness/proof/lemmas/4/list/contains:trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq",
      "//protocol-correctness/proof/lemmas/4/list/list-to-map-set:trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete",
  ],
  semantics = "//protocol-correctness/proof/malicious-user/can-be-deleted:can-be-deleted-execute",
  timeout = "eternal",
  breadth = "16",
)

ktrusted(
  name = "trusted-recfu-unsign-void-neq",
  srcs = ["proof-recfu-unsign-void-neq.k"],
  visibility = ["//visibility:public"],
)

