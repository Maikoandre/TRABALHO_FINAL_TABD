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
