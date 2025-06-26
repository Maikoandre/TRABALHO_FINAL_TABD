CREATE DATABASE IF NOT EXISTS Bookflow DEFAULT CHARACTER SET = 'utf8mb4';

CREATE TABLE IF NOT EXISTS Categorias (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    CONSTRAINT pk_categoria_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Livros (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    ISBN CHAR(13) NOT NULL,
    editora VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    categoria_id INT,
    CONSTRAINT pk_livro_id PRIMARY KEY (id),
    CONSTRAINT fk_livro_categoria_id FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

CREATE TABLE IF NOT EXISTS Autores (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    CONSTRAINT pk_autor_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Editoras (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    CONSTRAINT pk_editora_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    CONSTRAINT pk_cliente_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Pedidos (
    id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('Aberto', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    CONSTRAINT pk_pedido_id PRIMARY KEY (id),
    CONSTRAINT fk_pedido_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

CREATE TABLE IF NOT EXISTS Itens_Pedido (
    id INT NOT NULL AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    livro_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_item_pedido_id PRIMARY KEY (id),
    CONSTRAINT fk_item_pedido_id FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    CONSTRAINT fk_item_livro_id FOREIGN KEY (livro_id) REFERENCES Livros(id)
);

CREATE TABLE IF NOT EXISTS Carrinho (
    id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    livro_id INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_carrinho_id PRIMARY KEY (id),
    CONSTRAINT fk_carrinho_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    CONSTRAINT fk_carrinho_livro_id FOREIGN KEY (livro_id) REFERENCES Livros(id)
);

INSERT INTO Categorias (nome) VALUES
('Ficção Científica'),
('Fantasia'),
('Romance'),
('Biografia'),
('Mistério');

INSERT INTO Autores (nome, nacionalidade, data_nascimento) VALUES
('Isaac Asimov', 'Russa-Americana', '1920-01-02'),
('J.R.R. Tolkien', 'Britânica', '1892-01-03'),
('Machado de Assis', 'Brasileira', '1839-06-21'),
('Walter Isaacson', 'Americana', '1952-05-20'),
('Stieg Larsson', 'Sueca', '1954-08-15');

INSERT INTO Editoras (nome, pais) VALUES
('Aleph', 'Brasil'),
('HarperCollins', 'EUA'),
('Antofágica', 'Brasil'),
('Companhia das Letras', 'Brasil');

INSERT INTO Livros (titulo, autor, ISBN, editora, preco, quantidade_estoque, categoria_id) VALUES
('Eu, Robô', 'Isaac Asimov', '9788576572008', 'Aleph', 54.90, 50, 1),
('O Senhor dos Anéis: A Sociedade do Anel', 'J.R.R. Tolkien', '9788595084759', 'HarperCollins', 79.90, 30, 2),
('Dom Casmurro', 'Machado de Assis', '9786586493000', 'Antofágica', 89.90, 40, 3),
('Steve Jobs', 'Walter Isaacson', '9788535919714', 'Companhia das Letras', 99.90, 20, 4),
('A Menina com a Tatuagem de Dragão', 'Stieg Larsson', '9788535913002', 'Companhia das Letras', 64.90, 60, 5),
('Fundação', 'Isaac Asimov', '9788576570240', 'Aleph', 49.90, 70, 1),
('O Hobbit', 'J.R.R. Tolkien', '9788595084742', 'HarperCollins', 45.00, 100, 2);

INSERT INTO Clientes (nome, email, senha, endereco) VALUES
('Ana Silva', 'ana.silva@email.com', 'senha123', 'Rua das Flores, 123, São Paulo, SP'),
('Bruno Costa', 'bruno.costa@email.com', 'senha456', 'Avenida Principal, 456, Rio de Janeiro, RJ'),
('Carla Dias', 'carla.dias@email.com', 'senha789', 'Praça da Árvore, 789, Belo Horizonte, MG');

INSERT INTO Pedidos (cliente_id, data_pedido, status) VALUES
(1, '2025-05-10', 'Entregue'),
(2, '2025-05-25', 'Enviado'),
(1, '2025-06-01', 'Aberto');

INSERT INTO Itens_Pedido (pedido_id, livro_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 54.90),  -- Pedido 1: Eu, Robô
(1, 3, 1, 89.90),  -- Pedido 2: Dom Casmurro
(2, 5, 1, 64.90),  -- Pedido 3: A Menina com a Tatuagem de Dragão
(3, 7, 2, 45.00);  -- Pedido 4: 2x O Hobbit

INSERT INTO Carrinho (cliente_id, livro_id, quantidade) VALUES
(2, 6, 1),  -- Bruno: Fundação
(3, 2, 1);  -- Carla: O Senhor dos Anéis
