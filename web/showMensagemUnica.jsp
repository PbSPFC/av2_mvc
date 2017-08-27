<%@include file="verificaSessao.jsp" %>
<%@page import="conexao.MensagemDAO"%>
<%@page import="conexao.UsuarioDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="bean.Usuario"%>
<%@page import="bean.Mensagem"%>
<%@page import="java.sql.SQLException"%>
<%@page import="conexao.ConnectionFactory"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>

<!-- inclui a barra superior -->
<%@include file="topo.jsp" %>

<%    try {
        String id = String.valueOf(session.getAttribute("id")).toString();
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        MensagemDAO mensagemDAO = new MensagemDAO();
        List<Mensagem> mensagens = mensagemDAO.getListaMensagensBy("id", request.getParameter("idMensagem"));

        for (Mensagem mensagem : mensagens) {

            if ("cxe".equals(request.getParameter("tipo"))) {
                mensagem.setLida(1);
                mensagemDAO.lida(mensagem);
            }
%>
<!-- Painel do cadastro -->
<div class="container col-md-6 col-md-offset-3">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title h1">Detalhes da Mensagem</h3>
        </div>
        <div class="panel-body">
            <fieldset>
                <form name="sendMessage" class="form-horizontal" action="responderMensagem.jsp" method="post">
                    <div class="form-group">
                        <label for="inputAssunto" class="col-lg-2 control-label">Data</label>
                        <div class="col-lg-10">
                            <input type="text" disabled class="form-control" id="inputAssunto" name="assunto" placeholder="" value="<%= fmt.format(mensagem.getDataEnvio().getTimeInMillis())%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAssunto" class="col-lg-2 control-label">Assunto</label>
                        <div class="col-lg-10">
                            <input type="text" disabled="" class="form-control" id="inputAssunto" name="assunto" placeholder="" value="<%= mensagem.getAssunto()%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputDestinatario" class="col-lg-2 control-label">
                            <% if (request.getParameter("tipo").equals("cxe")) { %>
                            Remetente
                            <%} else {%>
                            Destinatário
                            <%}%>
                        </label>
                        <div class="col-lg-10">
                            <input type="text" disabled class="form-control" id="inputDestinatario" name="destinatario" placeholder="" value="<%= mensagem.getDestinatario()%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-lg-2 control-label">E-mail</label>
                        <div class="col-lg-10">
                            <input type="text" disabled class="form-control" id="inputEmail" name="email" placeholder="" value="<%= mensagem.getEmail()%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputMensagem" class="col-lg-2 control-label">Mensagem</label>
                        <div class="col-lg-10">
                            <textarea name="mensagem" disabled rows="5" class="form-control" id="inputMensagem" placeholder=""><%= mensagem.getMensagem()%></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-6 col-lg-offset-2">
                            <input type="hidden" name="pg" value="<%=request.getParameter("pg")%>" />
                            <input type="hidden" name="idDest" value="<%=request.getParameter("idUsuario")%>" />
                            <input type="hidden" name="idMsg" value="<%=request.getParameter("idMensagem")%>" />
                            <button type="submit" name="responder" class="btn btn-primary" value="Responder" >Responder</button>
                        </div>
                    </div>  
                </form>

                <form action="<%=request.getParameter("pg")%>.jsp">
                    <div class="form-group">
                        <div class="col-lg-6 col-lg-offset-2">
                            <button type="submit" name="operacao" class="btn btn-primary" value="do_voltar">Voltar</button>
                        </div>
                    </div> 
                </form>                         
            </fieldset>
        </div>
    </div> 
</div>
<%
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>
</body>
</html>