<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="beans.LoginBean, bd.daos.Usuarios,bd.dbos.Usuario"%>
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
		session.setAttribute("usuario", new Usuario(15, "artur", "arturpmrs@gmail.com", "senha"));
		response.sendRedirect("principal.jsp");
		
		/*
		if(Usuarios.autenticarLogin(loginBean)) {
			session.setAttribute("usuario", Usuarios.getUsuario(loginBean.getEmail()));
			session.removeAttribute("erroLogin");
			response.sendRedirect("principal.jsp");
		} else {
			session.setAttribute
			response.sendRedirect("index.jsp");
		}
		*/
	%>
</body>
</html>