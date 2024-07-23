CREATE TABLE "estado" (
    "id"   SERIAL PRIMARY KEY,
    "nome" TEXT   NOT NULL
);

CREATE TABLE "cidade" (
    "id"        SERIAL  PRIMARY KEY,
    "nome"      TEXT    NOT NULL,
    "estado_id"	INTEGER NOT NULL,

    FOREIGN KEY("estado_id") REFERENCES "estado"("id")
);

CREATE TABLE "pessoa" (
    "id"	      SERIAL     PRIMARY KEY,
    "nome"	      TEXT       NOT NULL,
    "sexo"	      VARCHAR(1) NOT NULL,
    "data_nascimento" DATE       NOT NULL,
    "cidade_id"	      INTEGER    NOT NULL,

    FOREIGN KEY("cidade_id") REFERENCES "cidade"("id")
);

CREATE TABLE "post" (
    "id"	            SERIAL    PRIMARY KEY,
    "titulo"	            TEXT      NOT NULL,
    "conteudo"	            TEXT      NOT NULL,
    "data_hora_publicacao"  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_hora_atualizacao" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "likes"	            INTEGER   NOT NULL DEFAULT 0,
    "dislikes"	            INTEGER   NOT NULL DEFAULT 0,
    "visualizacoes"	    INTEGER   NOT NULL DEFAULT 0,
    "nota_post"	            NUMERIC   NOT NULL DEFAULT 0.0,
    "pessoa_id"	            INTEGER   NOT NULL,

    FOREIGN KEY("pessoa_id") REFERENCES "pessoa"("id")
);

CREATE TABLE "comentario" (
    "id"	SERIAL    PRIMARY KEY,
    "conteudo"	TEXT      NOT NULL,
    "data_hora"	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pessoa_id"	INTEGER   NOT NULL,
    "post_id"	INTEGER   NOT NULL,

    FOREIGN KEY("pessoa_id") REFERENCES "pessoa"("id"),
    FOREIGN KEY("post_id")   REFERENCES "post"("id")
);

CREATE TABLE "categoria" (
    "id"   SERIAL PRIMARY KEY,
    "nome" TEXT   NOT NULL
);

CREATE TABLE "post_categoria" (
    "id"	   SERIAL  PRIMARY KEY,
    "categoria_id" INTEGER NOT NULL,
    "post_id"	   INTEGER NOT NULL,

    FOREIGN KEY("categoria_id") REFERENCES "categoria"("id"),
    FOREIGN KEY("post_id")      REFERENCES "post"("id")
);
