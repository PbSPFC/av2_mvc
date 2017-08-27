package conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @file ConnectionFactory.java
 * @brief Classe Fabrica de Conexoes
 * @author DE SOUZA, Edson Melo <souzaem at outlook.com>
 * @date 14/11/2014, 20:29:02
 */
public class ConnectionFactory {

    // Variaveis da conexao
    private final String driver = "com.mysql.jdbc.Driver";
    private final String host = "localhost:3306";
    private final String database = "mensagem";
    private final String usuario = "root";
    private final String senha = "pb";

    /**
     * metodo que retorna uma conexao
     *
     * @return conexao
     * @throws SQLException
     */
    public Connection getConnection() throws SQLException {
        try {

            // carrega o driver correspondente da conexao
            Class.forName(driver);

            // efetua a conexao com o banco de dados
            Connection conexao = DriverManager.getConnection("jdbc:mysql://"
                    + host + "/" + database, usuario, senha);

            // retorna uma conexao
            return conexao;

        } catch (SQLException e) {

            // tratamento de erros gerados pelo SQL
            throw new SQLException(e.getLocalizedMessage());

        } catch (ClassNotFoundException ex) {

            // grava um log com o erro gerado
            Logger.getLogger(ConnectionFactory.class.getName()).
                    log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
