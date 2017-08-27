<%@page import="bean.Usuario"%>
<%@page import="conexao.UsuarioDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="conexao.ConnectionFactory"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>

<%!
    String checkLogin(String email) {
        int contador = 0;
        String msg = "";
        try {

            // instancia a classe DAO para o usuario
            UsuarioDAO usuarioDAO = new UsuarioDAO();

            // recupera os dados do usuario e coloca em uma lista
            List<Usuario> usuario = usuarioDAO.getListaUsuariosBy("email", email);

            for (Usuario key : usuario) {
                contador++;
            }
        } catch (Exception e) {
        }

        if (contador == 1) {
            msg = "<br><div class=\"alert alert-danger\" role=\"alert\">E-mail já cadastrado!</div>";
        }
        return msg;
    }
%>

<%
    String email = request.getParameter("email").toString();
    out.print(checkLogin(email));
%>
