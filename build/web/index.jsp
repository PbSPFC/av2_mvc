<%@page import="java.util.Calendar"%>
<%@page import="utils.Formata"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <div class="container">
            <form class="form-signin" role="form" action="LoginController" method="post">
                <label for="inputLogin" class="sr-only">Usuário (e-mail):</label>
                <input type="email" id="inputLogin" name="login" class="form-control" placeholder="Usuário (e-mail)" required>
                <br>
                <label for="inputPassword" class="sr-only">Senha:</label>
                <input type="password" id="inputPassword" name="senha" class="form-control" placeholder="Senha" required>
                <br>

                <%
                    try {
                        if (!session.getAttribute("errLogin").equals("")) {

                        }%>
                <div class="alert alert-danger" role="alert"><%=session.getAttribute("errLogin")%></div>
                <%} catch (Exception e) {
                    }%>

                <button class="btn btn-lg btn-primary btn-block" type="submit">Efetuar Login</button>
            </form>

            <form class="form-signin" role="form" action="cadastro.jsp" method="post">
                <button class="btn btn-lg btn-primary btn-block" type="submit">Novo Cadastro</button>
            </form>
        </div> <!-- /container -->
    </body>
</html>
