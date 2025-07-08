CREATE TRIGGER verificar_estoque
    BEFORE INSERT ON Itens_Pedido
    FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    DECLARE mensagem_erro VARCHAR(255);
    SELECT quantidade_estoque INTO estoque_atual FROM Livros WHERE id = NEW.livro_id;
    IF estoque_atual < NEW.quantidade THEN
        SET mensagem_erro = CONCAT('Estoque insuficiente. Disponível: ', estoque_atual);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensagem_erro;
END IF;
END;