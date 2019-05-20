<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
</head>
<body>
	<form method="POST" action="login.jsp">
		<input type="text" placeholder="email" id="email" name="email"/>
		<br>
		<% 
			boolean sucessoLogin = (session.getAttribute("erroLogin") == null);
		
			if(!sucessoLogin) {
				
		%>
			<script type="text/javascript">
				M.toast({html: '<%= session.getAttribute("erroLogin")%>', classes: "rounded"});
			</script>
		<% 
				session.removeAttribute("erroLogin");
			}
		%>
		<input type="password" placeholder="senha" id="senha" name="senha"/>
		<br>
		<input type="submit" value="entrar">
	</form>
</body>
</html>