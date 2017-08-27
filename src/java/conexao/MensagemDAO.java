package conexao;

import bean.Mensagem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import utils.MD5;

/**
 * @file MensagemDAO.java
 * @brief Classe MensagemDAO
 * @author DE SOUZA, Edson Melo <souzaem at outlook.com>
 * @date 16/11/2014, 13:34:06
 */
public class MensagemDAO {

    // variaveis genericas
    private final Connection conexao;
    private String status;
    private int totalRegistros;
    private String criterios;

    /**
     * construtor inicializando (fabricando) a conexao
     *
     * @throws SQLException
     */
    public MensagemDAO() throws SQLException {
        this.status = null;
        this.totalRegistros = 0;
        this.criterios = null;
        this.conexao = new ConnectionFactory().getConnection();
    }

    /**
     * adiciona uma nova mensagem
     *
     * @param mensagem
     */
    public void adiciona(Mensagem mensagem) throws Exception, Throwable {
        String sql = "insert into mensagem "
                + "(id_usuario, id_destinatario, email, "
                + "assunto, mensagem, data_envio, hash, lida)"
                + " values (?,?,?,?,?,?,?,?)";

        try {
            // seta os valores
            try ( // prepared statement para insercao
                    PreparedStatement stmt = conexao.prepareStatement(sql)) {

                // pega a data atual
                java.sql.Date dataAtual = new java.sql.Date(
                        Calendar.getInstance().getTimeInMillis());

                // Cria um hash para agrupar as respostas (replay)
                MD5 hashCode = new MD5();
                String hash = hashCode.md5(mensagem.getAssunto() + String.valueOf(dataAtual));

                // seta os valores
                stmt.setInt(1, mensagem.getIdUsuario());
                stmt.setInt(2, mensagem.getIdDestinatario());
                stmt.setString(3, mensagem.getEmail());
                stmt.setString(4, mensagem.getAssunto());
                stmt.setString(5, mensagem.getMensagem());
                stmt.setDate(6, dataAtual);
                stmt.setString(7, hash);
                stmt.setInt(8, 0); // grava a mensagem como não lida

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
     * atualiza para lida uma mensagem
     *
     * @param mensagem
     */
    public void lida(Mensagem mensagem) {
         String sql = "update mensagem set lida = ? where id = ?";
        try {
            // marca mensagem como lida
            try ( // prepared statement para exclusão
                    PreparedStatement stmt = conexao.prepareStatement(sql)) {

                // seta os valores
                stmt.setInt(1, mensagem.getLida());
                stmt.setInt(2, mensagem.getId());

                // executa o sql
                stmt.execute();

                // fecha a conexao
                stmt.close();
            }
            // tratamento dos erros
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    
    /**
     * metodo generico que lista mensagems conforme parametro informado
     *
     * @param nomeDoCampo
     * @param valorProcurado
     * @return Lista de mensagens
     */
    public List<Mensagem> getListaMensagensBy(String nomeDoCampo, String valorProcurado) {

        @SuppressWarnings("UnusedAssignment")
        String sql = null;

        // seleciona o parametro informado (monta a string SQL)
        switch (nomeDoCampo) {
            case "id":
                //sql = "select * from mensagem where id = " + Integer.parseInt(valorProcurado);
                sql = "SELECT usuario.nome as nome, mensagem.id, mensagem.assunto, mensagem.id_usuario, mensagem.id_destinatario, mensagem.email,\n"
                        + "mensagem.mensagem, mensagem.data_envio, mensagem.lida \n"
                        + "\n"
                        + "FROM usuario INNER JOIN mensagem\n"
                        + "\n"
                        + "ON usuario.id = mensagem.id_usuario\n"
                        + "WHERE (((mensagem.id)=" + valorProcurado + "));";
                break;

            // caixa de entrada    
            case "id_usuario":
                sql = "SELECT usuario.nome as nome, \n"
                        + "mensagem.id,\n"
                        + "mensagem.assunto,\n"
                        + "mensagem.id_usuario,\n"
                        + "mensagem.id_destinatario,\n"
                        + "mensagem.email,\n"
                        + "mensagem.mensagem,\n"
                        + "mensagem.data_envio,\n"
                        + "mensagem.lida\n"
                        + "\n"
                        + "FROM usuario INNER JOIN mensagem\n"
                        + "ON usuario.id = mensagem.id_destinatario\n"
                        + "WHERE (((mensagem.id_usuario)=" + Integer.parseInt(valorProcurado) + "))";
                break;

            // caixa de entrada    
            case "id_destinatario":
                sql = "SELECT usuario.nome as nome, \n"
                        + "mensagem.id,\n"
                        + "mensagem.assunto,\n"
                        + "mensagem.id_usuario,\n"
                        + "mensagem.id_destinatario,\n"
                        + "mensagem.email,\n"
                        + "mensagem.mensagem,\n"
                        + "mensagem.data_envio,\n"
                        + "mensagem.lida\n"
                        + "\n"
                        + "FROM usuario INNER JOIN mensagem\n"
                        + "ON usuario.id = mensagem.id_usuario\n"
                        + "WHERE (((mensagem.id_destinatario)=" + Integer.parseInt(valorProcurado) + "))";
                break;

            case "assunto":
                sql = "select * from mensagem where assunto like '%"
                        + valorProcurado + "%' order by nome asc";
                break;
            case "email":
                sql = "select * from mensagem where email like '%"
                        + valorProcurado + "%' order by nome asc";
                break;
            default:
                sql = "select * from mensagem order by assunto asc";
                break;
        }

        // retorna o criterio utilizado na pesaqisa
        criterios = nomeDoCampo + "=" + valorProcurado;

        // executa a pesquisa
        try {
            @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
            List<Mensagem> mensagens;
            mensagens = new ArrayList<>();

            try (PreparedStatement stmt = this.conexao.
                    prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery()) {

                if ("id_destinatario".equals(nomeDoCampo)) {
                    // percorre os registros e adiciona na lista (caso encontre)
                    while (rs.next()) {

                        // cria o objeto mensagem
                        Mensagem mensagem = new Mensagem();
                        mensagem.setId(rs.getInt("id"));
                        mensagem.setIdUsuario(rs.getInt("id_usuario"));
                        mensagem.setRemetente(rs.getString("nome")); // insere o nome do remetente
                        mensagem.setAssunto(rs.getString("assunto"));
                        mensagem.setEmail(rs.getString("email"));
                        mensagem.setMensagem(rs.getString("mensagem"));
                        mensagem.setLida(rs.getInt("lida"));

                        // trata o formato da data
                        Calendar data = Calendar.getInstance();
                        data.setTime(rs.getDate("data_envio"));
                        mensagem.setDataEnvio(data);

                        // adiciona os dados na lista
                        mensagens.add(mensagem);

                        // incrementa em um o numero de registros
                        totalRegistros++;
                    }
                } else {
                    while (rs.next()) {

                        // cria o objeto mensagem
                        Mensagem mensagem = new Mensagem();
                        mensagem.setId(rs.getInt("id"));
                        mensagem.setIdUsuario(rs.getInt("id_usuario"));
                        mensagem.setIdDestinatario(rs.getInt("id_destinatario"));
                        mensagem.setDestinatario(rs.getString("nome")); // insere o nome do remetente
                        mensagem.setAssunto(rs.getString("assunto"));
                        mensagem.setEmail(rs.getString("email"));
                        mensagem.setMensagem(rs.getString("mensagem"));
                        mensagem.setLida(rs.getInt("lida"));

                        // trata o formato da data
                        Calendar data = Calendar.getInstance();
                        data.setTime(rs.getDate("data_envio"));
                        mensagem.setDataEnvio(data);

                        // adiciona os dados na lista
                        mensagens.add(mensagem);

                        // incrementa em um o numero de registros
                        totalRegistros++;
                    }
                }
                // fecha conexao
                rs.close();
                stmt.close();

                return mensagens;
            }

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public List<Mensagem> getListaMensagens(String idUsu, String idDest){
        @SuppressWarnings("UnusedAssignment")
        String sql = null;
        
        sql = "SELECT usuario.nome as nome, mensagem.id, mensagem.assunto, mensagem.id_usuario, mensagem.id_destinatario, mensagem.email,\n"
                        + "mensagem.mensagem, mensagem.data_envio, mensagem.lida \n"
                        + "\n"
                        + "FROM usuario INNER JOIN mensagem\n"
                        + "\n"
                        + "ON (((usuario.id) = " + Integer.parseInt(idDest) + "))\n"
                        + "WHERE (((mensagem.id_destinatario)=" + Integer.parseInt(idUsu) + "));";
        try {
            @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
            List<Mensagem> mensagens;
            mensagens = new ArrayList<>();

            try (PreparedStatement stmt = this.conexao.
                    prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery()) {

                    while (rs.next()) {

                        // cria o objeto mensagem
                        Mensagem mensagem = new Mensagem();
                        mensagem.setId(rs.getInt("id"));
                        mensagem.setIdUsuario(rs.getInt("id_usuario"));
                        mensagem.setIdDestinatario(rs.getInt("id_destinatario"));
                        mensagem.setDestinatario(rs.getString("nome")); // insere o nome do remetente
                        mensagem.setAssunto(rs.getString("assunto"));
                        mensagem.setEmail(rs.getString("email"));
                        mensagem.setMensagem(rs.getString("mensagem"));
                        mensagem.setLida(rs.getInt("lida"));

                        // trata o formato da data
                        Calendar data = Calendar.getInstance();
                        data.setTime(rs.getDate("data_envio"));
                        mensagem.setDataEnvio(data);

                        // adiciona os dados na lista
                        mensagens.add(mensagem);

                        // incrementa em um o numero de registros
                        totalRegistros++;
                    }
                
                // fecha conexao
                rs.close();
                stmt.close();

                return mensagens;
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
}
