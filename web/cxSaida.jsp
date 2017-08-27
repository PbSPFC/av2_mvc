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
        List<Mensagem> mensagens = null;

        mensagens = mensagemDAO.getListaMensagensBy("id_usuario", id);
%>

<script type="text/javascript">
    function conta(str)
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
                document.getElementById("totMsg").innerHTML = xmlhttp.responseText;
            }
        };

        xmlhttp.open("GET", "novasMensagens.jsp", true);
        xmlhttp.send();
    }

    conta(); // This will run on page load
    setInterval(function () {
        conta() // this will run after every 5 seconds
    }, 15000);

</script>     
<div class="container col-md-8 col-md-offset-2">
    <div class="table-responsive">
        <div class="panel panel-primary ">
            <div class="panel-heading">
                <h2 class="panel-title h1">Mensagens Enviadas: <%= mensagemDAO.getTotalRegistros()%>
                    &nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;
                    <a href="cxSaida.jsp" class="glyphicon glyphicon-arrow-up" title="Enviadas"></a>&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="cxEntrada.jsp" class="glyphicon glyphicon-arrow-down" title="Recebidas"></a><span id="totMsg"></span>
                </h2>
            </div>
            <div class="panel-body">
                <table class="table table-responsive">
                    <thead>
                        <tr>
                            <th>Lida</th>
                            <th>Enviada</th>
                            <th>Destinatário</th>
                            <th>Assunto</th>
                            <th class="text-center">Mensagem</th>
                        </tr>
                    </thead>
                    <tbody>                    
                        <%
                            for (Mensagem mensagem : mensagens) {
                                String status = null;
                                if (mensagem.getLida() == 1) {
                                    status = "<span class=\"glyphicon glyphicon-folder-open\">";
                                } else {
                                    status = "<span class=\"glyphicon glyphicon-folder-close\">";
                                }

                        %>
                        <tr>
                            <td><%= status%></td>
                            <td><%= fmt.format(mensagem.getDataEnvio().getTimeInMillis())%></td>
                            <td><%= mensagem.getDestinatario()%></td>
                            <td><%= mensagem.getAssunto()%></td>
                            <td class="text-center"><a href="showMensagem.jsp?idMensagem=<%= mensagem.getId()%>&tipo=cxs&pg=cxSaida" class="glyphicon glyphicon-eye-open"></a></td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.print(e.getMessage());
                            }
                        %>                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>        
</body>
</html>