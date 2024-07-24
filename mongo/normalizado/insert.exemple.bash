// Insert into estado
db.estado.insertOne({
  "_id": ObjectId(),
  "nome": "State Name"
})

// Insert into cidade
db.cidade.insertOne({
  "_id": ObjectId(),
  "nome": "City Name",
  "estado_id": ObjectId("id_of_estado_document")  // Replace with actual ObjectId from estado
})

// Insert into pessoa
db.pessoa.insertOne({
  "_id": ObjectId(),
  "nome": "Person Name",
  "sexo": "M",
  "data_nascimento": ISODate("1990-01-01"),
  "cidade_id": ObjectId("id_of_cidade_document")  // Replace with actual ObjectId from cidade
})

// Insert into post
db.post.insertOne({
  "_id": ObjectId(),
  "titulo": "Post Title",
  "conteudo": "Post Content",
  "data_hora_publicacao": ISODate(),
  "data_hora_atualizacao": ISODate(),
  "likes": 0,
  "dislikes": 0,
  "visualizacoes": 0,
  "nota_post": 0.0,
  "pessoa_id": ObjectId("id_of_pessoa_document")  // Replace with actual ObjectId from pessoa
})

// Insert into comentario
db.comentario.insertOne({
  "_id": ObjectId(),
  "conteudo": "Comment Content",
  "data_hora": ISODate(),
  "pessoa_id": ObjectId("id_of_pessoa_document"),  // Replace with actual ObjectId from pessoa
  "post_id": ObjectId("id_of_post_document")      // Replace with actual ObjectId from post
})

// Insert into categoria
db.categoria.insertOne({
  "_id": ObjectId(),
  "nome": "Category Name"
})

// Insert into post_categoria
db.post_categoria.insertOne({
  "_id": ObjectId(),
  "categoria_id": ObjectId("id_of_categoria_document"),  // Replace with actual ObjectId from categoria
  "post_id": ObjectId("id_of_post_document")              // Replace with actual ObjectId from post
})
