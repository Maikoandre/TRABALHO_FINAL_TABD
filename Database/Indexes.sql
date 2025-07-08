CREATE INDEX idx_livros_quantidade_estoque
ON Livros (quantidade_estoque);

CREATE INDEX idx_pedidos_clientes_id
ON Pedidos (cliente_id);

CREATE INDEX idx_pedidos_data_pedido
ON Pedidos(data_pedido);

CREATE INDEX idx_itens_pedido_pedido_id
ON Itens_Pedido (pedido_id);

CREATE INDEX idx_itens_pedido_livro_id
ON Itens_Pedido (livro_id);

CREATE INDEX idx_itens_pedido_quantidade
ON Itens_Pedido (quantidade);

CREATE INDEX idx_itens_pedido_preco_unitario
ON Itens_Pedido (preco_unitario);

CREATE INDEX idx_carrinho_cliente_id
ON Carrinho (cliente_id);

CREATE INDEX idx_carrinho_livro_id
ON Carrinho (livro_id);