DECLARE
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO categoria (id, nome)
        VALUES (i, 'Categoria ' || i);
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('inserts de categorias foram criados com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir categorias: ' || SQLERRM);
        ROLLBACK;
END;