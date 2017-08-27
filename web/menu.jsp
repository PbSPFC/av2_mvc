<%@include file="verificaSessao.jsp" %>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>

<!-- inclui a barra superior -->
<%@include file="topo.jsp" %>

<%            // Verifica se foi informada uma mensagem
    try {

        String titulo = null;
        String corpo = null;

        if (request.getParameter("msg").equals("1")) {
            // configura a mensagem a ser apresentada dependendo da operação realizada
            titulo = "Alteração de Dados Cadastrais";
            corpo = "Dados alterados com sucesso!";

        } else if (request.getParameter("msg").equals("2")) {
            titulo = "Envio de Mensagem";
            corpo = "Mensagem enviada com sucesso!";
        }
%>
<div style="margin-top: 200px"></div>
<div class="container col-md-4 col-md-offset-4">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h2 class="panel-title h1"><%= titulo%></h2>
        </div>
        <div class="panel-body">
            <h3><%= corpo%></h3>
        </div>                        
    </div>
</div>            
<%
} catch (Exception e) {
%>
<div style="margin-top: 200px"></div>
<div class="container col-md-4 col-md-offset-4">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h2 class="panel-title h1">Olá, seja bem vindo!</h2>
        </div>
        <div class="panel-body">
            <p>Para operar o sistema, utilize as opções no Menu localizado na barra no topo da janela.</p>
        </div>                        
    </div>
</div>
<%
    }
%>
</body>
</html>