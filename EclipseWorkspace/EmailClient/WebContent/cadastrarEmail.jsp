<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bd.daos.Emails, bd.dbos.Usuario, bd.dbos.Email, mycrypto.MyCrypto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="emailBean" class="beans.EmailBean"></jsp:useBean>
	<jsp:setProperty name="emailBean" property="*"/>
	<%
		Usuario usuario = (Usuario)session.getAttribute("usuario");	
		// MyCrypto crypto = new MyCrypto("l7sjfoed83j47ktk");
					
		Email novoEmail = new Email(
				usuario.getId(), 
				emailBean.getEmail(), 
				// crypto.getEncryptedString(emailBean.getSenha(), "chaveultrasecret"), 
				emailBean.getSenha(), 
				emailBean.getPorta(), 
				emailBean.getHost(), 
				emailBean.getProtocolo()
				);	
		Emails.incluir(novoEmail);
		
		response.sendRedirect("principal.jsp");
	%>
</body>
</html>