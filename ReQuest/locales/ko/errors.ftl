## 오류 및 검사 실패 문자열

# 오류 임베드 래퍼
error-oops-title = ⚠️ 오류 발생!
error-report-description =
    예외가 발생했습니다:

    {"```"}{ $exception }{"```"}

    이 오류가 예상치 못한 것이거나, 봇이 정상적으로 작동하지 않는다고 판단되면 [공식 ReQuest 지원 Discord](https://discord.gg/Zq37gj4)에 버그 리포트를 제출해 주세요.

# 검사 실패
error-owner-only = 봇 소유자만 이 명령어를 사용할 수 있습니다!
error-no-permission = 이 명령어를 실행할 권한이 없습니다!
error-no-active-character = 이 서버에서 활성화된 캐릭터가 없습니다!
error-no-registered-characters = 등록된 캐릭터가 없습니다!
error-no-characters = 대상 플레이어에게 등록된 캐릭터가 없습니다.
error-no-active-character-target = 대상 플레이어가 이 서버에서 활성화한 캐릭터가 없습니다.
error-player-not-found = 플레이어 데이터를 찾을 수 없습니다.
error-character-not-found = 캐릭터 데이터를 찾을 수 없습니다.

# 화폐/거래 오류
error-transaction-cannot-complete = 거래를 완료할 수 없습니다:
    { $reason }
error-insufficient-item-trade = { $itemName }을(를) { $owned }개 보유하고 있지만 { $quantity }개를 지급하려고 합니다.
error-currency-process-failed = 화폐 { $currencyName }을(를) 처리할 수 없습니다.
error-insufficient-funds-transaction = 이 거래를 처리하기에 잔액이 부족합니다.
error-insufficient-funds = 잔액이 부족합니다.
error-insufficient-items = 아이템 부족: { $itemName }
error-currency-not-configured = 화폐 '{ $currencyName }'이(가) 이 서버에 설정되어 있지 않습니다.
error-cost-currency-system-mismatch = 비용 화폐 '{ $currencyName }'이(가) 자체 화폐 체계에 속하지 않습니다.
error-currency-config-error = 화폐 설정 오류: 0 또는 음수 단위 값입니다.
error-currency-validation = 화폐 유효성 검사 중 오류가 발생했습니다: { $error }
error-invalid-currency = { $itemName }은(는) 유효한 화폐가 아닙니다.
error-insufficient-funds-for-transaction = 이 거래를 위한 잔액이 부족합니다.

# 장바구니 오류
error-cart-not-found = 장바구니를 찾을 수 없습니다.
error-item-not-in-cart = 장바구니에 해당 아이템이 없습니다.
error-not-enough-stock = 재고가 부족합니다.

# 컨테이너 오류
error-container-not-found = 컨테이너를 찾을 수 없습니다.
error-container-name-empty = 컨테이너 이름은 비워둘 수 없습니다.
error-container-name-too-long = 컨테이너 이름은 { $maxLength }자를 초과할 수 없습니다.
error-max-containers-reached = 컨테이너는 최대 { $maxContainers }개까지 생성할 수 있습니다.
error-container-name-exists = "{ $containerName }"이라는 이름의 컨테이너가 이미 존재합니다.
error-item-already-in-container = 아이템이 이미 이 컨테이너에 있습니다.
error-quantity-minimum = 수량은 최소 1이어야 합니다.
error-source-container-not-found = 원본 컨테이너를 찾을 수 없습니다.
error-item-not-in-source = 원본 컨테이너에서 "{ $itemName }" 아이템을 찾을 수 없습니다.
error-insufficient-quantity-in-container = 수량이 부족합니다. 이 컨테이너에 { $available }개가 있습니다.
error-dest-container-not-found = 대상 컨테이너를 찾을 수 없습니다.
error-item-not-in-container = 이 컨테이너에서 "{ $itemName }" 아이템을 찾을 수 없습니다.
error-insufficient-quantity-consume = 이 컨테이너에 이 아이템이 { $available }개만 있습니다.
