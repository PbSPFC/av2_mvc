<%@include file="verificaSessao.jsp" %>
<%@page import="conexao.ConnectionFactory"%>
<%@page import="conexao.UsuarioDAO"%>
<%@page import="bean.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>

<%    // variaveis para manipulacao dos dados
    String id = String.valueOf(session.getAttribute("id"));
    String nome = null;
    String email = null;
    String data = null;

    try {
        // instancia classe DAO do usuario
        UsuarioDAO usuarioDAO = new UsuarioDAO();

        // efetua busca do usuario
        List<Usuario> usuarios = usuarioDAO.getListaUsuariosBy("id", id);

        // efetua a formatacao da data para apresentar na tela
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");

        // percorre a lista para alimentar os campos
        for (Usuario usuario : usuarios) {
            id = String.valueOf(usuario.getId());
            nome = usuario.getNome();
            email = usuario.getEmail();
            data = fmt.format(usuario.getDataCadastro().getTimeInMillis());
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>

<!-- inclui a barra superior -->
<%@include file="topo.jsp" %>

<!-- Painel do cadastro -->
<div class="container col-md-6 col-md-offset-3">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title h1">Alterar Dados Cadastrais</h3>
        </div>
        <div class="panel-body">
            <form name="cadastro" class="form-horizontal" action="AlteraController" method="post">
                <fieldset>
                    <div class="form-group">
                        <label for="inputNome" class="col-lg-2 control-label">Nome</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="inputNome" name="nome" placeholder="Nome" value="<%=nome%>" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-lg-2 control-label">E-mail</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="inputEmail" name="email" placeholder="Informe o E-mail"  value="<%= email%>" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputDtCadastro" class="col-lg-2 control-label">Cadastro</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="inputEmail" placeholder=""  value="<%= data%>" disabled="">
                        </div>
                    </div>                                
                    <div class="form-group">
                        <div class="col-lg-6 col-lg-offset-2">
                            <button type="submit" name="operacao" class="btn btn-primary" value="do_alterar">Submeter Alterações</button>
                            <button type="submit" name="operacao" class="btn btn-danger" value="do_excluir">Excluir Cadastro</button>
                        </div>
                    </div>
                </fieldset>
                <input type="hidden" name="id" value="<%=id%>"><br>
            </form>        
        </div>
    </div>                
</div>
</body>
</html>