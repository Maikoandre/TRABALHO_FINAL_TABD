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

CREATE VIEW vw_relatorio_vendas AS
SELECT
    c.nome AS categoria,
    l.autor,
    SUM(ip.quantidade) AS total_vendido,
    MIN(p.data_pedido) AS data_inicio,
    MAX(p.data_pedido) AS data_fim
FROM Itens_Pedido ip
         JOIN Livros l ON ip.livro_id = l.id
         JOIN Categorias c ON l.categoria_id = c.id
         JOIN Pedidos p ON ip.pedido_id = p.id
GROUP BY c.nome, l.autor;
