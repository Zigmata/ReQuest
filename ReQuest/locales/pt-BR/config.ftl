## Strings do módulo de configuração

# ==========================================
# BOTÕES
# ==========================================

# Cargos
config-btn-clear = Limpar
config-btn-remove-gm-roles = Remover Cargos de MJ
config-btn-forbidden-roles = Cargos Proibidos

# Missões
config-btn-toggle-quest-summary = Alternar Resumo de Missão
config-btn-toggle-player-experience = Alternar Experiência do Jogador
config-btn-toggle-display = Alternar Exibição
config-btn-purge-player-board = Limpar Quadro de Jogadores
config-btn-add-modify-rewards = Adicionar/Modificar Recompensas

# Moeda
config-btn-add-denomination = Adicionar Denominação
config-btn-add-new-currency = Adicionar Nova Moeda
config-btn-remove-currency = Remover Moeda

# Lojas - criação
config-btn-add-shop-wizard = Adicionar Loja (Assistente)
config-btn-add-shop-json = Adicionar Loja (JSON)
config-btn-edit-shop-wizard = Editar Loja (Assistente)
config-btn-edit-shop-json = Editar Loja (JSON)
config-btn-remove-shop = Remover Loja
config-btn-add-item = Adicionar Item
config-btn-edit-shop-details = Editar Detalhes da Loja
config-btn-download-json = Baixar JSON
config-btn-done-editing = Finalizar Edição
config-btn-scan-server-configs = Escanear Configurações do Servidor
config-btn-re-scan = Re-Escanear

# Loja de novo personagem
config-btn-upload-json = Enviar JSON
config-btn-configure-new-character-wealth = Configurar Riqueza de Novo Personagem
config-btn-configure-new-character-shop = Configurar Loja de Novo Personagem
config-btn-configure-static-kits = Configurar Kits Estáticos
config-btn-new-character-settings = Configurações de Novo Personagem
config-btn-disabled-no-currency = Desativado (Sem Moeda Configurada)
config-btn-disabled-no-wealth = Desativado (Sem Riqueza Inicial Configurada)

# Kits estáticos
config-btn-create-new-kit = Criar Novo Kit
config-btn-delete-kit = Excluir Kit
config-btn-add-currency = Adicionar Moeda

# Roleplay
config-btn-toggle-rp-rewards = Alternar Recompensas de RP
config-btn-clear-channels = Limpar Canais
config-btn-edit-settings = Editar Configurações
config-btn-configure-rewards = Configurar Recompensas

# Estoque
config-btn-stock-limits = Limites de Estoque
config-btn-set-limit = Definir Limite
config-btn-edit-limit = Editar Limite
config-btn-remove-limit = Remover Limite
config-btn-configure-restock-schedule = Configurar Agenda de Reabastecimento
config-btn-back-to-shop-editor = Voltar ao Editor de Loja

# Loja de fórum
config-btn-create-new-thread = Criar Novo Tópico
config-btn-use-existing-thread = Usar Tópico Existente

# Assistente
config-btn-quit = Sair
config-btn-configure-channels = Configurar Canais
config-btn-configure-roles = Configurar Cargos
config-btn-configure-quests = Configurar Missões
config-btn-configure-players = Configurar Jogadores
config-btn-configure-currency = Configurar Moeda
config-btn-configure-rp-rewards = Configurar Recomp. RP
config-btn-configure-shops = Configurar Lojas
config-btn-new-char-setup = Config. Novo Personagem

# Títulos de modais de confirmação (passados para ConfirmModal comum)
config-modal-title-confirm-role-removal = Confirmar Remoção de Cargo
config-modal-title-confirm-removal = Confirmar Remoção
config-modal-title-confirm-currency-removal = Confirmar Remoção de Moeda
config-modal-title-confirm-shop-removal = Confirmar Remoção de Loja
config-modal-title-confirm-kit-deletion = Confirmar Exclusão de Kit
config-modal-title-confirm-remove-stock-limit = Confirmar Remoção de Limite de Estoque

# Rótulos de modal de confirmação
config-modal-label-remove-role = Remover { $roleName }?
config-modal-label-remove-denomination = Remover { $denominationName }?
config-modal-label-remove-currency = Remover { $currencyName }?
config-modal-label-shop-removal-warning = AVISO: Esta ação é irreversível!
config-modal-label-kit-deletion-warning = AVISO: Irreversível!
config-modal-label-remove-stock-limit = Digite CONFIRM para remover o limite de estoque
config-modal-placeholder-type-confirm = Digite CONFIRM

# Mensagens de erro dos botões
config-error-shop-data-not-found = Erro: Não foi possível encontrar os dados dessa loja.
config-msg-shop-json-download = Aqui está a definição JSON de {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Aqui está a definição JSON da Loja de Novo Personagem.
config-error-select-forum-first = Por favor, selecione um canal de fórum primeiro.
config-error-select-thread-first = Por favor, selecione um tópico primeiro.

# ==========================================
# MODAIS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Adicionar Nova Moeda
config-modal-label-currency-name = Nome da Moeda
config-error-currency-already-exists = Uma moeda ou denominação chamada { $name } já existe!

# RenameCurrencyModal
config-modal-title-rename-currency = Renomear Moeda
config-modal-label-new-currency-name = Novo Nome da Moeda
config-error-currency-name-exists = Uma moeda chamada "{ $name }" já existe.
config-error-denomination-name-exists = Uma denominação chamada "{ $name }" já existe.

# RenameDenominationModal
config-modal-title-rename-denomination = Renomear Denominação
config-modal-label-new-denomination-name = Novo Nome da Denominação

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Adicionar Denominação de { $currencyName }
config-modal-label-denomination-name = Nome
config-modal-placeholder-denomination-name = ex.: Prata
config-modal-label-denomination-value = Valor
config-modal-placeholder-denomination-value = ex.: 0.1
config-error-denomination-matches-currency = O nome da nova denominação não pode ser igual a uma moeda existente neste servidor! Moeda existente encontrada: "{ $existingName }".
config-error-denomination-matches-denomination = O nome da nova denominação não pode ser igual a uma denominação existente neste servidor! Denominação existente "{ $denominationName }" encontrada na moeda "{ $currencyName }".
config-error-denomination-value-exists = As denominações de uma mesma moeda devem ter valores únicos! { $denominationName } já tem esse valor atribuído.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Nomes de Cargos Proibidos
config-modal-label-names = Nomes
config-modal-placeholder-names = Insira nomes separados por vírgulas
config-msg-forbidden-roles-updated = Cargos proibidos atualizados!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Limpar Quadro de Jogadores
config-modal-label-age = Idade
config-modal-placeholder-age = Insira a idade máxima da publicação (em dias) a manter
config-msg-posts-purged = Publicações com mais de { $days } dias foram removidas!

# GMRewardsModal
config-modal-title-gm-rewards = Adicionar/Modificar Recompensas do MJ
config-modal-label-experience = Experiência
config-modal-placeholder-enter-number = Digite um número
config-modal-label-items = Itens
config-modal-placeholder-items =
    Nome: Quantidade
    Nome2: Quantidade
    etc.
config-error-experience-invalid = A experiência deve ser um número inteiro válido (ex.: 2000).
config-error-item-format-invalid = Formato de item inválido: "{ $item }". Cada item deve estar em uma nova linha, no formato "Nome: Quantidade".

# ConfigShopDetailsModal
config-modal-title-shop-details = Adicionar/Editar Detalhes da Loja
config-modal-label-shop-channel = Selecione um canal
config-modal-placeholder-shop-channel = Selecione o canal para esta loja
config-modal-label-shop-name = Nome da Loja
config-modal-placeholder-shop-name = Insira o nome da loja
config-modal-label-shopkeeper-name = Nome do Lojista
config-modal-placeholder-shopkeeper-name = Insira o nome do lojista
config-modal-label-shop-description = Descrição da Loja
config-modal-placeholder-shop-description = Insira uma descrição para a loja
config-modal-label-shop-image-url = URL da Imagem da Loja
config-modal-placeholder-shop-image-url = Insira uma URL para a imagem da loja
config-error-no-channel-selected = Nenhum canal selecionado para a loja.
config-error-shop-already-in-channel = Uma loja já está registrada no canal selecionado. Escolha um canal diferente ou edite a loja existente.

# build_shop_header_view
config-label-shopkeeper = {"**"}Lojista:{"**"} { $name }
config-msg-use-shop-command = Use o comando `/shop` para navegar e comprar itens.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Criar Loja em Tópico de Fórum
config-modal-label-thread-name = Nome do Tópico
config-modal-placeholder-thread-name = Insira o nome para o tópico da loja
config-error-forum-not-found = Não foi possível encontrar o canal de fórum selecionado.
config-error-shop-already-in-thread = Uma loja já está registrada neste tópico. Isso não deveria acontecer para um novo tópico.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Adicionar Nova Loja via JSON
config-modal-label-upload-json = Envie um arquivo .json contendo os dados da loja
config-error-no-json-uploaded = Nenhum arquivo JSON enviado para a loja.
config-error-file-must-be-json = O arquivo enviado deve ser um arquivo JSON (.json).
config-error-invalid-json = Formato JSON inválido: { $error }
config-error-json-validation-failed = O JSON não está em conformidade com o esquema: { $error }

# ShopItemModal
config-modal-title-shop-item = Adicionar/Editar Item da Loja
config-modal-label-item-name = Nome do Item
config-modal-placeholder-item-name = Insira o nome do item
config-modal-label-item-description = Descrição do Item
config-modal-placeholder-item-description = Insira uma descrição para o item
config-modal-label-item-quantity = Quantidade do Item
config-modal-placeholder-item-quantity = Insira a quantidade vendida por compra
config-modal-label-item-costs = Custos do Item
config-modal-placeholder-item-costs = Ex.: 10 ouro + 5 prata\nOU: 50 rep\n(Use + para E, Novas Linhas para OU)
config-error-item-quantity-positive = A quantidade do item deve ser um número inteiro positivo.
config-error-cost-format-invalid = Formato de custo inválido na opção: "{ $option }". Cada custo deve ter um valor e uma moeda separados por espaço, ex.: "10 ouro".
config-error-cost-amount-invalid = Valor inválido "{ $amount }" para moeda: "{ $currency }". O valor deve ser um número positivo.
config-error-unknown-currency = Moeda desconhecida `{ $currency }`. Use uma moeda válida configurada para este servidor.
config-error-item-already-exists = Um item chamado { $itemName } já existe nesta loja.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Atualizar Loja via JSON
config-modal-label-upload-new-json = Envie uma nova definição JSON
config-error-no-file-uploaded = Nenhum arquivo foi enviado.
config-error-file-must-be-json-ext = O arquivo deve ser um `.json`.
config-error-json-validation-message = Validação JSON falhou: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Adicionar/Editar Equipamento de Novo Personagem
config-modal-placeholder-item-quantity-selection = Insira a quantidade recebida por seleção
config-modal-label-item-cost = Custo do Item
config-error-cost-format-short = Formato de custo inválido: '{ $component }'. Esperado 'Valor Moeda'.
config-error-amount-invalid-short = Valor inválido '{ $amount }' para moeda '{ $currency }'.
config-error-item-exists-new-char = Um item chamado { $itemName } já existe na loja de Novo Personagem.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Enviar Loja de Novo Personagem (JSON)
config-error-no-json-uploaded-short = Nenhum arquivo JSON enviado.
config-error-json-must-have-shopstock = O JSON deve conter um array 'shopStock'.
config-error-items-must-have-name-price = Todos os itens devem ter 'name' e 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Definir Riqueza de Novo Personagem
config-modal-label-amount = Valor
config-modal-placeholder-amount = Insira o valor desta moeda.
config-modal-placeholder-currency-name = Insira o nome de uma moeda definida neste servidor
config-error-no-currencies-configured = Nenhuma moeda está configurada neste servidor.
config-error-currency-not-found = Moeda ou denominação chamada { $name } não encontrada. Use uma moeda válida.

# CreateStaticKitModal
config-modal-title-create-kit = Criar Novo Kit Estático
config-modal-label-kit-name = Nome do Kit
config-modal-placeholder-kit-name = ex.: Kit Iniciante Guerreiro
config-modal-label-description = Descrição
config-modal-placeholder-kit-description = Descrição opcional para este kit
config-error-kit-name-exists = Um kit estático chamado "{ $kitName }" já existe. Escolha um nome diferente.

# StaticKitItemModal
config-modal-title-kit-item = Adicionar/Editar Item do Kit
config-modal-placeholder-kit-item-quantity = Insira a quantidade deste item a ser incluída no kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Adicionar Moeda ao Kit
config-modal-placeholder-currency-eg = ex.: Ouro
config-modal-placeholder-amount-eg = ex.: 100
config-error-amount-must-be-number = O valor deve ser um número.
config-error-no-currencies-on-server = Nenhuma moeda configurada no servidor.
config-error-currency-not-found-short = Moeda "{ $currency }" não encontrada.
config-error-denomination-not-found = Denominação "{ $denomination }" não encontrada na configuração de moeda.

# RoleplaySettingsModal
config-modal-title-rp-settings = Configurações de Roleplay
config-modal-label-min-message-length = Comprimento Mínimo da Mensagem (caracteres)
config-modal-placeholder-min-message-length = Nº de caracteres necessários para uma mensagem ser elegível. 0 para sem limite
config-modal-label-cooldown = Tempo de Espera (segundos)
config-modal-placeholder-cooldown = Tempo de espera, em segundos, entre contar mensagens como elegíveis para recompensas
config-modal-label-message-threshold = Limite de Mensagens
config-modal-placeholder-message-threshold = Número de mensagens necessárias para acionar recompensa
config-modal-label-frequency = Frequência (nº de mensagens)
config-modal-placeholder-frequency = Número de mensagens elegíveis necessárias para ganhar recompensas
config-error-min-length-invalid = O comprimento mínimo da mensagem deve ser um número inteiro não negativo.
config-error-cooldown-invalid = O tempo de espera deve ser um número inteiro não negativo.
config-error-threshold-invalid = O limite de mensagens deve ser um número inteiro positivo.
config-error-frequency-invalid = A frequência deve ser um número inteiro positivo.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Configurar Recompensas de Roleplay
config-modal-label-items-name-quantity = Itens (Nome: Quantidade)
config-modal-label-currency-name-amount = Moeda (Nome: Valor)
config-error-experience-non-negative = A experiência deve ser um número inteiro não negativo.
config-error-item-quantity-positive-named = A quantidade do item "{ $itemName }" deve ser um número inteiro positivo.
config-error-currency-amount-positive = O valor da moeda "{ $currencyName }" deve ser um número positivo.

# SetItemStockModal
config-modal-title-stock-limit = Limite de Estoque: { $itemName }
config-modal-label-max-stock = Estoque Máximo
config-modal-placeholder-max-stock = Insira o estoque máximo (ex.: 10)
config-modal-label-current-stock = Estoque Atual
config-modal-placeholder-current-stock = Insira o estoque disponível atual
config-error-max-stock-positive = O estoque máximo deve ser um número inteiro positivo.
config-error-current-stock-non-negative = O estoque atual deve ser um número inteiro não negativo.
config-error-current-exceeds-max = O estoque atual não pode exceder o estoque máximo.
config-error-item-not-in-shop = Item "{ $itemName }" não encontrado na loja.

# RestockScheduleModal
config-modal-title-restock-schedule = Configurar Agenda de Reabastecimento
config-modal-label-schedule = Agenda (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Insira: hourly, daily, weekly ou none
config-modal-label-time = Horário (HH:MM em UTC)
config-modal-desc-current-time = Horário atual: { $utcTime }
config-modal-placeholder-time = ex.: 14:30 para 14:30 UTC
config-modal-label-day-of-week = Dia da Semana (0=Seg, 6=Dom) - Apenas semanal
config-modal-placeholder-day-of-week = Insira 0-6 (Segunda=0, Domingo=6)
config-modal-label-mode = Modo (full/incremental)
config-modal-placeholder-mode = full = resetar ao máximo, incremental = adicionar quantidade
config-modal-label-increment = Quantidade Incremental (para modo incremental)
config-modal-placeholder-increment = Quantidade a adicionar por ciclo de reabastecimento
config-error-schedule-invalid = A agenda deve ser uma de: hourly, daily, weekly ou none.
config-error-time-format-invalid = O horário deve estar no formato HH:MM (ex.: 14:30).
config-error-day-of-week-invalid = O dia da semana deve ser 0-6 (Segunda=0, Domingo=6).
config-error-mode-invalid = O modo deve ser "full" ou "incremental".
config-error-increment-positive = A quantidade incremental deve ser um número inteiro positivo.

# ==========================================
# SELEÇÕES
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Procure seu Canal de { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Escolha seu Cargo de Anúncio de Missão

# AddGMRoleSelect
config-select-placeholder-gm-roles = Escolha seu(s) Cargo(s) de MJ

# ConfigWaitListSelect
config-select-placeholder-wait-list = Selecione o tamanho da Lista de Espera
config-select-option-disabled = 0 (Desativado)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Selecione o Modo de Inventário
config-select-option-disabled-label = Desativado
config-select-desc-disabled = Jogadores começam com inventários vazios.
config-select-option-selection = Seleção
config-select-desc-selection = Jogadores escolhem itens livremente da Loja de Novo Personagem.
config-select-option-purchase = Compra
config-select-desc-purchase = Jogadores compram itens da Loja de Novo Personagem com uma quantidade de moeda fornecida.
config-select-option-open = Aberto
config-select-desc-open = Jogadores inserem manualmente seus próprios inventários.
config-select-option-static = Estático
config-select-desc-static = Jogadores recebem um inventário inicial predefinido.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Selecione Canais Elegíveis

# RoleplayModeSelect
config-select-placeholder-rp-mode = Selecione o Modo
config-select-option-scheduled = Agendado
config-select-desc-scheduled = Recompensas são concedidas uma vez dentro de um período de reset especificado.
config-select-option-accrued = Acumulado
config-select-desc-accrued = Recompensas são concedidas repetidamente com base nos níveis de atividade especificados.

# RoleplayResetSelect
config-select-placeholder-reset-period = Selecione o Período de Reset
config-select-option-hourly = A cada Hora
config-select-desc-hourly = Reseta a cada hora.
config-select-option-daily = Diário
config-select-desc-daily = Reseta a cada 24 horas.
config-select-option-weekly = Semanal
config-select-desc-weekly = Reseta a cada 7 dias.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Selecione o Dia de Reset

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Selecione o Horário de Reset (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Selecione um canal de fórum

# ForumThreadSelect
config-select-placeholder-thread = Selecione um tópico
config-select-option-no-threads = Nenhum tópico ativo encontrado
config-select-desc-no-threads = Crie um novo tópico ou verifique tópicos arquivados
config-select-option-select-forum-first = Selecione um fórum primeiro
config-select-desc-select-forum-first = Selecione um canal de fórum acima
config-select-desc-thread-id = ID do Tópico: { $threadId }
config-error-select-valid-thread = Selecione um tópico válido ou crie um novo.
config-error-thread-not-found = Não foi possível encontrar o tópico selecionado. Ele pode ter sido excluído ou arquivado.

# ==========================================
# VIEWS
# ==========================================

## Menu Principal
config-title-main-menu = Configuração do Servidor - Menu Principal
config-menu-config-wizard = Assistente de Configuração
config-menu-desc-config-wizard = Valide se seu servidor está pronto para usar o ReQuest com um escaneamento rápido.
config-menu-channels = Canais
config-menu-desc-channels = Defina canais designados para publicações do ReQuest.
config-menu-currency = Moeda
config-menu-desc-currency = Configurações globais de moeda.
config-menu-players = Jogadores
config-menu-desc-players = Configurações globais de jogadores, como rastreamento de pontos de experiência.
config-menu-quests = Missões
config-menu-desc-quests = Configurações globais de missões, como listas de espera.
config-menu-rp-rewards = Recompensas de RP
config-menu-desc-rp-rewards = Configurar recompensas de roleplay.
config-menu-roles = Cargos
config-menu-desc-roles = Opções de configuração para cargos com ping ou privilegiados.
config-menu-shops = Lojas
config-menu-desc-shops = Configurar lojas personalizadas.
config-menu-language = Idioma
config-menu-desc-language = Definir o idioma padrão para este servidor.

## View do Assistente
config-title-wizard = {"**"}Configuração do Servidor - Assistente{"**"}
config-wizard-intro =
    {"**"}Bem-vindo ao Assistente de Configuração do ReQuest!{"**"}

    Este assistente ajudará você a garantir que seu servidor esteja configurado corretamente para usar os recursos do ReQuest.
    Ele escaneará suas configurações atuais e fornecerá recomendações para quaisquer ajustes necessários.

    Use o botão "Iniciar Escaneamento" abaixo para começar o processo de validação. Quando o escaneamento for concluído,
    você receberá um relatório detalhado da configuração do seu servidor junto com quaisquer alterações recomendadas.

# Assistente - Validação de Permissões do Bot
config-wizard-bot-permissions-header = __{"**"}Permissões Globais do Bot{"**"}__
config-wizard-bot-permissions-desc = Esta seção verifica se o ReQuest tem as permissões corretas para funcionar corretamente.
config-wizard-bot-role = Cargo do Bot: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ AVISOS ENCONTRADOS{"**"}
config-wizard-missing-perm = - ⚠️ Ausente: `{ $permissionName }`
config-wizard-ensure-permissions = Certifique-se de que o cargo mais alto do bot tenha essas permissões concedidas globalmente.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = O bot tem todas as permissões globais necessárias.
config-wizard-status-scan-failed = {"**"}Status: ❌ ESCANEAMENTO FALHOU{"**"}
config-wizard-scan-error = Ocorreu um erro inesperado ao verificar as permissões do bot.
config-wizard-error-type = Erro: { $errorType }
config-wizard-required-permissions = {"**"}Permissões Necessárias para o Cargo do Bot:{"**"}

# Assistente - Nomes de permissões
config-wizard-perm-view-channels = Ver Canais
config-wizard-perm-manage-roles = Gerenciar Cargos
config-wizard-perm-send-messages = Enviar Mensagens
config-wizard-perm-attach-files = Anexar Arquivos
config-wizard-perm-add-reactions = Adicionar Reações
config-wizard-perm-use-external-emoji = Usar Emoji Externo
config-wizard-perm-manage-messages = Gerenciar Mensagens
config-wizard-perm-read-message-history = Ler Histórico de Mensagens

# Assistente - Validação de Cargos
config-wizard-role-header = __{"**"}Configurações de Cargos{"**"}__
config-wizard-role-desc =
    Esta seção verifica o seguinte:

    - Cargos de MJ (obrigatório) e Cargo de Anúncio (opcional) estão configurados.
    - O cargo padrão (@everyone) tem as permissões necessárias para os usuários acessarem os recursos do bot.
    - O cargo padrão (@everyone) não tem permissões perigosas.
    - Os cargos de MJ e Anúncio são verificados para escalações de permissão além do cargo padrão.

    Quaisquer avisos aqui são apenas recomendações baseadas em uma configuração padrão. Dependendo das necessidades do seu servidor, você pode ter motivos para desconsiderar algumas dessas recomendações.

config-wizard-default-role-label = {"**"}Cargo Padrão:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Permissões Perigosas Encontradas:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Permissão Ausente: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Cargos de MJ:{"**"}
config-wizard-no-gm-roles = - ⚠️ Nenhum Cargo de MJ Configurado
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Cargo Configurado Não Encontrado/Excluído do Servidor
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Cargo de Anúncio:{"**"}
config-wizard-no-announcement-role = - ℹ️ Nenhum Cargo de Anúncio Configurado
config-wizard-announcement-role-not-found = - ⚠️ Cargo Configurado Não Encontrado/Excluído do Servidor
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Escalações de Permissão Detectadas - { $escalations }
config-wizard-escalation-more = , e mais { $count }...

# Assistente - Permissões Padrão Necessárias
config-wizard-perm-send-messages-in-threads = Enviar Mensagens em Tópicos
config-wizard-perm-use-application-commands = Usar Comandos de Aplicação

# Assistente - Permissões Perigosas
config-wizard-perm-manage-channels = Gerenciar Canais
config-wizard-perm-manage-webhooks = Gerenciar Webhooks
config-wizard-perm-manage-server = Gerenciar Servidor
config-wizard-perm-manage-nicknames = Gerenciar Apelidos
config-wizard-perm-kick-members = Expulsar Membros
config-wizard-perm-ban-members = Banir Membros
config-wizard-perm-timeout-members = Silenciar Membros
config-wizard-perm-mention-everyone = Mencionar @everyone
config-wizard-perm-manage-threads = Gerenciar Tópicos
config-wizard-perm-administrator = Administrador

# Assistente - Validação de Canais
config-wizard-channel-header = __{"**"}Configurações de Canais{"**"}__
config-wizard-channel-desc =
    Esta seção verifica o seguinte:

    - Canais configurados existem.
    - O bot tem permissão para ver e enviar mensagens nos canais configurados.
    - O cargo padrão (@everyone) não tem permissões de `Enviar Mensagens`.

config-wizard-channel-no-config-required = - ⚠️ Nenhum Canal Configurado
config-wizard-channel-not-configured = - ℹ️ Não Configurado (Opcional)
config-wizard-channel-not-found = - ⚠️ Canal Configurado Não Encontrado/Excluído do Servidor
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } não consegue ver este canal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } não consegue enviar mensagens neste canal.
config-wizard-everyone-can-send = - ⚠️ @everyone pode enviar mensagens neste canal.

# Assistente - Nomes de canais
config-wizard-channel-quest-board = Quadro de Missões
config-wizard-channel-player-board = Quadro de Jogadores
config-wizard-channel-quest-archive = Arquivo de Missões
config-wizard-channel-gm-transaction-log = Log de Transações do MJ
config-wizard-channel-player-transaction-log = Log de Transações do Jogador
config-wizard-channel-shop-log = Log da Loja
config-wizard-channel-approval-queue = Fila de Aprovação de Personagens

# Assistente - Painel
config-wizard-dashboard-header = __{"**"}Painel de Configurações{"**"}__
config-wizard-dashboard-desc = Esta seção fornece uma visão geral das configurações não essenciais para referência rápida.
config-wizard-quest-settings = {"**"}Configurações de Missão{"**"}
config-wizard-quest-wait-list = - Tamanho da Lista de Espera: { $size }
config-wizard-quest-summary = - Resumo de Missão: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Recompensas do MJ (Por Missão){"**"}
config-wizard-player-settings = {"**"}Configurações do Jogador{"**"}
config-wizard-player-experience = - Experiência do Jogador: { $status }
config-wizard-currency-settings = {"**"}Configurações de Moeda{"**"}
config-wizard-rp-rewards = {"**"}Recompensas de Roleplay{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Modo: { $mode }
config-wizard-rp-channels = - Canais Monitorados: { $count }
config-wizard-shops = {"**"}Lojas{"**"}
config-wizard-shops-count = - Lojas Configuradas: { $count }
config-wizard-shops-more = - ...e mais { $count }
config-wizard-new-char-setup = {"**"}Configuração de Novo Personagem{"**"}
config-wizard-inventory-type = - Tipo de Inventário: { $type }
config-wizard-new-char-shop-items = - Itens da Loja de Novo Personagem: { $count }
config-wizard-static-kits = - Kits Estáticos: { $count }

# Assistente - Relatório de Recompensas do MJ
config-wizard-no-currencies = - ℹ️ Nenhuma Moeda Configurada
config-wizard-configured-currencies = {"**"}Moedas Configuradas:{"**"}
config-wizard-no-denominations = - Nenhuma Denominação Configurada
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Desativado
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Ativado
config-wizard-gm-rewards-experience = - Experiência: { $xp }
config-wizard-gm-rewards-items = - Itens:
config-wizard-unnamed-shop = Loja Sem Nome

## View de Cargos
config-title-roles = {"**"}Configuração do Servidor - Cargos{"**"}
config-label-announcement-role = {"**"}Cargo de Anúncio:{"**"} { $status }
config-desc-announcement-role = Este cargo é mencionado quando uma missão é publicada.
config-label-announcement-role-default = {"**"}Cargo de Anúncio:{"**"} Não Configurado
config-label-gm-roles = {"**"}Cargo(s) de MJ:{"**"} { $roles }
config-desc-gm-roles = Esses cargos concederão acesso aos comandos e recursos de Mestre de Jogo.
config-label-gm-roles-default = {"**"}Cargo(s) de MJ:{"**"} Não Configurado
config-title-forbidden-roles = __{"**"}Cargos Proibidos{"**"}__
config-desc-forbidden-roles =
    Configura uma lista de nomes de cargos que não podem ser usados pelos Mestres de Jogo para seus cargos de grupo.
    Por padrão, `everyone`, `administrator`, `gm` e `game master` não podem ser usados. Esta configuração
    estende essa lista.

## View de Remoção de Cargo de MJ
config-title-remove-gm-roles = {"**"}Configuração do Servidor - Remover Cargo(s) de MJ{"**"}
config-msg-no-gm-roles = Nenhum cargo de MJ configurado.

## View de Canais
config-title-channels = {"**"}Configuração do Servidor - Canais{"**"}

config-label-quest-board = {"**"}Quadro de Missões:{"**"} { $channel }
config-desc-quest-board = O canal onde novas missões/missões ativas serão publicadas.
config-label-quest-board-default = {"**"}Quadro de Missões:{"**"} Não Configurado

config-label-player-board = {"**"}Quadro de Jogadores:{"**"} { $channel }
config-desc-player-board = Um quadro opcional de anúncios/mensagens para uso pelos jogadores.
config-label-player-board-default = {"**"}Quadro de Jogadores:{"**"} Não Configurado

config-label-quest-archive = {"**"}Arquivo de Missões:{"**"} { $channel }
config-desc-quest-archive = Um canal opcional onde missões completadas serão movidas, com informações de resumo.
config-label-quest-archive-default = {"**"}Arquivo de Missões:{"**"} Não Configurado

config-label-gm-transaction-log = {"**"}Log de Transações do MJ:{"**"} { $channel }
config-desc-gm-transaction-log = Um canal opcional onde transações do MJ (ex.: comandos Modificar Jogador) são registradas.
config-label-gm-transaction-log-default = {"**"}Log de Transações do MJ:{"**"} Não Configurado

config-label-player-transaction-log = {"**"}Log de Transações do Jogador:{"**"} { $channel }
config-desc-player-transaction-log = Um canal opcional onde transações de jogadores como trocas e consumo de itens são registradas.
config-label-player-transaction-log-default = {"**"}Log de Transações do Jogador:{"**"} Não Configurado

config-label-shop-log = {"**"}Log da Loja:{"**"} { $channel }
config-desc-shop-log = Um canal opcional onde transações da loja são registradas.
config-label-shop-log-default = {"**"}Log da Loja:{"**"} Não Configurado

## View de Missões
config-title-quests = {"**"}Configuração do Servidor - Missões{"**"}

config-label-wait-list = {"**"}Tamanho da Lista de Espera:{"**"} { $size }
config-desc-wait-list = Uma lista de espera permite que o número especificado de jogadores entre na fila para uma missão que está cheia, caso um jogador desista.
config-label-wait-list-disabled = {"**"}Tamanho da Lista de Espera:{"**"} Desativado

config-label-quest-summary = {"**"}Resumo de Missão:{"**"} { $status }
config-desc-quest-summary = Esta opção permite que MJs forneçam um breve resumo ao encerrar missões.
config-label-quest-summary-disabled = {"**"}Resumo de Missão:{"**"} Desativado

config-label-gm-rewards = {"**"}Recompensas do MJ{"**"}
config-desc-gm-rewards = Configurar recompensas para MJs receberem ao completar missões.

## View de Recompensas do MJ
config-title-gm-rewards = {"**"}Configuração do Servidor - Recompensas do MJ{"**"}
config-desc-gm-rewards-detail =
    {"**"}Adicionar/Modificar Recompensas{"**"}
    Abre um modal de entrada para adicionar, modificar ou remover recompensas do MJ.

    > As recompensas configuradas são por missão. Toda vez que um Mestre de Jogo completar uma missão,
    receberá as recompensas configuradas abaixo no seu personagem ativo.
config-msg-no-rewards = Nenhuma recompensa configurada.
config-label-gm-experience = {"**"}Experiência:{"**"} { $xp }
config-label-gm-items = {"**"}Itens:{"**"}

## View de Jogadores
config-title-players = {"**"}Configuração do Servidor - Jogadores{"**"}

config-label-player-experience = {"**"}Experiência do Jogador:{"**"} { $status }
config-desc-player-experience = Ativa/Desativa o uso de pontos de experiência (ou progressão de personagem baseada em valores similares).
config-label-player-experience-disabled = {"**"}Experiência do Jogador:{"**"} Desativado

config-label-new-char-settings = {"**"}Configurações de Novo Personagem{"**"}
config-desc-new-char-settings = Configurar opções relacionadas a novos personagens de jogador e como seus inventários iniciais são configurados.

config-label-player-board-purge = {"**"}Limpeza do Quadro de Jogadores{"**"}
config-desc-player-board-purge = Remove publicações do quadro de jogadores (se habilitado).

## View de Configurações de Novo Personagem
config-title-new-character = {"**"}Configuração do Servidor - Configurações de Novo Personagem{"**"}

config-label-inventory-type = {"**"}Tipo de Inventário de Novo Personagem:{"**"} { $type }
config-desc-inventory-type = Determina como personagens recém-registrados inicializam seus inventários.
config-label-inventory-type-disabled = {"**"}Tipo de Inventário de Novo Personagem:{"**"} Desativado

config-label-new-char-wealth = {"**"}Riqueza de Novo Personagem:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Riqueza de Novo Personagem:{"**"} Desativado

config-label-approval-queue = {"**"}Fila de Aprovação:{"**"} { $channel }
config-desc-approval-queue = Se definido, novos personagens devem ser aprovados por um MJ neste Canal de Fórum antes de ficarem ativos.
config-label-approval-queue-disabled = {"**"}Fila de Aprovação:{"**"} Desativado
config-label-approval-queue-not-configured = {"**"}Fila de Aprovação:{"**"} Não Configurado

# Descrições de tipo de inventário (usadas na configuração)
config-desc-inv-type-disabled = Jogadores começam com inventários vazios.
config-desc-inv-type-selection = Jogadores escolhem itens livremente da Loja de Novo Personagem.
config-desc-inv-type-purchase = Jogadores compram itens da Loja de Novo Personagem com uma quantidade de moeda fornecida.
config-desc-inv-type-open = Jogadores inserem manualmente seus itens de inventário.
config-desc-inv-type-static = Jogadores recebem um inventário inicial predefinido.

## View da Loja de Novo Personagem
config-title-new-char-shop = {"**"}Configuração do Servidor - Loja de Novo Personagem{"**"}
config-label-inv-type-selection = {"**"}Tipo de Inventário:{"**"} Seleção
config-desc-inv-type-selection-shop = Jogadores escolhem itens livremente da Loja de Novo Personagem.
config-label-inv-type-purchase = {"**"}Tipo de Inventário:{"**"} Compra
config-desc-inv-type-purchase-shop = Jogadores compram itens da Loja de Novo Personagem com uma quantidade de moeda fornecida.
config-label-inv-type-other = {"**"}Tipo de Inventário:{"**"} { $type }
config-desc-inv-type-not-in-use = A Loja de Novo Personagem não está em uso.
config-msg-define-shop-items = Defina os itens da loja.
config-msg-no-items = Nenhum item configurado.

## View de Kits Estáticos
config-title-static-kits = {"**"}Configuração do Servidor - Kits Estáticos{"**"}
config-desc-create-kit = Criar uma nova definição de kit.
config-msg-no-kits = Nenhum kit configurado.
config-label-kit-more-items = ...e mais { $count } itens
config-label-empty-kit = {"*"}Kit Vazio{"*"}

## View de Edição de Kit Estático
config-title-editing-kit = {"**"}Editando Kit: { $kitName }{"**"}
config-msg-kit-empty = Este kit está vazio. Use os botões acima para adicionar moeda ou itens.
config-label-kit-currency = {"**"}Moeda:{"**"} { $display }
config-label-kit-item = {"**"}Item:{"**"} { $name }

## View de Moeda
config-title-currency = {"**"}Configuração do Servidor - Moeda{"**"}
config-desc-create-currency = Criar uma nova moeda.
config-msg-no-currencies = Nenhuma moeda configurada.
config-label-currency-display-type = Tipo de Exibição: { $type } | Denominações: { $count }
config-label-currency-type-double = Decimal
config-label-currency-type-integer = Inteiro

## View de Edição de Moeda
config-title-manage-currency = {"**"}Gerenciar Moeda: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Moeda e Denominações{"**"}__
    - O nome dado à sua moeda é considerado a moeda base e tem valor 1.
    {"```"}Exemplo: "ouro" é configurado como moeda.{"```"}
    - Adicionar uma denominação requer especificar um nome e um valor relativo à moeda base.
    {"```"}Exemplo: Ouro recebe duas denominações: prata (valor de 0.1) e cobre (valor de 0.01).{"```"}
    - Quaisquer transações envolvendo uma moeda base ou suas denominações serão convertidas automaticamente.
    {"```"}Exemplo: Um jogador tem 10 ouro e gasta 3 cobre. Seu novo saldo exibirá automaticamente
    9 ouro, 9 prata e 7 cobre.{"```"}
    - Moedas exibidas como inteiro mostrarão cada denominação, enquanto moedas exibidas como decimal
    mostrarão apenas a moeda base.
    {"```"}Exemplo: O jogador acima com exibição decimal habilitada aparecerá como 9.97 ouro.{"```"}
config-btn-toggle-display-current = Alternar Exibição (Atual: { $type })
config-msg-no-denominations = Nenhuma denominação configurada.

## View de Lojas
config-title-shops = {"**"}Configuração do Servidor - Lojas{"**"}
config-desc-add-shop-wizard = {"**"}Adicionar Loja (Assistente){"**"}\nCriar uma nova loja vazia a partir de um formulário.
config-desc-add-shop-json = {"**"}Adicionar Loja (JSON){"**"}\nCriar uma nova loja fornecendo uma definição JSON completa. (Avançado)
config-msg-no-shops = Nenhuma loja configurada.
config-label-shop-type-forum = (Fórum)
config-label-shop-channel = Canal: <#{ $channelId }>

## View de Seleção de Tipo de Canal da Loja
config-title-choose-location = {"**"}Adicionar Loja - Escolher Tipo de Localização{"**"}
config-label-text-channel = {"**"}Canal de Texto{"**"}
config-desc-text-channel = Criar uma loja em um canal de texto padrão.
config-label-forum-thread = {"**"}Tópico de Fórum{"**"}
config-desc-forum-thread = Criar uma loja em um tópico de fórum (novo ou existente).

## View de Configuração de Loja de Fórum
config-title-forum-setup = {"**"}Adicionar Loja - Configuração de Tópico de Fórum{"**"}
config-label-step1 = {"**"}Passo 1: Selecione um Canal de Fórum{"**"}
config-label-step2 = {"**"}Passo 2: Escolha a Opção de Tópico{"**"}
config-label-step3 = {"**"}Passo 3: Selecione um Tópico Existente{"**"}
config-desc-create-new-thread = {"**"}Criar Novo Tópico{"**"}\nAbre um formulário para criar um novo tópico e configurar a loja.
config-label-selected-thread = {"**"}Tópico Selecionado:{"**"} { $threadName }
config-desc-click-to-configure = Clique para configurar a loja neste tópico.

## View de Gerenciamento de Loja
config-title-manage-shop = {"**"}Gerenciar Loja: { $shopName }{"**"}
config-label-shop-type = {"**"}Tipo:{"**"} { $type }
config-label-shop-type-text = Canal de Texto
config-label-shop-type-forum-thread = Tópico de Fórum
config-label-shopkeeper = {"**"}Lojista:{"**"} { $name }
config-label-shop-description = {"**"}Descrição:{"**"} { $description }
config-label-shop-channel-info = {"**"}Canal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Editar detalhes e itens da loja via Assistente.
config-desc-upload-json = Enviar uma nova definição JSON para esta loja.
config-desc-download-json = Baixar a definição JSON atual.
config-desc-remove-shop = Remover permanentemente esta loja.

## View de Edição de Loja
config-title-editing-shop = {"**"}Editando Loja: { $shopName }{"**"}
config-label-shop-shopkeeper = Lojista: {"**"}{ $name }{"**"}

## View de Limites de Estoque
config-title-stock-config = {"**"}Configuração de Estoque: { $shopName }{"**"}
config-label-current-utc = Horário UTC Atual: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Agenda de Reabastecimento:{"**"} { $schedule }
config-label-restock-hourly = no minuto :{ $minute }
config-label-restock-daily = às { $time } UTC
config-label-restock-weekly = { $day } às { $time } UTC
config-label-restock-mode = {"**"}Modo:{"**"} { $mode }
config-label-restock-full = Reabastecimento completo
config-label-restock-incremental = Adicionar { $amount } por ciclo (até o máximo)
config-label-restock-disabled = {"**"}Agenda de Reabastecimento:{"**"} Desativado
config-label-item-stock-limits = {"**"}Limites de Estoque de Itens{"**"}
config-msg-no-items-in-shop = Nenhum item nesta loja.
config-label-stock-with-available = Máx: { $max } | Disponível: { $available }
config-label-stock-reserved = | Reservado: { $reserved }
config-label-stock-not-initialized = Máx: { $max } | Disponível: (não inicializado)
config-label-stock-unlimited = Estoque: Ilimitado

## View de Roleplay
config-title-roleplay = {"**"}Configuração do Servidor - Recompensas de Roleplay{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Horário do Servidor:{"**"} `{ $time }`
config-label-rp-enabled = Ativado
config-label-rp-disabled = Desativado

config-desc-rp-mode-scheduled = {"```"}Recompensas são distribuídas uma vez, ao enviar o limite necessário de mensagens elegíveis dentro do período de tempo definido (por hora, diariamente ou semanalmente).{"```"}
config-desc-rp-mode-accrued = {"```"}Recompensas são distribuídas de forma recorrente cada vez que um número definido de mensagens elegíveis é enviado.{"```"}

config-label-rp-config-details = {"**"}Detalhes da Configuração:{"**"}
config-label-rp-mode = {"**"}Modo:{"**"} { $mode }
config-label-rp-min-length = {"**"}Comprimento Mínimo da Mensagem:{"**"} { $length } caracteres
config-label-rp-cooldown = {"**"}Tempo de Espera:{"**"} { $seconds } segundos
config-label-rp-frequency-once = {"**"}Frequência:{"**"} Uma vez por { $period }
config-label-rp-reset-time = {"**"}Horário de Reset:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Limite:{"**"} { $count } mensagens elegíveis
config-label-rp-frequency-every = {"**"}Frequência:{"**"} A cada { $count } mensagens elegíveis

config-label-rp-channels = {"**"}Canais de Roleplay:{"**"}
config-msg-rp-no-channels = Nenhum configurado.
config-label-rp-channels-more = ...e mais { $count }.

config-label-rp-rewards = {"**"}Recompensas:{"**"}
config-msg-rp-no-rewards = Nenhuma configurada.
config-label-rp-experience = {"**"}Experiência:{"**"} { $xp }
config-label-rp-items = {"**"}Itens:{"**"}
config-label-rp-currency = {"**"}Moeda:{"**"}

## View de Idioma
config-title-language = {"**"}Configuração do Servidor - Idioma{"**"}
config-label-server-language = {"**"}Idioma do Servidor:{"**"} { $language }
config-label-server-language-default = {"**"}Idioma do Servidor:{"**"} Padrão (sem substituição)
config-select-placeholder-server-language = Selecione o idioma do servidor
config-select-option-default = Padrão (sem substituição)
config-select-desc-default = Usar a preferência de cada usuário ou o idioma do Discord.
