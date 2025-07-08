CREATE DATABASE IF NOT EXISTS Bookflow DEFAULT CHARACTER SET = 'utf8mb4';
Use Bookflow;
CREATE TABLE IF NOT EXISTS Categorias (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Livros(
    id INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    ISBN CHAR(13) NOT NULL,
    editora VARCHAR(100) NOT NULL,
    preco DOUBLE NOT NULL,
    quantidade_estoque INT NOT NULL,
    categoria_id INT NOT NULL,
    CONSTRAINT fk_categoria_id FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

CREATE TABLE IF NOT EXISTS Autores(
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Editoras(
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Clientes (
    id INT AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NULL,
    CONSTRAINT pk_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Pedidos (
    id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('Aberto', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

CREATE TABLE IF NOT EXISTS Itens_Pedido (
    id INT AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    livro_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT pk_pedido_id FOREIGN KEY (pedido_id) REFERENCES Pedidos(id)
);

CREATE TABLE IF NOT EXISTS Carrinho (
    id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    livro_id INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_client_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    CONSTRAINT fk_livro_id FOREIGN KEY (livro_id) REFERENCES Livros(id)
);

INSERT INTO Categorias (id, nome, pais) VALUES
(1, 'Ficção Científica', 'EUA'),
(2, 'Fantasia', 'Reino Unido'),
(3, 'Romance', 'Brasil'),
(4, 'Biografia', 'EUA'),
(5, 'Mistério', 'Suécia');

INSERT INTO Autores (id, nome, nacionalidade, data_nascimento) VALUES
(1, 'Isaac Asimov', 'Russa-Americana', '1920-01-02'),
(2, 'J.R.R. Tolkien', 'Britânica', '1892-01-03'),
(3, 'Machado de Assis', 'Brasileira', '1839-06-21'),
(4, 'Walter Isaacson', 'Americana', '1952-05-20'),
(5, 'Stieg Larsson', 'Sueca', '1954-08-15');

INSERT INTO Editoras (id, nome) VALUES
(1, 'Aleph'),
(2, 'HarperCollins'),
(3, 'Antofágica'),
(4, 'Companhia das Letras');

INSERT INTO Livros (id, titulo, autor, ISBN, editora, preco, quantidade_estoque, categoria_id) VALUES
(1, 'Eu, Robô', 'Isaac Asimov', '9788576572008', 'Aleph', 54.90, 50, 1),
(2, 'O Senhor dos Anéis: A Sociedade do Anel', 'J.R.R. Tolkien', '9788595084759', 'HarperCollins', 79.90, 30, 2),
(3, 'Dom Casmurro', 'Machado de Assis', '9786586493000', 'Antofágica', 89.90, 40, 3),
(4, 'Steve Jobs', 'Walter Isaacson', '9788535919714', 'Companhia das Letras', 99.90, 20, 4),
(5, 'A Menina com a Tatuagem de Dragão', 'Stieg Larsson', '9788535913002', 'Companhia das Letras', 64.90, 60, 5),
(6, 'Fundação', 'Isaac Asimov', '9788576570240', 'Aleph', 49.90, 70, 1),
(7, 'O Hobbit', 'J.R.R. Tolkien', '9788595084742', 'HarperCollins', 45.00, 100, 2);

INSERT INTO Clientes (nome, email, senha, endereco) VALUES
('Ana Silva', 'ana.silva@email.com', 'senha123', 'Rua das Flores, 123, São Paulo, SP'),
('Bruno Costa', 'bruno.costa@email.com', 'senha456', 'Avenida Principal, 456, Rio de Janeiro, RJ'),
('Carla Dias', 'carla.dias@email.com', 'senha789', 'Praça da Árvore, 789, Belo Horizonte, MG');

INSERT INTO Pedidos (cliente_id, data_pedido, status) VALUES
(1, '2025-05-10', 'Entregue'),
(2, '2025-05-25', 'Enviado'),
(1, '2025-06-01', 'Aberto');

INSERT INTO Itens_Pedido (pedido_id, livro_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 54.90),  -- Pedido 1 (Ana): Eu, Robô
(1, 3, 1, 89.90),  -- Pedido 1 (Ana): Dom Casmurro
(2, 5, 1, 64.90),  -- Pedido 2 (Bruno): A Menina com a Tatuagem de Dragão
(3, 7, 2, 45.00);  -- Pedido 3 (Ana): 2x O Hobbit

INSERT INTO Carrinho (cliente_id, livro_id, quantidade) VALUES
(2, 6, 1),
(3, 2, 1);

-- 1. Selecionar livros com preço acima de R$ 60.00
SELECT titulo, autor, preco FROM Livros WHERE preco > 60.00;

-- 2. Selecionar livros de uma categoria específica
SELECT
    L.titulo,
    L.autor,
    C.nome AS categoria
FROM
    Livros AS L
JOIN
    Categorias AS C ON L.categoria_id = C.id
WHERE
    C.nome = 'Ficção Científica';

-- 3. Selecionar pedidos com status 'Entregue'
SELECT
    P.id AS pedido_id,
    C.nome AS nome_cliente,
    P.data_pedido,
    P.status
FROM
    Pedidos AS P
JOIN
    Clientes AS C ON P.cliente_id = C.id
WHERE
    P.status = 'Entregue';

-- 4. Selecionar todos os itens de um pedido específico
SELECT
    IP.id AS item_pedido_id,
    L.titulo AS nome_livro,
    IP.quantidade,
    IP.preco_unitario
FROM
    Itens_Pedido AS IP
JOIN
    Livros AS L ON IP.livro_id = L.id
WHERE
    IP.pedido_id = 1;

-- 5. Selecionar todos os livros no carrinho de um cliente específico
SELECT
    C.nome AS nome_cliente,
    L.titulo AS nome_livro,
    CA.quantidade
FROM
    Carrinho AS CA
JOIN
    Clientes AS C ON CA.cliente_id = C.id
JOIN
    Livros AS L ON CA.livro_id = L.id
WHERE
    C.id = 2;

-- 6. Contar o número de livros por categoria
SELECT
    C.nome AS categoria,
    COUNT(L.id) AS total_livros
FROM
    Categorias AS C
LEFT JOIN
    Livros AS L ON C.id = L.categoria_id
GROUP BY
    C.nome
ORDER BY
    total_livros DESC;

-- 7. Calcular o valor total de um pedido 
SELECT
    P.id AS pedido_id,
    C.nome AS nome_cliente,
    SUM(IP.quantidade * IP.preco_unitario) AS valor_total_pedido
FROM
    Pedidos AS P
JOIN
    Itens_Pedido AS IP ON P.id = IP.pedido_id
JOIN
    Clientes AS C ON P.cliente_id = C.id
WHERE
    P.id = 1
GROUP BY
    P.id, C.nome;

-- 8. Listar livros e suas categorias, ordenados pelo título do livro
SELECT
    L.titulo,
    L.autor,
    C.nome AS categoria
FROM
    Livros AS L
JOIN
    Categorias AS C ON L.categoria_id = C.id
ORDER BY
    L.titulo ASC;

-- 9. Selecionar os 3 livros mais caros
SELECT titulo, autor, preco
FROM Livros
ORDER BY preco DESC
LIMIT 3;

-- 10. Selecionar clientes que fizeram pedidos e seus respectivos pedidos
SELECT
    CL.nome AS nome_cliente,
    P.id AS pedido_id,
    P.data_pedido,
    P.status
FROM
    Clientes AS CL
JOIN
    Pedidos AS P ON CL.id = P.cliente_id
ORDER BY
    CL.nome, P.data_pedido DESC;

-- 11. Relatório de vendas por categoria e período
SELECT c.nome AS categoria, SUM(ip.quantidade) AS total_vendido
FROM Itens_Pedido ip
         JOIN Livros l ON ip.livro_id = l.id
         JOIN Categorias c ON l.categoria_id = c.id
         JOIN Pedidos p ON ip.pedido_id = p.id
WHERE p.data_pedido BETWEEN '2025-01-01' AND '2025-06-30'
GROUP BY c.nome;

-- 12. relatório de vendas por autor
SELECT l.autor, SUM(ip.quantidade) AS total_vendas
FROM Itens_Pedido ip
         JOIN Livros l ON ip.livro_id = l.id
GROUP BY l.autor;