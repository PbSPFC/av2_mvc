<%request.setCharacterEncoding("ISO-8859-1");%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>
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
    <!--
        <script type="text/javascript">$(document).ready(function () {
                $("#inputLogin").mask("999.999.999-99");
            });
        </script>
    -->

    <script type="text/javascript">
        function showHint(str)
        {
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    document.getElementById("resultado").innerHTML = xmlhttp.responseText;
                }
            };

            xmlhttp.open("GET", "checkLogin.jsp?email=" + str, true);
            xmlhttp.send();
        }
    </script>     
</head>
<body>
    <%@include file="_topo.jsp" %>

    <!-- Painel do cadastro -->
    <div class="container col-md-6 col-md-offset-3">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title h1">Novo Usuário</h3>
            </div>

            <%
                String nome = "";
                String email = "";
                String senha = "";
                String confirmar = "";

                try {
                    if (session.getAttribute("errCadastro").equals("")) {
                        nome = "";
                        email = "";
                        senha = "";
                        confirmar = "";
                    } else {
                        nome = String.valueOf(session.getAttribute("nome"));
                        email = String.valueOf(session.getAttribute("email"));
                        senha = String.valueOf(session.getAttribute("senha"));
                        confirmar = String.valueOf(session.getAttribute("confirmar"));
            %>
            <div class="alert alert-danger" role="alert">
                <strong>Atenção! Preencha os(s) campo(s) a seguir:</strong><br><br><%=session.getAttribute("errCadastro")%>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.getMessage();
                }
            %>                    
            <div class="panel-body">
                <form name="cadastro" class="form-horizontal" action="CadastroController" method="post">
                    <fieldset>
                        <div class="form-group">
                            <label for="inputNome" class="col-lg-2 control-label">Nome</label>
                            <div class="col-lg-10">
                                <input type="text" class="form-control" id="inputNome" name="nome" placeholder="Nome" value="<%=nome%>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail" class="col-lg-2 control-label">E-mail</label>
                            <div class="col-lg-10">
                                <input type="text" class="form-control" id="inputEmail" name="email" placeholder="Informe o E-mail" value="<%=email%>" onBlur="showHint(this.value);">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputSenha" class="col-lg-2 control-label">senha</label>
                            <div class="col-lg-10">
                                <input type="password" class="form-control" id="inputSenha" name="senha" placeholder="Informe a senha" value="<%=senha%>">
                            </div>
                        </div>                                
                        <div class="form-group">
                            <label for="inputContraSenha" class="col-lg-2 control-label">Confirmar</label>
                            <div class="col-lg-10">

                                <input type="password" class="form-control" id="inputContraSenha" name="confirmar" placeholder="Informe novamente a senha" value="<%=confirmar%>">

                                <div id="resultado"></div>

                                <%
                                    try {
                                        if (!request.getParameter("err").equals("")) { %>
                                <br><div class="alert alert-danger" role="alert">E-mail já cadastrado!</div>
                                <%
                                        }
                                    } catch (Exception e) {
                                    }
                                %>
                           </div>
                        </div>      
                       <div class="form-group">
                            <div class="col-lg-6 col-lg-offset-2">
                                <button type="submit" name="operacao" class="btn btn-primary" value="cadastrar">Prosseguir</button>
                            </div>

                        </div>

                    </fieldset>
                    <input type="hidden" name="id_cadastro" value="1">
                </form>        
            </div>      
        </div>                
    </div>
</body>
</html>
