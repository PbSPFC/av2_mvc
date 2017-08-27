package controller;

import bean.Usuario;
import conexao.UsuarioDAO;
import java.io.IOException;
import static java.lang.System.out;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.Formata;

@WebServlet(name = "CadastroController", urlPatterns = {"/CadastroController"})
public class CadastroController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try { 
            /**
             * verifica se o script foi acessado diretamente neste script nao
             * foi incluida a validacao da session, uma vez que no cadastro a
             * session nao e necessaria
             */
            if (request.getParameter("id_cadastro") == null) {
                response.sendRedirect("index.jsp");
            }

            // instancia do bean para o usuario
            Usuario usuario = new Usuario();
            session.setAttribute("errCadastro", "");

            // adiciona os campos no objeto usuario
            usuario.setNome(request.getParameter("nome"));
            usuario.setEmail(request.getParameter("email"));
            usuario.setSenha(request.getParameter("senha"));
            usuario.setContraSenha(request.getParameter("confirmar"));

            // cria e percorre a lista de campos, certificando o preenchimento
            Map<String, String> campos = new HashMap<>();

            // recupera os campos validados
            campos = usuario.verificaDados();

            // objeto para converter a primeira letra em maíscula
            Formata letra = new Formata();

            String verifica = "";

            // percorre a lista e apresenta a mensagem de erro
            for (String key : campos.keySet()) {
                String value = campos.get(key);
                if (campos.get(key).equals("")) {
                    verifica = verifica + "&rarr; " + letra.firstUp(String.valueOf(key)) + "<br>";
                    session.setAttribute(key, "");
                } else {
                    session.setAttribute(key, value);
                }
            }

            // sessão para apresentar erros no cadastro
            if (!verifica.equals("")) {
                session.setAttribute("errCadastro", verifica);
            }

            // verifica o resuldado da validacao
            //if (campos.isEmpty()) { // nao ocorreram erros
            if (verifica.equals("")) { // nao ocorreram erros

                // instacia um DAO para o usuario
                UsuarioDAO usuarioDAO = new UsuarioDAO();

                // efetua a pesquisa para verificar se o usuario ja esta cadastrado
                usuarioDAO.getListaUsuariosBy("email", request.getParameter("email"));

                // se encontrou, emite mensagem
                if (usuarioDAO.getTotalRegistros() > 0) {
                    response.sendRedirect("cadastro.jsp?err=1");

                } else {

                    // informa os dados ao DAO para gravacao no banco de dados
                    usuarioDAO.adiciona(usuario);
                    request.setAttribute("usuario", usuario);
                    
                    session.setAttribute("errCadastro", "");
                    session.invalidate();

                    // redireciona para cadastrado com sucesso
                    
                    RequestDispatcher dispacher = request.getRequestDispatcher("cadastroSuccess.jsp");
                    dispacher.forward(request, response);
                }
            } else { // se a validacao nao funcionou, retorna com uma mensagem de erro
                response.sendRedirect("cadastro.jsp");
            }

        } catch (Exception e) {
            out.print(e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
