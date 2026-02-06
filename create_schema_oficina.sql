USE oficina_dio;

------------------------------------------------
-- INSERTS DE EXEMPLO
------------------------------------------------

INSERT INTO cliente (id_cliente, nome, telefone, email, cpf_cnpj) VALUES
(1, 'João Silva', '1199999-1111', 'joao@exemplo.com', '123.456.789-00'),
(2, 'Empresa ABC', '113333-2222', 'contato@abc.com', '12.345.678/0001-99');

INSERT INTO veiculo (id_veiculo, id_cliente, placa, modelo, ano) VALUES
(1, 1, 'ABC-1234', 'Gol 1.0', 2015),
(2, 2, 'XYZ-9876', 'Fiorino 1.4', 2018);

INSERT INTO mecanico (id_mecanico, nome, especialidade) VALUES
(1, 'Carlos Mecânico', 'Motor'),
(2, 'Marcos Eletricista', 'Elétrica');

INSERT INTO servico (id_servico, descricao, valor_base) VALUES
(1, 'Troca de óleo', 100.00),
(2, 'Alinhamento e balanceamento', 150.00),
(3, 'Revisão elétrica', 200.00);

INSERT INTO peca (id_peca, descricao, preco) VALUES
(1, 'Filtro de óleo', 30.00),
(2, 'Lâmpada farol', 40.00);

INSERT INTO ordem_servico (id_os, id_veiculo, id_mecanico, data_abertura, data_fechamento, status, valor_total) VALUES
(1, 1, 1, '2026-02-01', '2026-02-02', 'Fechada', 180.00),
(2, 2, 2, '2026-02-03', NULL, 'Aberta', NULL);

INSERT INTO os_servico (id_os, id_servico, quantidade, valor_unitario) VALUES
(1, 1, 1, 100.00),
(1, 2, 1, 80.00);

INSERT INTO os_peca (id_os, id_peca, quantidade, valor_unitario) VALUES
(1, 1, 1, 30.00);

------------------------------------------------
-- QUERIES DO DESAFIO
------------------------------------------------

-- 1) SELECT simples: listar clientes
SELECT id_cliente, nome, telefone, email
FROM cliente;

-- 2) WHERE: ordens de serviço ainda abertas
SELECT id_os, status, data_abertura
FROM ordem_servico
WHERE status = 'Aberta';

-- 3) Atributo derivado: custo total de serviço * quantidade
SELECT 
    os.id_os,
    s.descricao,
    os_s.quantidade,
    os_s.valor_unitario,
    (os_s.quantidade * os_s.valor_unitario) AS total_servico
FROM os_servico os_s
JOIN servico s       ON os_s.id_servico = s.id_servico
JOIN ordem_servico os ON os_s.id_os = os.id_os;

-- 4) ORDER BY: veículos ordenados por ano (do mais novo para o mais antigo)
SELECT placa, modelo, ano
FROM veiculo
ORDER BY ano DESC;

-- 5) HAVING: quantidade de OS por mecânico, filtrando quem tem pelo menos 1 OS
SELECT 
    m.nome AS mecanico,
    COUNT(os.id_os) AS qtde_os
FROM mecanico m
LEFT JOIN ordem_servico os ON m.id_mecanico = os.id_mecanico
GROUP BY m.nome
HAVING COUNT(os.id_os) > 0;

-- 6) JOIN: listar OS com cliente, veículo e mecânico
SELECT 
    os.id_os,
    c.nome      AS cliente,
    v.placa     AS veiculo,
    v.modelo,
    m.nome      AS mecanico,
    os.status,
    os.data_abertura,
    os.data_fechamento
FROM ordem_servico os
JOIN veiculo v   ON os.id_veiculo = v.id_veiculo
JOIN cliente c   ON v.id_cliente = c.id_cliente
JOIN mecanico m  ON os.id_mecanico = m.id_mecanico;

-- 7) JOIN + agregação: total de peças usadas por OS
SELECT 
    os.id_os,
    SUM(os_p.quantidade * os_p.valor_unitario) AS total_pecas
FROM ordem_servico os
JOIN os_peca os_p ON os.id_os = os_p.id_os
GROUP BY os.id_os;
