<%@page import="bean.Mensagem"%>
<%@page import="conexao.MensagemDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="bean.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="conexao.UsuarioDAO"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>
<%@include file="verificaSessao.jsp" %>


<!-- inclui a barra superior -->
<%@include file="topo.jsp" %>
<%    
    String destinatario = null;
    String email = null;
    String assunto = null;
    
    try {
        String id = String.valueOf(session.getAttribute("id")).toString();
        
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        MensagemDAO mensagemDAO = new MensagemDAO();
        List<Mensagem> mensagens = mensagemDAO.getListaMensagensBy("id", request.getParameter("idMsg"));

        for (Mensagem mensagem : mensagens) {
            
            destinatario = mensagem.getDestinatario();
            email = mensagem.getEmail();
            assunto = mensagem.getAssunto();
            
            
            if ("cxe".equals(request.getParameter("tipo"))) {
                mensagem.setLida(1);
                mensagemDAO.lida(mensagem);
            }
%>
<!-- Mostrar msg escolhida para ser respondida -->
<div class="container col-md-6 col-md-offset-3">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title h1">Detalhes da Mensagem</h3>
        </div>
        <div class="panel-body">
            <form name="verMensagem" class="form-horizontal" action="<%=request.getParameter("pg")%>.jsp" method="post">
                <fieldset>
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
                            Remetente
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
                            <button type="submit" name="operacao" class="btn btn-primary" value="do_voltar">Voltar</button>
                        </div>
                    </div>                            
                </fieldset>
            </form>
        </div>
    </div> 
</div>
<%
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>                           
                        
<!-- Mostrar div de resposta -->
<!-- Painel do cadastro -->
<div class="container col-md-6 col-md-offset-3">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title h1">Enviar Mensagem</h3>
        </div>
        <div class="panel-body">
            <form name="sendMessage" class="form-horizontal" action="MensagemController" method="post">
                <fieldset>
                    <div class="form-group">
                        <label for="inputDestinatario" class="col-lg-2 control-label">Destinatário</label>
                        <div class="col-lg-10">
                            <!--<input type="text" class="form-control" id="inputDestinatario" name="destinatario" placeholder="Digite o nome do destinatário" value="" required>-->
                            <input type="text" class="form-control" disabled="true" id="inputDestinatario" placeholder="" value="<%= destinatario %> (<%= email %>)">
                        </div>
                    </div>                    
                    <div class="form-group">
                        <label for="inputAssunto" class="col-lg-2 control-label">Assunto</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" disabled="true" id="inputAssunto" placeholder="Digite o assunto" value="<%= assunto %>">
                        </div>
                    </div>
                    <!--<div class="form-group">
                        <label for="inputEmail" class="col-lg-2 control-label">E-mail</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="inputEmail" name="email" placeholder="Digite o e-mail do destinatário" value="" required>
                        </div>
                    </div>-->
                    
                        
                    
                    <div class="form-group">
                        <label for="inputMensagem" class="col-lg-2 control-label">Mensagem</label>
                        <div class="col-lg-10">
                            <textarea name="mensagem" rows="5" class="form-control" id="inputMensagem" placeholder="Digite a mensagem" required></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-6 col-lg-offset-2">
                            <button type="submit" name="operacao" class="btn btn-primary" value="do_enviar">Enviar</button>
                        </div>
                    </div>                            
                </fieldset>
                <input type="hidden" name="id_destinatario" value="<%= request.getParameter("idDest") %>" >
                <input type="hidden" name="email" value="<%= email %>" >
                <input type="hidden" name="assunto" value="<%= assunto %>" >
                <input type="hidden" name="id_usuario" value="<%=session.getAttribute("id")%>">
            </form>
        </div>
    </div> 
</div>
</body>
</html>