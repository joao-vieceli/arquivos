-- ESTADO

-- Cria sequence
CREATE SEQUENCE estado_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- Cria Tabela
CREATE TABLE estado (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(255) NOT NULL
);

-- Cria Trigger para o id
CREATE OR REPLACE TRIGGER estado_trigger
BEFORE INSERT ON estado
FOR EACH ROW
BEGIN
  SELECT estado_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;

-------------------------------------------------------------------------------
-- CIDADE

CREATE SEQUENCE cidade_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE cidade (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(255) NOT NULL,
    estado_id NUMBER NOT NULL,
    FOREIGN KEY(estado_id) REFERENCES estado(id)
);

CREATE OR REPLACE TRIGGER cidade_trigger
BEFORE INSERT ON cidade
FOR EACH ROW
BEGIN
  SELECT cidade_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;

-------------------------------------------------------------------------------
-- PESSOA

CREATE SEQUENCE pessoa_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE pessoa (
    id NUMBER PRIMARY KEY,
    nome	VARCHAR2(255) NOT NULL,
    sexo	CHAR(1) NOT NULL,
    data_nascimento DATE NOT NULL,
    cidade_id	NUMBER NOT NULL,
    FOREIGN KEY(cidade_id) REFERENCES cidade(id)
);

CREATE OR REPLACE TRIGGER pessoa_trigger
BEFORE INSERT ON pessoa
FOR EACH ROW
BEGIN
  SELECT pessoa_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;

-------------------------------------------------------------------------------
-- POST

CREATE SEQUENCE post_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE post (
    id NUMBER PRIMARY KEY,
    titulo	VARCHAR2(255) NOT NULL,
    conteudo	CLOB NOT NULL,
    data_hora_publicacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    data_hora_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    likes	NUMBER DEFAULT 0 NOT NULL,
    dislikes NUMBER DEFAULT 0 NOT NULL,
    visualizacoes NUMBER DEFAULT 0 NOT NULL,
    nota_post NUMBER DEFAULT 0.0 NOT NULL,
    pessoa_id NUMBER NOT NULL,
    FOREIGN KEY(pessoa_id) REFERENCES pessoa(id)
);

CREATE OR REPLACE TRIGGER post_trigger
BEFORE INSERT ON post
FOR EACH ROW
BEGIN
  SELECT post_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;


-------------------------------------------------------------------------------
-- COMENTARIO
CREATE SEQUENCE comentario_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE comentario (
    id NUMBER PRIMARY KEY,
    conteudo	CLOB NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    pessoa_id NUMBER NOT NULL,
    post_id	NUMBER NOT NULL,
    FOREIGN KEY(pessoa_id) REFERENCES pessoa(id),
    FOREIGN KEY(post_id) REFERENCES post(id)
);

CREATE OR REPLACE TRIGGER comentario_trigger
BEFORE INSERT ON comentario
FOR EACH ROW
BEGIN
  SELECT comentario_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;

-------------------------------------------------------------------------------
-- CATEGORIA
CREATE SEQUENCE categoria_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE categoria (
    id NUMBER PRIMARY KEY,
    nome	VARCHAR2(255) NOT NULL
);


CREATE OR REPLACE TRIGGER categoria_trigger
BEFORE INSERT ON categoria
FOR EACH ROW
BEGIN
  SELECT categoria_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;

-------------------------------------------------------------------------------

CREATE SEQUENCE post_categoria_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE post_categoria (
    id NUMBER PRIMARY KEY,
    categoria_id	NUMBER NOT NULL,
    post_id	NUMBER NOT NULL,
    FOREIGN KEY(categoria_id) REFERENCES categoria(id),
    FOREIGN KEY(post_id) REFERENCES post(id)
);

CREATE OR REPLACE TRIGGER post_categoria_trigger
BEFORE INSERT ON post_categoria
FOR EACH ROW
BEGIN
  SELECT post_categoria_seq.NEXTVAL
  INTO :NEW.id
  FROM dual;
END;

