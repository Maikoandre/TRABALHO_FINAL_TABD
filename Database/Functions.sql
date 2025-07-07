
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
