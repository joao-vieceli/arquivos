DECLARE
    v_total_pessoas NUMBER := 2;
    v_cidade_id NUMBER;
    v_nome_pessoa VARCHAR2(45);
    v_sobrenome_pessoa VARCHAR2(45);
    v_sexo_pessoa VARCHAR2(1);
    v_data_nascimento_pessoa DATE;
    v_range_dias NUMBER;

BEGIN
    FOR i IN 1..v_total_pessoas LOOP
        v_cidade_id := TRUNC(DBMS_RANDOM.VALUE(1, 5570));

        SELECT dbms_random.string('A', 10) INTO v_nome_pessoa FROM dual;
        SELECT dbms_random.string('A', 10) INTO v_sobrenome_pessoa FROM dual;

        IF dbms_random.value(0, 1) < 0.5 THEN
                v_sexo_pessoa := 'M';
            ELSE
                v_sexo_pessoa := 'F';
            END IF;


        v_range_dias := TRUNC(DBMS_RANDOM.VALUE(0, (TO_DATE('31-12-2015', 'DD-MM-YYYY') - TO_DATE('01-01-1700', 'DD-MM-YYYY'))));
   
        v_data_nascimento_pessoa := TO_DATE('01-01-1700', 'DD-MM-YYYY') + v_range_dias;
         INSERT INTO pessoa (nome, sexo, data_nascimento, cidade_id)
         VALUES (v_nome_pessoa || ' ' || v_sobrenome_pessoa, v_sexo_pessoa, v_data_nascimento_pessoa,  v_cidade_id);
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Script de inserção gerado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar script: ' || SQLERRM);
        ROLLBACK;
END;