package conexao;

import bean.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * @file UsuarioDAO.java
 * @brief Classe UsuarioDAO
 * @author DE SOUZA, Edson Melo <souzaem at outlook.com>
 * @date 14/11/2014, 21:00:46
 */
public class UsuarioDAO {

    // variaveis genericas
    private final Connection conexao;
    private String status;
    private int totalRegistros;
    private String criterios;

    /**
     * construtor inicializando a conexao
     *
     * @throws SQLException
     */
    public UsuarioDAO() throws SQLException {
        this.status = null;
        this.totalRegistros = 0;
        this.criterios = null;
        this.conexao = new ConnectionFactory().getConnection();
    }

    /**
     * adiciona um novo usuario
     *
     * @param usuario
     */
    public void adiciona(Usuario usuario) {
        String sql = "insert into usuario "
                + "(nome, email, "
                + "senha, data_cadastro)"
                + " values (?,?,?,?)";

        try {
            // seta os valores
            try ( // prepared statement para insercao
                    PreparedStatement stmt = conexao.prepareStatement(sql)) {

                // pega a data atual
                java.sql.Date dataAtual = new java.sql.Date(
                        Calendar.getInstance().getTimeInMillis());

                // seta os valores
                stmt.setString(1, usuario.getNome());
                stmt.setString(2, usuario.getEmail());
                stmt.setString(3, usuario.getSenha());
                stmt.setDate(4, dataAtual);

                // executa o sql
                stmt.execute();

                // fecha a conexao
                stmt.close();

                // retorna o status da operacao
                status = ("Dados incluídos com sucesso!");
            }
            // tratamento dos erros
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * altera dados do usuario
     *
     * @param usuario
     */
    public void altera(Usuario usuario) {
        String sql = "update usuario set nome=?, email=? where id = ?";

        try {
            // seta os valores
            try ( // prepared statement para insercao
                    PreparedStatement stmt = conexao.prepareStatement(sql)) {

                // seta os valores
                stmt.setString(1, usuario.getNome());
                stmt.setString(2, usuario.getEmail());
                stmt.setInt(3, usuario.getId());

                // executa o sql
                stmt.execute();

                // fecha a conexao
                stmt.close();

                // retorna o status da operacao
                status = ("Dados alterados com sucesso!");
            }
            // tratamento dos erros
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * altera senha do usuario
     *
     * @param usuario
     */
    public void alteraSenha(Usuario usuario) {
        String sql = "update usuario set senha=? where id = ?";

        try {
            // seta os valores
            try ( // prepared statement para insercao
                    PreparedStatement stmt = conexao.prepareStatement(sql)) {

                // seta os valores
                stmt.setString(1, usuario.getSenha());
                stmt.setInt(2, usuario.getId());

                // executa o sql
                stmt.execute();

                // fecha a conexao
                stmt.close();

                status = ("Senha alterada com sucesso!");
            }
            // tratamento dos erros
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * exclui um determinado usuario e todas as mensagens enviadas por ele
     *
     * @param usuario
     */
    public void exclui(Usuario usuario) {
        String sqlUsuario = "delete from usuario where id = ?";
        String sqlMensagens = "delete from mensagem where id_usuario = ?";
        
        try {
            // exclui o usuario
            try ( // prepared statement para insercao
                    PreparedStatement stmt = conexao.prepareStatement(sqlUsuario)) {

                // seta os valores
                stmt.setInt(1, usuario.getId());

                // executa o sql
                stmt.execute();

                // fecha a conexao
                stmt.close();

                // retorna o status da opercao
                status = ("Usuário excluído com sucesso!");
            }

            // eclui todas as mensagens
            try ( // prepared statement para insercao
                    PreparedStatement stmt = conexao.prepareStatement(sqlMensagens)) {

                // seta os valores
                stmt.setInt(1, usuario.getId());

                // executa o sql
                stmt.execute();

                // fecha a conexao
                stmt.close();

                // retorna o status da operacao
                status = ("Mensagens excluídas com sucesso!");
            }

            // tratamento dos erros
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * metodo generico que lista usuarios conforme parametro informado
     *
     * @param nomeDoCampo
     * @param valorProcurado
     * @return List usuarios
     */
    public List<Usuario> getListaUsuariosBy(String nomeDoCampo, String valorProcurado) {

        @SuppressWarnings("UnusedAssignment")
        String sql = null;

        // seleciona o parametro informado; monta a string SQL.
        switch (nomeDoCampo) {
            case "id":
                sql = "select * from usuario where id = "
                        + Integer.parseInt(valorProcurado);
                break;
            case "nome":
                sql = "select * from usuario where nome like '%"
                        + valorProcurado + "%' order by nome asc";
                break;
            case "email":
                sql = "select * from usuario where email like '%"
                        + valorProcurado + "%' order by nome asc";
                break;
            default:
                sql = "select * from usuario order by nome asc";
                break;
        }

        // retona o status da pesquisa
        criterios = nomeDoCampo + "=" + valorProcurado;

        try {
            @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
            List<Usuario> usuarios;
            usuarios = new ArrayList<>();

            // executa a pesquisa
            try (PreparedStatement stmt = this.conexao.
                    prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery()) {

                // percorre os registros e adiciona na lista
                while (rs.next()) {

                    // cria o objeto usuario
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNome(rs.getString("nome"));
                    usuario.setEmail(rs.getString("email"));

                    // trata o formato da data
                    Calendar data = Calendar.getInstance();
                    data.setTime(rs.getDate("data_cadastro"));
                    usuario.setDataCadastro(data);

                    // adiciona os dados na lista
                    usuarios.add(usuario);

                    // incrementa em um o numero de registros
                    totalRegistros++;
                }
                // fecha conexao
                rs.close();
                stmt.close();

                // retorna os usuarios lozalizados pelo criterio
                return usuarios;
            }

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * retorna o total de registros para uma query
     *
     * @return
     */
    public int getTotalRegistros() {
        return totalRegistros;
    }

    /**
     * retorna o campo e valor informado na query
     *
     * @return
     */
    public String getCriterios() {
        if (!this.criterios.equals("=")) {
            return ("Dados não localizados para [" + criterios + "]");
        } else {
            return ("Não há registros cadastrados!");
        }
    }

    /**
     * retorna o status da operacao
     * @return status
     */
    public String getStatus(){
        return status;
    }
    
    /**
     * Executa a operacao de login
     * 
     * @param email
     * @param senha
     * @return id e nome do usuario
     */
    public List<Usuario> getLogin(String email, String senha) {

        @SuppressWarnings("UnusedAssignment")
        String sql = "select * from usuario where "
                + " email='" + email
                + "' and senha='" + senha + "'";

        try {
            @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
            List<Usuario> usuarios;
            usuarios = new ArrayList<>();

            try (PreparedStatement stmt = this.conexao.
                    prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery()) {

                // percorre os registros e adiciona na lista
                while (rs.next()) {

                    // cria o objeto usuario
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNome(rs.getString("nome"));

                    // adiciona os dados na lista
                    usuarios.add(usuario);

                    // incrementa em um o numero de registros
                    totalRegistros++;
                }
                // fecha conexao
                rs.close();
                stmt.close();

                // retorna o usuario pesquisado, ou nao
                return usuarios;
            }

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
}
