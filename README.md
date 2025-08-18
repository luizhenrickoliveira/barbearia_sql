# 💈 Sistema de Barbearia — Banco de Dados

## Sobre
Este repositório contém o projeto de banco de dados para uma barbearia. O objetivo é controlar clientes, barbeiros, serviços, agendamentos, produtos e vendas.

## Estrutura do repositório
- `DER.png` ou `DER.pdf` — diagrama entidade-relacionamento (exportado do dbdiagram.io)
- `script.sql` — script SQL para criar o banco, inserir alguns dados de exemplo e consultas usadas para testes
- `prints/` — capturas de tela (MySQL Workbench) mostrando queries e resultados (incluir prints antes da entrega)
- `README.md` — este arquivo

## Entidades principais
- **Cliente**: cadastro de clientes (dados básicos)
- **Barbeiro**: barbeiros que atendem na barbearia
- **Serviço**: tipo de serviço prestado (corte, barba, etc.)
- **Agendamento**: marcação de horário entre cliente e barbeiro para um serviço
- **Produto**: produtos vendidos na loja (pomadas, shampoos)
- **Venda**: registro de vendas realizadas
- **ItemVenda**: itens que compõem cada venda (relacionamento N:N com produto)

## Normalização
O modelo foi projetado até a **3ª Forma Normal (3FN)**:
- Atributos atômicos (1FN)
- Eliminação de dependências parciais (2FN)
- Sem dependências transitivas (3FN)

## Principais consultas usadas (exemplos)
- Listar clientes: `SELECT * FROM cliente;`
- Listar agendamentos com nomes: JOIN entre agendamento, cliente, barbeiro e servico
- Produtos com estoque baixo: `SELECT * FROM produto WHERE estoque <= 5;`
- Faturamento por mês: agregação por `DATE_FORMAT(data_venda, '%Y-%m')`
- Relacionamento venda ↔ produtos via `item_venda`

## Como rodar
1. Abra o MySQL Workbench (ou outro cliente MySQL).  
2. Execute o arquivo `script.sql`.  
3. Exporte o diagrama do dbdiagram.io (cole o DBML em https://dbdiagram.io) e salve `DER.png` ou `DER.pdf`.  
4. Adicione prints em `prints/` mostrando as consultas principais rodando (ex.: SELECT de agendamento e relatório de vendas).  
5. Faça commits organizados no GitHub (um commit para criação das tabelas, outro para dados de exemplo, outro para prints).

## Observações finais
- Antes da entrega, personalize o `README.md` com seu nome e a data.
- Se quiser, eu já deixei alguns inserts de exemplo no `script.sql` para facilitar os testes.

---
Autor: Luiz
