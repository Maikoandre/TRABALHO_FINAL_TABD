DELIMITER //
CREATE PROCEDURE cadastrar_cliente (
    IN p_nome VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_senha VARCHAR(255),
    IN p_endereco VARCHAR(255)
)
BEGIN
    INSERT INTO Clientes (nome, email, senha, endereco)
    VALUES (p_nome, p_email, SHA2(p_senha, 255), p_endereco);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE atualizar_cliente (
    IN p_id INT,
    IN p_nome VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_senha VARCHAR(255),
    IN p_endereco VARCHAR(255)
)
BEGIN
    UPDATE Clientes
    SET nome = p_nome,
        email = p_email,
        senha = SHA2(p_senha, 255),
        endereco = p_endereco
    WHERE id = p_id;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE excluir_cliente (
    IN p_id INT
)
BEGIN
    DELETE FROM Clientes WHERE id = p_id;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE criar_pedido (
    IN p_cliente_id INT,
    OUT p_pedido_id INT
)
BEGIN
    INSERT INTO Pedidos (cliente_id, data_pedido, status)
    VALUES (p_cliente_id, CURDATE(), 'Aberto');
    SET p_pedido_id = LAST_INSERT_ID();
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE adicionar_item_pedido (
    IN p_pedido_id INT,
    IN p_livro_id INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_preco DECIMAL(10,2);

    SELECT preco INTO v_preco FROM Livros WHERE id = p_livro_id;

    INSERT INTO Itens_Pedido (pedido_id, livro_id, quantidade, preco_unitario)
    VALUES (p_pedido_id, p_livro_id, p_quantidade, v_preco);

    UPDATE Livros
    SET quantidade_estoque = quantidade_estoque - p_quantidade
    WHERE id = p_livro_id;
END;
//
DELIMITER ;
