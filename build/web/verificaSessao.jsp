<%

    // verifica se existe uma sessao registrada, se nao houver, 
    // redireciona para pagina index.htm
    try {
        if (!session.getAttribute("id").equals("")) {
            //out.print("Usuário: " + session.getAttribute("nome"));
        }
    } catch (Exception e) {
        response.sendRedirect("index.jsp");
    }
%>