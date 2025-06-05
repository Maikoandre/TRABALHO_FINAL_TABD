CREATE DATABASE IF NOT EXISTS Bookflow DEFAULT CHARACTER SET = 'utf8mb4';

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
    data_nascimento TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Editoras(
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Clientes (
    id INT AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NULL,
    CONSTRAINT pk_id PRIMARY KEY (id), 
);

CREATE TABLE IF NOT EXISTS Pedidos (
    id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido, DATE NOT NULL,
    status ENUM('Aberto', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

CREATE TABLE IF NOT EXISTS Itens_Pedido: (
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
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    CONSTRAINT fk_livro_id FOREIGN KEY (livro_id) REFERENCES Clientes(id)
);