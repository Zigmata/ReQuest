## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Servidor Não Autorizado
admin-embed-desc-unauthorized =
    Obrigado pelo seu interesse no ReQuest! Seu servidor não está na lista de servidores autorizados para testes.
    Entre no Discord de suporte abaixo e entre em contato com a equipe de desenvolvimento para solicitar acesso de teste.

    [Discord de Desenvolvimento do ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Os seguintes comandos foram sincronizados com { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Os seguintes comandos foram sincronizados globalmente
admin-error-missing-scope = O ReQuest não possui o escopo correto no servidor de destino. Adicione a permissão `applications.commands` e tente novamente.
admin-error-sync-failed = Ocorreu um erro ao sincronizar os comandos: { $error }
admin-msg-commands-cleared = Comandos Removidos.

# Admin buttons
admin-btn-shutdown = Desligar
admin-modal-title-confirm-shutdown = Confirmar Desligamento
admin-modal-label-shutdown-warning = Atenção! Isso irá desligar o bot. Digite CONFIRMAR para continuar.
admin-msg-shutting-down = Desligando!
admin-btn-add-server = Adicionar Novo Servidor
admin-btn-load-cog = Carregar Cog
admin-msg-extension-loaded = Cog carregado com sucesso: `{ $module }`
admin-btn-reload-cog = Recarregar Cog
admin-msg-extension-reloaded = Cog recarregado com sucesso: `{ $module }`
admin-btn-output-guilds = Listar Servidores
admin-msg-connected-guilds = Conectado a { $count } servidores:

# Admin modals
admin-modal-title-add-server = Adicionar ID de Servidor à Lista de Permissões
admin-modal-label-server-name = Nome do Servidor
admin-modal-placeholder-server-name = Digite um nome curto para o servidor do Discord
admin-modal-label-server-id = ID do Servidor
admin-modal-placeholder-server-id = Digite o ID do Servidor do Discord
admin-select-placeholder-server = Selecione um servidor para remover
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nome
admin-modal-placeholder-cog-name = Insira o nome do cog para { $action }

# Admin views
admin-title-main-menu = Administração - Menu Principal
admin-desc-allowlist = Configurar a lista de permissões de servidores para restrições de convite.
admin-desc-cogs = Carregar ou Recarregar Cogs.
admin-desc-guild-list = Retorna uma lista de todos os servidores dos quais o bot faz parte.
admin-desc-shutdown = Desliga o bot
admin-title-allowlist = Administração - Lista de Permissões de Servidores
admin-desc-allowlist-warning =
    Adicione o ID de um novo servidor do Discord à lista de permissões.
    {"**"}ATENÇÃO: Não há como verificar se o ID do servidor informado é válido sem que o bot esteja presente nele. Verifique os dados com atenção!{"**"}
admin-msg-no-servers = Nenhum servidor na lista de permissões.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Confirmar Remoção do Servidor
admin-modal-label-server-removal = Remover servidor da lista de permissões?

# Admin cog view
admin-title-cogs = Administração - Cogs
admin-desc-load-cog = Carrega um cog do bot pelo nome. O arquivo deve se chamar `<nome>.py` e estar em ReQuest/cogs/.
admin-desc-reload-cog = Recarrega um cog já carregado pelo nome. As mesmas regras de nome e caminho se aplicam.
