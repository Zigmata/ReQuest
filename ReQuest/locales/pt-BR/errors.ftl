## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ups!
error-report-description =
    Ocorreu uma exceção:

    ```{ $exception }```

    Se este erro for inesperado, ou se você suspeitar que o bot não está funcionando corretamente, envie um relatório de bug no [Discord Oficial de Suporte do ReQuest](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Apenas o dono do bot pode usar este comando!
error-no-permission = Você não tem permissão para executar este comando!
error-no-active-character = Você não possui um personagem ativo neste servidor!
error-no-registered-characters = Você não possui personagens registrados!
error-no-characters = O jogador alvo não possui personagens registrados.
error-no-active-character-target = O jogador alvo não possui um personagem ativo neste servidor.
error-player-not-found = Dados do jogador não encontrados.
error-character-not-found = Dados do personagem não encontrados.

# Currency/transaction errors
error-transaction-cannot-complete = A transação não pode ser concluída:
    { $reason }
error-insufficient-item-trade = Você possui { $owned }x { $itemName } mas está tentando entregar { $quantity }.
error-currency-process-failed = A moeda { $currencyName } não pôde ser processada.
error-insufficient-funds-transaction = Fundos insuficientes para cobrir esta transação.
error-insufficient-funds = Fundos insuficientes.
error-insufficient-items = Itens insuficientes: { $itemName }
error-currency-not-configured = A moeda '{ $currencyName }' não está configurada neste servidor.
error-cost-currency-system-mismatch = A moeda de custo '{ $currencyName }' não faz parte do seu próprio sistema de moeda.
error-currency-config-error = Erro de configuração da moeda: valor de denominação 0 ou negativo.
error-currency-validation = Ocorreu um erro durante a validação da moeda: { $error }
error-invalid-currency = { $itemName } não é uma moeda válida.
error-insufficient-funds-for-transaction = Fundos insuficientes para esta transação.

# Cart errors
error-cart-not-found = Carrinho não encontrado.
error-item-not-in-cart = Item não está no carrinho.
error-not-enough-stock = Estoque insuficiente.

# Container errors
error-container-not-found = Contêiner não encontrado.
error-container-name-empty = O nome do contêiner não pode estar vazio.
error-container-name-too-long = O nome do contêiner não pode exceder { $maxLength } caracteres.
error-max-containers-reached = Você não pode criar mais de { $maxContainers } contêineres.
error-container-name-exists = Já existe um contêiner chamado "{ $containerName }".
error-item-already-in-container = O item já está neste contêiner.
error-quantity-minimum = A quantidade deve ser no mínimo 1.
error-source-container-not-found = Contêiner de origem não encontrado.
error-item-not-in-source = Item "{ $itemName }" não encontrado no contêiner de origem.
error-insufficient-quantity-in-container = Quantidade insuficiente. Você possui { $available } neste contêiner.
error-dest-container-not-found = Contêiner de destino não encontrado.
error-item-not-in-container = Item "{ $itemName }" não encontrado neste contêiner.
error-insufficient-quantity-consume = Você possui apenas { $available } deste item neste contêiner.
