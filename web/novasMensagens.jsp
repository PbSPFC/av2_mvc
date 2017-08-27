<%@page import="bean.Mensagem"%>
<%@page import="java.util.List"%>
<%@page import="conexao.MensagemDAO"%>
<%@page import="conexao.UsuarioDAO"%>
<%
    String id = String.valueOf(session.getAttribute("id")).toString();
    UsuarioDAO usuarioDAO = new UsuarioDAO();

    MensagemDAO mensagemDAO = new MensagemDAO();

    List<Mensagem> mensagens = mensagemDAO.getListaMensagensBy("id_destinatario", id);

    int contador = 0;

    for (Mensagem mensagem : mensagens) {
        if (mensagem.getLida() != 1) {
            contador++;
        }
    }

    out.print("<sup>" + contador + " <sup>Novas</sup></sup>");
%>
