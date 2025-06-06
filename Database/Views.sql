CREATE VIEW vw_livros_mais_vendidos AS
SELECT lv.titulo as Titulo_Livro, SUM(ip.quantidade) AS Total_Vendido
FROM Itens_Pedido AS ip
JOIN Livros as lv on ip.livro_id=lv.id DESC LIMIT 10
GROUP BY lv.id, lv.titulo
ORDER BY Total_Vendido DESC;

CREATE VIEW vw_estoque_baixo AS
SELECT id as ID_Livro, titulo as Titulo_Livro, quantidade as Quantidade_Estoque
FROM Livros
WHERE quantidade_estoque < 10;

CREATE VIEW vw_clientes_ativos AS
SELECT DISTINCT c.id AS ID_Cliente, c.nome AS Nome_Cliente, c.email AS Email
FROM Clientes AS c
JOIN Pedidos AS p ON c.id=p.cliente_id
WHERE p.data_pedido >= DATE('now', '-6 months');