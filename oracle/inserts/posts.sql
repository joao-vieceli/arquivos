DECLARE
    v_titulo VARCHAR2(255);
    v_conteudo CLOB;
    v_data_hora_publicacao TIMESTAMP;
    v_data_hora_atualizacao TIMESTAMP;
    v_likes NUMBER;
    v_dislikes NUMBER;
    v_visualizacoes NUMBER;
    v_nota_post NUMBER;
    v_pessoa_id NUMBER;
BEGIN
    FOR i IN 1..1000000 LOOP 
        v_titulo := 'Título do Post ' || i;
        v_conteudo := 'Conteúdo do Post ' || i;
        
        v_data_hora_publicacao := SYSTIMESTAMP - DBMS_RANDOM.VALUE(1, 100);
        v_data_hora_atualizacao := v_data_hora_publicacao + DBMS_RANDOM.VALUE(0, 1);

        v_likes := TRUNC(DBMS_RANDOM.VALUE(0, 1000));
        v_dislikes := TRUNC(DBMS_RANDOM.VALUE(0, 100));
        v_visualizacoes := TRUNC(DBMS_RANDOM.VALUE(0, 10000));
        v_nota_post := DBMS_RANDOM.VALUE(0, 5);

        v_pessoa_id := TRUNC(DBMS_RANDOM.VALUE(1, 10000));

        INSERT INTO post (id, titulo, conteudo, data_hora_publicacao, data_hora_atualizacao, likes, dislikes, visualizacoes, nota_post, pessoa_id)
        VALUES (i, v_titulo, v_conteudo, v_data_hora_publicacao, v_data_hora_atualizacao, v_likes, v_dislikes, v_visualizacoes, v_nota_post, v_pessoa_id);

        IF MOD(i, 1000) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Numero atual: ' || i);
            COMMIT;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserções concluídas.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir: ' || SQLERRM);
        ROLLBACK;
END;

