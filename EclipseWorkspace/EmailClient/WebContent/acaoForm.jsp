<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="bd.dbos.*, bd.daos.*, email.EmailHandler, javax.mail.*, javax.mail.internet.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int indexMensagem = Integer.parseInt(request.getParameter("index"));
		ArrayList<Message> mensagens = (ArrayList<Message>)session.getAttribute("todasMensagens");
		Message mensagem = mensagens.get(indexMensagem);
		String acao = request.getParameter("acao");
				
		response.sendRedirect("principal.jsp");
	%>
</body>
</html>