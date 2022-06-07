load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "invariant-execute",
  srcs = ["invariant-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
      ":init-loop-parts-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "invariant-execute-files",
  srcs = ["invariant-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
      ":init-loop-parts-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "init-loop-parts-files",
  srcs = ["init-loop-parts.k"],
  deps = [
      "//protocol-correctness/lib/functions:can-add-list-elements-at-index-files",
      "//protocol-correctness/lib/functions:can-add-value-for-list-elements-at-index-files",
      "//protocol-correctness/lib/functions:list-elements-are-of-type-files",
      "//protocol-correctness/lib/functions:map-keys-are-below-limit-files",
      "//protocol-correctness/lib/functions:maps-are-reverse-files",
      "//protocol-correctness:pseudocode-files",
      "//protocol-correctness/proof:execution-proof-helpers-files",
      "//protocol-correctness/proof:invariant-files",
      "//protocol-correctness/proof/map:map-execute-files",
  ],
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
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "8",
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
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "8",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
  timeout = "long",
  breadth = "8",
)

ktrusted(
  name = "trusted-discard-action",
  srcs = ["proof-discard-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-init-loop-body-no-error",
  srcs = ["proof-init-loop-body-no-error.k"],
  trusted = [
  ],
  semantics = "invariant-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-init-loop-body-no-error",
  srcs = ["proof-init-loop-body-no-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-init-loop-error",
  srcs = ["proof-init-loop-error.k"],
  trusted = [
  ],
  semantics = "invariant-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-init-loop-error",
  srcs = ["proof-init-loop-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-init-loop-no-error",
  srcs = ["proof-init-loop-no-error.k"],
  trusted = [
      ":trusted-init-loop-body-no-error",
  ],
  semantics = "invariant-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-init-loop-no-error",
  srcs = ["proof-init-loop-no-error.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-init",
  srcs = ["proof-init.k"],
  trusted = [
      ":trusted-init-loop-error",
      ":trusted-init-loop-no-error",
      "//protocol-correctness/proof/functions:trusted-listlen",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-init",
  srcs = ["proof-init.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint",
  srcs = ["proof-perform-action-endpoint.k"],
  trusted = [
      ":trusted-perform-parts-1",
      ":trusted-perform-parts-2",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-New-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-no-quorum-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-None-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-nothing-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "26",
)

ktrusted(
  name = "trusted-perform-action-endpoint",
  srcs = ["proof-perform-action-endpoint.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-1",
  srcs = ["proof-perform-parts-1.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member",
      ":trusted-perform-parts-add-proposer-signers",
      ":trusted-perform-parts-add-proposer-no-signers",
      ":trusted-perform-parts-change-quorum",
      ":trusted-perform-parts-remove-user",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-sc-call-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-sc-deploy-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-send-egld-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "7",
)

ktrusted(
  name = "trusted-perform-parts-1",
  srcs = ["proof-perform-parts-1.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-2",
  srcs = ["proof-perform-parts-2.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member",
      ":trusted-perform-parts-add-proposer-signers",
      ":trusted-perform-parts-add-proposer-no-signers",
      ":trusted-perform-parts-change-quorum",
      ":trusted-perform-parts-remove-user",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-sc-call-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-sc-deploy-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-send-egld-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "7",
)

ktrusted(
  name = "trusted-perform-parts-2",
  srcs = ["proof-perform-parts-2.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-board-member-eq",
  srcs = ["proof-perform-parts-add-board-member-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-BoardMember-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-Proposer-eq-marker",
  ],
  semantics = "invariant-execute",
  timeout = "long",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-eq",
  srcs = ["proof-perform-parts-add-board-member-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-board-member-neq",
  srcs = ["proof-perform-parts-add-board-member-neq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-BoardMember-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-Proposer-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "7",
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-neq",
  srcs = ["proof-perform-parts-add-board-member-neq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-board-member",
  srcs = ["proof-perform-parts-add-board-member.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member-eq",
      ":trusted-perform-parts-add-board-member-neq",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-New-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-None-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "9",
)

ktrusted(
  name = "trusted-perform-parts-add-board-member",
  srcs = ["proof-perform-parts-add-board-member.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-proposer-no-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-Proposer-eq-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "5",
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-no-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-proposer-no-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-neq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-Proposer-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-no-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-neq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-proposer-no-signers",
  srcs = ["proof-perform-parts-add-proposer-no-signers.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-no-signers-eq",
      ":trusted-perform-parts-add-proposer-no-signers-neq",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-New",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-None",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "5",
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-no-signers",
  srcs = ["proof-perform-parts-add-proposer-no-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-proposer-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-signers-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-Proposer-eq-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-signers-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-proposer-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-signers-neq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-Proposer-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-signers-neq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-add-proposer-signers",
  srcs = ["proof-perform-parts-add-proposer-signers.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-signers-eq",
      ":trusted-perform-parts-add-proposer-signers-neq",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-New-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-None-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "5",
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-signers",
  srcs = ["proof-perform-parts-add-proposer-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-change-quorum",
  srcs = ["proof-perform-parts-change-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-change-quorum-no-quorum-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-change-quorum-with-quorum-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-parts-change-quorum",
  srcs = ["proof-perform-parts-change-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-remove-user-eq",
  srcs = ["proof-perform-parts-remove-user-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-too-few-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-eq-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-eq-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "12",
)

ktrusted(
  name = "trusted-perform-parts-remove-user-eq",
  srcs = ["proof-perform-parts-remove-user-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-remove-user-neq-1",
  srcs = ["proof-perform-parts-remove-user-neq-1.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-parts-remove-user-neq-1",
  srcs = ["proof-perform-parts-remove-user-neq-1.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-remove-user-neq-2",
  srcs = ["proof-perform-parts-remove-user-neq-2.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-too-few-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-parts-remove-user-neq-2",
  srcs = ["proof-perform-parts-remove-user-neq-2.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-remove-user-neq",
  srcs = ["proof-perform-parts-remove-user-neq.k"],
  trusted = [
      ":trusted-perform-parts-remove-user-neq-1",
      ":trusted-perform-parts-remove-user-neq-2",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-parts-remove-user-neq",
  srcs = ["proof-perform-parts-remove-user-neq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-parts-remove-user",
  srcs = ["proof-perform-parts-remove-user.k"],
  trusted = [
      ":trusted-perform-parts-remove-user-eq",
      ":trusted-perform-parts-remove-user-neq",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-New-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-None-marker",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "9",
)

ktrusted(
  name = "trusted-perform-parts-remove-user",
  srcs = ["proof-perform-parts-remove-user.k"],
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
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "4",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
  timeout = "long",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
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
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "10",
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
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-pound-list-swap-remove-2",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-pound-remove-last-pound-last",
      "//protocol-correctness/proof/lemmas/2/list/contains:trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-neq",
  ],
  semantics = "invariant-execute",
  timeout = "eternal",
  breadth = "17",
)

ktrusted(
  name = "trusted-unsign",
  srcs = ["proof-unsign.k"],
  visibility = ["//visibility:public"],
)

