<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="bd.dbos.*, bd.daos.*, email.EmailHandler, javax.mail.*, javax.mail.internet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
<style>
	.btn {
    text-transform: none;
}
</style>
</head>
<body>
	<% 
		Email[] todosEmails = {new Email(1, "art@ur"), new Email(2, "pra@to"), new Email(3, "ter@ra")};
		request.setAttribute("todosEmails", todosEmails);
		if(session.getAttribute("usuario") == null) {
			session.setAttribute("erroLogin", "Você precisa estar logado para acessar o site.");
			response.sendRedirect("index.jsp");
		}
		Usuario usuario = (Usuario)session.getAttribute("usuario");
		//request.setAttribute("emails", Emails.getEmails(usuario.getId()));
	%>
	<%= (Usuario)session.getAttribute("usuario") %>
	<form action="logout.jsp" id="formLogout">
		<input type="submit" id="btnLogout" value="deslogar"/>
	</form>
	
	<a class="waves-effect waves-light btn modal-trigger" href="#modal1">enviar email</a>

	<!-- Modal Structure -->
	<div id="modal1" class="modal">
	  <div class="modal-content">
	    <h4>Modal Header</h4>  
		<form action="enviarEmail.jsp" id="formEmail">
			Novo Email
			<br>
			<div class="input-field col s12">
				<select name="cbxEmails">
				    <option value="" disabled selected>selecione o email de origem</option>		    
				    <c:forEach var="email" items="${todosEmails}">
				        <option value="${email.getEmail()}">
				            ${email.getEmail()}
				        </option>
				     </c:forEach>
				</select>
			</div>
			<input type="text" placeholder="enviar para:" name="emailDestino" id="emailDestino"/>
			<br>
			<input type="text" placeholder="assunto:" name="assunto" id="assunto"/>
			<br>
			<input type="text" placeholder="conteudo:" name="conteudo" id="conteudo"/>
			<br>
			<input type="submit" id="botao" value="Enviar e-mail"/>
		</form>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
	  </div>
	</div>
    
	
	
	<ul class="collection with-header collapsible">
		<li class="collection-header">
		    <h4>Emails</h4>
		</li>
	<%  
		try {
			//Message[] todasMensagens = (Message[])session.getAttribute("todosEmails");
			//request.setAttribute("erroMensagens", (todasMensagens.length == 0 || todasMensagens == null));
		} finally {}	
	%>
	
	<c:catch var="ex">
		<li>Erro ao carregar as mensagens! ${ex.getMessage()}</li>
	</c:catch>
	
	<c:if test="${erroMensagens}">
		<li>Nenhuma mensagem disponível!</li>
	</c:if>
	
	<c:forEach var="mensagemAtual" items="${todasMensagens}">
		<li class="collection-item avatar">
		  <img src="images/yuna.jpg" alt="" class="circle">
		  <span class="title"><c:out value="${mensagemAtual}"></c:out></span>
		  <p> <br></p>
		  <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
		</li>
	</c:forEach>
		
	</ul>
            
	
	<script>
		$(document).ready(function(){
		    $('select').formSelect();
		});
		
		$(document).ready(function(){
		    $('.modal').modal();
		});
            
		$(document).ready(function () {
		    $('#botao').on('click', function(e) {
		        e.preventDefault();
		        
		        request_url = 'enviarEmail.jsp?';
		        request_url += 'emailOrigem=' + $('#emailOrigem').val() + '&';
		        request_url += 'emailDestino=' + $('#emailDestino').val() + '&';
		        request_url += 'assunto=' + $('#assunto').val() + '&';
		        request_url += 'conteudo=' + $('#conteudo').val();
		        
		        $.ajax({
		            url : request_url,
		            type: "GET",
		            success: function (data, textStatus, xhr) {
		            	M.toast({html: 'Email enviado!', classes: 'rounded'});
		                $("#form_output").html(data);
		            },
		            error: function (jXHR, textStatus, errorThrown) {
		                alert('aaaaaaaaaaaaaaaaa');
		            }
		        });
		    });
		});
	</script>
</body>
</html>