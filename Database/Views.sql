CREATE VIEW vw_livros_mais_vendidos AS
SELECT Livros.nome, Itens_Pedido.quantidade 
FROM Itens_Pedido 
JOIN Livros on Itens_Pedido.livro_id=Livros.id DESC LIMIT 10;

CREATE VIEW vw_clientes_ativos AS
SELECT 