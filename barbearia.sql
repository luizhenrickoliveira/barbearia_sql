-- BANCO DE DADOS BARBEARIA
-- Feito por Luiz

-- 1. Criando o banco
CREATE DATABASE IF NOT EXISTS barbearia_db;
USE barbearia_db;

-- ==========================================================
-- 2. Criação das tabelas
-- ==========================================================

-- Tabela de clientes
DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);


-- Tabela de barbeiros
DROP TABLE IF EXISTS barbeiro;
CREATE TABLE barbeiro (
    id_barbeiro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

-- Tabela de serviços
DROP TABLE IF EXISTS servico;
CREATE TABLE servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de agendamentos
DROP TABLE IF EXISTS agendamento;
CREATE TABLE agendamento (
    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_barbeiro INT,
    id_servico INT,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_barbeiro) REFERENCES barbeiro(id_barbeiro),
    FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
);

-- Tabela de vendas
DROP TABLE IF EXISTS venda;
CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_venda DATETIME NOT NULL,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de itens de venda
DROP TABLE IF EXISTS item_venda;
CREATE TABLE item_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT,
    id_servico INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
);

-- ==========================================================
-- 3. Inserindo dados de exemplo
-- ==========================================================

-- Clientes
INSERT INTO cliente (nome, telefone, email) VALUES
('João Silva', '1199999999', 'joao@email.com'),
('Lucas Oliveira', '1188888888', 'lucas@email.com');  -- nome masculino

-- Barbeiros
INSERT INTO barbeiro (nome, especialidade) VALUES
('Carlos Souza', 'Corte Masculino'),
('Pedro Santos', 'Barba e Cabelo');

-- Serviços
INSERT INTO servico (descricao, preco) VALUES
('Corte de cabelo', 40.00),
('Barba completa', 25.00),
('Corte + Barba', 60.00);

-- Agendamentos
INSERT INTO agendamento (id_cliente, id_barbeiro, id_servico, data_hora) VALUES
(1, 1, 1, '2025-08-20 14:00:00'),
(2, 2, 3, '2025-08-21 16:30:00');

-- Vendas
INSERT INTO venda (id_cliente, data_venda, valor_total) VALUES
(1, NOW(), 0),
(2, NOW(), 0);

-- Itens de venda
INSERT INTO item_venda (id_venda, id_servico, quantidade, preco_unitario) VALUES
(1, 1, 1, 40.00),
(2, 3, 1, 60.00);

-- Atualiza valor total da venda (corrigido)
UPDATE venda v
JOIN (
    SELECT id_venda, SUM(quantidade * preco_unitario) AS total
    FROM item_venda
    GROUP BY id_venda
) AS iv_sum ON v.id_venda = iv_sum.id_venda
SET v.valor_total = iv_sum.total;

-- ==========================================================
-- 4. Consultas de exemplo
-- ==========================================================

-- 1. Listar todos os clientes
SELECT * FROM cliente;

-- 2. Ver todos os barbeiros e suas especialidades
SELECT * FROM barbeiro;

-- 3. Consultar agendamentos com cliente, barbeiro e serviço
SELECT a.id_agendamento, c.nome AS cliente, b.nome AS barbeiro, s.descricao AS servico, a.data_hora
FROM agendamento a
JOIN cliente c ON a.id_cliente = c.id_cliente
JOIN barbeiro b ON a.id_barbeiro = b.id_barbeiro
JOIN servico s ON a.id_servico = s.id_servico;

-- 4. Listar vendas com nome do cliente
SELECT v.id_venda, c.nome AS cliente, v.data_venda, v.valor_total
FROM venda v
JOIN cliente c ON v.id_cliente = c.id_cliente;

-- 5. Listar itens de venda detalhados
SELECT iv.id_item, v.id_venda, s.descricao, iv.quantidade, iv.preco_unitario
FROM item_venda iv
JOIN venda v ON iv.id_venda = v.id_venda
JOIN servico s ON iv.id_servico = s.id_servico;

-- 6. Mostrar quanto cada cliente já gastou na barbearia
SELECT c.nome, SUM(v.valor_total) AS total_gasto
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;

SET SQL_SAFE_UPDATES = 0;
