<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bd.dbos.Usuario" errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		if(session.getAttribute("usuario") == null)
			response.sendRedirect("logout.jsp");
	
		if(session.getAttribute("msgAtualizacao") != null) {
			
	%>
		<script type="text/javascript">
			M.toast({html: '<%= session.getAttribute("msgAtualizacao")%>', classes: "rounded"});
		</script>
	<% 
			session.removeAttribute("msgAtualizacao");
		}
	%>
	<jsp:include page="navbar.jsp"></jsp:include>
	<%
		Usuario usuario = (Usuario)session.getAttribute("usuario");
	%>
	<div class="container center-align">
		<div class="row">
			<br>
		</div>
		<div class="row">
			<center>
				<img class="materialboxed circle" width="150px" src="img/tux.png">
			</center>
			<h4>${usuario.getNome()}</h4>
			<h6>${usuario.getEmail()}</h6>
		</div>
		<div class="row">
			<a class="btn modal-trigger pink darken-1" href="#modal1">
				editar informações
				<i class="material-icons left">edit</i>
			</a>
		</div>
	</div>
	
	<div id="modal1" class="modal">
	  <div class="modal-content container">
		<form action="atualizarUsuario.jsp" id="formEmail">
			<h5>suas informações</h5>
			<br>
			<input type="text" placeholder="nome" name="nome" id="nome" value="${usuario.getNome()}"/>
			<br>
			<input type="text" placeholder="email" name="email" id="email" value="${usuario.getEmail()}"/>
			<br>
			<input type="password" placeholder="senha" name="senha" id="senha"/>
			<br>
			<br>
			<button type="submit" id="botao" class="btn pink darken-1">
				salvar
				<i class="material-icons right">save_alt</i>
			</button>
			<br>
			<br>
		</form>
	  </div>
	</div>
	
	
	
	
	<script>
		$(document).ready(function(){
		    $('.materialboxed').materialbox();
		});
	</script>
</body>
</html>