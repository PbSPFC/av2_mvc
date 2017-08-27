<%@include file="verificaSessao.jsp" %>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="conexao.UsuarioDAO"%>
<%@page import="bean.Usuario"%>
<%@page import="java.sql.SQLException"%>
<%@page import="conexao.ConnectionFactory"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>


<!-- inclui a barra superior -->
<%@include file="topo.jsp" %>        
<%    try {
        UsuarioDAO usuarioDAO = new UsuarioDAO();

        List<Usuario> usuarios = usuarioDAO.getListaUsuariosBy("", "");

        if (usuarioDAO.getTotalRegistros() < 1) {
            out.print(usuarioDAO.getCriterios());
        } else {

            SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
%>
<div class="container col-md-8 col-md-offset-2">
    <div class="table-responsive">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h2 class="panel-title h1">Usuários Cadastrados: <%= usuarioDAO.getTotalRegistros()%></h2>
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Nome</th>
                            <th>E-mail</th>
                            <th>Data Cadastro</th>
                        </tr>
                    </thead>
                    <tbody>                    
                        <%
                            for (Usuario usuario : usuarios) {
                        %>
                        <tr>
                            <td><%= usuario.getNome()%></td>
                            <td><%= usuario.getEmail()%></td>
                            <td><%= fmt.format(usuario.getDataCadastro().getTimeInMillis())%></td>
                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                out.print(e.getMessage());
                            }
                        %>                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>        
</body>
</html>