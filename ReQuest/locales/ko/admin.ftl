## 관리 모듈 문자열

# 관리 코그
admin-embed-title-unauthorized = 미승인 서버
admin-embed-desc-unauthorized =
    ReQuest에 관심을 가져 주셔서 감사합니다! 이 서버는 ReQuest의 승인된 테스트 서버 목록에 포함되어 있지 않습니다.
    아래 지원 Discord에 참여하시고, 개발팀에 테스트 접근 권한을 요청해 주세요.

    [ReQuest 개발 Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = 다음 명령어가 { $guildName }, ID { $guildId }에 동기화되었습니다
admin-embed-title-sync-global = 다음 명령어가 전역으로 동기화되었습니다
admin-error-missing-scope = ReQuest에 대상 길드에서 올바른 범위가 설정되어 있지 않습니다. `applications.commands` 권한을 추가한 후 다시 시도해 주세요.
admin-error-sync-failed = 명령어 동기화 중 오류가 발생했습니다: { $error }
admin-msg-commands-cleared = 명령어가 초기화되었습니다.

# 관리 버튼
admin-btn-shutdown = 종료
admin-modal-title-confirm-shutdown = 종료 확인
admin-modal-label-shutdown-warning = 경고! 봇이 종료됩니다. 계속하려면 확인을 입력하세요.
admin-msg-shutting-down = 종료 중입니다!
admin-btn-add-server = 새 서버 추가
admin-btn-load-cog = 코그 로드
admin-msg-extension-loaded = 확장 기능이 성공적으로 로드되었습니다: `{ $module }`
admin-btn-reload-cog = 코그 리로드
admin-msg-extension-reloaded = 확장 기능이 성공적으로 리로드되었습니다: `{ $module }`
admin-btn-output-guilds = 길드 목록 출력
admin-msg-connected-guilds = { $count }개의 길드에 연결됨:

# 관리 모달
admin-modal-title-add-server = 허용 목록에 서버 ID 추가
admin-modal-label-server-name = 서버 이름
admin-modal-placeholder-server-name = Discord 서버의 간단한 이름을 입력하세요
admin-modal-label-server-id = 서버 ID
admin-modal-placeholder-server-id = Discord 서버의 ID를 입력하세요
admin-select-placeholder-server = 제거할 서버를 선택하세요
admin-modal-title-cog-action = 코그 { $action }
admin-modal-label-cog-name = 이름
admin-modal-placeholder-cog-name = { $action }할 코그의 이름을 입력하세요

# 관리 뷰
admin-title-main-menu = 관리 - 메인 메뉴
admin-desc-allowlist = 초대 제한을 위한 서버 허용 목록을 설정합니다.
admin-desc-cogs = 코그를 로드하거나 리로드합니다.
admin-desc-guild-list = 봇이 참여 중인 모든 길드의 목록을 반환합니다.
admin-desc-shutdown = 봇을 종료합니다
admin-title-allowlist = 관리 - 서버 허용 목록
admin-desc-allowlist-warning =
    새 Discord 서버 ID를 허용 목록에 추가합니다.
    {"**"}경고: 봇이 서버에 참여하지 않으면 제공된 서버 ID가 유효한지 확인할 방법이 없습니다. 입력 내용을 다시 한번 확인하세요!{"**"}
admin-msg-no-servers = 허용 목록에 서버가 없습니다.

# 관리 확인 모달
admin-modal-title-confirm-server-removal = 서버 제거 확인
admin-modal-label-server-removal = 허용 목록에서 서버를 제거하시겠습니까?

# 관리 코그 뷰
admin-title-cogs = 관리 - 코그
admin-desc-load-cog = 이름으로 봇 코그를 로드합니다. 파일 이름은 `<이름>.py`이어야 하며 ReQuest/cogs/에 저장되어 있어야 합니다.
admin-desc-reload-cog = 이름으로 로드된 코그를 리로드합니다. 동일한 이름 및 파일 경로 제한이 적용됩니다.
