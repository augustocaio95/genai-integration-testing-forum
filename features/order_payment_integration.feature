# language: pt
Funcionalidade: Integração entre Order Service e Payment Service
  Como o serviço de Pedidos (Order Service)
  Quero me comunicar com o serviço de Payment Service via API REST
  Para garantir que a autorização de pagamento ocorra corretamente antes de confirmar o pedido.

  Cenário: Autorização de pagamento realizada com sucesso (Caminho Feliz)
    Dado que existe um pedido com status "PENDENTE" e valor de R$ 150,00
    Quando o Order Service envia uma requisição "POST /api/v1/payments" com dados válidos
    Então o Payment Service deve retornar o código HTTP 200 (OK)
    E o payload de resposta deve conter o status "APPROVED" e o ID da transação
    E o Order Service deve atualizar o status do pedido para "PAGO"

  Cenário: Falha de comunicação por Timeout no Gateway de Pagamento
    Dado que o Order Service envia uma requisição de pagamento ao Payment Service
    Quando o Payment Service demora mais de 5000ms para responder (Timeout)
    Então o Order Service deve cancelar a conexão e retornar o código HTTP 504 (Gateway Timeout)
    E o pedido deve ser mantido no status "AGUARDANDO_REPROCESSAMENTO"
    E uma mensagem de retry deve ser enviada para a fila de mensageria

  Cenário: Pagamento recusado por saldo/crédito insuficiente
    Dado que o cliente não possui saldo/crédito suficiente no cartão informado
    Quando o Order Service dispara a requisição "POST /api/v1/payments"
    Então o Payment Service deve retornar o código HTTP 422 (Unprocessable Entity)
    E a resposta deve conter a mensagem de erro "CREDIT_LIMIT_EXCEEDED"
    E o Order Service deve atualizar o status do pedido para "PAGAMENTO_RECUSADO"

  Cenário: Rejeição de payload com contrato inválido (Campos obrigatórios ausentes)
    Dado que a requisição de pagamento é enviada sem o campo obrigatório "card_token"
    Quando a requisição atinge o endpoint "POST /api/v1/payments"
    Então o Payment Service deve retornar o código HTTP 400 (Bad Request)
    E o corpo da resposta deve conter o detalhe da validação do schema "card_token is required"