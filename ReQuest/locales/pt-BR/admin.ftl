## Strings do módulo de administração

# Cog de admin
admin-embed-title-unauthorized = Servidor Não Autorizado
admin-embed-desc-unauthorized =
    Obrigado pelo seu interesse no ReQuest! Seu servidor não está na lista de servidores de teste autorizados do ReQuest.
    Por favor, entre no Discord de suporte abaixo e entre em contato com a equipe de desenvolvimento para solicitar acesso de teste.

    [Discord de Desenvolvimento do ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Os seguintes comandos foram sincronizados com { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Os seguintes comandos foram sincronizados globalmente
admin-error-missing-scope = O ReQuest não tem o escopo correto no servidor alvo. Adicione a permissão `applications.commands` e tente novamente.
admin-error-sync-failed = Houve um erro ao sincronizar comandos: { $error }
admin-msg-commands-cleared = Comandos limpos.

# Botões de admin
admin-btn-shutdown = Desligar
admin-modal-title-confirm-shutdown = Confirmar Desligamento
admin-modal-label-shutdown-warning = Aviso! Isso desligará o bot. Digite CONFIRM para continuar.
admin-msg-shutting-down = Desligando!
admin-btn-add-server = Adicionar Novo Servidor
admin-btn-load-cog = Carregar Cog
admin-msg-extension-loaded = Extensão carregada com sucesso: `{ $module }`
admin-btn-reload-cog = Recarregar Cog
admin-msg-extension-reloaded = Extensão recarregada com sucesso: `{ $module }`
admin-btn-output-guilds = Listar Servidores
admin-msg-connected-guilds = Conectado a { $count } servidores:

# Modais de admin
admin-modal-title-add-server = Adicionar ID do Servidor à Lista de Permissão
admin-modal-label-server-name = Nome do Servidor
admin-modal-placeholder-server-name = Digite um nome curto para o Servidor Discord
admin-modal-label-server-id = ID do Servidor
admin-modal-placeholder-server-id = Digite o ID do Servidor Discord
admin-select-placeholder-server = Selecione um servidor para remover
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nome
admin-modal-placeholder-cog-name = Digite o nome do Cog para { $action }

# Views de admin
admin-title-main-menu = Administração - Menu Principal
admin-desc-allowlist = Configurar a lista de permissão do servidor para restrições de convite.
admin-desc-cogs = Carregar ou recarregar cogs.
admin-desc-guild-list = Retorna uma lista de todos os servidores dos quais o bot é membro.
admin-desc-shutdown = Desliga o bot
admin-title-allowlist = Administração - Lista de Permissão de Servidores
admin-desc-allowlist-warning =
    Adicione um novo ID de Servidor Discord à lista de permissão.
    {"**"}AVISO: Não há como verificar se o ID do servidor fornecido é válido sem o bot ser membro do servidor. Verifique suas entradas!{"**"}
admin-msg-no-servers = Nenhum servidor na lista de permissão.

# Modais de confirmação de admin
admin-modal-title-confirm-server-removal = Confirmar Remoção do Servidor
admin-modal-label-server-removal = Remover servidor da lista de permissão?

# View de cogs de admin
admin-title-cogs = Administração - Cogs
admin-desc-load-cog = Carregar um cog do bot por nome. O arquivo deve se chamar `<nome>.py` e estar em ReQuest\cogs\.
admin-desc-reload-cog = Recarregar um cog carregado por nome. As mesmas restrições de nome e caminho de arquivo se aplicam.
