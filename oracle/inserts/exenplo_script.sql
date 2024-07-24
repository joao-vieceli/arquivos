-- NOME ALEATORIO LITERALMENTE
DECLARE
    v_total_cidades NUMBER := 1000; -- Número total de cidades desejadas
    v_estado_id NUMBER;
    v_nome_cidade VARCHAR2(255);
BEGIN
    -- Loop para gerar os comandos INSERT
    FOR i IN 1..v_total_cidades LOOP
        -- Gera um estado_id aleatório entre 1 e 27
        v_estado_id := TRUNC(DBMS_RANDOM.VALUE(1, 28)); -- 28 para incluir o 27

        -- Gera um nome aleatório para a cidade
        SELECT dbms_random.string('A', 15) INTO v_nome_cidade FROM dual;

        -- Insere na tabela cidade
        INSERT INTO cidade (nome, estado_id)
        VALUES (v_nome_cidade, v_estado_id);
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Script de inserção gerado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar script: ' || SQLERRM);
        ROLLBACK;
END;