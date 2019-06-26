<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="container">
		<h3>ops! temos um erro aqui...</h3>
		<h4> <span class="ascii">(╯°□°）╯︵ ┻━┻</span></h4>
		<div class="chip">
		para desenvolvedores: <%= exception.getClass() %> - <%= exception.getMessage() %>
		</div>
		<br>
		<a href="logout.jsp"><span>voltar para a página inicial</span></a>
	</div>
</body>
</html>