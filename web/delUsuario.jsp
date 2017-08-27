<%@include file="verificaSessao.jsp" %>
<%@page import="conexao.ConnectionFactory"%>
<%@page import="conexao.UsuarioDAO"%>
<%@page import="bean.Usuario"%>
<%@page import="conexao.MensagemDAO"%>
<%@page import="bean.Mensagem"%>

<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>

<%    try {

        String nome = null;

        // recupera o id da sessao do usuario
        int id = Integer.parseInt(String.valueOf(session.getAttribute("id").toString()));

        // instancia o ben do usuario
        Usuario usuario = new Usuario();

        // informa o id ao bean
        usuario.setId(id);

        // instancia o DAO do usuario
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        usuarioDAO.getListaUsuariosBy("id", String.valueOf(session.getAttribute("id").toString()));

        // instancia de mensagem DAO para contagem das mensagens
        MensagemDAO mensagensDAO = new MensagemDAO();

        // recupera o total de mensagens para o usuario
        mensagensDAO.getListaMensagensBy("id_usuario", String.valueOf(session.getAttribute("id").toString()));

        // efetua a exclusao do usuario
        usuarioDAO.exclui(usuario);
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Controle de Mensagens</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <!-- Chamada ao css do framework Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- jQuery necessaria para o funcionamento do Bootstrap -->
        <script src="bootstrap/js/jquery-1.11.1.js"></script>

        <!-- Chamada ao framework Bootstrap -->
        <script src="bootstrap/js/bootstrap.min.js"></script>

        <!-- Mascara para o CPF -->
        <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
        <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"/></script>

    <!-- Custom styles for this template -->
    <link href="bootstrap/css/signin.css" rel="stylesheet">
</head>
<body>
    <!-- Menu de navegação fixo no topo -->
    <nav class="navbar navbar-inverse" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" 
                    data-target="#example-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">CONTROLE DE MENSAGENS V1.0</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-left">
                <li class="active"><a href="index.jsp">TELA DE LOGIN<span class="sr-only"></span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </nav>

<!-- Painel do cadastro -->
<div class="container col-md-6 col-md-offset-3">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title h1">Exclusão de Usuário</h3>
        </div>
        <div class="panel-body text-center">
            <%
                out.print("O usuário [<strong>" + session.getAttribute("nome") + "</strong>] foi excluído com sucesso!<br><br>");
                out.print("[<strong>" + mensagensDAO.getTotalRegistros() + "</strong>] mensagens também foram excluídas!<br><br>");
                out.print("<a href=\"index.jsp\">Página Inicial</a>");
            %>
        </div>
    </div>
</div>
</div>                
</div>
</body>
</html>

<%
    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>

