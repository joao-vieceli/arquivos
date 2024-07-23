-- 1- Quantidade de Posts (count) da base de dados que sejam das Categoria 2, 5 e 7.

SELECT 
    COUNT(*) 
FROM 
    post_categoria 
WHERE 
    categoria_id IN (2, 5, 7)
;

-- 2- Dados dos Posts (todas as colunas da tabela e dos joins) da base de dados, das Categoria 2, 5 e 7.

SELECT 
    * 
FROM 
               post 
    INNER JOIN pessoa         ON post.pessoa_id   = pessoa.id 
    INNER JOIN cidade         ON pessoa.cidade_id = cidade.id
    INNER JOIN estado         ON cidade.estado_id = estado.id
    INNER JOIN post_categoria ON post.id          = post_categoria.post_id 
    INNER JOIN categoria      ON categoria.id     = post_categoria.categoria_id
WHERE 
    categoria.id IN (2, 5, 7)
;

-- 3- Dados dos Posts (todas as colunas da tabela e dos joins) da base de dados de autores que residem no estado do RS.

SELECT 
    *
FROM 
               post 
    INNER JOIN pessoa         ON post.pessoa_id   = pessoa.id 
    INNER JOIN cidade         ON pessoa.cidade_id = cidade.id
    INNER JOIN estado         ON cidade.estado_id = estado.id
    INNER JOIN post_categoria ON post.id          = post_categoria.post_id 
    INNER JOIN categoria      ON categoria.id     = post_categoria.categoria_id
WHERE
    estado.id = 23
;

-- 4- Dados dos Posts (todas as colunas da tabela e dos joins) da base de dados, das Pessoas que tenham entre 15 e 18 anos, de autores do RS e somente das Categorias 3 e 6.

SELECT 
    *
FROM 
    post 
    INNER JOIN pessoa         ON post.pessoa_id   = pessoa.id 
    INNER JOIN cidade         ON pessoa.cidade_id = cidade.id
    INNER JOIN estado         ON cidade.estado_id = estado.id
    INNER JOIN post_categoria ON post.id          = post_categoria.post_id 
    INNER JOIN categoria      ON categoria.id     = post_categoria.categoria_id
WHERE
        EXTRACT(YEAR FROM age(pessoa.data_nascimento)) >= 15
    AND EXTRACT(YEAR FROM age(pessoa.data_nascimento)) <= 18
;

-- 5- Quantidade de comentários por tipo de Categoria de Post. Ex. Categ 1: 2000, Categ 2: 1570.

SELECT 
    categoria.nome, 
    COUNT(*)
FROM 
               comentario
    INNER JOIN post           ON post.id      = comentario.post_id
    INNER JOIN post_categoria ON post.id      = post_categoria.post_id
    INNER JOIN categoria      ON categoria.id = post_categoria.categoria_id
GROUP BY
    categoria.id
;

-- 6- Dados dos Posts (todas as colunas da tabela e dos joins) da base de dados e seus respectivos comentários, somente das pessoas de Sexo Feminino e que residam na Cidade de XXX. Escolher uma cidade existente na tabela.

SELECT 
    *
FROM 
               post
    INNER JOIN pessoa         ON post.pessoa_id   = pessoa.id
    INNER JOIN cidade         ON pessoa.cidade_id = cidade.id
    INNER JOIN estado         ON cidade.estado_id = estado.id
    INNER JOIN post_categoria ON post.id          = post_categoria.post_id
    INNER JOIN categoria      ON categoria.id     = post_categoria.categoria_id
    LEFT  JOIN comentario     ON post.id          = comentario.post_id
WHERE
    pessoa.sexo = 'F'
    AND cidade.nome = 'Porto Alegre'
;

-- 7- Dados dos Posts (todas as colunas da tabela e dos joins) da base de dados que tenham em seu conteúdo ou comentário as palavras “mouse” ou “teclado” ou “monitor”. Se essas palavras não existirem na sua tabela, substitua por palavras que existam.

SELECT 
    *
FROM 
               post
    INNER JOIN pessoa         ON post.pessoa_id   = pessoa.id
    INNER JOIN cidade         ON pessoa.cidade_id = cidade.id
    INNER JOIN estado         ON cidade.estado_id = estado.id
    INNER JOIN post_categoria ON post.id          = post_categoria.post_id
    INNER JOIN categoria      ON categoria.id     = post_categoria.categoria_id
    LEFT  JOIN comentario     ON post.id          = comentario.post_id
WHERE
    -- Nota trocar palavras aqui dentro, nao temos mouse teclado ou monitor
        post.conteudo ILIKE '%mouse%'
    OR  post.conteudo ILIKE '%teclado%'
    OR  post.conteudo ILIKE '%monitor%'
    OR  comentario.conteudo ILIKE '%mouse%'
    OR  comentario.conteudo ILIKE '%teclado%'
    OR  comentario.conteudo ILIKE '%monitor%'
LIMIT 1
;

-- 8- Ranking descendente dos Posts com base nos Likes. Exibir: Id, Titulo, Data Publicação, Autor, Categorias e Quantidade de Posts.

SELECT 
    post.id, 
    post.titulo, 
    post.data_hora_publicacao, 
    pessoa.nome AS autor, 
    STRING_AGG(DISTINCT categoria.nome, ', ') AS categorias,
    -- Achei esquisito o pedido de quantidade de posts, mas acho que é a quantidade de likes
    -- Mandei mensagem para o professor, mas por enquanto vou considerar que é a quantidade de likes
    post.likes
FROM 
               post
    INNER JOIN pessoa         ON post.pessoa_id   = pessoa.id
    LEFT  JOIN post_categoria ON post.id          = post_categoria.post_id
    LEFT  JOIN categoria      ON categoria.id     = post_categoria.categoria_id
GROUP BY
    post.id, 
    pessoa.id
ORDER BY
    post.likes DESC
;

-- 9- Ranking dos Posts com base na nota do post e suas categorias. Exibir uma lista descendente, da categoria com maior nota para a menor. O objetivo dessa consulta é saber quais são as categorias com maior nota dentro do Blog, ou seja, as mais populares.

SELECT 
    categoria.nome, 
    AVG(post.nota_post) AS nota_media
FROM 
               post
    INNER JOIN post_categoria ON post.id          = post_categoria.post_id
    INNER JOIN categoria      ON categoria.id     = post_categoria.categoria_id
GROUP BY
    categoria.id
ORDER BY
    nota_media DESC
;

-- 10- Quantidade de comentários realizados entre meia noite e 6h da manhã, de Posts com mais de 50 visualizações, das categorias 4 e 8.

SELECT 
    COUNT(*)
FROM 
               comentario
    INNER JOIN post           ON post.id      = comentario.post_id
    INNER JOIN post_categoria ON post.id      = post_categoria.post_id
WHERE
        EXTRACT(HOUR FROM comentario.data_hora) >= 0
    AND EXTRACT(HOUR FROM comentario.data_hora) <= 6
    AND post.visualizacoes > 50
    AND post_categoria.categoria_id IN (4, 8)
;
