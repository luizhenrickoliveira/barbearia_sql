# 💈 Sistema de Barbearia — Banco de Dados

## Sobre
Este repositório contém o projeto de banco de dados para uma barbearia. O objetivo é controlar clientes, barbeiros, serviços, agendamentos, produtos e vendas.

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
- 1. Listar clientes: `SELECT * FROM cliente;`
- <img width="797" height="273" alt="Captura de Tela (45)" src="https://github.com/user-attachments/assets/9e0e1f69-9c4a-45c1-80fe-e5c46412b0b9" />

- 2. Ver todos os barbeiros e suas especialidades: `SELECT * FROM barbeiro;´`
<img width="801" height="247" alt="Captura de Tela (46)" src="https://github.com/user-attachments/assets/82caa18b-e0e5-4044-ab05-f2eeb80beeb4" />
  
- 3. Consultar agendamentos com cliente, barbeiro e serviços
`SELECT a.id_agendamento, c.nome AS cliente, b.nome AS barbeiro, s.descricao AS servico, a.data_hora
FROM agendamento a
JOIN cliente c ON a.id_cliente = c.id_cliente
JOIN barbeiro b ON a.id_barbeiro = b.id_barbeiro
JOIN servico s ON a.id_servico = s.id_servico;`
<img width="811" height="270" alt="Captura de Tela (47)" src="https://github.com/user-attachments/assets/4cdba1a1-e381-4fc4-a691-34282abaf9c7" />

- 4. Listar vendas com nome do cliente:
`SELECT v.id_venda, c.nome AS cliente, v.data_venda, v.valor_total
FROM venda v
JOIN cliente c ON v.id_cliente = c.id_cliente;`
<img width="833" height="288" alt="Captura de Tela (48)" src="https://github.com/user-attachments/assets/e444dffa-9968-454a-b55e-10f08bcd8ae6" />

- 5. Listar itens de venda detalhados:
 `SELECT iv.id_item, v.id_venda, s.descricao, iv.quantidade, iv.preco_unitario
FROM item_venda iv
JOIN venda v ON iv.id_venda = v.id_venda
JOIN servico s ON iv.id_servico = s.id_servico;`
<img width="852" height="285" alt="Captura de Tela (49)" src="https://github.com/user-attachments/assets/9bc579f7-6341-47ff-87e5-d0f5cf6a4ef8" />

- 6. Mostrar quanto cada cliente já gastou na barbearia:
`SELECT c.nome, SUM(v.valor_total) AS total_gasto
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;`
<img width="858" height="336" alt="Captura de Tela (50)" src="https://github.com/user-attachments/assets/a4f6a53d-3b2a-4886-a7f6-3a00d1a95407" />


## Como rodar
1. Abra o MySQL Workbench (ou outro cliente MySQL).  
2. Execute o arquivo `barberia.sql`.  
3. Exporte o diagrama do dbdiagram.io (cole o DBML em https://dbdiagram.io) e salve `DER.png` ou `DER.pdf`.  
4. Adicione prints em `prints/` mostrando as consultas principais rodando (ex.: SELECT de agendamento e relatório de vendas).  
5. Faça commits organizados no GitHub (um commit para criação das tabelas, outro para dados de exemplo, outro para prints).


Autor: Luiz Henrick




