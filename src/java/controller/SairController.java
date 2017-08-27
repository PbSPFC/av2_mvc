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

@WebServlet(name = "SairController", urlPatterns = {"/SairController"})
public class SairController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        // atribui valor vazio para a sessao
        session.setAttribute("id", "");
        session.setAttribute("nome", "");

        // invalida sessao
        session.invalidate();

        // redireciona para a pagina inicial
        response.sendRedirect("index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
