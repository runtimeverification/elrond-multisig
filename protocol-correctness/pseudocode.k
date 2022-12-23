require "protocol-correctness/lib/functions/functions.k"
require "protocol-correctness/lib/language/language.k"

require "protocol-correctness/lib/functions/list-contains.k"
require "protocol-correctness/lib/functions/list-find.k"
require "protocol-correctness/lib/functions/list-swap-remove.k"
require "protocol-correctness/lib/functions/plistlen-functions.k"
require "protocol-correctness/lib/functions/push-list.k"
require "protocol-correctness/lib/functions/remove-last.k"
require "protocol-correctness/lib/functions/reverse-expression-csv.k"

require "protocol-correctness/multisig/lib/language/syntax.k"

require "protocol-correctness/multisig/lib/functions/functions.k"
require "protocol-correctness/multisig/lib/language/language.k"

module PSEUDOCODE-SYNTAX
  imports MULTISIG-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX
endmodule

module PSEUDOCODE
  imports LANGUAGE
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-EXPRESSION
  imports PSEUDOCODE-FUNCTION-CALL
  imports PSEUDOCODE-FUNCTIONS
  imports PSEUDOCODE-SYNTAX

  imports LANGUAGE
  imports FUNCTIONS

  imports MULTISIG-LANGUAGE
  imports MULTISIG-FUNCTIONS
endmodule

module PSEUDOCODE-EXPRESSION
  imports EXPRESSION-SYNTAX
  imports PSEUDOCODE-SYNTAX
  imports RUNNING-SYNTAX

  rule evaluate((meta(A:Int) | meta(B:Int)) => meta(A |Int B))
endmodule

module PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  rule CodeMetadata::DEFAULT      => meta(0)
  rule CodeMetadata::UPGRADEABLE  => meta(1 <<Int 8)
  rule CodeMetadata::PAYABLE      => meta(1 <<Int 1)
  rule CodeMetadata::READABLE     => meta(1 <<Int 10)
endmodule

module PSEUDOCODE-FUNCTIONS-SYNTAX
  imports BOOL
  imports INT

  imports PSEUDOCODE-SYNTAX

  syntax KResult

  syntax FunctionTag ::= "proposeActionSCDeploy"

  syntax KItem ::= "plusOne"

endmodule

module PSEUDOCODE-FUNCTION-CALL
  imports PSEUDOCODE-CONFIGURATION
  imports FUNCTION-CALL-SYNTAX

  syntax CustomStackState ::= customStackState(ContractStateCell, LogCell)

  rule  <k> getCustomStackState => customStackState(C, Log) ... </k>
        <state>
          C:ContractStateCell
          _:PseudocodeStateCell
          _:ExternalCallEnvCell
          Log:LogCell
        </state>

  rule  <k> setCustomStackState(customStackState(C:ContractStateCell, Log:LogCell)) => .K ... </k>
        <state>
          (_:ContractStateCell => C)
          _:PseudocodeStateCell
          _:ExternalCallEnvCell
          (_:LogCell => Log)
        </state>
endmodule

module PSEUDOCODE-FUNCTIONS
  imports BOOL
  imports MAP

  imports MAP-UTILS
  // imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-FUNCTIONS-SYNTAX
  // imports PSEUDOCODE-SYNTAX

  imports EXPRESSION-SYNTAX
  imports FLOW-SYNTAX
  imports FUNCTION-CALL-SYNTAX
  imports MAP-UTILS-SYNTAX
  imports MULTISIG-TYPE-REFLECTION-SYNTAX

  imports LIST-CONTAINS-SYNTAX
  imports LIST-FIND-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports PUSH-LIST-SYNTAX
  imports REMOVE-LAST-SYNTAX
  imports REVERSE-EXPRESSION-CSV-SYNTAX

  rule call(init(Quorum:Usize, Board:ExpressionList)) =>
      runPseudoCode(
        require(!isEmptyList(Board));
        require(Quorum <= listLen(Board));
        setQuorum(Quorum);
        for (i, address) in Board {
            user_id = i + u(1);
            require(getUserId(address) == u(0));
            setUserId(address, user_id);
            setUserAddress(user_id, address);
            setUserIdToRole(user_id, BoardMember);
        }
        setNumUsers(listLen(Board));
        setNumBoardMembers(listLen(Board));
        ok(void);
      )

  rule call(proposeAddBoardMember(Member:Address)) =>
      runPseudoCode(
        proposeAction(AddBoardMember(Member));
      )

  rule call(proposeAddProposer(Member:Address)) =>
      runPseudoCode(
        proposeAction(AddProposer(Member));
      )

  rule call(proposeRemoveUser(Member:Address)) =>
      runPseudoCode(
        proposeAction(RemoveUser(Member));
      )

  rule call(proposeChangeQuorum(Quorum:Usize)) =>
      runPseudoCode(
        proposeAction(ChangeQuorum(Quorum));
      )

  rule call(proposeSendEgld(To:Address, Amount:BigUint)) =>
      runPseudoCode(
        proposeAction(SendEgld(To, Amount, bytes("")));
      )

  rule call(proposeSendEgld(To:Address, Amount:BigUint, Data:BoxedBytes)) =>
      runPseudoCode(
        proposeAction(SendEgld(To, Amount, Data));
      )

  rule call(proposeSCDeploy(
          Amount:BigUint,
          Code:BoxedBytes,
          Upgradeable:Bool,
          Payable:Bool,
          Readable:Bool,
          Args:ExpressionList)) =>
      runPseudoCode(
          code_metadata = CodeMetadata::DEFAULT;
          if (Upgradeable) {
            code_metadata = code_metadata | CodeMetadata::UPGRADEABLE;
          }
          if (Payable) {
            code_metadata = code_metadata | CodeMetadata::PAYABLE;
          }
          if (Readable) {
            code_metadata = code_metadata | CodeMetadata::READABLE;
          }
          proposeActionSCDeploy(Amount, Code, code_metadata, Args);
      )

  rule  call(proposeActionSCDeploy(Amount:BigUint, Code:BoxedBytes, CodeMetadata:CodeMetadata, Args:ExpressionList))
        => runPseudoCode(proposeAction(SCDeploy(Amount, Code, CodeMetadata, Args));)

  rule call(proposeSCCall(To:Address, Amount:BigUint, Function:BoxedBytes, Args:ExpressionList)) =>
      runPseudoCode(
        proposeAction(SCCall(To, Amount, Function, Args));
      )

  rule call(sign(ActionId:Usize)) =>
      runPseudoCode(
        require(!isEmptyActionData(ActionId));
        caller_address = getCaller();
        caller_id = getUserId(caller_address);
        caller_role = getUserIdToRole(caller_id);
        require(canSign(caller_role));

        signer_ids = getActionSignerIds(ActionId);
        if (!listContains(signer_ids, caller_id)) {
          signer_ids = pushList(signer_ids, caller_id);
          setActionSignerIDs(ActionId, signer_ids);
        }

        ok(void);
      )

  rule call(unsign(ActionId:Usize)) =>
      runPseudoCode(
        require(!isEmptyActionData(ActionId));

        caller_address = getCaller();
        caller_id = getUserId(caller_address);
        caller_role = getUserIdToRole(caller_id);
        require(canSign(caller_role));

        signer_ids = getActionSignerIds(ActionId);
        signer_pos = listFind(signer_ids, caller_id);
        if (u(0) <= signer_pos) {
          signer_ids = listSwapRemove(signer_ids, signer_pos);
          setActionSignerIDs(ActionId, signer_ids);
        }

        ok(void);
      )

  rule call(proposeAction(A:Action))
      => runPseudoCode(
            caller = getCaller();
            caller_id = getUserId(caller);
            caller_role = getUserIdToRole(caller_id);
            require(userRoleCanPropose(caller_role));
            action_id = getActionLastIndex() + u(1);
            setActionLastIndex(action_id);
            setActionData(action_id, A);
            if (userRoleCanSign(caller_role)) {
              setActionSignerIDs(action_id, [caller_id, .]);  // TODO
            }
            ok(action_id);
        )

  rule call(performActionEndpoint(ActionId:Usize))
      => runPseudoCode(
            caller_address = getCaller();
            caller_id = getUserId(caller_address);
            caller_role = getUserIdToRole(caller_id);
            require(userRoleCanPerformAction(caller_role));
            require(quorumReached(ActionId));
            performActionFromId(ActionId);
      )

  rule call(discardAction(ActionId:Usize))
        => runPseudoCode(
              caller_address = getCaller();
              caller_id = getUserId(caller_address);
              caller_role = getUserIdToRole(caller_id);
              require(userRoleCanDiscardAction(caller_role));
              require(getActionValidSignerCount(ActionId) == u(0));
              clearAction(ActionId);
              ok(void);
        )

  rule  call(userRoleCanPropose(None)) => false  [label(userRoleCanProposeNone)]
  rule  call(userRoleCanPropose(Proposer)) => true  [label(userRoleCanProposeProposer)]
  rule  call(userRoleCanPropose(BoardMember)) => true  [label(userRoleCanProposeBoardMember)]

  rule  call(userRoleCanSign(None)) => false
  rule  call(userRoleCanSign(Proposer)) => false
  rule  call(userRoleCanSign(BoardMember)) => true

  rule  call(userRoleCanPerformAction(R:UserRole) => userRoleCanPropose(R))

  rule  call(userRoleCanDiscardAction(R:UserRole) => userRoleCanPropose(R))

  rule  call(isEmptyList([.])) => true  [label(isEmptyListEmpty)]
  rule  call(isEmptyList(_:ExpressionList)) => false [owise, label(isEmptyListNotEmpty)]

  rule  call(listLen([.])) => u(0)
  rule  call(listLen([_:Expression , Es:ExpressionCSV]))
        => call(listLen([Es])) ~> plusOne

  rule  (I:Usize ~> plusOne) => add(I, u(1))

  rule  <k> call(setQuorum(Quorum:Usize)) => void ... </k>
        <quorum>_ => Quorum</quorum>

  rule  <k> call(setNumUsers(Users:Usize)) => void ... </k>
        <num-users>_ => Users</num-users>

  rule  <k> call(setNumBoardMembers(Members:Usize)) => void ... </k>
        <num-board-members>_ => Members</num-board-members>

  rule  <k> call(setNumProposers(Proposers:Usize)) => void ... </k>
        <num-proposers>_ => Proposers</num-proposers>

  rule  <k> (.K => nullableMapSet(E, I, M, rUsize)) ~> call(setUserId(E:Expression, I:Usize)) ...</k>
        <address-to-user-id> M:Map </address-to-user-id>
  rule  <k> (M:Map ~> call(setUserId(_:Expression, _:Usize))) => void ... </k>
        <address-to-user-id> _:Map => M </address-to-user-id>

  rule  <k> (.K => mapSet(I, E, M)) ~> call(setUserAddress(I:Usize, E:Expression)) ...</k>
        <user-id-to-address> M:Map </user-id-to-address>
  rule  <k> (M:Map ~> call(setUserAddress(_:Usize, _:Expression))) => void ... </k>
        <user-id-to-address> _:Map => M </user-id-to-address>

  rule  <k> (.K => nullableMapSet(I, R, M, rUserRole)) ~> call(setUserIdToRole(I:Usize, R:UserRole)) ... </k>
        <user-roles> M:Map </user-roles>
  rule  <k> (M:Map ~> call(setUserIdToRole(_:Usize, _:UserRole))) => void ... </k>
        <user-roles> _:Map => M </user-roles>

  rule  <k> call(getCaller()) => A ... </k>
        <caller-address> A:Address </caller-address>

  rule  <k> call(getQuorum()) => Quorum ... </k>
        <quorum> Quorum:Usize </quorum>

  rule  <k> call(getUserId(A:Expression))
            =>  cast(A, rAddress)
                ~> removeValue
                ~> nullableMapLookup(A, M, rUsize)
        ... </k>
        <address-to-user-id> M:Map </address-to-user-id>

  rule  <k> call(getUserIdToRole(I:Usize)) => nullableMapLookup(I, M, rUserRole) ... </k>
        <user-roles> M:Map </user-roles>

  rule  <k> call(getActionLastIndex()) => Index ... </k>
        <action-last-index> Index:Usize </action-last-index>

  rule  <k> call(setActionLastIndex(Index:Usize)) => void ... </k>
        <action-last-index> _ => Index </action-last-index>

  rule  <k> call(getNumUsers()) => Users ... </k>
        <num-users> Users:Usize </num-users>

  rule  <k> call(getNumBoardMembers()) => Members ... </k>
        <num-board-members> Members:Usize </num-board-members>

  rule  <k> call(getNumProposers()) => Proposers ... </k>
        <num-proposers> Proposers:Usize </num-proposers>

  rule  <k> (.K => nullableMapSet(ActionId, A, M, rAction)) ~> call(setActionData(ActionId:Usize, A:Action)) ... </k>
        <action-data> M:Map </action-data>
  rule  <k> (M:Map ~> call(setActionData(_:Usize, _:Action))) => void ... </k>
        <action-data> _:Map => M </action-data>

  rule  <k> call(getActionData(ActionId:Usize)) => nullableMapLookup(ActionId, M, rAction) ... </k>
        <action-data> M:Map </action-data>

  rule  <k> (.K => nullableMapSet(ActionId, Signers, M, rExpressionList))
            ~> call(setActionSignerIDs(ActionId:Usize, Signers:ExpressionList))
        ...</k>
        <action-signers> M:Map </action-signers>

  rule  <k> (M:Map ~> call(setActionSignerIDs(_:Usize, _:ExpressionList))) => void ... </k>
        <action-signers> _:Map => M </action-signers>

  rule  <k> (.K => call(getActionData(ActionId))) ~> call(isEmptyActionData(ActionId:Usize)) ... </k>
  rule  Action:Action ~> call(isEmptyActionData(_:Usize)) => Action ==K Nothing

  rule  call(canSign(BoardMember)) => true
  rule  call(canSign(_)) => false  [owise]

  rule  <k> call(getActionSignerIds(ActionId:Usize))
            => nullableMapLookup(ActionId, M:Map, rExpressionList)
        ... </k>
        <action-signers> M:Map </action-signers>

  rule call(listContains(Es:ExpressionList, E:Expression)) => #listContainsSafe(Es, E)

  rule call(listFind(Es:ExpressionList, E:Expression)) => u(#listFindSafe(Es, E))
  
  rule  call(listSwapRemove([L:ExpressionCSV], u(I:Int)))
        => [#listSwapRemove(L, I)]
    // TODO: Do things work with this requires?
    requires I >=Int 0

  rule call(performActionFromId(ActionId:Usize))
        => runPseudoCode(
              action = getActionData(ActionId);
              clearAction(ActionId);
              performAction(action);

        )

  rule  <k> call(performAction(Action:Action))
            => call(performActionNoLogging(Action))
        ...</k>
        <performed-actions> Log:List => ListItem(Action) Log </performed-actions>

  rule call(performActionNoLogging(Nothing)) => evaluate(void)

  rule call(performActionNoLogging(AddBoardMember(BoardMemberAddress:Address)))
        => runPseudoCode(
              changeUserRole(BoardMemberAddress, BoardMember);
        )

  rule call(performActionNoLogging(AddProposer(ProposerAddress:Address)))
        => runPseudoCode(
              changeUserRole(ProposerAddress, Proposer);
              new_board_members = getNumBoardMembers();
              require(getQuorum() <= new_board_members);
        )

  rule call(performActionNoLogging(RemoveUser(UserAddress:Address)))
        => runPseudoCode(
              changeUserRole(UserAddress, None);
              num_board_members = getNumBoardMembers();
              num_proposers = getNumProposers();
              require(num_board_members + num_proposers > u(0));
              require(getQuorum() <= num_board_members);
        )

  rule call(performActionNoLogging(ChangeQuorum(NewQuorum)))
        => runPseudoCode(
              require(NewQuorum <= getNumBoardMembers());
              setQuorum(NewQuorum);
        )

  rule call(performActionNoLogging(SendEgld(To:Address, Amount:BigUint, Data:BoxedBytes)))
        => runPseudoCode(
              sendTx(To, Amount, Data);
        )

  rule call(performActionNoLogging(SCDeploy(
            Amount:BigUint,
            Code:BoxedBytes,
            CodeMetadata:CodeMetadata,
            Arguments:ExpressionList)))
        => runPseudoCode(
              gas_left = getGasLeft();
              new_address = deployContract(gas_left, Amount, Code, CodeMetadata, Arguments);
              [new_address, .];
              void;
        )

  rule call(performActionNoLogging(SCCall(To:Address, Amount:BigUint, Function:BoxedBytes, [Arguments:ExpressionCSV])))
        => runPseudoCode(
              asyncCall(To, Amount, [Function , Arguments]);
        )

  rule call(clearAction(ActionId:Usize))
        => runPseudoCode(
              setActionData(ActionId, Nothing);
              setActionSignerIDs(ActionId, [.]);
        )

  rule call(quorumReached(ActionId:Usize))
        => runPseudoCode(
              quorum = getQuorum();
              valid_signers_count = getActionValidSignerCount(ActionId);
              quorum <= valid_signers_count;
        )

  rule call(getActionValidSignerCount(ActionId:Usize))
        => runPseudoCode(
              signer_ids = getActionSignerIds(ActionId);
              countCanSign(signer_ids);
        )

  rule call(countCanSign([.])) => evaluate(u(0))
  rule call(countCanSign([SignerId:Usize , SignerIds:ExpressionCSV]))
        => runPseudoCode(
              result = u(0);
              user_role = getUserIdToRole(SignerId);
              if (userRoleCanSign(user_role)) {
                result = u(1);
              }
              result + countCanSign([SignerIds]);
        )
  rule (.K => stuck) ~> call(countCanSign([E:Expression , _:ExpressionCSV]))
    ensures notBool isUsize(E)
    [owise]

  rule call(changeUserRole(UserAddress:Address, NewRole:UserRole))
        => runPseudoCode(
          user_id = getOrCreateUser(UserAddress);
          old_role = None;
          if (!(user_id == u(0))) {
            old_role = getUserIdToRole(user_id);
          }
          setUserIdToRole(user_id, NewRole);

          if (old_role == BoardMember) {
            if (!(NewRole == BoardMember)) {
              new_board_members = getNumBoardMembers() - u(1);
              setNumBoardMembers(new_board_members);
            }
          } else {
            if (NewRole == BoardMember) {
              setNumBoardMembers(getNumBoardMembers() + u(1));
            }
          }

          if (old_role == Proposer) {
            if (!(NewRole == Proposer)) {
              setNumProposers(getNumProposers() - u(1));
            }
          } else {
            if (NewRole == Proposer) {
              setNumProposers(getNumProposers() + u(1));
            }
          }
        )

  rule call(getOrCreateUser(Address:Address))
        => runPseudoCode(
              user_id = getUserId(Address);
              if (user_id == u(0)) {
                num_users = getNumUsers();
                num_users = num_users + u(1);
                setNumUsers(num_users);
                user_id = num_users;
                setUserId(Address, user_id);
                setUserAddress(user_id, Address);
              }
              user_id;
        )

  rule call(pushList([Es:ExpressionCSV], E:Expression))
        => [#pushList(Es, E)]

  rule call(sendTx(_To:Address, _Amount:BigUint, _Data:BoxedBytes))
        => evaluate(void)

  rule call(getGasLeft()) => evaluate(u(-1))

  rule call(deployContract(
            _GasLeft:Usize,
            _Amount:BigUint,
            _Code:BoxedBytes,
            _:CodeMetadata,
            Arguments:ExpressionList))
        => evaluate(void)
    requires isKResult(Arguments)

  rule call(asyncCall(
            _:Address,
            _Amount:BigUint,
            Arguments:ExpressionList))
        => evaluate(void)
    requires isKResult(Arguments)

endmodule

module PSEUDOCODE-CONFIGURATION
  imports MAP

  imports LANGUAGE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX
  imports PSEUDOCODE-COMMON

  configuration
    <T>
      <TT>
        <k />
        <state>
          <contract-state>
            <users>
              <num-users>u(0)</num-users>
              <user-id-to-address>.Map</user-id-to-address>
              <address-to-user-id>.Map</address-to-user-id>
            </users>
            <board-state>
              <num-board-members>u(0)</num-board-members>
              <num-proposers>u(0)</num-proposers>
              <user-roles>.Map</user-roles>
              <quorum>u(0)</quorum>
            </board-state>
            <action-state>
              <action-last-index>u(0)</action-last-index>
              <actions>
                <action-data>.Map</action-data>
                <action-signers>.Map</action-signers>
              </actions>
            </action-state>
          </contract-state>
          <pseudocode-state />
          <external-call-env />
          <log>
            <performed-actions>.List</performed-actions>
          </log>
        </state>
    </TT>
  </T>

  syntax StateCell ::= "initialState"   [function]
  rule initialState =>
      <state>
        <contract-state>
          <users>
            <num-users>u(0)</num-users>
            <user-id-to-address>.Map</user-id-to-address>
            <address-to-user-id>.Map</address-to-user-id>
          </users>
          <board-state>
            <num-board-members>u(0)</num-board-members>
            <num-proposers>u(0)</num-proposers>
            <user-roles>.Map</user-roles>
            <quorum>u(0)</quorum>
          </board-state>
          <action-state>
            <action-last-index>u(0)</action-last-index>
            <actions>
              <action-data>.Map</action-data>
              <action-signers>.Map</action-signers>
            </actions>
          </action-state>
        </contract-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .stack </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>uninitialized</caller-address>
        </external-call-env>
        <log>
          <performed-actions>.List</performed-actions>
        </log>
      </state>
endmodule
