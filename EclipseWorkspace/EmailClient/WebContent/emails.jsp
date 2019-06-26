<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bd.dbos.Usuario, java.util.*"
    errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<meta charset="UTF-8">
<style>
	.list i.circle {
	  padding: 10px;
	  background-color: rgba(0, 0, 0, 0.26);
	}
</style>
<title>eMali: emails cadastrados</title>
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
		ArrayList<Usuario> todosEmails = (ArrayList<Usuario>)session.getAttribute("todosEmails");
	%>
	<div class="container">
	<center>
	<ul class="list">
		<c:forEach var="email" items="${sessionScope.todosEmails}">
			<li class="waves-effect">
				<div class="row">
				  <div class="valign-wrapper">
				    <i class="material-icons left circle white-text">email</i>
				    <div class="title">
				      <h6>${email.getEmail()}</h6><br>
				      <span>
						porta: ${email.getPorta()} |  
						protocolo: ${email.getProtocolo()} |   
						host: ${email.getHost()}
				      </span>
				    </div>
				    <a class="modal-trigger blue btn white-text" href="#modal${email.getId()}">
						<i class="material-icons">edit</i>
					</a>
					<form action="excluirEmail.jsp">
						<button class="btn red" type="submit" id="btnSubmit" name="btnSubmit" value="${email.getId()}">
							<i class="material-icons">delete</i>
						</button>
					</form>
				  </div>
				</div>
			</li>
			
			<div id="modal${email.getId()}" class="modal">
			  <div class="modal-content container">
			    <h4>editar informações</h4>  
				<form action="atualizarEmail.jsp" id="formEmail">
					<input type="hidden" name="idEmail" id="idEmail" value="${email.getId()}"/>
					<input type="text" placeholder="endereço de e-mail:" name="email" id="email" value="${email.getEmail()}"/>
					<br>
					<input type="password" placeholder="senha:" name="senha" id="senha"/>
					<br>
					<input type="text" placeholder="porta:" name="porta" id="porta" value="${email.getPorta()}"/>
					<br>
					<input type="text" placeholder="host:" name="host" id="host" value="${email.getHost()}"/>
					<br>
					<input type="text" placeholder="protocolo:" name="protocolo" id="protocolo" value="${email.getProtocolo()}"/>
					<br>
					<br>
					<button type="submit" id="botao" class="btn pink darken-1">
						salvar alterações
						<i class="material-icons right">save_alt</i>
					</button>
				</form>
			  </div>
			</div>
		</c:forEach>
	</ul>
	</center>
	</div>
	<script>
		$(document).ready(function(){
		    $('.materialboxed').materialbox();
		});
	</script>
</body>
</html>