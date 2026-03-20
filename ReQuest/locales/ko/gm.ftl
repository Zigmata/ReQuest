## GM 모듈 문자열

# GM 버튼
gm-btn-create = 생성
gm-btn-edit-details = 상세 편집
gm-btn-toggle-ready = 준비 상태 전환
gm-btn-configure-rewards = 보상 설정
gm-btn-remove-player = 플레이어 제거
gm-btn-cancel-quest = Quest 취소
gm-btn-manage-party-rewards = 파티 보상 관리
gm-btn-manage-individual-rewards = 개인 보상 관리
gm-btn-join = 참가
gm-btn-leave = 탈퇴
gm-btn-complete-quest = Quest 완료
gm-btn-review-submission = 제출 검토
gm-btn-approve = 승인
gm-btn-deny = 거부

# GM 모달
gm-modal-title-create-quest = 새 Quest 생성
gm-modal-label-quest-title = Quest 제목
gm-modal-placeholder-quest-title = Quest의 제목
gm-modal-label-restrictions = 제한 사항
gm-modal-placeholder-restrictions = 플레이어 레벨 등 제한 사항이 있다면 입력
gm-modal-label-max-party = 최대 파티 인원
gm-modal-placeholder-max-party = 이 Quest의 최대 파티 인원 수
gm-modal-label-party-role = 파티 역할
gm-modal-placeholder-party-role = 이 Quest에 대한 역할 생성 (선택 사항)
gm-modal-label-description = 설명
gm-modal-placeholder-description = Quest의 세부 사항을 여기에 작성하세요
gm-modal-title-editing-quest = { $questTitle } 편집 중
gm-modal-label-title = 제목
gm-modal-label-max-party-size = 최대 파티 인원
gm-modal-title-add-reward = 보상 추가
gm-modal-label-experience = 경험치
gm-modal-placeholder-experience = 숫자를 입력하세요
gm-modal-label-items = 아이템
gm-modal-placeholder-items =
    아이템: 수량
    아이템2: 수량
    등등.
gm-modal-title-add-summary = Quest 요약 추가
gm-modal-label-summary = 요약
gm-modal-placeholder-summary = Quest의 스토리 요약을 추가하세요
gm-modal-title-modifying-player = { $playerName } 수정 중
gm-modal-placeholder-xp-add-remove = 양수 또는 음수를 입력하세요.
gm-modal-label-inventory = 인벤토리
gm-modal-placeholder-inventory-modify =
    아이템: 수량
    아이템2: 수량
    등등.
gm-modal-title-review-submission = 제출 검토
gm-modal-label-submission-id = 제출 ID
gm-modal-placeholder-submission-id = 8자리 ID를 입력하세요

# GM 오류
gm-error-forbidden-role-name = 파티 역할에 제공된 이름은 금지되어 있습니다.
gm-error-role-already-exists = 이 서버에 해당 이름의 역할이 이미 존재합니다.
gm-error-no-quest-channel = Quest 게시용 채널이 아직 지정되지 않았습니다. 서버 관리자에게 Quest 채널 설정을 요청하세요.
gm-error-cannot-ping-announce = { $channel } 채널에서 알림 역할 { $role }을(를) 멘션할 수 없습니다. 서버 관리자에게 채널 및 ReQuest 역할 권한을 확인하세요.
gm-error-invalid-item-format = 잘못된 아이템 형식: "{ $item }". 각 아이템은 새 줄에 "이름: 수량" 형식으로 입력해야 합니다.
gm-error-submission-not-found = 제출을 찾을 수 없습니다.
gm-error-already-on-quest = 이미 { $characterName }(으)로 이 Quest에 참가 중입니다.
gm-error-no-active-character-long = 이 서버에서 활성화된 캐릭터가 없습니다. `/player`를 사용하여 캐릭터를 등록하거나 활성화하세요.
gm-error-quest-locked = Quest {"**"}{ $questTitle }{"**"} 참가 오류: Quest가 GM에 의해 잠겨 있습니다.
gm-error-quest-full = Quest {"**"}{ $questTitle }{"**"} 참가 오류: Quest 인원이 가득 찼습니다!
gm-error-not-signed-up = 이 Quest에 등록되어 있지 않습니다.
gm-error-quest-channel-not-set = Quest 채널이 설정되지 않았습니다!
gm-error-empty-roster = 빈 명단으로는 Quest를 완료할 수 없습니다. 대신 취소를 시도해 보세요.
gm-error-invalid-xp-value = XP 값은 양의 정수여야 합니다!

# GM 확인 모달
gm-modal-title-cancel-quest = Quest 취소
gm-modal-label-cancel-quest = Quest를 취소하려면 CONFIRM을 입력하세요.
gm-modal-placeholder-cancel-quest = 계속하려면 "CONFIRM"을 입력하세요.
gm-modal-title-remove-from-quest = Quest에서 캐릭터 제거
gm-modal-label-remove-from-quest = 캐릭터 제거를 확인하시겠습니까?
gm-modal-placeholder-remove-from-quest = 계속하려면 "CONFIRM"을 입력하세요.

# GM DM 메시지
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"}이(가) GM에 의해 취소되었습니다.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"}이(가) 준비 완료되었습니다!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"}의 잠금이 해제되었습니다.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"}이(가) GM에 의해 잠겼습니다.
gm-dm-player-removed = Quest {"**"}{ $questTitle }{"**"}에서 제거되었습니다.
gm-dm-player-removed-waitlist = {"**"}{ $questTitle }{"**"}의 대기 목록에서 제거되었습니다.
gm-dm-party-promotion = 플레이어 이탈로 인해 {"**"}{ $questTitle }{"**"}의 파티에 추가되었습니다!
gm-dm-roster-locked = Quest 명단이 잠기고 파티에 알림이 전송되었습니다!
gm-dm-roster-unlocked = Quest 명단의 잠금이 해제되었습니다.
gm-dm-rewards-no-characters =
    서버 관리자가 GM의 Quest 완료 시 보상을 설정했습니다.
    그러나 등록된 캐릭터가 없어 현재 보상을
    자동으로 지급할 수 없습니다.
gm-dm-rewards-no-active-character =
    서버 관리자가 GM의 Quest 완료 시 보상을 설정했습니다.
    그러나 이 서버에서 활성화된 캐릭터가 없어 현재 보상을
    자동으로 지급할 수 없습니다.
gm-dm-rewards-issued = 활성 캐릭터 { $characterName }에게 다음 보상이 지급되었습니다

# GM 셀렉트 메뉴
gm-select-placeholder-party-member = 파티 멤버를 선택하세요

# GM 임베드
gm-embed-title-mod-report = GM 플레이어 수정 보고서
gm-embed-field-experience = 경험치
gm-embed-title-quest-complete = Quest 완료: { $questTitle }
gm-embed-title-quest-completed = QUEST 완료: { $questTitle }
gm-embed-field-rewards = 보상
gm-embed-field-party = __파티__
gm-embed-field-summary = 요약
gm-embed-title-gm-rewards = GM 보상 지급
gm-embed-field-items = 아이템
gm-msg-player-removed = 플레이어가 제거되고 Quest 명단이 업데이트되었습니다!

# GM 뷰
gm-title-main-menu = GM - 메인 메뉴
gm-menu-quests = Quest
gm-menu-desc-quests = Quest를 생성, 편집 및 관리합니다.
gm-menu-players = 플레이어
gm-menu-desc-players = 플레이어 인벤토리를 관리하고 캐릭터를 수정합니다.
gm-menu-approvals = 캐릭터 승인
gm-menu-desc-approvals = 캐릭터 제출을 검토하고 승인/거부합니다.

gm-title-quest-management = GM - Quest 관리
gm-desc-create-quest = 새 Quest를 생성합니다.
gm-msg-no-quests = Quest를 찾을 수 없습니다.
gm-label-quest-locked = (잠김)
gm-title-manage-quest = Quest 관리 - { $questTitle } `{ $questId }`
gm-desc-edit-quest = 제목, 설명, 파티 인원 등 Quest 세부 사항을 편집합니다.
gm-desc-toggle-ready = 준비 상태 전환 (현재: {"**"}{ $status }{"**"})
    - Quest 명단을 잠그고 파티 멤버에게 Quest가 곧 시작됨을 알립니다. 역할이 설정된 경우, 잠금 시 파티 멤버에게 할당됩니다.
    - 열림으로 설정하면 명단 잠금이 해제됩니다.
gm-label-ready-locked = 잠김/준비
gm-label-ready-open = 열림
gm-desc-configure-rewards = 선택한 Quest의 보상을 설정합니다.
gm-desc-complete-quest = Quest를 완료합니다. 보상이 있다면 파티 멤버에게 지급합니다.
gm-desc-remove-player = Quest 명단에서 플레이어를 제거하고 알림을 보냅니다.
gm-desc-cancel-quest = Quest를 취소하고 Quest 게시판에서 삭제합니다.
gm-title-player-management = GM - 플레이어 관리
gm-desc-player-management =
    이 명령어들은 컨텍스트 메뉴로 이동되었습니다. 플레이어의 프로필을 우클릭(데스크톱) 또는 길게 누르기(모바일)하여 다음 메뉴 옵션을 사용하세요:

    - {"**"}Modify Player{"**"}: 플레이어의 아이템과 경험치를 추가하거나 제거합니다.
    - {"**"}View Player{"**"}: 플레이어의 활성 캐릭터 세부 사항을 확인합니다.
gm-title-remove-player = Quest에서 플레이어 제거 - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}플레이어 제거 참고 사항{"**"}__

    - 아래 드롭다운에서 Quest 명단에서 제거할 플레이어를 선택하세요.
    - 대기 목록에 플레이어가 있는 경우, 목록의 첫 번째 플레이어가 파티로 승격됩니다.
    - 제거된 플레이어의 개인 보상은 Quest에서 삭제됩니다.
    - 이전 기여에 대해 플레이어에게 보상을 지급하려면 `Modify Player` 컨텍스트 메뉴를 사용하여 직접 보상을 지급하세요.
gm-label-no-players-in-roster = Quest 명단에 플레이어가 없습니다
gm-title-character-sheet = { $characterName }의 캐릭터 시트 (<@{ $memberId }>)
gm-label-experience-points = __{"**"}경험치:{"**"}__
gm-label-possessions = __{"**"}소지품{"**"}__
gm-label-currency-heading = {"**"}화폐{"**"}
gm-msg-inventory-empty = 인벤토리가 비어 있습니다.

# GM 승인
gm-title-approvals = GM - 인벤토리 승인
gm-desc-review-submission = 제출 ID를 입력하여 검토하고 승인/거부합니다.
gm-title-reviewing = 검토 중: { $characterName }
gm-label-items = {"**"}아이템:{"**"}
gm-label-currency = {"**"}화폐:{"**"}
gm-embed-title-approved = 인벤토리 업데이트 승인됨
gm-embed-desc-approved = {"**"}{ $characterName }{"**"}의 인벤토리가 { $approver }에 의해 승인되었습니다.
gm-embed-title-denied = 인벤토리 업데이트 거부됨
gm-embed-desc-denied = {"**"}{ $characterName }{"**"}의 인벤토리가 { $denier }에 의해 거부되었습니다.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
