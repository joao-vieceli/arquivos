DECLARE
    v_total_comentarios NUMBER := 10000000; 
    v_batch_size NUMBER := 1000;          
    v_pessoa_id NUMBER;
    v_post_id NUMBER;
    v_conteudo CLOB;
BEGIN
    FOR i IN 1..CEIL(v_total_comentarios / v_batch_size) LOOP
        FOR j IN 1..v_batch_size LOOP
            v_pessoa_id := TRUNC(DBMS_RANDOM.VALUE(1, 10000));
            v_post_id := TRUNC(DBMS_RANDOM.VALUE(1, 1000000)); 
            
            v_conteudo := 'Conteúdo do comentário ' || (i * v_batch_size + j);

            INSERT INTO comentario (id, conteudo, data_hora, pessoa_id, post_id)
            VALUES (i * v_batch_size + j, v_conteudo,
                    SYSTIMESTAMP - DBMS_RANDOM.VALUE(1, 1000), v_pessoa_id, v_post_id);

            IF MOD(j, 10000) = 0 THEN
                COMMIT;
                DBMS_OUTPUT.PUT_LINE('Numero atual: ' || i);

            END IF;
        END LOOP;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserções de comentários concluídas.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir comentários: ' || SQLERRM);
        ROLLBACK;
END;