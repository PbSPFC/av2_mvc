package controller;

import bean.Usuario;
import conexao.UsuarioDAO;
import java.io.IOException;
import static java.lang.System.out;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.Formata;

@WebServlet(name = "AlteraController", urlPatterns = {"/AlteraController"})
public class AlteraController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {

            String botao = request.getParameter("operacao");

            if (botao.equals("do_excluir")) {
                response.sendRedirect("delUsuario.jsp");
            }

            request.setCharacterEncoding("UTF-8");

            int id = Integer.parseInt(request.getParameter("id").toString());

            Usuario usuario = new Usuario();
            usuario.setId(id);
            usuario.setNome(request.getParameter("nome"));
            usuario.setEmail(request.getParameter("email"));
            usuario.setSenha(request.getParameter("senha"));

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.altera(usuario);

            session.setAttribute("nome", request.getParameter("nome"));

            response.sendRedirect("menu.jsp?msg=1");

        } catch (Exception e) {
            out.print(e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
