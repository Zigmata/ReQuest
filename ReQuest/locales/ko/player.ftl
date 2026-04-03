## 플레이어 모듈 문자열

# --- 코그 ---

player-cmd-name = 거래
player-cmd-desc = 플레이어 메뉴

# --- 버튼 ---

# 캐릭터 관리
player-btn-register-character = 새 캐릭터 등록
player-btn-activate = 활성화
player-btn-active = 활성

# 플레이어 게시판
player-btn-create-post = 게시물 작성
player-btn-open-starting-shop = 시작 상점 열기
player-btn-select-kit = 키트 선택
player-btn-input-inventory = 인벤토리 입력

# 마법사 / 상점 버튼
player-btn-add-to-cart = 장바구니에 추가
player-btn-add-to-cart-cost = 장바구니에 추가 ({ $costString })
player-btn-view-purchase-options = 구매 옵션 보기
player-btn-review-submit = 검토 및 제출 ({ $count })
player-btn-submit-character = 캐릭터 제출
player-btn-keep-shopping = 쇼핑 계속
player-btn-edit-quantity = 수량 편집
player-btn-clear-cart = 장바구니 비우기

# 키트 버튼
player-btn-confirm-selection = 선택 확인
player-btn-back-to-kits = 키트로 돌아가기

# 인벤토리 관리
player-btn-spend-currency = 화폐 사용
player-btn-print-inventory = 인벤토리 출력

# 컨테이너 관리
player-btn-manage-containers = 컨테이너 관리
player-btn-create-new = + 새로 생성
player-btn-consume-destroy = 소비/파괴
player-btn-move = 이동
player-btn-move-all = 전부 이동
player-btn-move-some = 일부 이동...
player-btn-back-to-overview = ← 개요로 돌아가기
player-btn-cancel-move = ← 취소
player-btn-up = ▲ 위로
player-btn-down = ▼ 아래로

# --- 모달 ---

# 교환 모달
player-modal-title-trade = { $targetName }과(와) 교환
player-modal-label-trade-name = 이름
player-modal-placeholder-trade-name = 교환할 아이템의 이름을 입력하세요
player-modal-label-trade-quantity = 수량
player-modal-placeholder-trade-quantity = 교환할 수량을 입력하세요

# 캐릭터 등록 모달
player-modal-title-register = 새 캐릭터 등록
player-modal-label-char-name = 이름
player-modal-placeholder-char-name = 캐릭터의 이름을 입력하세요.
player-modal-label-char-note = 메모
player-modal-placeholder-char-note = 캐릭터를 식별할 수 있는 메모를 입력하세요

# 자유 인벤토리 입력 모달
player-modal-title-starting-inventory = 시작 인벤토리 입력
player-modal-label-inventory = 인벤토리
player-modal-placeholder-inventory-input =
    한 줄에 하나씩 <이름>: <수량> 형식으로 입력, 예:
    검: 1
    gold: 30

# 화폐 사용 모달
player-modal-title-spend-currency = 화폐 사용
player-modal-label-currency-name = 화폐 이름
player-modal-placeholder-currency-name = 사용할 화폐의 이름을 입력하세요
player-modal-label-currency-amount = 금액
player-modal-placeholder-currency-amount = 사용할 금액을 입력하세요

# 플레이어 게시물 작성 모달
player-modal-title-create-post = 플레이어 게시판 게시물 작성
player-modal-label-post-title = 제목
player-modal-placeholder-post-title = 게시물의 제목을 입력하세요
player-modal-label-post-content = 게시물 내용
player-modal-placeholder-post-content = 게시물의 본문을 입력하세요

# 플레이어 게시물 편집 모달
player-modal-title-edit-post = 플레이어 게시판 게시물 편집

# 마법사 장바구니 아이템 수량 편집 모달
player-modal-title-edit-cart-qty = 장바구니 수량 편집
player-modal-label-cart-qty = 수량
player-modal-placeholder-cart-qty = 새 수량을 입력하세요 (0이면 제거)

# 컨테이너 생성 모달
player-modal-title-create-container = 새 컨테이너 생성
player-modal-label-container-name = 컨테이너 이름
player-modal-placeholder-container-name = 컨테이너 이름을 입력하세요 (예: 배낭)

# 컨테이너 이름 변경 모달
player-modal-title-rename-container = 컨테이너 이름 변경
player-modal-label-new-container-name = 새 컨테이너 이름
player-modal-placeholder-new-container-name = 새 이름을 입력하세요

# 컨테이너에서 소비 모달
player-modal-title-consume = 아이템 소비/파괴
player-modal-label-consume-qty = 수량 (최대: { $maxQuantity })
player-modal-placeholder-consume-qty = 소비/파괴할 수량을 입력하세요

# 아이템 이동 수량 모달
player-modal-title-move-item = 아이템 이동
player-modal-label-move-qty = 이동할 수량 (최대: { $maxQuantity })
player-modal-placeholder-move-qty = 이동할 수량을 입력하세요

# --- 셀렉트 ---

player-select-placeholder-no-characters = 등록된 캐릭터가 없습니다
player-select-placeholder-remove-character = 제거할 캐릭터를 선택하세요
player-select-placeholder-post = 게시물을 선택하세요
player-select-placeholder-container-view = 확인할 컨테이너를 선택하세요...
player-select-placeholder-item = 아이템을 선택하세요...
player-select-placeholder-destination = 대상을 선택하세요...
player-select-placeholder-container = 컨테이너를 선택하세요...
player-select-option-no-containers = 컨테이너 없음
player-select-option-no-items = 아이템 없음
player-select-option-no-destinations = 대상 없음

# --- 뷰 ---

# PlayerBaseView - 메인 메뉴
player-title-main-menu = {"**"}플레이어 명령어 - 메인 메뉴{"**"}
player-menu-btn-characters = 캐릭터
player-menu-desc-characters = 플레이어 캐릭터를 등록, 확인 및 활성화합니다.
player-menu-btn-inventory = 인벤토리
player-menu-desc-inventory = 활성 캐릭터의 인벤토리를 확인하고 화폐를 사용합니다.
player-menu-btn-player-board = 플레이어 게시판
player-menu-btn-player-board-disabled = 플레이어 게시판 (미설정)
player-menu-desc-player-board = 플레이어 게시판에 게시물을 작성합니다

# CharacterBaseView
player-title-characters = {"**"}플레이어 명령어 - 캐릭터{"**"}
player-desc-register-character = 새 캐릭터를 등록합니다.
player-msg-no-characters = 등록된 캐릭터가 없습니다.
player-label-active = (활성)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}진행 중인 캐릭터: { $characterName }{"**"}
    캐릭터 등록이 인벤토리 설정을 기다리고 있습니다.
player-btn-resume = 계속
player-btn-discard = 삭제
player-modal-title-discard-character = 캐릭터 삭제
player-modal-label-discard-confirm = { $characterName }을(를) 삭제하시겠습니까?

# 캐릭터 제거 확인
player-modal-title-confirm-char-removal = 캐릭터 제거 확인
player-modal-label-confirm-char-delete = { $characterName }을(를) 삭제하시겠습니까?

# 게시물 제거 확인
player-modal-title-confirm-post-removal = 게시물 제거 확인
player-modal-label-post-removal-warning = 경고: 이 작업은 되돌릴 수 없습니다!

# InventoryOverviewView
player-title-inventory = {"**"}플레이어 명령어 - 인벤토리{"**"}
player-title-char-inventory = {"**"}{ $characterName }의 인벤토리{"**"}
player-msg-no-active-character = 활성 캐릭터 없음: 이 메뉴를 사용하려면 이 서버에서 캐릭터를 활성화하세요.
player-msg-no-characters-registered = 캐릭터 없음: 이 메뉴를 사용하려면 캐릭터를 등록하세요.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count }개 아이템
player-label-currency = {"**"}화폐{"**"}
player-msg-inventory-empty = 인벤토리가 비어 있습니다.

# 인벤토리 출력 임베드
player-embed-title-inventory = { $characterName }의 인벤토리

# ContainerItemsView
player-msg-container-empty = 이 컨테이너가 비어 있습니다.
player-label-selected-item = 선택됨: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}"{ $itemName }" 이동{"**"} ({ $available }개 가용)
player-msg-no-other-containers = 다른 컨테이너가 없습니다.
player-msg-select-destination = 대상 컨테이너를 선택하세요:
player-label-destination = 대상: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}컨테이너 관리{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count }개 아이템){ $suffix }
player-label-default-suffix = { " " }(기본)
player-msg-no-containers = 컨테이너가 없습니다.
player-label-selected-container = 선택됨: {"**"}{ $containerName }{"**"}

# 컨테이너 삭제 확인
player-modal-title-confirm-container-delete = 컨테이너 삭제 확인
player-modal-label-container-has-items = { $itemCount }개의 아이템이 있습니다. 미분류 아이템으로 이동됩니다.
player-modal-label-confirm-container-delete = "{ $containerName }"을(를) 삭제하시겠습니까?

# 컨테이너 오류
player-error-cannot-rename-loose = 미분류 아이템의 이름은 변경할 수 없습니다.
player-error-cannot-delete-loose = 미분류 아이템은 삭제할 수 없습니다.

# PlayerBoardView
player-title-player-board = {"**"}플레이어 명령어 - 플레이어 게시판{"**"}
player-desc-create-post = 플레이어 게시판에 새 게시물을 작성합니다.
player-msg-no-posts = 현재 게시물이 없습니다.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = 작성자
player-embed-footer-post-id = 게시물 ID: { $postId }
player-error-board-channel-not-found = 플레이어 게시판 채널을 찾을 수 없습니다.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}{ $characterName }의 인벤토리 설정{"**"}
player-desc-browse-shop = 시작 상점을 탐색하여 캐릭터를 장비하세요.
player-desc-select-kit = 시작 키트를 선택하세요.
player-desc-input-inventory = 시작 인벤토리를 수동으로 입력하세요.

# StaticKitSelectView
player-title-select-kit = {"**"}{ $characterName }의 키트 선택{"**"}
player-msg-no-kits = 사용 가능한 시작 키트가 없습니다.
player-label-and-more-items = ...외 { $count }개 아이템 더
player-label-empty-kit = {"*"}빈 키트{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}선택 확인: { $kitName }{"**"}
player-label-items-heading = {"**"}아이템:{"**"}
player-label-currency-heading = {"**"}화폐:{"**"}
player-msg-kit-empty = 이 키트가 비어 있습니다.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}구매 옵션: { $itemName }{"**"}
player-msg-no-cost-options = 이 아이템에 사용 가능한 비용 옵션이 없습니다.
player-label-cost-option = {"**"}옵션 { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}시작 상점 ({ $inventoryType }){"**"}
player-label-starting-wealth = 시작 재산: { $formattedCurrency }
player-label-in-cart = {"**"}(장바구니: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}장바구니 검토{"**"}
player-msg-cart-empty = 장바구니가 비어 있습니다.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (합계: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } 부족
player-label-total-cost = {"**"}총 비용:{"**"}
player-label-total-cost-free = {"**"}총 비용:{"**"} 무료
player-label-cart-page = { $current } / { $total } 페이지

# 교환 임베드
player-embed-title-trade = 교환 보고서
player-embed-desc-trade-sender = 보내는 사람: { $senderMention } (`{ $senderCharacter }`)
player-embed-desc-trade-recipient = 받는 사람: { $recipientMention } (`{ $recipientCharacter }`)
player-embed-field-currency = 화폐
player-embed-field-amount = 금액
player-embed-field-balance = { $characterName }의 잔액
player-embed-field-item = 아이템
player-embed-field-quantity = 수량
player-embed-footer-transaction-id = 거래 ID: { $transactionId }

# 교환 오류
player-error-trade-no-characters = 교환 대상 플레이어에게 캐릭터가 없습니다!
player-error-trade-no-active = 교환 대상 플레이어가 이 서버에서 활성화된 캐릭터가 없습니다!

# 화폐 사용 임베드
player-embed-title-spend = 플레이어 거래 보고서
player-embed-desc-spend-player = 플레이어: { $playerMention } (`{ $characterName }`)
player-embed-desc-spend-transaction = 거래: {"**"}{ $characterName }{"**"}이(가) {"**"}{ $formattedAmount }{"**"}을(를) 사용했습니다.
player-embed-field-channel = 채널
player-embed-field-receipt = 영수증

# 화폐 사용 오류
player-error-amount-not-number = 금액은 숫자여야 합니다.
player-error-amount-positive = 양수 금액을 사용해야 합니다.
player-error-amount-exceeds-maximum = 금액은 { $max }을(를) 초과할 수 없습니다.
player-error-no-active-character-server = 이 서버에서 활성화된 캐릭터가 없습니다.
player-error-no-currency-config = 이 서버에 화폐 설정이 없습니다.

# 아이템 소비 임베드
player-embed-title-consume = 아이템 소비 보고서
player-embed-desc-consume = 플레이어: { $playerMention } (`{ $characterName }`)
player-embed-desc-consume-removed = 제거됨: {"**"}{ $quantity }x { $itemName }{"**"} ({"**"}{ $containerName }{"**"}에서)

# 아이템 소비 오류
player-error-qty-positive-integer = 수량은 양의 정수여야 합니다.
player-error-qty-at-least-one = 수량은 최소 1이어야 합니다.
player-error-qty-only-have = 이 아이템은 { $maxQuantity }개만 보유하고 있습니다.

# 인벤토리 입력 오류
player-error-invalid-format = 잘못된 형식: "{ $line }". <이름>: <수량>을 사용하세요.
player-error-empty-name = 줄 "{ $line }"에서 아이템 이름이 비어 있습니다.
player-error-invalid-quantity = "{ $name }"의 잘못된 수량: "{ $quantity }". 양의 정수여야 합니다.
player-error-input-errors-header = 인벤토리 입력 오류:
player-msg-no-valid-items = 유효한 아이템이 제공되지 않았습니다. 빈 인벤토리로 초기화합니다.

# Validation error view
player-validation-error-title = 입력 오류
player-validation-btn-retry = 다시 시도

# 장바구니 수량 유효성 검사
player-error-enter-valid-number = 유효한 양수를 입력해 주세요.

# 제출 임베드 (승인 대기열)
player-embed-title-approval = 인벤토리 승인: { $characterName }
player-embed-desc-submitted-by = { $userMention }이(가) 제출함
player-embed-field-items = 아이템
player-embed-field-currency-received = 화폐
player-embed-footer-submission-id = 제출 ID: { $submissionId }
player-label-approval-thread = 승인: { $characterName }
player-embed-title-submission-sent = 인벤토리 제출 완료
player-embed-desc-submission-sent =
    {"**"}{ $characterName }{"**"}에 대한 제출이 GM 팀에 승인 검토를 위해 전송되었습니다!
    검토가 완료되면 알림을 받게 됩니다.
    [제출 스레드 보기]({ $threadUrl })

# 직접 적용 임베드 (승인 대기열 없음)
player-embed-title-starting-inventory = 시작 인벤토리 적용됨
player-embed-desc-starting-inventory = 플레이어: { $playerMention } (`{ $characterName }`)
player-embed-field-items-received = 받은 아이템
player-embed-field-currency-received-label = 받은 화폐
player-label-untitled = 제목 없음

# ApprovalPostView
player-approval-post-header =
    {"**"}인벤토리 제출: { $characterName }{"**"}
    { $userMention }이(가) 제출함
player-approval-post-items = 아이템
player-approval-post-currency = 화폐
player-approval-resolved = 이 제출물은 처리되었습니다.
player-approval-btn-approve = 승인
player-approval-btn-deny = 거부
player-approval-btn-edit = 편집
player-approval-error-no-permission = 이 작업을 수행할 권한이 없습니다.
player-approval-error-not-submitter = 원래 제출자만 이 제출물을 편집할 수 있습니다.
player-approval-thread-instructions =
    이 스레드는 {"**"}{ $characterName }{"**"}의 승인을 위해 생성되었습니다.
    게임 마스터가 제출물을 검토하고 승인 또는 거부합니다.
    승인 또는 거부되면 이 스레드는 잠깁니다.

    {"**"}게임 마스터:{"**"} 인벤토리가 허용 가능한 상태가 될 때까지
    플레이어와 필요한 변경 사항을 논의하세요. `거부` 버튼은
    조정 불가능한 제출물에만 사용하세요.

    { $playerMention }: 게임 마스터가 여기에서 요청한 변경 사항을
    적용하려면 `편집` 버튼을 사용하세요.
player-approval-approved-by = 이 제출물은 { $approver }에 의해 승인되었습니다.
player-approval-denied-by = 이 제출물은 { $denier }에 의해 거부되었습니다.
player-approval-deny-reason = 사유: { $reason }
player-msg-submission-updated = 제출물이 업데이트되었습니다.


# Denial modal
player-modal-title-deny-reason = 제출물 거부
player-modal-label-deny-reason = 거부 사유
player-modal-placeholder-deny-reason = 선택사항: 거부 사유를 설명하세요
# Approval DM notifications
player-dm-title-approved = 캐릭터 승인됨
player-dm-desc-approved =
    당신의 캐릭터 {"**"}{ $characterName }{"**"}이(가)
    {"**"}{ $guildName }{"**"}에서 { $approver }에 의해 승인되었습니다!
player-dm-title-denied = 캐릭터 거부됨
player-dm-desc-denied =
    당신의 캐릭터 {"**"}{ $characterName }{"**"}이(가)
    {"**"}{ $guildName }{"**"}에서 { $denier }에 의해 거부되었습니다.
