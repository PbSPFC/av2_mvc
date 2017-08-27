<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Controle de Mensagens</title>
        <meta charset="ISO-8859-1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <!-- Chamada ao css do framework Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-select.css">

        <!-- jQuery necessaria para o funcionamento do Bootstrap -->
        <script src="jQuery/jquery-1.11.1.js"></script>

        <!-- Chamada ao framework Bootstrap -->
        <script src="bootstrap/js/bootstrap.min.js"></script>

        <script type="text/javascript" src="bootstrap/js/bootstrap-select.js"></script>

        <!-- Chamada ao framework Bootstrap Dropdown-->
        <script src="bootstrap/js/bootstrap-dropdown.js"></script>        

        <!-- Custom styles for this template -->
        <link href="bootstrap/css/signin.css" rel="stylesheet">

        <script type="text/javascript">
            
            $('.selectpicker').selectpicker({
                style: 'btn-info',
                size: 4
            });
        </script>

    </head>
    <body>
        <!-- Menu de navegação fixo no topo -->
        <nav class="navbar navbar-inverse" role="navigation">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="menu.jsp">CONTROLE DE MENSAGENS V1.0</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Menu de Opções <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="alteraDados.jsp">Alterar Dados Pessoais</a></li>
                                <li><a href="listaUsuarios.jsp">listar Todos Usuários</a></li>
                                <li class="divider"></li>
                                <li><a href="cxEntrada.jsp">Visualizar Mensagens</a></li>
                                <li><a href="mensagem.jsp">Enviar Mensagem</a></li>
                            </ul>
                        </li>
                    </ul>
                    <!--
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Pesquisar">
                        </div>
                        button type="submit" class="btn btn-default">Pesquisar</button>
                    </form>
                    -->
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">Usuário: <strong><%= session.getAttribute("nome")%></strong></a></li>
                        <li><a href="SairController">Sair</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>