// Insert into cidade
db.cidade.insertOne({
  "_id": ObjectId(),
  "nome": "City Name",
  "estado": {                
    "estado_id": ObjectId(),
    "nome": "State Name"
  }
})

// Insert into pessoa
db.pessoa.insertOne({
  "_id": ObjectId(),
  "nome": "Person Name",
  "sexo": "M",
  "data_nascimento": ISODate("1990-01-01"),
  "cidade": {                
    "cidade_id": ObjectId()
  }
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
  "pessoa": {               
    "pessoa_id": ObjectId()
  },
  "categorias": [             
    {
      "categoria_id": ObjectId()
    }
  ]
})

// Insert into comentario
db.comentario.insertOne({
  "_id": ObjectId(),
  "conteudo": "Comment Content",
  "data_hora": ISODate(),
  "pessoa": {               
    "pessoa_id": ObjectId()
  },
  "post": {                 
    "post_id": ObjectId()
  }
})
