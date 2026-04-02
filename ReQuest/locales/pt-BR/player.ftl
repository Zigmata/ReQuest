## Player module strings

# --- Cog ---

player-cmd-name = Trocar
player-cmd-desc = Menus do Jogador

# --- Buttons ---

# Character management
player-btn-register-character = Registrar Novo Personagem
player-btn-activate = Ativar
player-btn-active = Ativo

# Player board
player-btn-create-post = Criar Publicação
player-btn-open-starting-shop = Abrir Loja Inicial
player-btn-select-kit = Selecionar Kit
player-btn-input-inventory = Inserir Inventário

# Wizard / shop buttons
player-btn-add-to-cart = Adicionar ao Carrinho
player-btn-add-to-cart-cost = Adicionar ao Carrinho ({ $costString })
player-btn-view-purchase-options = Ver Opções de Compra
player-btn-review-submit = Revisar e Enviar ({ $count })
player-btn-submit-character = Enviar Personagem
player-btn-keep-shopping = Continuar Comprando
player-btn-edit-quantity = Editar Quantidade
player-btn-clear-cart = Limpar Carrinho

# Kit buttons
player-btn-confirm-selection = Confirmar Seleção
player-btn-back-to-kits = Voltar para Kits

# Inventory management
player-btn-spend-currency = Gastar Moeda
player-btn-print-inventory = Exibir Inventário

# Container management
player-btn-manage-containers = Gerenciar Contêineres
player-btn-create-new = + Criar Novo
player-btn-consume-destroy = Consumir/Destruir
player-btn-move = Mover
player-btn-move-all = Mover tudo
player-btn-move-some = Mover parte...
player-btn-back-to-overview = ← Voltar à Visão Geral
player-btn-cancel-move = ← Cancelar
player-btn-up = ▲ Subir
player-btn-down = ▼ Descer

# --- Modals ---

# Trade modal
player-modal-title-trade = Trocando com { $targetName }
player-modal-label-trade-name = Nome
player-modal-placeholder-trade-name = Insira o nome do item que você está trocando
player-modal-label-trade-quantity = Quantidade
player-modal-placeholder-trade-quantity = Insira a quantidade que deseja trocar

# Character register modal
player-modal-title-register = Registrar Novo Personagem
player-modal-label-char-name = Nome
player-modal-placeholder-char-name = Insira o nome do seu personagem.
player-modal-label-char-note = Nota
player-modal-placeholder-char-note = Insira uma nota para identificar seu personagem

# Open inventory input modal
player-modal-title-starting-inventory = Inserção de Inventário Inicial
player-modal-label-inventory = Inventário
player-modal-placeholder-inventory-input =
    Um por linha no formato <nome>: <quantidade> por exemplo:
    Espada: 1
    ouro: 30

# Spend currency modal
player-modal-title-spend-currency = Gastar Moeda
player-modal-label-currency-name = Nome da Moeda
player-modal-placeholder-currency-name = Insira o nome da moeda que deseja gastar
player-modal-label-currency-amount = Quantidade
player-modal-placeholder-currency-amount = Insira a quantidade a gastar

# Create player post modal
player-modal-title-create-post = Criar Publicação no Quadro de Jogadores
player-modal-label-post-title = Título
player-modal-placeholder-post-title = Insira um título para sua publicação
player-modal-label-post-content = Conteúdo da publicação
player-modal-placeholder-post-content = Insira o conteúdo da sua publicação

# Edit player post modal
player-modal-title-edit-post = Editar Publicação do Quadro de Jogadores

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Editar Quantidade no Carrinho
player-modal-label-cart-qty = Quantidade
player-modal-placeholder-cart-qty = Insira a nova quantidade (0 para remover)

# Create container modal
player-modal-title-create-container = Criar Novo Contêiner
player-modal-label-container-name = Nome do Contêiner
player-modal-placeholder-container-name = Insira um nome (ex: Mochila)

# Rename container modal
player-modal-title-rename-container = Renomear Contêiner
player-modal-label-new-container-name = Novo Nome do Contêiner
player-modal-placeholder-new-container-name = Insira o novo nome

# Consume from container modal
player-modal-title-consume = Consumir/Destruir Item
player-modal-label-consume-qty = Quantidade (máx: { $maxQuantity })
player-modal-placeholder-consume-qty = Insira a quantidade a consumir/destruir

# Move item quantity modal
player-modal-title-move-item = Mover Item
player-modal-label-move-qty = Quantidade a mover (máx: { $maxQuantity })
player-modal-placeholder-move-qty = Insira a quantidade a mover

# --- Selects ---

player-select-placeholder-no-characters = Você não possui personagens registrados
player-select-placeholder-remove-character = Selecione um personagem para remover
player-select-placeholder-post = Selecione uma publicação
player-select-placeholder-container-view = Selecione um contêiner para ver...
player-select-placeholder-item = Selecione um item...
player-select-placeholder-destination = Selecione um destino...
player-select-placeholder-container = Selecione um contêiner...
player-select-option-no-containers = Nenhum contêiner
player-select-option-no-items = Nenhum item
player-select-option-no-destinations = Nenhum destino

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Comandos do Jogador - Menu Principal{"**"}
player-menu-btn-characters = Personagens
player-menu-desc-characters = Registrar, visualizar e ativar personagens.
player-menu-btn-inventory = Inventário
player-menu-desc-inventory = Visualizar o inventário do personagem ativo e gastar moeda.
player-menu-btn-player-board = Quadro de Jogadores
player-menu-btn-player-board-disabled = Quadro de Jogadores (Não configurado)
player-menu-desc-player-board = Criar uma publicação para o Quadro de Jogadores

# CharacterBaseView
player-title-characters = {"**"}Comandos do Jogador - Personagens{"**"}
player-desc-register-character = Registrar um Novo Personagem.
player-msg-no-characters = Você não possui personagens registrados.
player-label-active = (Ativo)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Personagem em andamento: { $characterName }{"**"}
    O registro do seu personagem aguarda a configuração do inventário.
player-btn-resume = Retomar
player-btn-discard = Descartar
player-modal-title-discard-character = Descartar personagem
player-modal-label-discard-confirm = Descartar { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Confirmar Remoção de Personagem
player-modal-label-confirm-char-delete = Excluir { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Confirmar Remoção da Publicação
player-modal-label-post-removal-warning = AVISO: Esta ação é irreversível!

# InventoryOverviewView
player-title-inventory = {"**"}Comandos do Jogador - Inventário{"**"}
player-title-char-inventory = {"**"}Inventário de { $characterName }{"**"}
player-msg-no-active-character = Nenhum Personagem Ativo: Ative um personagem neste servidor para usar estes menus.
player-msg-no-characters-registered = Nenhum Personagem: Registre um personagem para usar estes menus.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } itens
player-label-currency = {"**"}Moeda{"**"}
player-msg-inventory-empty = O inventário está vazio.

# Print inventory embed
player-embed-title-inventory = Inventário de { $characterName }

# ContainerItemsView
player-msg-container-empty = Este contêiner está vazio.
player-label-selected-item = Selecionado: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Mover "{ $itemName }"{"**"} ({ $available } disponíveis)
player-msg-no-other-containers = Nenhum outro contêiner disponível.
player-msg-select-destination = Selecione o contêiner de destino:
player-label-destination = Destino: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Gerenciar Contêineres{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } itens){ $suffix }
player-label-default-suffix = { " " }(padrão)
player-msg-no-containers = Nenhum contêiner.
player-label-selected-container = Selecionado: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Confirmar Exclusão de Contêiner
player-modal-label-container-has-items = Possui { $itemCount } itens. Serão movidos para Itens soltos.
player-modal-label-confirm-container-delete = Excluir "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Não é possível renomear Itens soltos.
player-error-cannot-delete-loose = Não é possível excluir Itens soltos.

# PlayerBoardView
player-title-player-board = {"**"}Comandos do Jogador - Quadro de Jogadores{"**"}
player-desc-create-post = Criar uma nova publicação para o Quadro de Jogadores.
player-msg-no-posts = Você não possui publicações atualmente.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID da Publicação: { $postId }
player-error-board-channel-not-found = Canal do Quadro de Jogadores não encontrado.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configurar inventário de { $characterName }{"**"}
player-desc-browse-shop = Explore a loja inicial para equipar seu personagem.
player-desc-select-kit = Selecione um kit inicial.
player-desc-input-inventory = Insira manualmente seu inventário inicial.

# StaticKitSelectView
player-title-select-kit = {"**"}Selecionar kit para { $characterName }{"**"}
player-msg-no-kits = Nenhum kit inicial disponível.
player-label-and-more-items = ...e mais { $count } itens
player-label-empty-kit = {"*"}Kit Vazio{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Confirmar Seleção: { $kitName }{"**"}
player-label-items-heading = {"**"}Itens:{"**"}
player-label-currency-heading = {"**"}Moeda:{"**"}
player-msg-kit-empty = Este kit está vazio.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opções de Compra: { $itemName }{"**"}
player-msg-no-cost-options = Este item não possui opções de custo disponíveis.
player-label-cost-option = {"**"}Opção { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Loja Inicial ({ $inventoryType }){"**"}
player-label-starting-wealth = Riqueza Inicial: { $formattedCurrency }
player-label-in-cart = {"**"}(No Carrinho: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Revisar Carrinho{"**"}
player-msg-cart-empty = Seu carrinho está vazio.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } insuficiente
player-label-total-cost = {"**"}Custo Total:{"**"}
player-label-total-cost-free = {"**"}Custo Total:{"**"} Grátis
player-label-cart-page = Página { $current } de { $total }

# Trade embed
player-embed-title-trade = Relatório de Troca
player-embed-desc-trade-sender = Remetente: { $senderMention } como `{ $senderCharacter }`
player-embed-desc-trade-recipient = Destinatário: { $recipientMention } como `{ $recipientCharacter }`
player-embed-field-currency = Moeda
player-embed-field-amount = Montante
player-embed-field-balance = Saldo de { $characterName }
player-embed-field-item = Item
player-embed-field-quantity = Quantidade
player-embed-footer-transaction-id = ID da Transação: { $transactionId }

# Trade errors
player-error-trade-no-characters = O jogador com quem você está tentando trocar não possui personagens!
player-error-trade-no-active = O jogador com quem você está tentando trocar não possui um personagem ativo neste servidor!

# Spend currency embed
player-embed-title-spend = Relatório de Transação do Jogador
player-embed-desc-spend-player = Jogador: { $playerMention } como `{ $characterName }`
player-embed-desc-spend-transaction = Transação: {"**"}{ $characterName }{"**"} gastou {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canal
player-embed-field-receipt = Recibo

# Spend currency errors
player-error-amount-not-number = A quantidade deve ser um número.
player-error-amount-positive = Você deve gastar um valor positivo.
player-error-amount-exceeds-maximum = O valor não pode exceder { $max }.
player-error-no-active-character-server = Você não possui um personagem ativo neste servidor.
player-error-no-currency-config = Nenhuma configuração de moeda encontrada para este servidor.

# Consume item embed
player-embed-title-consume = Relatório de Consumo de Item
player-embed-desc-consume = Jogador: { $playerMention } como `{ $characterName }`
player-embed-desc-consume-removed = Removido: {"**"}{ $quantity }x { $itemName }{"**"} de {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = A quantidade deve ser um número inteiro positivo.
player-error-qty-at-least-one = A quantidade deve ser no mínimo 1.
player-error-qty-only-have = Você possui apenas { $maxQuantity } deste item.

# Inventory input errors
player-error-invalid-format = Formato inválido: "{ $line }". Use <nome>: <quantidade>.
player-error-empty-name = O nome do item não pode estar vazio na linha: "{ $line }".
player-error-invalid-quantity = Quantidade inválida para "{ $name }": "{ $quantity }". Deve ser um número inteiro positivo.
player-error-input-errors-header = Erros na entrada de inventário:
player-msg-no-valid-items = Nenhum item válido fornecido. Inicializando inventário vazio.

# Validation error view
player-validation-error-title = Erros de entrada
player-validation-btn-retry = Tentar novamente

# Cart quantity validation
player-error-enter-valid-number = Insira um número positivo válido.

# Submission embeds (approval queue)
player-embed-title-approval = Aprovação de Inventário: { $characterName }
player-embed-desc-submitted-by = Enviado por { $userMention }
player-embed-field-items = Itens
player-embed-field-currency-received = Moeda
player-embed-footer-submission-id = ID do Envio: { $submissionId }
player-label-approval-thread = Aprovação: { $characterName }
player-embed-title-submission-sent = Envio de Inventário Realizado
player-embed-desc-submission-sent =
    Seu envio para {"**"}{ $characterName }{"**"} foi enviado para o Mestre da equipe para aprovação!
    Você será notificado quando for revisado.
    [Ver Discussão do Envio]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Inventário Inicial Aplicado
player-embed-desc-starting-inventory = Jogador: { $playerMention } como `{ $characterName }`
player-embed-field-items-received = Itens Recebidos
player-embed-field-currency-received-label = Moeda Recebida
player-label-untitled = Sem título

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Itens
player-approval-post-currency = Moeda
player-approval-resolved = Esta submissão foi resolvida.
player-approval-btn-approve = Aprovar
player-approval-btn-deny = Recusar
player-approval-btn-edit = Editar
player-approval-error-no-permission = Você não tem permissão para realizar esta ação.
player-approval-error-not-submitter = Apenas o remetente original pode editar esta submissão.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Esta submissão foi aprovada por { $approver }.
player-approval-denied-by = Esta submissão foi recusada por { $denier }.
player-approval-deny-reason = Motivo: { $reason }
player-msg-submission-updated = Sua submissão foi atualizada.


# Denial modal
player-modal-title-deny-reason = Recusar submissão
player-modal-label-deny-reason = Motivo da recusa
player-modal-placeholder-deny-reason = Opcional: explique o motivo da recusa
# Approval DM notifications
player-dm-title-approved = Personagem aprovado
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Personagem recusado
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
