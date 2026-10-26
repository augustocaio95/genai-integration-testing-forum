# Testes de Integração de API com GenAI (Estudo de Caso)

Este repositório contém artefatos de teste de integração entre **Order Service** e **Payment Service**, desenvolvidos com apoio de Inteligência Artificial Generativa (LLM) para o Fórum da Unidade III.

## Estrutura do Repositório
- `features/order_payment_integration.feature`: Cenários de teste de integração escritos em Gherkin/BDD.
- `test-data/payment_payloads.json`: Massa de dados e variações de contrato para testes de mutação e validação de schema.

## Prompts Utilizados
1. **Prompt de Cenários (Gherkin):** Focado na extração de fluxos de exceção, resiliência e contratos.
2. **Prompt de Dados (Payload Mutation):** Focado na geração de payloads válidos, malformados e valores limite (Boundary Testing).

