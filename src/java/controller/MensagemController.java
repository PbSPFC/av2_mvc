package controller;

import bean.Mensagem;
import conexao.MensagemDAO;
import java.io.IOException;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MensagemController", urlPatterns = {"/MensagemController"})
public class MensagemController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {

            // recupera o id do usuario autenticado
            int idUsuario = Integer.parseInt(request.getParameter("id_usuario").toString());

            // instancia o DAO da mensagem
            MensagemDAO mensagemDAO = new MensagemDAO();

            // formata o codigo de pagina para o banco de dados
            request.setCharacterEncoding("UTF-8");

            // cria uma nova mensagem
            Mensagem mensagem = new Mensagem();

            // informa os valores ao objeto mensagem
            mensagem.setIdUsuario(idUsuario);
            mensagem.setIdDestinatario(Integer.parseInt(request.getParameter("id_destinatario")));
            mensagem.setEmail(request.getParameter("email"));
            mensagem.setAssunto(request.getParameter("assunto"));
            mensagem.setMensagem(request.getParameter("mensagem"));

            out.print("<h1>Cadastro de Mensagem</h1>");

            // cria e percorre a lista de campos, certificando o preenchimento
            ArrayList<String> campos = new ArrayList<>();

            // recupera os campos validados
            campos = mensagem.verificaDados();

            // percorre a lista e apresenta a mensagem de erro
            for (String string : campos) {
                out.print(string.toString() + "<br>");
            }

            // verifica o resuldado da validacao
            if (campos.isEmpty()) { // nao ocorreram erros

                // faz a inclusao (persistencia) no bbanco de dados
                mensagemDAO.adiciona(mensagem);

                // envia para a pagina do menu
                response.sendRedirect("menu.jsp?msg=2");
            }

        } catch (Exception e) {
            out.print("Erro: " + e.getMessage());
        } catch (Throwable ex) {
            Logger.getLogger(MensagemController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
