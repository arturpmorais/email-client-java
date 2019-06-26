<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bd.daos.Emails, bd.dbos.*" errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Usuario usuario = (Usuario)session.getAttribute("usuario");		
	
		int id = Integer.parseInt(request.getParameter("btnSubmit"));
		Emails.excluir(id);
		
		session.setAttribute("todosEmails", Emails.getEmails(usuario.getId()));
		session.setAttribute("msgAtualizacao", "Conta excluída!");
		
		response.sendRedirect("emails.jsp");
	%>
</body>
</html>