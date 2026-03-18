## Strings do módulo de jogador

# --- Cog ---

player-cmd-name = Trocar
player-cmd-desc = Menus do Jogador

# --- Botões ---

# Gerenciamento de personagem
player-btn-register-character = Registrar Novo Personagem
player-btn-activate = Ativar
player-btn-active = Ativo

# Quadro de jogadores
player-btn-create-post = Criar Publicação
player-btn-open-starting-shop = Abrir Loja Inicial
player-btn-select-kit = Selecionar Kit
player-btn-input-inventory = Inserir Inventário

# Botões de assistente / loja
player-btn-add-to-cart = Adicionar ao Carrinho
player-btn-add-to-cart-cost = Adicionar ao Carrinho ({ $costString })
player-btn-view-purchase-options = Ver Opções de Compra
player-btn-review-submit = Revisar e Enviar ({ $count })
player-btn-submit-character = Enviar Personagem
player-btn-keep-shopping = Continuar Comprando
player-btn-edit-quantity = Editar Quantidade
player-btn-clear-cart = Limpar Carrinho

# Botões de kit
player-btn-confirm-selection = Confirmar Seleção
player-btn-back-to-kits = Voltar aos Kits

# Gerenciamento de inventário
player-btn-spend-currency = Gastar Moeda
player-btn-print-inventory = Imprimir Inventário

# Gerenciamento de contêineres
player-btn-manage-containers = Gerenciar Contêineres
player-btn-create-new = + Criar Novo
player-btn-consume-destroy = Consumir/Destruir
player-btn-move = Mover
player-btn-move-all = Mover Tudo
player-btn-move-some = Mover Alguns...
player-btn-back-to-overview = ← Voltar à Visão Geral
player-btn-cancel-move = ← Cancelar
player-btn-up = ▲ Subir
player-btn-down = ▼ Descer

# --- Modais ---

# Modal de troca
player-modal-title-trade = Trocando com { $targetName }
player-modal-label-trade-name = Nome
player-modal-placeholder-trade-name = Digite o nome do item que está trocando
player-modal-label-trade-quantity = Quantidade
player-modal-placeholder-trade-quantity = Digite a quantidade que está trocando

# Modal de registro de personagem
player-modal-title-register = Registrar Novo Personagem
player-modal-label-char-name = Nome
player-modal-placeholder-char-name = Digite o nome do seu personagem.
player-modal-label-char-note = Nota
player-modal-placeholder-char-note = Digite uma nota para identificar seu personagem

# Modal de inserção de inventário aberto
player-modal-title-starting-inventory = Inserção de Inventário Inicial
player-modal-label-inventory = Inventário
player-modal-placeholder-inventory-input =
    Um por linha no formato <nome>: <quantidade>, ex.:
    Espada: 1
    ouro: 30

# Modal de gastar moeda
player-modal-title-spend-currency = Gastar Moeda
player-modal-label-currency-name = Nome da Moeda
player-modal-placeholder-currency-name = Digite o nome da moeda que está gastando
player-modal-label-currency-amount = Quantidade
player-modal-placeholder-currency-amount = Digite a quantidade a gastar

# Modal de criar publicação de jogador
player-modal-title-create-post = Criar Publicação no Quadro de Jogadores
player-modal-label-post-title = Título
player-modal-placeholder-post-title = Digite um título para sua publicação
player-modal-label-post-content = Conteúdo da Publicação
player-modal-placeholder-post-content = Digite o corpo da sua publicação

# Modal de editar publicação de jogador
player-modal-title-edit-post = Editar Publicação do Quadro de Jogadores

# Modal de editar quantidade no carrinho do assistente
player-modal-title-edit-cart-qty = Editar Quantidade no Carrinho
player-modal-label-cart-qty = Quantidade
player-modal-placeholder-cart-qty = Digite a nova quantidade (0 para remover)

# Modal de criar contêiner
player-modal-title-create-container = Criar Novo Contêiner
player-modal-label-container-name = Nome do Contêiner
player-modal-placeholder-container-name = Digite um nome para seu contêiner (ex.: Mochila)

# Modal de renomear contêiner
player-modal-title-rename-container = Renomear Contêiner
player-modal-label-new-container-name = Novo Nome do Contêiner
player-modal-placeholder-new-container-name = Digite o novo nome

# Modal de consumir do contêiner
player-modal-title-consume = Consumir/Destruir Item
player-modal-label-consume-qty = Quantidade (máx: { $maxQuantity })
player-modal-placeholder-consume-qty = Digite a quantidade para consumir/destruir

# Modal de mover quantidade de item
player-modal-title-move-item = Mover Item
player-modal-label-move-qty = Quantidade para mover (máx: { $maxQuantity })
player-modal-placeholder-move-qty = Digite a quantidade para mover

# --- Seleções ---

player-select-placeholder-no-characters = Você não tem personagens registrados
player-select-placeholder-remove-character = Selecione um personagem para remover
player-select-placeholder-post = Selecione uma publicação
player-select-placeholder-container-view = Selecione um contêiner para ver...
player-select-placeholder-item = Selecione um item...
player-select-placeholder-destination = Selecione o destino...
player-select-placeholder-container = Selecione um contêiner...
player-select-option-no-containers = Sem contêineres
player-select-option-no-items = Sem itens
player-select-option-no-destinations = Sem destinos

# --- Views ---

# PlayerBaseView - Menu principal
player-title-main-menu = {"**"}Comandos do Jogador - Menu Principal{"**"}
player-menu-btn-characters = Personagens
player-menu-desc-characters = Registrar, visualizar e ativar personagens de jogador.
player-menu-btn-inventory = Inventário
player-menu-desc-inventory = Ver o inventário do seu personagem ativo e gastar moeda.
player-menu-btn-player-board = Quadro de Jogadores
player-menu-btn-player-board-disabled = Quadro de Jogadores (Não Configurado)
player-menu-desc-player-board = Criar uma publicação para o Quadro de Jogadores

# CharacterBaseView
player-title-characters = {"**"}Comandos do Jogador - Personagens{"**"}
player-desc-register-character = Registrar um novo personagem.
player-msg-no-characters = Você não tem personagens registrados.
player-label-active = (Ativo)
player-label-xp = { $xp } XP

# Confirmação de remoção de personagem
player-modal-title-confirm-char-removal = Confirmar Remoção de Personagem
player-modal-label-confirm-char-delete = Excluir { $characterName }?

# Confirmação de remoção de publicação
player-modal-title-confirm-post-removal = Confirmar Remoção de Publicação
player-modal-label-post-removal-warning = AVISO: Esta ação é irreversível!

# InventoryOverviewView
player-title-inventory = {"**"}Comandos do Jogador - Inventário{"**"}
player-title-char-inventory = {"**"}Inventário de { $characterName }{"**"}
player-msg-no-active-character = Sem Personagem Ativo: Ative um personagem para este servidor para usar esses menus.
player-msg-no-characters-registered = Sem Personagens: Registre um personagem para usar esses menus.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } itens
player-label-currency = {"**"}Moeda{"**"}
player-msg-inventory-empty = Inventário vazio.

# Embed de imprimir inventário
player-embed-title-inventory = Inventário de { $characterName }

# ContainerItemsView
player-msg-container-empty = Este contêiner está vazio.
player-label-selected-item = Selecionado: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Mover "{ $itemName }"{"**"} ({ $available } disponível)
player-msg-no-other-containers = Nenhum outro contêiner disponível.
player-msg-select-destination = Selecione o contêiner de destino:
player-label-destination = Destino: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Gerenciar Contêineres{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } itens){ $suffix }
player-label-default-suffix = { " " }(padrão)
player-msg-no-containers = Sem contêineres.
player-label-selected-container = Selecionado: {"**"}{ $containerName }{"**"}

# Confirmação de exclusão de contêiner
player-modal-title-confirm-container-delete = Confirmar Exclusão do Contêiner
player-modal-label-container-has-items = Tem { $itemCount } itens. Serão movidos para Itens Soltos.
player-modal-label-confirm-container-delete = Excluir "{ $containerName }"?

# Erros de contêiner
player-error-cannot-rename-loose = Não é possível renomear Itens Soltos.
player-error-cannot-delete-loose = Não é possível excluir Itens Soltos.

# PlayerBoardView
player-title-player-board = {"**"}Comandos do Jogador - Quadro de Jogadores{"**"}
player-desc-create-post = Criar uma nova publicação para o Quadro de Jogadores.
player-msg-no-posts = Você não tem publicações ativas.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID da Publicação: { $postId }
player-error-board-channel-not-found = Canal do Quadro de Jogadores não encontrado.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configurar Inventário de { $characterName }{"**"}
player-desc-browse-shop = Navegue na Loja Inicial para equipar seu personagem.
player-desc-select-kit = Selecione um Kit Inicial.
player-desc-input-inventory = Insira manualmente seu inventário inicial.

# StaticKitSelectView
player-title-select-kit = {"**"}Selecionar Kit para { $characterName }{"**"}
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
player-msg-no-cost-options = Este item não tem opções de custo disponíveis.
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

# Embed de troca
player-embed-title-trade = Relatório de Troca
player-embed-desc-trade-sender = Remetente: { $senderMention } como `{ $senderCharacter }`
player-embed-desc-trade-recipient = Destinatário: { $recipientMention } como `{ $recipientCharacter }`
player-embed-field-currency = Moeda
player-embed-field-amount = Quantidade
player-embed-field-balance = Saldo de { $characterName }
player-embed-field-item = Item
player-embed-field-quantity = Quantidade
player-embed-footer-transaction-id = ID da Transação: { $transactionId }

# Erros de troca
player-error-trade-no-characters = O jogador com quem você está tentando trocar não tem personagens!
player-error-trade-no-active = O jogador com quem você está tentando trocar não tem um personagem ativo neste servidor!

# Embed de gastar moeda
player-embed-title-spend = Relatório de Transação do Jogador
player-embed-desc-spend-player = Jogador: { $playerMention } como `{ $characterName }`
player-embed-desc-spend-transaction = Transação: {"**"}{ $characterName }{"**"} gastou {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canal
player-embed-field-receipt = Recibo

# Erros de gastar moeda
player-error-amount-not-number = A quantidade deve ser um número.
player-error-amount-positive = Você deve gastar uma quantidade positiva.
player-error-no-active-character-server = Você não tem um personagem ativo neste servidor.
player-error-no-currency-config = Nenhuma configuração de moeda foi encontrada para este servidor.

# Embed de consumir item
player-embed-title-consume = Relatório de Consumo de Item
player-embed-desc-consume = Jogador: { $playerMention } como `{ $characterName }`
player-embed-desc-consume-removed = Removido: {"**"}{ $quantity }x { $itemName }{"**"} de {"**"}{ $containerName }{"**"}

# Erros de consumir item
player-error-qty-positive-integer = A quantidade deve ser um número inteiro positivo.
player-error-qty-at-least-one = A quantidade deve ser pelo menos 1.
player-error-qty-only-have = Você só tem { $maxQuantity } deste item.

# Erros de inserção de inventário
player-error-invalid-format = Formato inválido: "{ $line }". Use <nome>: <quantidade>.
player-error-empty-name = O nome do item não pode estar vazio na linha: "{ $line }".
player-error-invalid-quantity = Quantidade inválida para "{ $name }": "{ $quantity }". Deve ser um número inteiro positivo.
player-error-input-errors-header = Erros na inserção de inventário:
player-msg-no-valid-items = Nenhum item válido fornecido. Inicializando com inventário vazio.

# Validação de quantidade no carrinho
player-error-enter-valid-number = Por favor, digite um número positivo válido.

# Embeds de submissão (fila de aprovação)
player-embed-title-approval = Aprovação de Inventário: { $characterName }
player-embed-desc-submitted-by = Enviado por { $userMention }
player-embed-field-items = Itens
player-embed-field-currency-received = Moeda
player-embed-footer-submission-id = ID da Submissão: { $submissionId }
player-label-approval-thread = Aprovação: { $characterName }
player-embed-title-submission-sent = Submissão de Inventário Enviada
player-embed-desc-submission-sent =
    Sua submissão para {"**"}{ $characterName }{"**"} foi enviada à equipe de MJ para aprovação!
    Você será notificado quando for revisada.
    [Ver Tópico da Submissão]({ $threadUrl })

# Embeds de aplicação direta (sem fila de aprovação)
player-embed-title-starting-inventory = Inventário Inicial Aplicado
player-embed-desc-starting-inventory = Jogador: { $playerMention } como `{ $characterName }`
player-embed-field-items-received = Itens Recebidos
player-embed-field-currency-received-label = Moeda Recebida
player-label-untitled = Sem Título
