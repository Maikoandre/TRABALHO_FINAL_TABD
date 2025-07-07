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
CREATE FUNCTION login_cliente (
    p_email VARCHAR(255),
    p_senha VARCHAR(255)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT;
    SELECT id INTO v_id
    FROM Clientes
    WHERE email = p_email AND senha = SHA2(p_senha, 255);
    RETURN v_id;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION recuperar_senha (
    p_email VARCHAR(255)
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE v_senha VARCHAR(255);
    SELECT senha INTO v_senha
    FROM Clientes
    WHERE email = p_email;
    RETURN v_senha;
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

DELIMITER //
CREATE FUNCTION calcular_total_pedido (
    p_pedido_id INT,
    p_frete DECIMAL(10,2),
    p_taxa_imposto DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT SUM(quantidade * preco_unitario)
    INTO v_total
    FROM Itens_Pedido
    WHERE pedido_id = p_pedido_id;

    SET v_total = v_total + p_frete + (v_total * (p_taxa_imposto / 100));
    RETURN v_total;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE atualizar_status_pedido (
    IN p_pedido_id INT,
    IN p_novo_status ENUM('Aberto', 'Enviado', 'Entregue', 'Cancelado')
)
BEGIN
    UPDATE Pedidos
    SET status = p_novo_status
    WHERE id = p_pedido_id;
END;
//
DELIMITER ;
