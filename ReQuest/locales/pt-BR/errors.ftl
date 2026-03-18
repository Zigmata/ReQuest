## Strings de erros e falhas de verificação

# Wrapper do embed de erro
error-oops-title = ⚠️ Ops!
error-report-description =
    Ocorreu uma exceção:

    ```{ $exception }```

    Se este erro for inesperado, ou você suspeitar que o bot não está funcionando corretamente, envie um relatório de bug
    no [Discord Oficial de Suporte do ReQuest](https://discord.gg/Zq37gj4).

# Falhas de verificação
error-owner-only = Apenas o dono do bot pode usar este comando!
error-no-permission = Você não tem permissão para executar este comando!
error-no-active-character = Você não tem um personagem ativo neste servidor!
error-no-registered-characters = Você não tem nenhum personagem registrado!
error-no-characters = O jogador alvo não tem nenhum personagem registrado.
error-no-active-character-target = O jogador alvo não tem um personagem ativado neste servidor.
error-player-not-found = Dados do jogador não encontrados.
error-character-not-found = Dados do personagem não encontrados.

# Erros de moeda/transação
error-transaction-cannot-complete = A transação não pode ser concluída:
    { $reason }
error-insufficient-item-trade = Você tem { $owned }x { $itemName } mas está tentando dar { $quantity }.
error-currency-process-failed = A moeda { $currencyName } não pôde ser processada.
error-insufficient-funds-transaction = Fundos insuficientes para cobrir esta transação.
error-insufficient-funds = Fundos insuficientes.
error-insufficient-items = Item(ns) insuficiente(s): { $itemName }
error-currency-not-configured = A moeda '{ $currencyName }' não está configurada neste servidor.
error-cost-currency-system-mismatch = A moeda de custo '{ $currencyName }' não faz parte do seu próprio sistema de moedas.
error-currency-config-error = Erro de configuração de moeda: valor de denominação 0 ou negativo.
error-currency-validation = Ocorreu um erro durante a validação da moeda: { $error }
error-invalid-currency = { $itemName } não é uma moeda válida.
error-insufficient-funds-for-transaction = Fundos insuficientes para esta transação.

# Erros de carrinho
error-cart-not-found = Carrinho não encontrado.
error-item-not-in-cart = Item não está no carrinho.
error-not-enough-stock = Estoque insuficiente disponível.

# Erros de contêiner
error-container-not-found = Contêiner não encontrado.
error-container-name-empty = O nome do contêiner não pode estar vazio.
error-container-name-too-long = O nome do contêiner não pode exceder { $maxLength } caracteres.
error-max-containers-reached = Você não pode criar mais de { $maxContainers } contêineres.
error-container-name-exists = Um contêiner chamado "{ $containerName }" já existe.
error-item-already-in-container = O item já está neste contêiner.
error-quantity-minimum = A quantidade deve ser pelo menos 1.
error-source-container-not-found = Contêiner de origem não encontrado.
error-item-not-in-source = Item "{ $itemName }" não encontrado no contêiner de origem.
error-insufficient-quantity-in-container = Quantidade insuficiente. Você tem { $available } neste contêiner.
error-dest-container-not-found = Contêiner de destino não encontrado.
error-item-not-in-container = Item "{ $itemName }" não encontrado neste contêiner.
error-insufficient-quantity-consume = Você só tem { $available } deste item neste contêiner.
