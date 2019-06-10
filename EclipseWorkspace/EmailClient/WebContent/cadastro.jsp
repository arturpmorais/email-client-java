<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="beans.CadastroBean, bd.daos.Usuarios, bd.dbos.Usuario"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="cadastroBean" class="beans.CadastroBean"></jsp:useBean>
	<jsp:setProperty name="cadastroBean" property="*"/>
	<%
		//session.setAttribute("usuario", new Usuario(15, "artur", "arturpmrs@gmail.com", "senha"));
		//response.sendRedirect("principal.jsp");
		try {
			if(Usuarios.cadastrado(cadastroBean.getEmail()))
				throw new Exception("Endereço de e-mail já cadastrado!");
			
			Usuarios.incluir(cadastroBean);
			session.removeAttribute("usuario");
			session.setAttribute("usuario", Usuarios.getUsuario(cadastroBean.getEmail()));
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