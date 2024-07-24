<?php


function remover_caracteres_especiais($str) {
    $str = preg_replace('/[áàãâä]/ui', 'a', $str);
    $str = preg_replace('/[éèêë]/ui', 'e', $str);
    $str = preg_replace('/[íìîï]/ui', 'i', $str);
    $str = preg_replace('/[óòõôö]/ui', 'o', $str);
    $str = preg_replace('/[úùûü]/ui', 'u', $str);
    $str = preg_replace('/[ç]/ui', 'c', $str);
    $str = preg_replace('/[^a-z0-9]/i', ' ', $str); // Substitui caracteres especiais por '_'

    return $str;
}

function salvar_resultados_csv($arquivo_saida, $dados) {
    // Abre o arquivo CSV para escrita
    if (($handle = fopen($arquivo_saida, "w")) !== FALSE) {
        // Escreve cada linha de dados no arquivo CSV
        foreach ($dados as $linha) {
            fwrite($handle, $linha . "\n");
        }
        fclose($handle); // Fecha o arquivo
        return true; // Sucesso ao escrever no arquivo
    } else {
        return false; // Falha ao abrir o arquivo
    }
}

function gerar_sql_insercao($arquivo_csv) {
    $sql_inserts = array();

    if (($handle = fopen($arquivo_csv, "r")) !== FALSE) {

        while (($row = fgetcsv($handle, 1000, ",")) !== FALSE) {

            $cidade = trim($row[0]); 
            $cidade = remover_caracteres_especiais($cidade);

            $estado = rand(1, 27); 

            $sql = "INSERT INTO cidade (nome, estado_id) VALUES ('" . addslashes($cidade) . "', " . $estado . ");";

            $sql_inserts[] = $sql;
        }
        fclose($handle); // Fecha o arquivo
    }

    return $sql_inserts;
}




// Caminho para o arquivo CSV contendo cidades e estados
$arquivo_csv = 'municipios.csv';

// Chama a função para gerar os comandos SQL
$comandos_sql = gerar_sql_insercao($arquivo_csv);


$arquivo_saida = 'resultados_inserts.csv';
// Imprime os comandos SQL gerados
// foreach ($comandos_sql as $sql) {
//     echo $sql . "\n";
// }


$resultado = salvar_resultados_csv($arquivo_saida, $comandos_sql);

// Verifica se o salvamento foi bem-sucedido
if ($resultado) {
    echo "Resultados dos inserts foram salvos em '$arquivo_saida'.\n";
} else {
    echo "Erro ao salvar resultados em '$arquivo_saida'.\n";
}


?>
