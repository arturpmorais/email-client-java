<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="enviarEmail.jsp">
		Novo Email
		<br>
		<input type="text" placeholder="enviar de:" name="emailOrigem" id="emailOrigem"/>
		<br>
		<input type="text" placeholder="enviar para:" name="emailDestino" id="emailDestino"/>
		<br>
		<input type="text" placeholder="assunto:" name="assunto" id="assunto"/>
		<br>
		<input type="text" placeholder="conteudo:" name="conteudo" id="conteudo"/>
		<br>
		<input type="submit" value="Enviar e-mail"/>
	</form>
</body>
</html>