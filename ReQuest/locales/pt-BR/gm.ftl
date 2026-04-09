## Game Master module strings

# GM buttons
gm-btn-create = Criar
gm-btn-edit-details = Editar Quest
gm-btn-toggle-ready = Alternar Prontidão
gm-btn-configure-rewards = Configurar Recompensas
gm-btn-remove-player = Remover Jogador
gm-btn-cancel-quest = Cancelar Quest
gm-btn-manage-party-rewards = Gerenciar Recompensas do Grupo
gm-btn-manage-individual-rewards = Gerenciar recompensas individuais
gm-btn-join = Entrar
gm-btn-leave = Sair
gm-btn-complete-quest = Concluir Quest
gm-btn-edit-details-modal = Editar Detalhes
gm-btn-edit-images = Editar Imagens
gm-select-placeholder-party-role = Selecione um cargo do grupo...
gm-modal-title-edit-details = Editar Detalhes da Quest
gm-modal-title-edit-images = Editar Imagens da Quest
gm-btn-publish = Publicar
gm-btn-update-post = Atualizar Post

# GM modals
gm-modal-title-create-quest = Criar Nova Quest
gm-modal-label-quest-title = Título da Quest
gm-modal-placeholder-quest-title = Título da sua quest
gm-modal-label-restrictions = Restrições
gm-modal-placeholder-restrictions = Restrições, se houver, como nível dos jogadores
gm-modal-label-max-party = Tamanho Máximo do Grupo
gm-modal-placeholder-max-party = Tamanho máximo do grupo para esta quest
gm-modal-label-party-role = Cargo do Grupo
gm-modal-placeholder-party-role = Crie um cargo para esta quest (Opcional)
gm-modal-label-description = Descrição
gm-modal-placeholder-description = Escreva os detalhes da sua quest aqui
gm-modal-label-image-url = URL da Miniatura
gm-modal-label-large-image-url = URL da Imagem Grande
gm-modal-placeholder-image-url = Insira a URL de uma imagem (ou deixe em branco para remover)
gm-modal-title-add-reward = Adicionar Recompensa
gm-modal-label-experience = Pontos de Experiência
gm-modal-placeholder-experience = Insira um número
gm-modal-label-items = Itens
gm-modal-placeholder-items =
    item: quantidade
    item2: quantidade
    etc.
gm-modal-title-add-summary = Adicionar Resumo da Quest
gm-modal-label-summary = Resumo
gm-modal-placeholder-summary = Adicione um resumo da história da quest
gm-modal-title-modifying-player = Modificando { $playerName }
gm-modal-placeholder-xp-add-remove = Insira um número positivo ou negativo.
gm-modal-label-inventory = Inventário
gm-modal-placeholder-inventory-modify =
    item: quantidade
    item2: quantidade
    etc.

# GM errors
gm-error-forbidden-role-name = O nome fornecido para o cargo do grupo é proibido.
gm-error-role-already-exists = Já existe um cargo com esse nome neste servidor.
gm-error-no-quest-channel = Um canal ainda não foi definido para postagens de quests. Entre em contato com um administrador do servidor para configurar o canal de quests.
gm-error-cannot-ping-announce = Não foi possível mencionar o cargo { $role } no canal { $channel }. Verifique as permissões do canal e do ReQuest com o(s) administrador(es) do servidor.
gm-error-invalid-item-format = Formato de item inválido: "{ $item }". Cada item deve estar em uma nova linha, no formato "Nome: Quantidade".
gm-error-already-on-quest = Você já está nesta quest como { $characterName }.
gm-error-no-active-character-long = Você não possui um personagem ativo neste servidor. Use `/player` para registrar ou ativar um personagem.
gm-error-quest-locked = Erro ao entrar na quest {"**"}{ $questTitle }{"**"}: A quest está bloqueada pelo Mestre.
gm-error-quest-full = Erro ao entrar na quest {"**"}{ $questTitle }{"**"}: O grupo já está completo!
gm-error-not-signed-up = Você não está inscrito nesta quest.
gm-error-quest-channel-not-set = O canal de quests não foi configurado!
gm-error-empty-roster = Você não pode concluir uma quest com o grupo vazio. Tente cancelar em vez disso.
gm-error-invalid-xp-value = O valor de XP deve ser um número inteiro positivo!
gm-error-role-hierarchy = O ReQuest não pode gerenciar o cargo "{ $roleName }" (ID: { $roleId }) porque está posicionado acima do cargo mais alto do ReQuest na hierarquia do servidor. Entre em contato com um administrador do servidor para mover o cargo abaixo do cargo do ReQuest, ou atribuir ao ReQuest um cargo mais alto, e tente novamente.

# GM confirm modals
gm-modal-title-cancel-quest = Cancelar Quest
gm-modal-label-cancel-quest = Digite CONFIRMAR para cancelar a quest.
gm-modal-title-remove-from-quest = Remover personagem da quest
gm-modal-label-remove-from-quest = Confirmar remoção do personagem?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest Cancelada
gm-dm-desc-quest-cancelled = A quest {"**"}{ $questTitle }{"**"} foi cancelada pelo Mestre.
gm-dm-title-quest-ready = Quest Pronta
gm-dm-desc-quest-ready = A quest {"**"}{ $questTitle }{"**"} está pronta! Seu Mestre iniciará a quest em breve.
gm-dm-title-player-removed = Removido da Quest
gm-dm-desc-player-removed = Você foi removido da quest {"**"}{ $questTitle }{"**"} pelo Mestre.
gm-dm-desc-player-removed-waitlist = Você foi removido da lista de espera da quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Promoção ao Grupo
gm-dm-desc-party-promotion =
    Você foi promovido ao grupo principal de {"**"}{ $questTitle }{"**"}
    porque um jogador saiu da quest.
gm-dm-title-roster-locked = Grupo da Quest Bloqueado
gm-dm-desc-roster-locked =
    O grupo da quest {"**"}{ $questTitle }{"**"} foi bloqueado
    e todos os membros do grupo foram notificados.
gm-dm-title-roster-unlocked = Grupo da Quest Desbloqueado
gm-dm-desc-roster-unlocked = O grupo da quest {"**"}{ $questTitle }{"**"} foi desbloqueado.
gm-dm-title-player-removed-confirm = Jogador Removido
gm-dm-desc-player-removed-confirm =
    O jogador foi removido de {"**"}{ $questTitle }{"**"}
    e o grupo da quest foi atualizado.
gm-dm-footer-quest = ID da Quest: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    O administrador do servidor configurou recompensas para Mestres ao concluírem
    quests. No entanto, como você não possui personagens registrados, suas recompensas
    não puderam ser concedidas automaticamente neste momento.
gm-dm-rewards-no-active-character =
    O administrador do servidor configurou recompensas para Mestres ao concluírem
    quests. No entanto, como você não possui um personagem ativo neste servidor,
    suas recompensas não puderam ser concedidas automaticamente neste momento.
gm-dm-rewards-issued = O seguinte foi concedido ao seu personagem ativo, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Falha ao remover o cargo {"**"}{ $roleName }{"**"} dos seguintes membros: { $members }.
    Notifique um administrador do servidor para remover o cargo manualmente.
gm-dm-role-not-found =
    ⚠️ O cargo de quest (ID: { $roleId }) para a quest {"**"}{ $questTitle }{"**"} não existe mais no servidor.
    As operações de cargo foram ignoradas. Notifique um administrador do servidor se isso for inesperado.

# GM select menus
gm-select-placeholder-party-member = Selecione um membro do grupo
gm-modal-label-select-party-role = Cargo do Grupo
gm-modal-desc-select-party-role = Selecione um cargo para atribuir ao grupo da quest.
gm-select-option-no-role = Nenhum (Sem Cargo de Grupo)

# GM embeds
gm-embed-title-mod-report = Relatório de Modificação de Jogador (Mestre)
gm-embed-field-experience = Experiência
gm-embed-title-quest-complete = Quest Concluída: { $questTitle }
gm-embed-title-quest-completed = QUEST CONCLUÍDA: { $questTitle }
gm-embed-field-rewards = Recompensas
gm-embed-field-party = __Grupo__
gm-embed-field-summary = Resumo
gm-embed-title-gm-rewards = Recompensas do Mestre Concedidas
gm-embed-field-items = Itens

# GM views
gm-title-main-menu = Mestre - Menu Principal
gm-menu-quests = Quests
gm-menu-desc-quests = Criar, editar e gerenciar quests.
gm-menu-players = Jogadores
gm-menu-desc-players = Gerenciar inventários dos jogadores e modificar personagens.

gm-title-quest-management = Mestre - Gerenciamento de Quests
gm-desc-create-quest = Criar uma nova quest.
gm-msg-no-quests = Nenhuma quest encontrada.
gm-label-quest-locked = (Bloqueada)
gm-label-quest-draft = (Rascunho)
gm-title-manage-quest = Gerenciar Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editar detalhes da quest como título, descrição e tamanho do grupo.
gm-title-edit-quest = Editar Quest - { $questTitle }
gm-label-field-not-set = Não definido
gm-label-description-not-set = Descrição não definida
gm-label-current-title = {"**"}Título:{"**"} { $value }
gm-label-current-description = {"**"}Descrição{"**"}
gm-label-current-restrictions = {"**"}Restrições:{"**"} { $value }
gm-label-current-party-size = {"**"}Tamanho Máximo do Grupo:{"**"} { $value }
gm-label-current-party-role = {"**"}Cargo do Grupo:{"**"} { $value }
gm-label-current-image = {"**"}Miniatura{"**"}
gm-label-current-large-image = {"**"}Imagem{"**"}
gm-error-party-size-positive = O tamanho do grupo deve ser um número positivo.
gm-error-party-size-too-small = O tamanho do grupo não pode ser menor que o grupo atual ({ $currentSize } membros).
gm-desc-toggle-ready = Alternar estado de prontidão (Atual: {"**"}{ $status }{"**"})
    - Bloqueia o grupo da quest e notifica os membros que a quest começará em breve. Se um cargo estiver configurado, será atribuído aos membros do grupo quando bloqueado.
    - Desbloqueia o grupo quando definido como Aberto.
gm-label-ready-locked = Bloqueada/Pronta
gm-label-ready-open = Aberta
gm-desc-configure-rewards = Configurar recompensas para a quest selecionada.
gm-desc-complete-quest = Concluir uma quest. Concede recompensas, se houver, aos membros do grupo.
gm-desc-remove-player = Remover um jogador do grupo da quest e notificá-lo.
gm-desc-cancel-quest = Cancelar a quest e removê-la do quadro de quests.
gm-desc-publish-quest = Publicar esta quest no quadro de quests.
gm-desc-update-quest-post = Atualizar o post da quest no quadro de quests.
gm-error-role-name-forbidden = O nome do cargo "{ $roleName }" é proibido neste servidor.
gm-error-role-name-exists = Já existe um cargo chamado "{ $roleName }" neste servidor.
gm-title-player-management = Mestre - Gerenciamento de Jogadores
gm-desc-player-management =
    Esses comandos foram migrados para menus de contexto. Clique com o botão direito (desktop) ou pressione e segure (celular) o perfil de um jogador para as seguintes opções:

    - {"**"}Modificar Jogador{"**"}: Adicionar ou remover itens e experiência de um jogador.
    - {"**"}Ver Jogador{"**"}: Ver os detalhes do personagem ativo de um jogador.
gm-title-remove-player = Remover Jogador da Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notas sobre a Remoção de Jogadores{"**"}__

    - Escolha um jogador no menu abaixo para removê-lo do grupo da quest.
    - Se houver jogadores na lista de espera, o primeiro da lista será promovido ao grupo.
    - As recompensas individuais do jogador removido serão excluídas da quest.
    - Se deseja recompensar o jogador por contribuições anteriores, use o menu de contexto `Modificar Jogador` para conceder recompensas diretamente.
gm-label-no-players-in-roster = Nenhum jogador no grupo da quest
gm-title-character-sheet = Ficha de Personagem de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Pontos de Experiência:{"**"}__
gm-label-possessions = __{"**"}Posses{"**"}__
gm-label-currency-heading = {"**"}Moeda{"**"}
gm-msg-inventory-empty = O inventário está vazio.

# GM approvals
