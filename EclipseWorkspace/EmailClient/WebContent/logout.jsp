<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		session.removeAttribute("usuario");
		session.removeAttribute("erroLogin");
		session.removeAttribute("todosEmails");
		session.removeAttribute("todasMensagens");
		session.removeAttribute("msgAtualizacao");
		session.removeAttribute("todosEmailHandlers");
	
		response.sendRedirect("index.jsp");
	%>
</body>
</html>