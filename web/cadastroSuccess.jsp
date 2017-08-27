<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="conexao.UsuarioDAO"%>
<%@page import="bean.Usuario"%>
<%@page import="java.sql.SQLException"%>
<%@page import="conexao.ConnectionFactory"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>

<html lang="pt">
    <head>
        <title>Controle de Mensagens</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <!-- <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script> -->
        <!-- <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"/></script> -->

        <!-- Custom styles for this template -->
        <link href="bootstrap/css/signin.css" rel="stylesheet">
        <!--
            <script type="text/javascript">$(document).ready(function () {
                    $("#inputLogin").mask("999.999.999-99");
                });
            </script>
        -->
    </head>
    <body>
        <%@include file="_topo.jsp" %>
        <%
            Usuario usuario = (Usuario) request.getAttribute("usuario");
        %>
        <div class="container col-md-8 col-md-offset-2">
            <div class="table-responsive">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                    </div>
                    <div class="panel-body">
                        <h3><%= usuario.getNome()%> seu cadastro foi efetuado com sucesso!</h3>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>E-mail</th>
                                </tr>
                            </thead>
                            <tbody>                    
                                <tr>
                                    <td><%= usuario.getNome()%></td>
                                    <td><%= usuario.getEmail()%></td>
                                </tr>                       
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div> 
    </body>
</html>