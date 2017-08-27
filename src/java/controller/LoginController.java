package controller;

import bean.Usuario;
import conexao.UsuarioDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            // variaveis recuperadas do formulario de login
            String login = request.getParameter("login").toString();
            String senha = request.getParameter("senha").toString();
            // instancia a classe DAO para o usuario
            UsuarioDAO usuarioDAO = new UsuarioDAO();

            // recupera os dados do usuario e coloca em uma lista
            List<Usuario> usuarios = usuarioDAO.getLogin(login, senha);

            // verifica se foram encontrados registros
            if (usuarioDAO.getTotalRegistros() == 1) {

                // percorre a lista e inclui os dados do usuario na sessao
                for (Usuario usuario : usuarios) {
                    
                    session.setAttribute("id", usuario.getId());
                    session.setAttribute("nome", usuario.getNome());
                    response.sendRedirect("menu.jsp");
                    session.setAttribute("errLogin", null);
                }
                //} //lse if (usuarioDAO.getTotalRegistros() == 0) {
                //  response.sendRedirect("cadastro.jsp?err=Cadastro Inexistente!");

            } else {
                session.setAttribute("errLogin", "Usuário e/ou Senha incorretos");
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            // cria sessao para apresentar o erro na página de login
            session.setAttribute("errLogin", "Usuário e/ou Senha incorretos");
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
