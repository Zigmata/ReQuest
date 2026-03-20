## Strings do módulo de Mestre de Jogo

# Botões de MJ
gm-btn-create = Criar
gm-btn-edit-details = Editar Detalhes
gm-btn-toggle-ready = Alternar Pronto
gm-btn-configure-rewards = Configurar Recompensas
gm-btn-remove-player = Remover Jogador
gm-btn-cancel-quest = Cancelar Quest
gm-btn-manage-party-rewards = Gerenciar Recompensas do Grupo
gm-btn-manage-individual-rewards = Gerenciar Recompensas Individuais
gm-btn-join = Entrar
gm-btn-leave = Sair
gm-btn-complete-quest = Completar Quest
gm-btn-review-submission = Revisar Submissão
gm-btn-approve = Aprovar
gm-btn-deny = Negar

# Modais de MJ
gm-modal-title-create-quest = Criar Nova Quest
gm-modal-label-quest-title = Título da Quest
gm-modal-placeholder-quest-title = Título da sua quest
gm-modal-label-restrictions = Restrições
gm-modal-placeholder-restrictions = Restrições, se houver, como nível dos jogadores
gm-modal-label-max-party = Tamanho Máximo do Grupo
gm-modal-placeholder-max-party = Tamanho máximo do grupo para esta quest
gm-modal-label-party-role = Cargo do Grupo
gm-modal-placeholder-party-role = Criar um cargo para esta quest (Opcional)
gm-modal-label-description = Descrição
gm-modal-placeholder-description = Escreva os detalhes da sua quest aqui
gm-modal-title-editing-quest = Editando { $questTitle }
gm-modal-label-title = Título
gm-modal-label-max-party-size = Tamanho Máximo do Grupo
gm-modal-title-add-reward = Adicionar Recompensa
gm-modal-label-experience = Pontos de Experiência
gm-modal-placeholder-experience = Digite um número
gm-modal-label-items = Itens
gm-modal-placeholder-items =
    item: quantidade
    item2: quantidade
    etc.
gm-modal-title-add-summary = Adicionar Resumo da Quest
gm-modal-label-summary = Resumo
gm-modal-placeholder-summary = Adicione um resumo da história da quest
gm-modal-title-modifying-player = Modificando { $playerName }
gm-modal-placeholder-xp-add-remove = Digite um número positivo ou negativo.
gm-modal-label-inventory = Inventário
gm-modal-placeholder-inventory-modify =
    item: quantidade
    item2: quantidade
    etc.
gm-modal-title-review-submission = Revisar Submissão
gm-modal-label-submission-id = ID da Submissão
gm-modal-placeholder-submission-id = Digite o ID de 8 caracteres

# Erros de MJ
gm-error-forbidden-role-name = O nome fornecido para o cargo do grupo é proibido.
gm-error-role-already-exists = Um cargo com esse nome já existe neste servidor.
gm-error-no-quest-channel = Um canal ainda não foi designado para postagens de quests. Entre em contato com um admin do servidor para configurar o Canal de Quests.
gm-error-cannot-ping-announce = Não foi possível mencionar o cargo de anúncio { $role } no canal { $channel }. Verifique as permissões do canal e do cargo do ReQuest com o(s) admin(s) do servidor.
gm-error-invalid-item-format = Formato de item inválido: "{ $item }". Cada item deve estar em uma nova linha, no formato "Nome: Quantidade".
gm-error-submission-not-found = Submissão não encontrada.
gm-error-already-on-quest = Você já está nesta quest como { $characterName }.
gm-error-no-active-character-long = Você não tem um personagem ativo neste servidor. Use `/player` para registrar ou ativar um personagem.
gm-error-quest-locked = Erro ao entrar na quest {"**"}{ $questTitle }{"**"}: A quest está bloqueada pelo Mestre.
gm-error-quest-full = Erro ao entrar na quest {"**"}{ $questTitle }{"**"}: O grupo está cheio!
gm-error-not-signed-up = Você não está inscrito nesta quest.
gm-error-quest-channel-not-set = O canal de quests não foi definido!
gm-error-empty-roster = Você não pode completar uma quest com a lista de jogadores vazia. Tente cancelar em vez disso.
gm-error-invalid-xp-value = O valor de XP deve ser um número inteiro positivo!

# Modais de confirmação de MJ
gm-modal-title-cancel-quest = Cancelar Quest
gm-modal-label-cancel-quest = Digite CONFIRM para cancelar a quest.
gm-modal-placeholder-cancel-quest = Digite "CONFIRM" para continuar.
gm-modal-title-remove-from-quest = Remover personagem da quest
gm-modal-label-remove-from-quest = Confirmar remoção do personagem?
gm-modal-placeholder-remove-from-quest = Digite "CONFIRM" para continuar.

# Mensagens diretas de MJ
gm-dm-quest-cancelled = A quest {"**"}{ $questTitle }{"**"} foi cancelada pelo Mestre.
gm-dm-quest-ready = A quest {"**"}{ $questTitle }{"**"} está pronta!
gm-dm-quest-unlocked = A quest {"**"}{ $questTitle }{"**"} não está mais bloqueada.
gm-dm-quest-locked = A quest {"**"}{ $questTitle }{"**"} foi bloqueada pelo Mestre.
gm-dm-player-removed = Você foi removido da quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Você foi removido da lista de espera de {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Você foi adicionado ao grupo de {"**"}{ $questTitle }{"**"}, devido à saída de um jogador!
gm-dm-roster-locked = Lista da quest bloqueada e grupo notificado!
gm-dm-roster-unlocked = A lista da quest foi desbloqueada.
gm-dm-rewards-no-characters =
    O administrador do seu servidor configurou recompensas para Mestres de Jogo ao completarem
    quests. No entanto, como você não tem personagens registrados, suas recompensas não puderam
    ser emitidas automaticamente neste momento.
gm-dm-rewards-no-active-character =
    O administrador do seu servidor configurou recompensas para Mestres de Jogo ao completarem
    quests. No entanto, como você não tem um personagem ativo neste servidor, suas recompensas
    não puderam ser emitidas automaticamente neste momento.
gm-dm-rewards-issued = O seguinte foi concedido ao seu personagem ativo, { $characterName }

# Menus de seleção de MJ
gm-select-placeholder-party-member = Selecione um membro do grupo

# Embeds de MJ
gm-embed-title-mod-report = Relatório de Modificação de Jogador pelo MJ
gm-embed-field-experience = Experiência
gm-embed-title-quest-complete = Quest Completa: { $questTitle }
gm-embed-title-quest-completed = QUEST COMPLETADA: { $questTitle }
gm-embed-field-rewards = Recompensas
gm-embed-field-party = __Grupo__
gm-embed-field-summary = Resumo
gm-embed-title-gm-rewards = Recompensas do MJ Emitidas
gm-embed-field-items = Itens
gm-msg-player-removed = Jogador removido e lista da quest atualizada!

# Views de MJ
gm-title-main-menu = Mestre de Jogo - Menu Principal
gm-menu-quests = Quests
gm-menu-desc-quests = Criar, editar e gerenciar quests.
gm-menu-players = Jogadores
gm-menu-desc-players = Gerenciar inventários de jogadores e modificar personagens.
gm-menu-approvals = Aprovações de Personagens
gm-menu-desc-approvals = Revisar e aprovar/negar submissões de personagens.

gm-title-quest-management = Mestre de Jogo - Gerenciamento de Quests
gm-desc-create-quest = Criar uma nova quest.
gm-msg-no-quests = Nenhuma quest encontrada.
gm-label-quest-locked = (Bloqueada)
gm-title-manage-quest = Gerenciar Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editar detalhes da quest como título, descrição e tamanho do grupo.
gm-desc-toggle-ready = Alternar estado de prontidão (Atual: {"**"}{ $status }{"**"})
    - Bloqueia a lista da quest e notifica os membros do grupo que a quest começará em breve. Se um cargo estiver configurado, será atribuído aos membros do grupo quando bloqueado.
    - Desbloqueia a lista quando definido como Aberto.
gm-label-ready-locked = Bloqueada/Pronta
gm-label-ready-open = Aberta
gm-desc-configure-rewards = Configurar recompensas para a quest selecionada.
gm-desc-complete-quest = Completar uma quest. Emite recompensas, se houver, para os membros do grupo.
gm-desc-remove-player = Remover um jogador da lista da quest e notificá-lo.
gm-desc-cancel-quest = Cancelar a quest e removê-la do quadro de quests.
gm-title-player-management = Mestre de Jogo - Gerenciamento de Jogadores
gm-desc-player-management =
    Esses comandos migraram para menus de contexto. Clique com o botão direito (desktop) ou pressione e segure (mobile) o perfil de um jogador para as seguintes opções:

    - {"**"}Modificar Jogador{"**"}: Adicionar ou remover itens e experiência de um jogador.
    - {"**"}Ver Jogador{"**"}: Ver os detalhes do personagem ativo de um jogador.
gm-title-remove-player = Remover Jogador da Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notas de Remoção de Jogador{"**"}__

    - Escolha um jogador no menu abaixo para removê-lo da lista da quest.
    - Se houver jogadores na lista de espera, o primeiro jogador da lista será promovido ao grupo.
    - As recompensas individuais do jogador removido serão excluídas da quest.
    - Se deseja recompensar o jogador por contribuições anteriores, use o menu de contexto `Modificar Jogador` para emitir recompensas diretamente.
gm-label-no-players-in-roster = Nenhum jogador na lista da quest
gm-title-character-sheet = Ficha do Personagem de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Pontos de Experiência:{"**"}__
gm-label-possessions = __{"**"}Posses{"**"}__
gm-label-currency-heading = {"**"}Moeda{"**"}
gm-msg-inventory-empty = Inventário vazio.

# Aprovações de MJ
gm-title-approvals = Mestre de Jogo - Aprovações de Inventário
gm-desc-review-submission = Digite um ID de Submissão para revisar e aprovar/negar.
gm-title-reviewing = Revisando: { $characterName }
gm-label-items = {"**"}Itens:{"**"}
gm-label-currency = {"**"}Moeda:{"**"}
gm-embed-title-approved = Atualização de Inventário Aprovada
gm-embed-desc-approved = O inventário de {"**"}{ $characterName }{"**"} foi aprovado por { $approver }.
gm-embed-title-denied = Atualização de Inventário Negada
gm-embed-desc-denied = O inventário de {"**"}{ $characterName }{"**"} foi negado por { $denier }.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
