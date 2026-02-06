# Projeto Lógico de Banco de Dados - Oficina Mecânica (DIO)

Este repositório faz parte do lab **"Construa um Projeto Lógico de Banco de Dados do Zero"** da DIO.  
Aqui eu desenvolvo um modelo lógico de banco de dados para o cenário de uma **oficina mecânica**, com criação do esquema em SQL e algumas consultas de exemplo. [page:39]

## Cenário do projeto

O objetivo é modelar um banco de dados para uma oficina, pensando em como os dados seriam organizados para atender o dia a dia do negócio: cadastro de clientes, veículos, mecânicos, ordens de serviço, serviços executados e peças utilizadas. [page:39]

O foco é praticar modelagem lógica e criação de tabelas, incluindo chaves primárias, chaves estrangeiras e relacionamentos entre as tabelas, seguindo as orientações do lab da DIO. [page:39]

## Modelo lógico (tabelas do esquema)

Abaixo, um resumo das principais tabelas do esquema lógico da oficina:

- `cliente`  
  - `id_cliente` (PK)  
  - `nome`  
  - `telefone`  
  - `email`  
  - `cpf_cnpj` (pode armazenar tanto CPF quanto CNPJ)

- `veiculo`  
  - `id_veiculo` (PK)  
  - `id_cliente` (FK para `cliente`)  
  - `placa`  
  - `modelo`  
  - `ano`

- `mecanico`  
  - `id_mecanico` (PK)  
  - `nome`  
  - `especialidade`

- `servico`  
  - `id_servico` (PK)  
  - `descricao`  
  - `valor_base`

- `peca`  
  - `id_peca` (PK)  
  - `descricao`  
  - `preco`

- `ordem_servico`  
  - `id_os` (PK)  
  - `id_veiculo` (FK para `veiculo`)  
  - `id_mecanico` (FK para `mecanico`)  
  - `data_abertura`  
  - `data_fechamento`  
  - `status` (por exemplo: Aberta, Em andamento, Fechada)  
  - `valor_total`

- `os_servico` (serviços executados em cada OS)  
  - `id_os` (FK para `ordem_servico`)  
  - `id_servico` (FK para `servico`)  
  - `quantidade`  
  - `valor_unitario`

- `os_peca` (peças utilizadas em cada OS)  
  - `id_os` (FK para `ordem_servico`)  
  - `id_peca` (FK para `peca`)  
  - `quantidade`  
  - `valor_unitario`

## Scripts incluídos neste repositório

- `create_schema_oficina.sql`  
  Script com a criação do banco de dados `oficina_dio` e de todas as tabelas do projeto lógico da oficina.

- `data_and_queries_oficina.sql`  
  Script com:
  - Inserção de alguns dados de exemplo (clientes, veículos, mecânicos, serviços, peças e ordens de serviço).  
  - Consultas SQL para testar o modelo e praticar SELECT, filtros, agregações e JOINs.

## Exemplos de perguntas respondidas pelas consultas

Algumas das perguntas de negócio que podem ser respondidas com as queries deste projeto são:

- **Quais ordens de serviço ainda estão abertas?**  
  Usando `WHERE` para filtrar pelo status da OS.

- **Quantas ordens de serviço cada mecânico atendeu?**  
  Usando `GROUP BY` e `HAVING` para contar OS por mecânico.

- **Qual o detalhamento de cada OS (cliente, veículo e mecânico)?**  
  Usando `JOIN` entre `ordem_servico`, `veiculo`, `cliente` e `mecanico`.

- **Qual o custo total de serviços e peças por ordem de serviço?**  
  Usando `JOIN` e expressões para multiplicar quantidade por valor unitário e somar.

Além disso, as queries também demonstram:

- Recuperação simples de dados com `SELECT`.  
- Filtros com `WHERE`.  
- Criação de atributos derivados com expressões (por exemplo, total de um serviço = quantidade * valor_unitario).  
- Ordenação com `ORDER BY`.  
- Agrupamento e filtros em grupos com `GROUP BY` e `HAVING`.  
- Junções entre várias tabelas para obter uma visão completa da rotina da oficina.

---

Este projeto faz parte da minha jornada de aprendizado em banco de dados e SQL, e foi desenvolvido seguindo as orientações do lab da DIO para praticar modelagem lógica e implementação em SQL no contexto de uma oficina mecânica. [page:39]
