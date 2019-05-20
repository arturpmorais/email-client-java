<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="bd.dbos.Usuario, email.EmailHandler, javax.mail.*, javax.mail.internet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
</head>
<body>
	<% 
		if(session.getAttribute("usuario") == null) {
			session.setAttribute("erroLogin", "Você precisa estar logado para acessar o site.");
			response.sendRedirect("index.jsp");
		}
	%>
	<%= (Usuario)session.getAttribute("usuario") %>
	<form action="enviarEmail.jsp" id="formEmail">
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
		<input type="submit" id="botao" value="Enviar e-mail"/>
	</form>
	
	
	<ul class="collection with-header collapsible">
		<li class="collection-header">
		    <h4>Emails</h4>
		</li>
	<%  
		try {
			Message[] todasMensagens = (Message[])session.getAttribute("todosEmails");
			if(todasMensagens.length == 0 || todasMensagens == null) {
	%>
		<li>Nenhuma mensagem disponível!</li>
	<%
			}
			for(Message mensagem : todasMensagens) {
	%>
		<li class="collection-item avatar">
		  <img src="images/yuna.jpg" alt="" class="circle">
		  <span class="title"><%= mensagem.getSubject() %></span>
		  <p> <%= mensagem.getFrom()[0] %><br></p>
		  <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
		</li>
	<% 
			}
		} catch(Exception e) {
	%>
		<li>Erro ao carregar as mensagens! <%= e.getMessage() %></li>
	<%
		}	
	%>
	</ul>
            
	
	<script>
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