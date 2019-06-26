<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="bd.dbos.*, bd.daos.*, email.EmailHandler, javax.mail.*, javax.mail.internet.*, java.util.*" 
    errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		EmailHandler handler = new EmailHandler(); 
		String emailOrigem, emailDestino, assunto, conteudo; 
		emailOrigem = request.getParameter("emailOrigem");
		emailDestino = request.getParameter("emailDestino");
		assunto = request.getParameter("assunto");
		conteudo = request.getParameter("conteudo");
		
		ArrayList<EmailHandler>	todosEmailHandlers = (ArrayList<EmailHandler>)session.getAttribute("todosEmailHandlers");
		
		for(EmailHandler atual : todosEmailHandlers) {
			if(atual.getEmailAddress().equals(emailOrigem))
				handler = atual;
		}
		
		handler.sendEmail(emailDestino, assunto, conteudo);	
		
		response.sendRedirect("principal.jsp");
	%>
</body>
</html>