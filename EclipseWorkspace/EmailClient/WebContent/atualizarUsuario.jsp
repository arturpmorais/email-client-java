<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bd.dbos.Usuario, bd.daos.Usuarios"
    errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Usuario usuarioAtualizado = (Usuario)session.getAttribute("usuario");
		usuarioAtualizado.setNome(request.getParameter("nome"));
		usuarioAtualizado.setEmail(request.getParameter("email"));
		usuarioAtualizado.setSenha(request.getParameter("senha"));
		
		Usuarios.alterar(usuarioAtualizado);
		session.setAttribute("usuario", usuarioAtualizado);
		session.setAttribute("msgAtualizacao", "Informações atualizadas!");
		
		response.sendRedirect("infos.jsp");
	%>
</body>
</html>