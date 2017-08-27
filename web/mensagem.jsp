<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="bean.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="conexao.UsuarioDAO"%>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="ISO-8859-1"%>
<%@include file="verificaSessao.jsp" %>


<!-- inclui a barra superior -->
<%@include file="topo.jsp" %>

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
                            <select name="id_destinatario" class="selectpicker" data-width="auto">

                                <%  
                                    UsuarioDAO usuarioDAO = new UsuarioDAO();
                                    List<Usuario> usuarios = usuarioDAO.getListaUsuariosBy("", "");

                                    String id = String.valueOf(session.getAttribute("id"));
                                    String email = null;
                                    for (Usuario destinatario : usuarios) {
                                        if (!id.equals(String.valueOf(destinatario.getId()))) {
                                            out.print("<option value=\"" + destinatario.getId() + "\">" + destinatario.getNome() + "  (" + destinatario.getEmail() + ")");
                                            email = destinatario.getEmail();
                                            out.print("</option>" + "\n");
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>                    
                    <div class="form-group">
                        <label for="inputAssunto" class="col-lg-2 control-label">Assunto</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="inputAssunto" name="assunto" placeholder="Digite o assunto" value="" required>
                        </div>
                    </div>
                    <!--<div class="form-group">
                        <label for="inputEmail" class="col-lg-2 control-label">E-mail</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="inputEmail" name="email" placeholder="Digite o e-mail do destinatário" value="" required>
                        </div>
                    </div>-->
                    
                        <input type="hidden" name="email" value="<%= email %>" >
                    
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
                <input type="hidden" name="id_usuario" value="<%=session.getAttribute("id")%>">
            </form>
        </div>
    </div> 
</div>
</body>
</html>