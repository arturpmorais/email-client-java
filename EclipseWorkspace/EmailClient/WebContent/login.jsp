<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="beans.LoginBean, bd.daos.Usuarios, bd.dbos.Usuario, bd.daos.Emails"%>
<% %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="loginBean" class="beans.LoginBean"></jsp:useBean>
	<jsp:setProperty name="loginBean" property="*"/>
	<%
		//session.setAttribute("usuario", new Usuario(15, "artur", "arturpmrs@gmail.com", "senha"));
		//response.sendRedirect("principal.jsp");
		try {
			Usuarios.alterar(new Usuario(1, "Artur", "arturpmrs@gmail.com", "senha"));
			Usuarios.autenticarLogin(loginBean);
			session.setAttribute("usuario", Usuarios.getUsuario(loginBean.getEmail()));
			session.removeAttribute("erroLogin");
			response.sendRedirect("principal.jsp");
		} catch(Exception e) {
			
			session.setAttribute("erroLogin", e.getMessage());
			e.printStackTrace();
			
			response.sendRedirect("index.jsp");
		}
	%>
</body>
</html>