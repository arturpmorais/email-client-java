<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="beans.LoginBean"%>
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
		//autenticar(username, password)
		response.sendRedirect("index.jsp");
	%>
</body>
</html>