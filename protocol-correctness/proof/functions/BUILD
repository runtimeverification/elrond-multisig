load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-change-user-role-BoardMember",
  srcs = ["proof-change-user-role-BoardMember.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-change-user-role-BoardMember",
  srcs = ["proof-change-user-role-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-change-user-role-New",
  srcs = ["proof-change-user-role-New.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "3",
)

ktrusted(
  name = "trusted-change-user-role-New",
  srcs = ["proof-change-user-role-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-change-user-role-None",
  srcs = ["proof-change-user-role-None.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-change-user-role-None",
  srcs = ["proof-change-user-role-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-change-user-role-Proposer",
  srcs = ["proof-change-user-role-Proposer.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-change-user-role-Proposer",
  srcs = ["proof-change-user-role-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-count-can-sign",
  srcs = ["proof-count-can-sign.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "6",
)

ktrusted(
  name = "trusted-count-can-sign",
  srcs = ["proof-count-can-sign.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-has-signers",
  srcs = ["proof-discard-action-has-signers.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-discard-action-has-signers",
  srcs = ["proof-discard-action-has-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-role-marker",
  srcs = ["proof-discard-action-no-role-marker.k"],
  trusted = [
      ":trusted-discard-action-no-role",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-discard-action-no-role-marker",
  srcs = ["proof-discard-action-no-role-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-role",
  srcs = ["proof-discard-action-no-role.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-discard-action-no-role",
  srcs = ["proof-discard-action-no-role.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-signers-no-action",
  srcs = ["proof-discard-action-no-signers-no-action.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-discard-action-no-signers-no-action",
  srcs = ["proof-discard-action-no-signers-no-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-signers",
  srcs = ["proof-discard-action-no-signers.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-discard-action-no-signers",
  srcs = ["proof-discard-action-no-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-user-marker",
  srcs = ["proof-discard-action-no-user-marker.k"],
  trusted = [
      ":trusted-discard-action-no-user",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-discard-action-no-user-marker",
  srcs = ["proof-discard-action-no-user-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-user",
  srcs = ["proof-discard-action-no-user.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-discard-action-no-user",
  srcs = ["proof-discard-action-no-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-valid-signers-no-action",
  srcs = ["proof-discard-action-no-valid-signers-no-action.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "eternal",
  breadth = "2",
)

ktrusted(
  name = "trusted-discard-action-no-valid-signers-no-action",
  srcs = ["proof-discard-action-no-valid-signers-no-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-discard-action-no-valid-signers",
  srcs = ["proof-discard-action-no-valid-signers.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "eternal",
  breadth = "2",
)

ktrusted(
  name = "trusted-discard-action-no-valid-signers",
  srcs = ["proof-discard-action-no-valid-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-listlen",
  srcs = ["proof-listlen.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "4",
)

ktrusted(
  name = "trusted-listlen",
  srcs = ["proof-listlen.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-board-member-BoardMember",
  srcs = ["proof-perform-action-add-board-member-BoardMember.k"],
  trusted = [
      ":trusted-change-user-role-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-board-member-BoardMember",
  srcs = ["proof-perform-action-add-board-member-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-board-member-New",
  srcs = ["proof-perform-action-add-board-member-New.k"],
  trusted = [
      ":trusted-change-user-role-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-board-member-New",
  srcs = ["proof-perform-action-add-board-member-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-board-member-None",
  srcs = ["proof-perform-action-add-board-member-None.k"],
  trusted = [
      ":trusted-change-user-role-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-board-member-None",
  srcs = ["proof-perform-action-add-board-member-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-board-member-Proposer",
  srcs = ["proof-perform-action-add-board-member-Proposer.k"],
  trusted = [
      ":trusted-change-user-role-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-board-member-Proposer",
  srcs = ["proof-perform-action-add-board-member-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-action-add-proposer-BoardMember-no-quorum.k"],
  trusted = [
      ":trusted-change-user-role-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-action-add-proposer-BoardMember-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-proposer-BoardMember",
  srcs = ["proof-perform-action-add-proposer-BoardMember.k"],
  trusted = [
      ":trusted-change-user-role-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-proposer-BoardMember",
  srcs = ["proof-perform-action-add-proposer-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-proposer-New",
  srcs = ["proof-perform-action-add-proposer-New.k"],
  trusted = [
      ":trusted-change-user-role-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-add-proposer-New",
  srcs = ["proof-perform-action-add-proposer-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-proposer-None",
  srcs = ["proof-perform-action-add-proposer-None.k"],
  trusted = [
      ":trusted-change-user-role-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-proposer-None",
  srcs = ["proof-perform-action-add-proposer-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-add-proposer-Proposer",
  srcs = ["proof-perform-action-add-proposer-Proposer.k"],
  trusted = [
      ":trusted-change-user-role-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-add-proposer-Proposer",
  srcs = ["proof-perform-action-add-proposer-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-change-quorum-no-quorum",
  srcs = ["proof-perform-action-change-quorum-no-quorum.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-change-quorum-no-quorum",
  srcs = ["proof-perform-action-change-quorum-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-change-quorum",
  srcs = ["proof-perform-action-change-quorum.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-change-quorum",
  srcs = ["proof-perform-action-change-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-New-marker",
  srcs = ["proof-perform-action-endpoint-New-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-New-marker",
  srcs = ["proof-perform-action-endpoint-New-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-New",
  srcs = ["proof-perform-action-endpoint-New.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-New",
  srcs = ["proof-perform-action-endpoint-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-None-marker",
  srcs = ["proof-perform-action-endpoint-None-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-None-marker",
  srcs = ["proof-perform-action-endpoint-None-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-None",
  srcs = ["proof-perform-action-endpoint-None.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-None",
  srcs = ["proof-perform-action-endpoint-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-BoardMember-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-board-member-BoardMember-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-BoardMember-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-BoardMember-eq",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-board-member-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-BoardMember-eq",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-BoardMember-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-board-member-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-BoardMember-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-BoardMember",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-board-member-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-BoardMember",
  srcs = ["proof-perform-action-endpoint-add-board-member-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-New-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-New-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-board-member-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-New-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-New-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-New",
  srcs = ["proof-perform-action-endpoint-add-board-member-New.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-board-member-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-New",
  srcs = ["proof-perform-action-endpoint-add-board-member-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-None-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-None-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-board-member-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-None-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-None-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-None",
  srcs = ["proof-perform-action-endpoint-add-board-member-None.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-board-member-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-None",
  srcs = ["proof-perform-action-endpoint-add-board-member-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-Proposer-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-board-member-Proposer-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-Proposer-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-Proposer-eq",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-board-member-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-Proposer-eq",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-Proposer-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-board-member-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-Proposer-marker",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-board-member-Proposer",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-board-member-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-board-member-Proposer",
  srcs = ["proof-perform-action-endpoint-add-board-member-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-BoardMember-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-eq",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-eq",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-BoardMember-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-BoardMember-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-BoardMember",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-BoardMember",
  srcs = ["proof-perform-action-endpoint-add-proposer-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-New-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-New-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-New-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-New-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-New",
  srcs = ["proof-perform-action-endpoint-add-proposer-New.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-New",
  srcs = ["proof-perform-action-endpoint-add-proposer-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-None-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-None-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-None-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-None-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-None",
  srcs = ["proof-perform-action-endpoint-add-proposer-None.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-None",
  srcs = ["proof-perform-action-endpoint-add-proposer-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-Proposer-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-Proposer-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-Proposer-eq-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-Proposer-eq",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-Proposer-eq",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-Proposer-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-add-proposer-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-Proposer-marker",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-add-proposer-Proposer",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-add-proposer-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-add-proposer-Proposer",
  srcs = ["proof-perform-action-endpoint-add-proposer-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-change-quorum-no-quorum-marker",
  srcs = ["proof-perform-action-endpoint-change-quorum-no-quorum-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-change-quorum-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-change-quorum-no-quorum-marker",
  srcs = ["proof-perform-action-endpoint-change-quorum-no-quorum-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-change-quorum-no-quorum",
  srcs = ["proof-perform-action-endpoint-change-quorum-no-quorum.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-change-quorum-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-change-quorum-no-quorum",
  srcs = ["proof-perform-action-endpoint-change-quorum-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-change-quorum-with-quorum-marker",
  srcs = ["proof-perform-action-endpoint-change-quorum-with-quorum-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-change-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-change-quorum-with-quorum-marker",
  srcs = ["proof-perform-action-endpoint-change-quorum-with-quorum-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-change-quorum",
  srcs = ["proof-perform-action-endpoint-change-quorum.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-change-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-change-quorum",
  srcs = ["proof-perform-action-endpoint-change-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-fragment-New",
  srcs = ["proof-perform-action-endpoint-fragment-New.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-perform-action-endpoint-fragment-New",
  srcs = ["proof-perform-action-endpoint-fragment-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-fragment-None",
  srcs = ["proof-perform-action-endpoint-fragment-None.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-fragment-None",
  srcs = ["proof-perform-action-endpoint-fragment-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-fragment-no-quorum",
  srcs = ["proof-perform-action-endpoint-fragment-no-quorum.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-action-endpoint-fragment-no-quorum",
  srcs = ["proof-perform-action-endpoint-fragment-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-fragment-performs",
  srcs = ["proof-perform-action-endpoint-fragment-performs.k"],
  trusted = [
      ":trusted-count-can-sign",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "eternal",
  breadth = "6",
)

ktrusted(
  name = "trusted-perform-action-endpoint-fragment-performs",
  srcs = ["proof-perform-action-endpoint-fragment-performs.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-no-quorum-marker",
  srcs = ["proof-perform-action-endpoint-no-quorum-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-no-quorum-marker",
  srcs = ["proof-perform-action-endpoint-no-quorum-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-no-quorum",
  srcs = ["proof-perform-action-endpoint-no-quorum.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-no-quorum",
  srcs = ["proof-perform-action-endpoint-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-nothing-marker",
  srcs = ["proof-perform-action-endpoint-nothing-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-nothing",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-nothing-marker",
  srcs = ["proof-perform-action-endpoint-nothing-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-nothing",
  srcs = ["proof-perform-action-endpoint-nothing.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-nothing",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-nothing",
  srcs = ["proof-perform-action-endpoint-nothing.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-BoardMember-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-too-few-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-BoardMember-too-few-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-too-few-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-too-few-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-BoardMember-too-few",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-too-few-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-too-few-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-BoardMember-too-few",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-too-few-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-BoardMember-too-few",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember-too-few.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-BoardMember",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-BoardMember",
  srcs = ["proof-perform-action-endpoint-remove-user-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-New-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-New-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-New-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-New-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-New",
  srcs = ["proof-perform-action-endpoint-remove-user-New.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-New",
  srcs = ["proof-perform-action-endpoint-remove-user-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-None-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-None-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-None-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-None-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-None",
  srcs = ["proof-perform-action-endpoint-remove-user-None.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-None",
  srcs = ["proof-perform-action-endpoint-remove-user-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-Proposer-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-nobody-left-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left-eq-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-eq",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-eq-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left-eq-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-nobody-left-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left-eq.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-Proposer-nobody-left",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-eq",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left-eq.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-nobody-left-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-remove-user-Proposer-nobody-left",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-marker",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-Proposer-nobody-left",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer-nobody-left.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-remove-user-Proposer",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-remove-user-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-remove-user-Proposer",
  srcs = ["proof-perform-action-endpoint-remove-user-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-sc-call-marker",
  srcs = ["proof-perform-action-endpoint-sc-call-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-sc-call",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-sc-call-marker",
  srcs = ["proof-perform-action-endpoint-sc-call-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-sc-call",
  srcs = ["proof-perform-action-endpoint-sc-call.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-sc-call",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-sc-call",
  srcs = ["proof-perform-action-endpoint-sc-call.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-sc-deploy-marker",
  srcs = ["proof-perform-action-endpoint-sc-deploy-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-sc-deploy",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-sc-deploy-marker",
  srcs = ["proof-perform-action-endpoint-sc-deploy-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-sc-deploy",
  srcs = ["proof-perform-action-endpoint-sc-deploy.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-sc-deploy",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-sc-deploy",
  srcs = ["proof-perform-action-endpoint-sc-deploy.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-send-egld-marker",
  srcs = ["proof-perform-action-endpoint-send-egld-marker.k"],
  trusted = [
      ":trusted-perform-action-endpoint-send-egld",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-endpoint-send-egld-marker",
  srcs = ["proof-perform-action-endpoint-send-egld-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-endpoint-send-egld",
  srcs = ["proof-perform-action-endpoint-send-egld.k"],
  trusted = [
      ":trusted-perform-action-endpoint-fragment-performs",
      ":trusted-perform-action-id-send-egld",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-endpoint-send-egld",
  srcs = ["proof-perform-action-endpoint-send-egld.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-board-member-BoardMember",
  srcs = ["proof-perform-action-id-add-board-member-BoardMember.k"],
  trusted = [
      ":trusted-perform-action-add-board-member-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-board-member-BoardMember",
  srcs = ["proof-perform-action-id-add-board-member-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-board-member-New",
  srcs = ["proof-perform-action-id-add-board-member-New.k"],
  trusted = [
      ":trusted-perform-action-add-board-member-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-board-member-New",
  srcs = ["proof-perform-action-id-add-board-member-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-board-member-None",
  srcs = ["proof-perform-action-id-add-board-member-None.k"],
  trusted = [
      ":trusted-perform-action-add-board-member-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-board-member-None",
  srcs = ["proof-perform-action-id-add-board-member-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-board-member-Proposer",
  srcs = ["proof-perform-action-id-add-board-member-Proposer.k"],
  trusted = [
      ":trusted-perform-action-add-board-member-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-board-member-Proposer",
  srcs = ["proof-perform-action-id-add-board-member-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-action-id-add-proposer-BoardMember-no-quorum.k"],
  trusted = [
      ":trusted-perform-action-add-proposer-BoardMember-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-action-id-add-proposer-BoardMember-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-proposer-BoardMember",
  srcs = ["proof-perform-action-id-add-proposer-BoardMember.k"],
  trusted = [
      ":trusted-perform-action-add-proposer-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-proposer-BoardMember",
  srcs = ["proof-perform-action-id-add-proposer-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-proposer-New",
  srcs = ["proof-perform-action-id-add-proposer-New.k"],
  trusted = [
      ":trusted-perform-action-add-proposer-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "5",
)

ktrusted(
  name = "trusted-perform-action-id-add-proposer-New",
  srcs = ["proof-perform-action-id-add-proposer-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-proposer-None",
  srcs = ["proof-perform-action-id-add-proposer-None.k"],
  trusted = [
      ":trusted-perform-action-add-proposer-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "5",
)

ktrusted(
  name = "trusted-perform-action-id-add-proposer-None",
  srcs = ["proof-perform-action-id-add-proposer-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-add-proposer-Proposer",
  srcs = ["proof-perform-action-id-add-proposer-Proposer.k"],
  trusted = [
      ":trusted-perform-action-add-proposer-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-add-proposer-Proposer",
  srcs = ["proof-perform-action-id-add-proposer-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-change-quorum-no-quorum",
  srcs = ["proof-perform-action-id-change-quorum-no-quorum.k"],
  trusted = [
      ":trusted-perform-action-change-quorum-no-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-change-quorum-no-quorum",
  srcs = ["proof-perform-action-id-change-quorum-no-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-change-quorum",
  srcs = ["proof-perform-action-id-change-quorum.k"],
  trusted = [
      ":trusted-perform-action-change-quorum",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-change-quorum",
  srcs = ["proof-perform-action-id-change-quorum.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-nothing",
  srcs = ["proof-perform-action-id-nothing.k"],
  trusted = [
      ":trusted-perform-action-nothing",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-nothing",
  srcs = ["proof-perform-action-id-nothing.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-action-id-remove-user-BoardMember-too-few.k"],
  trusted = [
      ":trusted-perform-action-remove-user-BoardMember-too-few",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-action-id-remove-user-BoardMember-too-few.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-remove-user-BoardMember",
  srcs = ["proof-perform-action-id-remove-user-BoardMember.k"],
  trusted = [
      ":trusted-perform-action-remove-user-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-remove-user-BoardMember",
  srcs = ["proof-perform-action-id-remove-user-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-remove-user-New",
  srcs = ["proof-perform-action-id-remove-user-New.k"],
  trusted = [
      ":trusted-perform-action-remove-user-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-remove-user-New",
  srcs = ["proof-perform-action-id-remove-user-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-remove-user-None",
  srcs = ["proof-perform-action-id-remove-user-None.k"],
  trusted = [
      ":trusted-perform-action-remove-user-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-remove-user-None",
  srcs = ["proof-perform-action-id-remove-user-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-action-id-remove-user-Proposer-nobody-left.k"],
  trusted = [
      ":trusted-perform-action-remove-user-Proposer-nobody-left",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-action-id-remove-user-Proposer-nobody-left.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-remove-user-Proposer",
  srcs = ["proof-perform-action-id-remove-user-Proposer.k"],
  trusted = [
      ":trusted-perform-action-remove-user-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-remove-user-Proposer",
  srcs = ["proof-perform-action-id-remove-user-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-sc-call",
  srcs = ["proof-perform-action-id-sc-call.k"],
  trusted = [
      ":trusted-perform-action-sc-call",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-sc-call",
  srcs = ["proof-perform-action-id-sc-call.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-sc-deploy",
  srcs = ["proof-perform-action-id-sc-deploy.k"],
  trusted = [
      ":trusted-perform-action-sc-deploy",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-sc-deploy",
  srcs = ["proof-perform-action-id-sc-deploy.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-id-send-egld",
  srcs = ["proof-perform-action-id-send-egld.k"],
  trusted = [
      ":trusted-perform-action-send-egld",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-perform-action-id-send-egld",
  srcs = ["proof-perform-action-id-send-egld.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-nothing",
  srcs = ["proof-perform-action-nothing.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-nothing",
  srcs = ["proof-perform-action-nothing.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-action-remove-user-BoardMember-too-few.k"],
  trusted = [
      ":trusted-change-user-role-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-perform-action-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-action-remove-user-BoardMember-too-few.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-remove-user-BoardMember",
  srcs = ["proof-perform-action-remove-user-BoardMember.k"],
  trusted = [
      ":trusted-change-user-role-BoardMember",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-remove-user-BoardMember",
  srcs = ["proof-perform-action-remove-user-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-remove-user-New",
  srcs = ["proof-perform-action-remove-user-New.k"],
  trusted = [
      ":trusted-change-user-role-New",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-remove-user-New",
  srcs = ["proof-perform-action-remove-user-New.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-remove-user-None",
  srcs = ["proof-perform-action-remove-user-None.k"],
  trusted = [
      ":trusted-change-user-role-None",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-perform-action-remove-user-None",
  srcs = ["proof-perform-action-remove-user-None.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-action-remove-user-Proposer-nobody-left.k"],
  trusted = [
      ":trusted-change-user-role-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-action-remove-user-Proposer-nobody-left.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-remove-user-Proposer",
  srcs = ["proof-perform-action-remove-user-Proposer.k"],
  trusted = [
      ":trusted-change-user-role-Proposer",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-perform-action-remove-user-Proposer",
  srcs = ["proof-perform-action-remove-user-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-sc-call",
  srcs = ["proof-perform-action-sc-call.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-sc-call",
  srcs = ["proof-perform-action-sc-call.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-sc-deploy",
  srcs = ["proof-perform-action-sc-deploy.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-sc-deploy",
  srcs = ["proof-perform-action-sc-deploy.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-perform-action-send-egld",
  srcs = ["proof-perform-action-send-egld.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-perform-action-send-egld",
  srcs = ["proof-perform-action-send-egld.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-action-BoardMember",
  srcs = ["proof-propose-action-BoardMember.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "eternal",
  breadth = "2",
)

ktrusted(
  name = "trusted-propose-action-BoardMember",
  srcs = ["proof-propose-action-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-action-Proposer",
  srcs = ["proof-propose-action-Proposer.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-propose-action-Proposer",
  srcs = ["proof-propose-action-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-action-error-no-role",
  srcs = ["proof-propose-action-error-no-role.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-propose-action-error-no-role",
  srcs = ["proof-propose-action-error-no-role.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-action-error-no-user",
  srcs = ["proof-propose-action-error-no-user.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-propose-action-error-no-user",
  srcs = ["proof-propose-action-error-no-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-BoardMember",
  srcs = ["proof-propose-sc-deploy-BoardMember.k"],
  trusted = [
      ":trusted-propose-action-BoardMember",
      ":trusted-propose-sc-deploy-fragment",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-propose-sc-deploy-BoardMember",
  srcs = ["proof-propose-sc-deploy-BoardMember.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-Proposer",
  srcs = ["proof-propose-sc-deploy-Proposer.k"],
  trusted = [
      ":trusted-propose-action-Proposer",
      ":trusted-propose-sc-deploy-fragment",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-propose-sc-deploy-Proposer",
  srcs = ["proof-propose-sc-deploy-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-error-no-role",
  srcs = ["proof-propose-sc-deploy-error-no-role.k"],
  trusted = [
      ":trusted-propose-action-error-no-role",
      ":trusted-propose-sc-deploy-fragment",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-propose-sc-deploy-error-no-role",
  srcs = ["proof-propose-sc-deploy-error-no-role.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-error-no-user",
  srcs = ["proof-propose-sc-deploy-error-no-user.k"],
  trusted = [
      ":trusted-propose-action-error-no-user",
      ":trusted-propose-sc-deploy-fragment",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-propose-sc-deploy-error-no-user",
  srcs = ["proof-propose-sc-deploy-error-no-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-propose-sc-deploy-fragment",
  srcs = ["proof-propose-sc-deploy-fragment.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "6",
)

ktrusted(
  name = "trusted-propose-sc-deploy-fragment",
  srcs = ["proof-propose-sc-deploy-fragment.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-caller-none",
  srcs = ["proof-sign-caller-none.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-sign-caller-none",
  srcs = ["proof-sign-caller-none.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-caller-not-user",
  srcs = ["proof-sign-caller-not-user.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-sign-caller-not-user",
  srcs = ["proof-sign-caller-not-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-caller-proposer",
  srcs = ["proof-sign-caller-proposer.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-sign-caller-proposer",
  srcs = ["proof-sign-caller-proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-empty-action",
  srcs = ["proof-sign-empty-action.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-sign-empty-action",
  srcs = ["proof-sign-empty-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-existing-signers-in-list",
  srcs = ["proof-sign-existing-signers-in-list.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
  breadth = "2",
)

ktrusted(
  name = "trusted-sign-existing-signers-in-list",
  srcs = ["proof-sign-existing-signers-in-list.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-existing-signers-not-in-list",
  srcs = ["proof-sign-existing-signers-not-in-list.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
  breadth = "2",
)

ktrusted(
  name = "trusted-sign-existing-signers-not-in-list",
  srcs = ["proof-sign-existing-signers-not-in-list.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-sign-no-signers",
  srcs = ["proof-sign-no-signers.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "eternal",
  breadth = "2",
)

ktrusted(
  name = "trusted-sign-no-signers",
  srcs = ["proof-sign-no-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-Proposer",
  srcs = ["proof-unsign-Proposer.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-Proposer",
  srcs = ["proof-unsign-Proposer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-no-action",
  srcs = ["proof-unsign-no-action.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-no-action",
  srcs = ["proof-unsign-no-action.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-no-role-marker",
  srcs = ["proof-unsign-no-role-marker.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-no-role-marker",
  srcs = ["proof-unsign-no-role-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-no-role",
  srcs = ["proof-unsign-no-role.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-no-role",
  srcs = ["proof-unsign-no-role.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-no-signers",
  srcs = ["proof-unsign-no-signers.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-no-signers",
  srcs = ["proof-unsign-no-signers.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-no-user-marker",
  srcs = ["proof-unsign-no-user-marker.k"],
  trusted = [
      ":trusted-unsign-no-user",
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
)

ktrusted(
  name = "trusted-unsign-no-user-marker",
  srcs = ["proof-unsign-no-user-marker.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-no-user",
  srcs = ["proof-unsign-no-user.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-no-user",
  srcs = ["proof-unsign-no-user.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-not-signed",
  srcs = ["proof-unsign-not-signed.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-not-signed",
  srcs = ["proof-unsign-not-signed.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-only-signer",
  srcs = ["proof-unsign-only-signer.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "moderate",
)

ktrusted(
  name = "trusted-unsign-only-signer",
  srcs = ["proof-unsign-only-signer.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-other-signers-first",
  srcs = ["proof-unsign-other-signers-first.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
)

ktrusted(
  name = "trusted-unsign-other-signers-first",
  srcs = ["proof-unsign-other-signers-first.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-unsign-other-signers-not-first",
  srcs = ["proof-unsign-other-signers-not-first.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  timeout = "long",
)

ktrusted(
  name = "trusted-unsign-other-signers-not-first",
  srcs = ["proof-unsign-other-signers-not-first.k"],
  visibility = ["//visibility:public"],
)

