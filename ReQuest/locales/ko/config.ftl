## 설정 모듈 문자열

# ==========================================
# 버튼
# ==========================================

# 역할
config-btn-clear = 초기화
config-btn-remove-gm-roles = GM 역할 제거
config-btn-forbidden-roles = 금지된 역할

# Quest
config-btn-toggle-quest-summary = Quest 요약 전환
config-btn-toggle-player-experience = 플레이어 경험치 전환
config-btn-toggle-display = 표시 전환
config-btn-purge-player-board = 플레이어 게시판 삭제
config-btn-add-modify-rewards = 보상 추가/수정

# 화폐
config-btn-add-denomination = 단위 추가
config-btn-add-new-currency = 새 화폐 추가
config-btn-remove-currency = 화폐 제거

# 상점 - 생성
config-btn-add-shop-wizard = 상점 추가 (마법사)
config-btn-add-shop-json = 상점 추가 (JSON)
config-btn-edit-shop-wizard = 상점 편집 (마법사)
config-btn-edit-shop-json = 상점 편집 (JSON)
config-btn-remove-shop = 상점 제거
config-btn-add-item = 아이템 추가
config-btn-edit-shop-details = 상점 상세 편집
config-btn-download-json = JSON 다운로드
config-btn-done-editing = 편집 완료
config-btn-scan-server-configs = 서버 설정 스캔
config-btn-re-scan = 재스캔

# 신규 캐릭터 상점
config-btn-upload-json = JSON 업로드
config-btn-configure-new-character-wealth = 신규 캐릭터 재산 설정
config-btn-configure-new-character-shop = 신규 캐릭터 상점 설정
config-btn-clear-shop = 상점 초기화
config-btn-configure-static-kits = 고정 키트 설정
config-btn-new-character-settings = 신규 캐릭터 설정
config-btn-disabled-no-currency = 비활성화 (화폐 미설정)
config-btn-disabled-no-wealth = 비활성화 (시작 재산 미설정)

# 고정 키트
config-btn-create-new-kit = 새 키트 생성
config-btn-delete-kit = 키트 삭제
config-btn-add-currency = 화폐 추가

# 롤플레이
config-btn-toggle-rp-rewards = RP 보상 전환
config-btn-clear-channels = 채널 초기화
config-btn-edit-settings = 설정 편집
config-btn-configure-rewards = 보상 설정

# 재고
config-btn-stock-limits = 재고 한도
config-btn-set-limit = 한도 설정
config-btn-edit-limit = 한도 편집
config-btn-remove-limit = 한도 제거
config-btn-configure-restock-schedule = 재입고 일정 설정
config-btn-back-to-shop-editor = 상점 편집기로 돌아가기

# 포럼 상점
config-btn-create-new-thread = 새 스레드 생성
config-btn-use-existing-thread = 기존 스레드 사용

# 마법사
config-btn-quit = 종료
config-btn-configure-channels = 채널 설정
config-btn-configure-roles = 역할 설정
config-btn-configure-quests = Quest 설정
config-btn-configure-players = 플레이어 설정
config-btn-configure-currency = 화폐 설정
config-btn-configure-rp-rewards = RP 보상 설정
config-btn-configure-shops = 상점 설정
config-btn-new-char-setup = 신규 캐릭터 설정

# 확인 모달 제목 (공통 ConfirmModal에 전달)
config-modal-title-confirm-role-removal = 역할 제거 확인
config-modal-title-confirm-removal = 제거 확인
config-modal-title-confirm-currency-removal = 화폐 제거 확인
config-modal-title-confirm-shop-removal = 상점 제거 확인
config-modal-title-confirm-kit-deletion = 키트 삭제 확인
config-modal-title-confirm-remove-stock-limit = 재고 한도 제거 확인
config-modal-title-clear-shop = 상점 초기화 확인

# 확인 모달 프롬프트 라벨
config-modal-label-remove-role = { $roleName }을(를) 제거하시겠습니까?
config-modal-label-remove-denomination = { $denominationName }을(를) 제거하시겠습니까?
config-modal-label-remove-currency = { $currencyName }을(를) 제거하시겠습니까?
config-modal-label-shop-removal-warning = 경고: 이 작업은 되돌릴 수 없습니다!
config-modal-label-kit-deletion-warning = 경고: 되돌릴 수 없습니다!
config-modal-label-remove-stock-limit = 재고 한도를 제거하려면 확인을 입력하세요
config-modal-label-clear-shop = 이 상점의 모든 아이템을 삭제하시겠습니까?

# 버튼의 오류 메시지
config-error-shop-data-not-found = 오류: 해당 상점 데이터를 찾을 수 없습니다.
config-msg-shop-json-download = {"**"}{ $shopName }{"**"}의 JSON 정의 파일입니다.
config-msg-new-char-shop-json-download = 신규 캐릭터 상점의 JSON 정의 파일입니다.
config-error-select-forum-first = 먼저 포럼 채널을 선택해 주세요.
config-error-select-thread-first = 먼저 스레드를 선택해 주세요.

# ==========================================
# 모달
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = 새 화폐 추가
config-modal-label-currency-name = 화폐 이름
config-error-currency-already-exists = { $name }이라는 이름의 화폐 또는 단위가 이미 존재합니다!

# RenameCurrencyModal
config-modal-title-rename-currency = 화폐 이름 변경
config-modal-label-new-currency-name = 새 화폐 이름
config-error-currency-name-exists = "{ $name }"이라는 이름의 화폐가 이미 존재합니다.
config-error-denomination-name-exists = "{ $name }"이라는 이름의 단위가 이미 존재합니다.

# RenameDenominationModal
config-modal-title-rename-denomination = 단위 이름 변경
config-modal-label-new-denomination-name = 새 단위 이름

# AddCurrencyDenominationModal
config-modal-title-add-denomination = { $currencyName } 단위 추가
config-modal-label-denomination-name = 이름
config-modal-placeholder-denomination-name = 예: 은화
config-modal-label-denomination-value = 값
config-modal-placeholder-denomination-value = 예: 0.1
config-error-denomination-matches-currency = 새 단위 이름은 이 서버의 기존 화폐와 일치할 수 없습니다! "{ $existingName }"이라는 기존 화폐가 발견되었습니다.
config-error-denomination-matches-denomination = 새 단위 이름은 이 서버의 기존 단위와 일치할 수 없습니다! "{ $currencyName }" 화폐 아래에 "{ $denominationName }"이라는 기존 단위가 발견되었습니다.
config-error-denomination-value-exists = 하나의 화폐 내 단위는 고유한 값을 가져야 합니다! { $denominationName }에 이미 이 값이 할당되어 있습니다.
config-label-denomination-info = **{ $name }** (값: { $value })

# ForbiddenRolesModal
config-modal-title-forbidden-roles = 금지된 역할 이름
config-modal-label-names = 이름
config-modal-placeholder-names = 쉼표로 구분하여 이름을 입력하세요
config-msg-forbidden-roles-updated = 금지된 역할이 업데이트되었습니다!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = 플레이어 게시판 삭제
config-modal-label-age = 기간
config-modal-placeholder-age = 유지할 최대 게시물 기간(일 단위)을 입력하세요
config-msg-posts-purged = { $days }일보다 오래된 게시물이 삭제되었습니다!

# GMRewardsModal
config-modal-title-gm-rewards = GM 보상 추가/수정
config-modal-label-experience = 경험치
config-modal-placeholder-enter-number = 숫자를 입력하세요
config-modal-label-items = 아이템
config-modal-placeholder-items =
    이름: 수량
    이름2: 수량
    등등.
config-error-experience-invalid = 경험치는 유효한 정수여야 합니다 (예: 2000).
config-error-item-format-invalid = 잘못된 아이템 형식: "{ $item }". 각 아이템은 새 줄에 "이름: 수량" 형식으로 입력해야 합니다.

# ConfigShopDetailsModal
config-modal-title-shop-details = 상점 상세 추가/편집
config-modal-label-shop-channel = 채널 선택
config-modal-placeholder-shop-channel = 이 상점의 채널을 선택하세요
config-modal-label-shop-name = 상점 이름
config-modal-placeholder-shop-name = 상점 이름을 입력하세요
config-modal-label-shopkeeper-name = 상점 주인 이름
config-modal-placeholder-shopkeeper-name = 상점 주인의 이름을 입력하세요
config-modal-label-shop-description = 상점 설명
config-modal-placeholder-shop-description = 상점에 대한 설명을 입력하세요
config-modal-label-shop-image-url = 상점 이미지 URL
config-modal-placeholder-shop-image-url = 상점 이미지의 URL을 입력하세요
config-error-no-channel-selected = 상점에 대한 채널이 선택되지 않았습니다.
config-error-shop-already-in-channel = 선택한 채널에 이미 상점이 등록되어 있습니다. 다른 채널을 선택하거나 기존 상점을 편집해 주세요.

# build_shop_header_view
config-label-shopkeeper = {"**"}상점 주인:{"**"} { $name }
config-msg-use-shop-command = `/shop` 명령어를 사용하여 아이템을 탐색하고 구매하세요.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = 포럼 스레드 상점 생성
config-modal-label-thread-name = 스레드 이름
config-modal-placeholder-thread-name = 상점 스레드의 이름을 입력하세요
config-error-forum-not-found = 선택한 포럼 채널을 찾을 수 없습니다.
config-error-shop-already-in-thread = 이 스레드에 이미 상점이 등록되어 있습니다. 새 스레드에서는 발생하지 않아야 합니다.

# ConfigShopJSONModal
config-modal-title-add-shop-json = JSON으로 새 상점 추가
config-modal-label-upload-json = 상점 데이터가 포함된 .json 파일을 업로드하세요
config-error-no-json-uploaded = 상점의 JSON 파일이 업로드되지 않았습니다.
config-error-file-must-be-json = 업로드된 파일은 JSON 파일(.json)이어야 합니다.
config-error-invalid-json = 잘못된 JSON 형식: { $error }
config-error-json-validation-failed = JSON이 스키마에 부합하지 않습니다: { $error }

# ShopItemModal
config-modal-title-shop-item = 상점 아이템 추가/편집
config-modal-label-item-name = 아이템 이름
config-modal-placeholder-item-name = 아이템 이름을 입력하세요
config-modal-label-item-description = 아이템 설명
config-modal-placeholder-item-description = 아이템에 대한 설명을 입력하세요
config-modal-label-item-quantity = 아이템 수량
config-modal-placeholder-item-quantity = 구매 시 판매되는 수량을 입력하세요
config-modal-label-item-costs = 아이템 비용
config-modal-placeholder-item-costs = 예: 10 gold + 5 silver\n또는: 50 rep\n(+는 AND, 새 줄은 OR)
config-error-item-quantity-positive = 아이템 수량은 양의 정수여야 합니다.
config-error-cost-format-invalid = 잘못된 비용 형식: "{ $option }". 각 비용은 금액과 화폐를 공백으로 구분해야 합니다 (예: "10 gold").
config-error-cost-amount-invalid = 화폐 "{ $currency }"에 대한 잘못된 금액 "{ $amount }". 금액은 양수여야 합니다.
config-error-unknown-currency = 알 수 없는 화폐 `{ $currency }`. 이 서버에 설정된 유효한 화폐를 사용해 주세요.
config-error-item-already-exists = 이 상점에 { $itemName }이라는 이름의 아이템이 이미 존재합니다.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = JSON으로 상점 업데이트
config-modal-label-upload-new-json = 새 JSON 정의 업로드
config-error-no-file-uploaded = 파일이 업로드되지 않았습니다.
config-error-file-must-be-json-ext = 파일은 `.json` 파일이어야 합니다.
config-error-json-validation-message = JSON 유효성 검사 실패: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = 신규 캐릭터 장비 추가/편집
config-modal-placeholder-item-quantity-selection = 선택 시 받는 수량을 입력하세요
config-modal-label-item-cost = 아이템 비용
config-error-cost-format-short = 잘못된 비용 형식: '{ $component }'. '금액 화폐' 형식이어야 합니다.
config-error-amount-invalid-short = 화폐 '{ $currency }'에 대한 잘못된 금액 '{ $amount }'.
config-error-item-exists-new-char = 신규 캐릭터 상점에 { $itemName }이라는 이름의 아이템이 이미 존재합니다.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = 신규 캐릭터 상점 업로드 (JSON)
config-error-no-json-uploaded-short = JSON 파일이 업로드되지 않았습니다.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = 신규 캐릭터 재산 설정
config-modal-label-amount = 금액
config-modal-placeholder-amount = 이 화폐의 금액을 입력하세요.
config-modal-placeholder-currency-name = 이 서버에 정의된 화폐 이름을 입력하세요
config-error-no-currencies-configured = 이 서버에 설정된 화폐가 없습니다.
config-error-currency-not-found = { $name }이라는 이름의 화폐 또는 단위를 찾을 수 없습니다. 유효한 화폐를 사용해 주세요.

# CreateStaticKitModal
config-modal-title-create-kit = 새 고정 키트 생성
config-modal-label-kit-name = 키트 이름
config-modal-placeholder-kit-name = 예: 전사 스타터 키트
config-modal-label-description = 설명
config-modal-placeholder-kit-description = 이 키트에 대한 선택적 설명
config-error-kit-name-exists = "{ $kitName }"이라는 이름의 고정 키트가 이미 존재합니다. 다른 이름을 선택해 주세요.

# StaticKitItemModal
config-modal-title-kit-item = 키트 아이템 추가/편집
config-modal-placeholder-kit-item-quantity = 키트에 포함될 이 아이템의 수량을 입력하세요

# StaticKitCurrencyModal
config-modal-title-kit-currency = 키트 화폐 추가
config-modal-placeholder-currency-eg = 예: 골드
config-modal-placeholder-amount-eg = 예: 100
config-error-amount-must-be-number = 금액은 숫자여야 합니다.
config-error-amount-exceeds-maximum = 금액은 { $max }을(를) 초과할 수 없습니다.
config-error-no-currencies-on-server = 서버에 설정된 화폐가 없습니다.
config-error-currency-not-found-short = 화폐 "{ $currency }"을(를) 찾을 수 없습니다.
config-error-denomination-not-found = 화폐 설정에서 단위 "{ $denomination }"을(를) 찾을 수 없습니다.

# RoleplaySettingsModal
config-modal-title-rp-settings = 롤플레이 설정
config-modal-label-min-message-length = 최소 메시지 길이 (글자 수)
config-modal-placeholder-min-message-length = 메시지가 적격하려면 필요한 글자 수. 제한 없으면 0
config-modal-label-cooldown = 쿨다운 (초)
config-modal-placeholder-cooldown = 보상 적격 메시지 간의 대기 시간(초)
config-modal-label-message-threshold = 메시지 임계값
config-modal-placeholder-message-threshold = 보상을 받기 위해 필요한 메시지 수
config-modal-label-frequency = 빈도 (메시지 수)
config-modal-placeholder-frequency = 보상을 받기 위해 필요한 적격 메시지 수
config-error-min-length-invalid = 최소 메시지 길이는 0 이상의 정수여야 합니다.
config-error-cooldown-invalid = 쿨다운은 0 이상의 정수여야 합니다.
config-error-threshold-invalid = 메시지 임계값은 양의 정수여야 합니다.
config-error-frequency-invalid = 빈도는 양의 정수여야 합니다.

# RoleplayRewardsModal
config-modal-title-rp-rewards = 롤플레이 보상 설정
config-modal-label-items-name-quantity = 아이템 (이름: 수량)
config-modal-label-currency-name-amount = 화폐 (이름: 금액)
config-error-experience-non-negative = 경험치는 0 이상의 정수여야 합니다.
config-error-item-quantity-positive-named = "{ $itemName }"의 아이템 수량은 양의 정수여야 합니다.
config-error-currency-amount-positive = "{ $currencyName }"의 화폐 금액은 양수여야 합니다.

# SetItemStockModal
config-modal-title-stock-limit = 재고 한도: { $itemName }
config-modal-label-max-stock = 최대 재고
config-modal-placeholder-max-stock = 최대 재고를 입력하세요 (예: 10)
config-modal-label-current-stock = 현재 재고
config-modal-placeholder-current-stock = 현재 가용 재고를 입력하세요
config-modal-label-restock-increment = 재입고량 (주기당)
config-modal-placeholder-restock-increment = 주기당 추가 수량 (기본값: 1)
config-error-max-stock-positive = 최대 재고는 양의 정수여야 합니다.
config-error-current-stock-non-negative = 현재 재고는 0 이상의 정수여야 합니다.
config-error-current-exceeds-max = 현재 재고가 최대 재고를 초과할 수 없습니다.
config-error-item-not-in-shop = 상점에서 "{ $itemName }" 아이템을 찾을 수 없습니다.

# RestockScheduleModal
config-modal-title-restock-schedule = 재입고 일정 설정
config-modal-restock-schedule-label = 일정
config-modal-restock-schedule-none = 없음 (비활성화)
config-modal-restock-schedule-hourly = 매시간
config-modal-restock-schedule-daily = 매일
config-modal-restock-schedule-weekly = 매주
config-modal-label-time = 시간 (UTC 기준 HH:MM)
config-modal-desc-current-time = 현재 시간: { $utcTime }
config-modal-placeholder-time = 예: 14:30 (오후 2시 30분 UTC)
config-modal-restock-day-label = 요일 (매주만 해당)
config-modal-restock-mode-label = 재입고 모드
config-modal-restock-mode-full = 전체 (최대로 리셋)
config-modal-restock-mode-incremental = 점진적 (수량 추가)
config-error-time-format-invalid = 시간은 HH:MM 형식이어야 합니다 (예: 14:30).
config-error-increment-positive = 증가량은 양의 정수여야 합니다.

# ==========================================
# 셀렉트
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = { $configName } 채널을 검색하세요

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Quest 알림 역할을 선택하세요

# AddGMRoleSelect
config-select-placeholder-gm-roles = GM 역할을 선택하세요

# ConfigWaitListSelect
config-select-placeholder-wait-list = 대기 목록 크기를 선택하세요
config-select-option-disabled = 0 (비활성화)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = 인벤토리 모드를 선택하세요
config-select-option-disabled-label = 비활성화
config-select-desc-disabled = 플레이어가 빈 인벤토리로 시작합니다.
config-select-option-selection = 선택
config-select-desc-selection = 플레이어가 신규 캐릭터 상점에서 자유롭게 아이템을 선택합니다.
config-select-option-purchase = 구매
config-select-desc-purchase = 플레이어가 주어진 금액의 화폐로 신규 캐릭터 상점에서 아이템을 구매합니다.
config-select-option-open = 자유 입력
config-select-desc-open = 플레이어가 직접 인벤토리 아이템을 입력합니다.
config-select-option-static = 고정
config-select-desc-static = 플레이어에게 미리 정의된 시작 인벤토리가 지급됩니다.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = 적격 채널을 선택하세요

# RoleplayModeSelect
config-select-placeholder-rp-mode = 모드를 선택하세요
config-select-option-scheduled = 예약
config-select-desc-scheduled = 지정된 초기화 기간 내에 보상이 한 번 지급됩니다.
config-select-option-accrued = 누적
config-select-desc-accrued = 지정된 활동 수준에 따라 보상이 반복적으로 지급됩니다.

# RoleplayResetSelect
config-select-placeholder-reset-period = 초기화 기간을 선택하세요
config-select-option-hourly = 매시간
config-select-desc-hourly = 매시간 초기화됩니다.
config-select-option-daily = 매일
config-select-desc-daily = 24시간마다 초기화됩니다.
config-select-option-weekly = 매주
config-select-desc-weekly = 7일마다 초기화됩니다.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = 초기화 요일을 선택하세요

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = 초기화 시간을 선택하세요 (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = 포럼 채널을 선택하세요

# ForumThreadSelect
config-select-placeholder-thread = 스레드를 선택하세요
config-select-option-no-threads = 활성 스레드를 찾을 수 없습니다
config-select-desc-no-threads = 새 스레드를 생성하거나 보관된 스레드를 확인하세요
config-select-option-select-forum-first = 먼저 포럼을 선택하세요
config-select-desc-select-forum-first = 위에서 포럼 채널을 선택해 주세요
config-select-desc-thread-id = 스레드 ID: { $threadId }
config-error-select-valid-thread = 유효한 스레드를 선택하거나 새 스레드를 생성해 주세요.
config-error-thread-not-found = 선택한 스레드를 찾을 수 없습니다. 삭제되었거나 보관되었을 수 있습니다.

# ==========================================
# 뷰
# ==========================================

## 메인 메뉴
config-title-main-menu = 서버 설정 - 메인 메뉴
config-menu-config-wizard = 설정 마법사
config-menu-desc-config-wizard = 빠른 스캔으로 서버가 ReQuest를 사용할 준비가 되었는지 확인합니다.
config-menu-channels = 채널
config-menu-desc-channels = ReQuest 게시물을 위한 지정 채널을 설정합니다.
config-menu-currency = 화폐
config-menu-desc-currency = 전체 화폐 설정입니다.
config-menu-players = 플레이어
config-menu-desc-players = 경험치 추적 등 전체 플레이어 설정입니다.
config-menu-quests = Quest
config-menu-desc-quests = 대기 목록 등 전체 Quest 설정입니다.
config-menu-rp-rewards = RP 보상
config-menu-desc-rp-rewards = 롤플레이 보상을 설정합니다.
config-menu-roles = 역할
config-menu-desc-roles = 핑 가능하거나 권한이 있는 역할의 설정 옵션입니다.
config-menu-shops = 상점
config-menu-desc-shops = 커스텀 상점을 설정합니다.
config-menu-language = 언어
config-menu-desc-language = 이 서버의 기본 언어를 설정합니다.

## 마법사 뷰
config-title-wizard = {"**"}서버 설정 - 마법사{"**"}
config-wizard-intro =
    {"**"}ReQuest 설정 마법사에 오신 것을 환영합니다!{"**"}

    이 마법사는 서버가 ReQuest의 기능을 사용하도록 올바르게 설정되었는지 확인하는 데 도움을 줍니다. 현재 설정을 스캔하고 필요한 조정 사항에 대한 권장 사항을 제공합니다.

    아래 "스캔 시작" 버튼을 사용하여 유효성 검사 프로세스를 시작하세요. 스캔이 완료되면 서버 설정에 대한 상세 보고서와 권장 변경 사항을 받게 됩니다.

# 마법사 - 봇 권한 검증
config-wizard-bot-permissions-header = __{"**"}봇 전체 권한{"**"}__
config-wizard-bot-permissions-desc = 이 섹션은 ReQuest가 올바르게 작동하기 위한 권한을 갖추고 있는지 확인합니다.
config-wizard-bot-role = 봇 역할: { $roleMention }
config-wizard-status-warnings = {"**"}상태: ⚠️ 경고 발견{"**"}
config-wizard-missing-perm = - ⚠️ 누락: `{ $permissionName }`
config-wizard-ensure-permissions = 봇의 최상위 역할에 이러한 권한이 전역으로 부여되어 있는지 확인해 주세요.
config-wizard-status-ok = {"**"}상태: ✅ 정상{"**"}
config-wizard-bot-permissions-ok = 봇에 필요한 모든 전체 권한이 있습니다.
config-wizard-status-scan-failed = {"**"}상태: ❌ 스캔 실패{"**"}
config-wizard-scan-error = 봇 권한을 확인하는 중 예기치 않은 오류가 발생했습니다.
config-wizard-error-type = 오류: { $errorType }
config-wizard-required-permissions = {"**"}봇 역할에 필요한 권한:{"**"}

# 마법사 - 권한 이름
config-wizard-perm-view-channels = 채널 보기
config-wizard-perm-manage-roles = 역할 관리
config-wizard-perm-send-messages = 메시지 보내기
config-wizard-perm-attach-files = 파일 첨부
config-wizard-perm-add-reactions = 반응 추가
config-wizard-perm-use-external-emoji = 외부 이모지 사용
config-wizard-perm-manage-messages = 메시지 관리
config-wizard-perm-read-message-history = 메시지 기록 읽기

# 마법사 - 역할 검증
config-wizard-role-header = __{"**"}역할 설정{"**"}__
config-wizard-role-desc =
    이 섹션은 다음 사항을 확인합니다:

    - GM 역할(필수) 및 알림 역할(선택)이 설정되어 있는지.
    - 기본(@everyone) 역할에 봇 기능 접근에 필요한 권한이 있는지.
    - 기본(@everyone) 역할에 위험한 권한이 없는지.
    - GM 및 알림 역할에 기본 역할 이상의 권한 상승이 있는지.

    여기의 경고는 기본 설정에 기반한 권장 사항입니다. 서버의 필요에 따라 일부 권장 사항을 무시해도 됩니다.

config-wizard-default-role-label = {"**"}기본 역할:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: 위험한 권한 발견:
config-wizard-default-role-ok = - ✅ @everyone: 정상
config-wizard-missing-permission = - 누락된 권한: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM 역할:{"**"}
config-wizard-no-gm-roles = - ⚠️ GM 역할이 설정되지 않았습니다
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} 설정된 역할을 서버에서 찾을 수 없거나 삭제되었습니다
config-wizard-role-ok = - ✅ { $roleMention }: 정상
config-wizard-announcement-role-label = {"**"}알림 역할:{"**"}
config-wizard-no-announcement-role = - ℹ️ 알림 역할이 설정되지 않았습니다
config-wizard-announcement-role-not-found = - ⚠️ 설정된 역할을 서버에서 찾을 수 없거나 삭제되었습니다
config-wizard-escalation-detected = - ⚠️ { $roleMention }: 권한 상승 감지됨 - { $escalations }
config-wizard-escalation-more = , 외 { $count }개 더...

# 마법사 - 필수 기본 권한
config-wizard-perm-send-messages-in-threads = 스레드에서 메시지 보내기
config-wizard-perm-use-application-commands = 애플리케이션 명령어 사용

# 마법사 - 위험한 권한
config-wizard-perm-manage-channels = 채널 관리
config-wizard-perm-manage-webhooks = 웹훅 관리
config-wizard-perm-manage-server = 서버 관리
config-wizard-perm-manage-nicknames = 닉네임 관리
config-wizard-perm-kick-members = 멤버 추방
config-wizard-perm-ban-members = 멤버 차단
config-wizard-perm-timeout-members = 멤버 타임아웃
config-wizard-perm-mention-everyone = @everyone 멘션
config-wizard-perm-manage-threads = 스레드 관리
config-wizard-perm-administrator = 관리자

# 마법사 - 채널 검증
config-wizard-channel-header = __{"**"}채널 설정{"**"}__
config-wizard-channel-desc =
    이 섹션은 다음 사항을 확인합니다:

    - 설정된 채널이 존재하는지.
    - 봇이 설정된 채널에서 메시지를 확인하고 보낼 수 있는 권한이 있는지.
    - 기본(@everyone) 역할에 `메시지 보내기` 권한이 없는지.

config-wizard-channel-no-config-required = - ⚠️ 채널이 설정되지 않았습니다
config-wizard-channel-not-configured = - ℹ️ 설정되지 않음 (선택 사항)
config-wizard-channel-not-found = - ⚠️ 설정된 채널을 서버에서 찾을 수 없거나 삭제되었습니다
config-wizard-channel-ok = - ✅ 정상
config-wizard-bot-cannot-view = - ⚠️ { $botMention }이(가) 이 채널을 볼 수 없습니다.
config-wizard-bot-cannot-send = - ⚠️ { $botMention }이(가) 이 채널에서 메시지를 보낼 수 없습니다.
config-wizard-everyone-can-send = - ⚠️ @everyone이 이 채널에서 메시지를 보낼 수 있습니다.

# 마법사 - 채널 이름
config-wizard-channel-quest-board = Quest 게시판
config-wizard-channel-player-board = 플레이어 게시판
config-wizard-channel-quest-archive = Quest 보관소
config-wizard-channel-gm-transaction-log = GM 거래 기록
config-wizard-channel-player-transaction-log = 플레이어 거래 기록
config-wizard-channel-shop-log = 상점 기록
config-wizard-channel-approval-queue = 캐릭터 승인 대기열

# 마법사 - 대시보드
config-wizard-dashboard-header = __{"**"}설정 대시보드{"**"}__
config-wizard-dashboard-desc = 이 섹션은 비필수 설정에 대한 빠른 참조 개요를 제공합니다.
config-wizard-quest-settings = {"**"}Quest 설정{"**"}
config-wizard-quest-wait-list = - Quest 대기 목록 크기: { $size }
config-wizard-quest-summary = - Quest 요약: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM 보상 (Quest당){"**"}
config-wizard-player-settings = {"**"}플레이어 설정{"**"}
config-wizard-player-experience = - 플레이어 경험치: { $status }
config-wizard-currency-settings = {"**"}화폐 설정{"**"}
config-wizard-rp-rewards = {"**"}롤플레이 보상{"**"}
config-wizard-rp-status = - 상태: { $status }
config-wizard-rp-mode = - 모드: { $mode }
config-wizard-rp-channels = - 모니터링 채널: { $count }
config-wizard-shops = {"**"}상점{"**"}
config-wizard-shops-count = - 설정된 상점: { $count }
config-wizard-shops-more = - ...외 { $count }개 더
config-wizard-new-char-setup = {"**"}신규 캐릭터 설정{"**"}
config-wizard-inventory-type = - 인벤토리 유형: { $type }
config-wizard-new-char-shop-items = - 신규 캐릭터 상점 아이템: { $count }
config-wizard-static-kits = - 고정 키트: { $count }

# 마법사 - GM 보상 보고서
config-wizard-no-currencies = - ℹ️ 설정된 화폐가 없습니다
config-wizard-configured-currencies = {"**"}설정된 화폐:{"**"}
config-wizard-no-denominations = - 설정된 단위가 없습니다
config-wizard-gm-rewards-disabled = {"**"}상태:{"**"} 비활성화
config-wizard-gm-rewards-enabled = {"**"}상태:{"**"} 활성화
config-wizard-gm-rewards-experience = - 경험치: { $xp }
config-wizard-gm-rewards-items = - 아이템:

# 마법사 - 서버 언어 (1페이지)
config-wizard-server-language-desc =
    이것은 ReQuest가 Quest 게시물, 상점 재입고 메시지, 거래 로그 등 모든 공개 메시지에 사용할 언어입니다.
config-wizard-server-language = {"**"}서버 언어:{"**"} { $language }
config-wizard-server-language-default = 기본값 (영어)

# 마법사 - 상점 재입고 정보
config-wizard-shop-restock-not-scheduled = ℹ️ 재입고 예정 없음

# 마법사 - Quest 설정 (5페이지)
config-wizard-quest-header = __{"**"}Quest 설정{"**"}__
config-wizard-quest-header-desc =
    이 섹션은 Quest 관련 설정에 대한 개요를 제공합니다.
config-wizard-quest-role-mode = - Quest 역할 모드: { $mode }
config-wizard-quest-roles-label = {"**"}GM Quest 역할{"**"}
config-wizard-quest-roles-count = - GM에 할당된 역할: { $count }
config-wizard-quest-roles-all-ok = - ✅ 모든 역할 정상
config-wizard-quest-roles-assigned-to = {"    "}할당 대상: { $gmNames }
config-wizard-quest-roles-not-found = - ⚠️ 역할 ID { $roleId }: 찾을 수 없음/서버에서 삭제됨
config-wizard-quest-roles-no-assignments = - ℹ️ 할당된 Quest 역할 없음

## 역할 뷰
config-title-roles = {"**"}서버 설정 - 역할{"**"}
config-label-announcement-role = {"**"}알림 역할:{"**"} { $status }
config-desc-announcement-role = Quest가 게시될 때 이 역할이 멘션됩니다.
config-label-announcement-role-default = {"**"}알림 역할:{"**"} 미설정
config-label-gm-roles = {"**"}GM 역할:{"**"} { $roles }
config-desc-gm-roles = 이 역할은 GM 명령어 및 기능에 대한 접근 권한을 부여합니다.
config-label-gm-roles-default = {"**"}GM 역할:{"**"} 미설정
config-title-forbidden-roles = __{"**"}금지된 역할{"**"}__
config-desc-forbidden-roles =
    GM이 파티 역할에 사용할 수 없는 역할 이름 목록을 설정합니다.
    기본적으로 `everyone`, `administrator`, `gm`, `game master`는 사용할 수 없습니다. 이 설정은
    해당 목록을 확장합니다.

## GM 역할 제거 뷰
config-title-remove-gm-roles = {"**"}서버 설정 - GM 역할 제거{"**"}
config-msg-no-gm-roles = 설정된 GM 역할이 없습니다.

## 채널 뷰
config-title-channels = {"**"}서버 설정 - 채널{"**"}

config-label-quest-board = {"**"}Quest 게시판:{"**"} { $channel }
config-desc-quest-board = 새로운/활성 Quest가 게시되는 채널입니다.
config-label-quest-board-default = {"**"}Quest 게시판:{"**"} 미설정

config-label-player-board = {"**"}플레이어 게시판:{"**"} { $channel }
config-desc-player-board = 플레이어가 사용할 수 있는 선택적 공지/메시지 게시판입니다.
config-label-player-board-default = {"**"}플레이어 게시판:{"**"} 미설정

config-label-quest-archive = {"**"}Quest 보관소:{"**"} { $channel }
config-desc-quest-archive = 완료된 Quest가 요약 정보와 함께 이동되는 선택적 채널입니다.
config-label-quest-archive-default = {"**"}Quest 보관소:{"**"} 미설정

config-label-gm-transaction-log = {"**"}GM 거래 기록:{"**"} { $channel }
config-desc-gm-transaction-log = GM 거래(예: 플레이어 수정 명령어)가 기록되는 선택적 채널입니다.
config-label-gm-transaction-log-default = {"**"}GM 거래 기록:{"**"} 미설정

config-label-player-transaction-log = {"**"}플레이어 거래 기록:{"**"} { $channel }
config-desc-player-transaction-log = 교환 및 아이템 소비 등 플레이어 거래가 기록되는 선택적 채널입니다.
config-label-player-transaction-log-default = {"**"}플레이어 거래 기록:{"**"} 미설정

config-label-shop-log = {"**"}상점 기록:{"**"} { $channel }
config-desc-shop-log = 상점 거래가 기록되는 선택적 채널입니다.
config-label-shop-log-default = {"**"}상점 기록:{"**"} 미설정

## Quest 뷰
config-title-quests = {"**"}서버 설정 - Quest{"**"}

config-label-wait-list = {"**"}Quest 대기 목록 크기:{"**"} { $size }
config-desc-wait-list = 대기 목록을 사용하면 지정된 수의 플레이어가 정원이 찬 Quest에 대기할 수 있습니다.
config-label-wait-list-disabled = {"**"}Quest 대기 목록 크기:{"**"} 비활성화

config-label-quest-summary = {"**"}Quest 요약:{"**"} { $status }
config-desc-quest-summary = 이 옵션을 활성화하면 GM이 Quest 종료 시 짧은 요약을 작성할 수 있습니다.
config-label-quest-summary-disabled = {"**"}Quest 요약:{"**"} 비활성화

config-label-gm-rewards = GM 보상
config-desc-gm-rewards = GM이 Quest 완료 시 받을 보상을 설정합니다.

## GM 보상 뷰
config-title-gm-rewards = {"**"}서버 설정 - GM 보상{"**"}
config-desc-gm-rewards-detail =
    {"**"}보상 추가/수정{"**"}
    GM 보상을 추가, 수정 또는 제거할 수 있는 입력 모달을 엽니다.

    > 설정된 보상은 Quest 단위입니다. GM이 Quest를 완료할 때마다
    활성 캐릭터에 아래 설정된 보상이 지급됩니다.
config-msg-no-rewards = 설정된 보상이 없습니다.
config-label-gm-experience = {"**"}경험치:{"**"} { $xp }
config-label-gm-items = {"**"}아이템:{"**"}

## 플레이어 뷰
config-title-players = {"**"}서버 설정 - 플레이어{"**"}

config-label-player-experience = {"**"}플레이어 경험치:{"**"} { $status }
config-desc-player-experience = 경험치(또는 유사한 수치 기반 캐릭터 성장) 사용을 활성화/비활성화합니다.
config-label-player-experience-disabled = {"**"}플레이어 경험치:{"**"} 비활성화

config-label-new-char-settings = {"**"}신규 캐릭터 설정{"**"}
config-desc-new-char-settings = 신규 플레이어 캐릭터 및 초기 인벤토리 설정 관련 옵션을 구성합니다.

config-label-player-board-purge = {"**"}플레이어 게시판 삭제{"**"}
config-desc-player-board-purge = 플레이어 게시판의 게시물을 삭제합니다(활성화된 경우).

## 신규 캐릭터 설정 뷰
config-title-new-character = {"**"}서버 설정 - 신규 캐릭터 설정{"**"}

config-label-inventory-type = {"**"}신규 캐릭터 인벤토리 유형:{"**"} { $type }
config-desc-inventory-type = 새로 등록된 캐릭터의 인벤토리 초기화 방식을 결정합니다.
config-label-inventory-type-disabled = {"**"}신규 캐릭터 인벤토리 유형:{"**"} 비활성화

config-label-new-char-wealth = {"**"}신규 캐릭터 재산:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}신규 캐릭터 재산:{"**"} 비활성화

config-label-approval-queue = {"**"}승인 대기열:{"**"} { $channel }
config-desc-approval-queue = 설정된 경우, 신규 캐릭터는 이 포럼 채널에서 GM의 승인을 받아야 활성화됩니다.
config-label-approval-queue-disabled = {"**"}승인 대기열:{"**"} 비활성화
config-label-approval-queue-not-configured = {"**"}승인 대기열:{"**"} 미설정

# 인벤토리 유형 설명 (설정 시 사용)
config-desc-inv-type-disabled = 플레이어가 빈 인벤토리로 시작합니다.
config-desc-inv-type-selection = 플레이어가 신규 캐릭터 상점에서 자유롭게 아이템을 선택합니다.
config-desc-inv-type-purchase = 플레이어가 주어진 금액의 화폐로 신규 캐릭터 상점에서 아이템을 구매합니다.
config-desc-inv-type-open = 플레이어가 직접 인벤토리 아이템을 입력합니다.
config-desc-inv-type-static = 플레이어에게 미리 정의된 시작 인벤토리가 지급됩니다.

## 신규 캐릭터 상점 뷰
config-title-new-char-shop = {"**"}서버 설정 - 신규 캐릭터 상점{"**"}
config-label-inv-type-selection = {"**"}인벤토리 유형:{"**"} 선택
config-desc-inv-type-selection-shop = 플레이어가 신규 캐릭터 상점에서 자유롭게 아이템을 선택합니다.
config-label-inv-type-purchase = {"**"}인벤토리 유형:{"**"} 구매
config-desc-inv-type-purchase-shop = 플레이어가 주어진 금액의 화폐로 신규 캐릭터 상점에서 아이템을 구매합니다.
config-label-inv-type-other = {"**"}인벤토리 유형:{"**"} { $type }
config-desc-inv-type-not-in-use = 신규 캐릭터 상점이 사용되지 않습니다.
config-msg-define-shop-items = 상점 아이템을 정의하세요.
config-msg-no-items = 설정된 아이템이 없습니다.

## 고정 키트 뷰
config-title-static-kits = {"**"}서버 설정 - 고정 키트{"**"}
config-desc-create-kit = 새 키트 정의를 생성합니다.
config-msg-no-kits = 설정된 키트가 없습니다.
config-label-kit-more-items = ...외 { $count }개 아이템 더
config-label-empty-kit = {"*"}빈 키트{"*"}

## 고정 키트 편집 뷰
config-title-editing-kit = {"**"}키트 편집 중: { $kitName }{"**"}
config-msg-kit-empty = 이 키트가 비어 있습니다. 위의 버튼을 사용하여 화폐나 아이템을 추가하세요.
config-label-kit-currency = {"**"}화폐:{"**"} { $display }
config-label-kit-item = {"**"}아이템:{"**"} { $name }

## 화폐 뷰
config-title-currency = {"**"}서버 설정 - 화폐{"**"}
config-desc-create-currency = 새 화폐를 생성합니다.
config-msg-no-currencies = 설정된 화폐가 없습니다.
config-label-currency-display-type = 표시 유형: { $type } | 단위: { $count }
config-label-currency-type-double = 소수점
config-label-currency-type-integer = 정수

## 화폐 관리 뷰
config-title-manage-currency = {"**"}화폐 관리: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}화폐와 단위{"**"}__
    - 화폐의 지정된 이름은 기본 화폐로 간주되며 값은 1입니다.
    {"```"}예: "골드"가 화폐로 설정됩니다.{"```"}
    - 단위를 추가하려면 기본 화폐에 대한 상대적 이름과 값을 지정해야 합니다.
    {"```"}예: 골드에 두 개의 단위가 추가됩니다: 실버(값 0.1), 코퍼(값 0.01).{"```"}
    - 기본 화폐 또는 그 단위를 포함하는 모든 거래는 자동으로 변환됩니다.
    {"```"}예: 플레이어가 10 골드를 보유하고 3 코퍼를 사용합니다. 새 잔액은 자동으로
    9 골드, 9 실버, 7 코퍼로 표시됩니다.{"```"}
    - 정수로 표시되는 화폐는 각 단위를 보여주고, 소수점으로 표시되는 화폐는
    기본 화폐로만 표시됩니다.
    {"```"}예: 위 플레이어가 소수점 표시를 활성화하면 9.97 골드로 표시됩니다.{"```"}
config-btn-toggle-display-current = 표시 전환 (현재: { $type })
config-msg-no-denominations = 설정된 단위가 없습니다.

## 상점 뷰
config-title-shops = {"**"}서버 설정 - 상점{"**"}
config-desc-add-shop-wizard =
    {"**"}상점 추가 (마법사){"**"}
    폼에서 비어 있는 새 상점을 생성합니다.
config-desc-add-shop-json =
    {"**"}상점 추가 (JSON){"**"}
    완전한 JSON 정의를 제공하여 새 상점을 생성합니다. (고급)
config-btn-example-json = 예시 JSON
config-desc-example-json =
    {"**"}예시 JSON{"**"}
    예상 형식을 보여주는 예시 JSON 파일을 다운로드합니다.
config-msg-example-json = 예상 형식을 보여주는 예시 JSON 파일입니다.
config-msg-no-shops = 설정된 상점이 없습니다.
config-label-shop-type-forum = (포럼)
config-label-shop-channel = 채널: <#{ $channelId }>

## 상점 채널 유형 선택 뷰
config-title-choose-location = {"**"}상점 추가 - 위치 유형 선택{"**"}
config-label-text-channel = {"**"}텍스트 채널{"**"}
config-desc-text-channel = 일반 텍스트 채널에 상점을 생성합니다.
config-label-forum-thread = {"**"}포럼 스레드{"**"}
config-desc-forum-thread = 포럼 스레드(신규 또는 기존)에 상점을 생성합니다.

## 포럼 상점 설정 뷰
config-title-forum-setup = {"**"}상점 추가 - 포럼 스레드 설정{"**"}
config-label-step1 = {"**"}1단계: 포럼 채널 선택{"**"}
config-label-step2 = {"**"}2단계: 스레드 옵션 선택{"**"}
config-label-step3 = {"**"}3단계: 기존 스레드 선택{"**"}
config-desc-create-new-thread =
    {"**"}새 스레드 생성{"**"}
    새 스레드를 생성하고 상점을 설정하는 폼을 엽니다.
config-label-selected-thread = {"**"}선택된 스레드:{"**"} { $threadName }
config-desc-click-to-configure = 이 스레드에서 상점을 설정하려면 클릭하세요.

## 상점 관리 뷰
config-title-manage-shop = {"**"}상점 관리: { $shopName }{"**"}
config-label-shop-type = {"**"}유형:{"**"} { $type }
config-label-shop-type-text = 텍스트 채널
config-label-shop-type-forum-thread = 포럼 스레드
config-label-shopkeeper = {"**"}상점 주인:{"**"} { $name }
config-label-shop-description = {"**"}설명:{"**"} { $description }
config-label-shop-channel-info = {"**"}채널:{"**"} <#{ $channelId }>
config-desc-edit-wizard = 마법사를 통해 상점 상세 및 아이템을 편집합니다.
config-desc-upload-json = 이 상점의 새 JSON 정의를 업로드합니다.
config-desc-download-json = 현재 JSON 정의를 다운로드합니다.
config-desc-remove-shop = 이 상점을 영구적으로 제거합니다.

## 상점 편집 뷰
config-title-editing-shop = {"**"}상점 편집 중: { $shopName }{"**"}
config-label-shop-shopkeeper = 상점 주인: {"**"}{ $name }{"**"}

## 재고 한도 뷰
config-title-stock-config = {"**"}재고 설정: { $shopName }{"**"}
config-label-current-utc = 현재 UTC 시간: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}재입고 일정:{"**"} { $schedule }
config-label-restock-hourly = { $minute }분에
config-label-restock-daily = { $time } UTC에
config-label-restock-weekly = { $day } { $time } UTC에
config-label-restock-mode = {"**"}모드:{"**"} { $mode }
config-label-restock-full = 전체 재입고
config-label-restock-incremental = 점진적 (아이템별 수량)
config-label-restock-disabled = {"**"}재입고 일정:{"**"} 비활성화
config-label-item-stock-limits = {"**"}아이템 재고 한도{"**"}
config-msg-no-items-in-shop = 이 상점에 아이템이 없습니다.
config-label-stock-with-available = 최대: { $max } | 가용: { $available }
config-label-stock-increment = 재입고: +{ $increment }/주기
config-label-stock-reserved = 예약: { $reserved }
config-label-stock-not-initialized = 최대: { $max } | 가용: (미초기화)
config-label-stock-unlimited = 재고: 무제한

## 롤플레이 뷰
config-title-roleplay = {"**"}서버 설정 - 롤플레이 보상{"**"}
config-label-rp-status = {"**"}상태:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}서버 시간:{"**"} `{ $time }`
config-label-rp-enabled = 활성화
config-label-rp-disabled = 비활성화

config-desc-rp-mode-scheduled = {"```"}보상은 설정된 기간(매시간, 매일 또는 매주) 내에 필요한 적격 메시지 임계값을 보낸 후 한 번 지급됩니다.{"```"}
config-desc-rp-mode-accrued = {"```"}보상은 설정된 수의 적격 메시지가 전송될 때마다 반복적으로 지급됩니다.{"```"}

config-label-rp-config-details = {"**"}설정 세부 사항:{"**"}
config-label-rp-mode = {"**"}모드:{"**"} { $mode }
config-label-rp-min-length = {"**"}최소 메시지 길이:{"**"} { $length }자
config-label-rp-cooldown = {"**"}쿨다운:{"**"} { $seconds }초
config-label-rp-frequency-once = {"**"}빈도:{"**"} { $period }당 1회
config-label-rp-reset-time = {"**"}초기화 시간:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}임계값:{"**"} 적격 메시지 { $count }개
config-label-rp-frequency-every = {"**"}빈도:{"**"} 적격 메시지 { $count }개마다

config-label-rp-channels = {"**"}롤플레이 채널:{"**"}
config-msg-rp-no-channels = 설정된 채널이 없습니다.
config-label-rp-channels-more = ...외 { $count }개 더.

config-label-rp-rewards = {"**"}보상:{"**"}
config-msg-rp-no-rewards = 설정된 보상이 없습니다.
config-label-rp-experience = {"**"}경험치:{"**"} { $xp }
config-label-rp-items = {"**"}아이템:{"**"}
config-label-rp-currency = {"**"}화폐:{"**"}

## 언어 뷰
config-title-language = {"**"}서버 설정 - 언어{"**"}
config-server-language-help =
    이 설정을 통해 이 서버에서 ReQuest의 {"**"}공개{"**"} 응답 및 메시지에 대한 기본 언어를 지정할 수 있습니다. 공개 응답에는 다음이 포함됩니다:
    - Quest 및 플레이어 게시판 게시물
    - Quest 요약 및 기록 채널 메시지
    - 상점 재입고
    - 플레이어 아이템 소비

    이 설정은 봇이 생성하는 고정 텍스트에만 영향을 미치며, 사용자가 입력한 아이템 이름이나 Quest 설명 같은 동적 콘텐츠는 번역되지 않습니다.

    개인 응답 및 메뉴는 이 설정의 영향을 받지 않습니다.
config-label-server-language = {"**"}서버 언어:{"**"} { $language }
config-label-server-language-default = {"**"}서버 언어:{"**"} 기본값 (재정의 없음)
config-select-placeholder-server-language = 서버 언어를 선택하세요
config-select-option-default = 기본값 (재정의 없음)
config-select-desc-default = 각 사용자의 환경 설정 또는 Discord 로캘을 사용합니다.

# Quest 역할
config-btn-quest-roles = Quest 역할
config-btn-manage-gm-quest-roles = 관리

config-modal-title-confirm-quest-role-removal = 역할 제거 확인
config-modal-label-remove-quest-role = { $gmName }에서 { $roleName }을(를) 제거하시겠습니까?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Quest 역할 모드 선택
config-select-option-quest-role-disabled = 비활성화
config-select-desc-quest-role-disabled = 역할이 생성되거나 할당되지 않습니다.
config-select-option-quest-role-temporary = 임시
config-select-desc-quest-role-temporary = GM이 Quest마다 임시 역할을 생성할 수 있습니다.
config-select-option-quest-role-static = 고정
config-select-desc-quest-role-static = GM이 미리 할당된 서버 역할에서 선택합니다.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = 이 GM에 서버 역할 할당

## Quest 역할 뷰
config-title-quest-roles = {"**"}서버 설정 - Quest 역할{"**"}

config-label-quest-role-mode-disabled = {"**"}Quest 역할 모드:{"**"} 비활성화
    Quest 중 역할이 생성되거나 할당되지 않습니다.
config-label-quest-role-mode-temporary = {"**"}Quest 역할 모드:{"**"} 임시
    GM이 Quest 생성 시 선택적으로 임시 역할을 생성할 수 있습니다.
    Quest가 완료되거나 취소되면 역할이 삭제됩니다.
config-label-quest-role-mode-static = {"**"}Quest 역할 모드:{"**"} 고정
    GM이 미리 할당된 서버 역할에서 선택합니다. Quest 중
    파티 멤버에게 역할이 할당되지만 삭제되지는 않습니다.

## 고정 Quest 역할 할당 뷰
config-title-static-quest-roles = {"**"}서버 설정 - 고정 Quest 역할 할당{"**"}
config-label-manage-assignments = 역할 할당 관리
config-desc-manage-assignments =
    Quest 중 사용할 기존 서버 역할을 GM에 할당합니다.
    역할은 서버 계층에서 ReQuest의 최상위 역할보다 낮아야 합니다.
config-msg-no-gm-members = 이 서버에서 GM 역할을 가진 멤버를 찾을 수 없습니다.
config-label-no-roles-assigned = 할당된 Quest 역할 없음
config-label-more-roles = (+{ $count }개 더)

## GM Quest 역할 할당 뷰
config-title-gm-quest-role-assign = {"**"}Quest 역할 관리 — { $gmName }{"**"}
config-error-unmanageable-roles = 다음 역할은 통합에 의해 관리되거나, 기본 역할이거나, ReQuest의 최상위 역할보다 높아서 할당할 수 없습니다: { $roles }
config-error-quest-role-limit = 이 GM은 최대 { $limit }개의 Quest 역할 할당 한도에 도달했습니다.
config-label-quest-role-count = 할당된 역할: { $count }/{ $limit }
