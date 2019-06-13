<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="bd.dbos.*, bd.daos.*, email.EmailHandler, javax.mail.*, javax.mail.internet.*, java.util.*"%>
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
	
	.input-field {
    	color: #673AB7;	
    }
</style>
</head>
<body>
	<%
		ArrayList<Email> todosEmails = null;
		ArrayList<EmailHandler> todosEmailHandlers = null;
		ArrayList<Message> todasMensagens = null;
	
		if(session.getAttribute("usuario") == null) {
			session.setAttribute("erroLogin", "Você precisa estar logado para acessar o site.");
			response.sendRedirect("index.jsp");
		}
		else {
			Usuario usuario = (Usuario)session.getAttribute("usuario");
			todosEmails = Emails.getEmails(usuario.getId());
			todosEmailHandlers = new ArrayList<EmailHandler>();
			
			for(int i = 0; i < todosEmails.size(); i++) {
				todosEmailHandlers.add(new EmailHandler(todosEmails.get(i)));
			}
			
			session.setAttribute("todosEmails", todosEmails);	
		}
			
		//if(!Emails.getEmails(usuario.getId()).isEmpty())
			//session.setAttribute("emails", Emails.getEmails(usuario.getId()));
	%>
	
	<nav class="grey darken-3"> ${usuario.getId()} <!-- navbar content here  --> </nav>

	<ul id="slide-out" class="sidenav">
		<li>
			<div class="user-view">
				<div class="background">
				  <img style="height: 100%; width: 100%;" src="img/1.jpg">
				</div>
				<a href="#user"><img class="circle" src="images/yuna.jpg"></a>
				<a href="#name"><span class="white-text name">${ usuario.getNome() }</span></a>
				<a href="#email"><span class="white-text email">${ usuario.getEmail() }</span></a>
			</div>
		</li>
		<li><a href="#!"><i class="material-icons">cloud</i>First Link With Icon</a></li>
		<li><a href="#!">Second Link</a></li>
		<li><div class="divider"></div></li>
		<li><a class="subheader">Subheader</a></li>
		<li><a class="waves-effect" href="#!">Third Link With Waves</a></li>
	</ul>
	<a href="#" data-target="slide-out" class="sidenav-trigger"><i class="material-icons">settings</i></a>
	
	<form action="logout.jsp" id="formLogout">
		<button type="submit" id="btnLogoutBasic" value="deslogar" class="grey darken-3 btn waves-effect waves-light">
			Deslogar
			<i class="material-icons left">exit_to_app</i>
		</button>
	</form>
	
	<a class="waves-effect waves-light btn modal-trigger" href="#modal1">enviar email</a>

	<!-- Modal Structure -->
	<div id="modal1" class="modal">
	  <div class="modal-content container">
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
			<div class="input-field col s12">
	          <textarea id="textarea1" class="materialize-textarea"></textarea>
	          <label for="textarea1">Textarea</label>
	        </div>
			<input type="text" placeholder="conteudo:" name="conteudo" id="conteudo"/>
			<br>
			<button type="submit" id="botao" class="btn deep-purple" value="Enviar e-mail">
				Enviar e-mail
				<i class="material-icons right">send</i>
			</button>
		</form>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
	  </div>
	</div>
	
	<a class="waves-effect waves-light btn modal-trigger" href="#modal2">cadastrar novo email</a>
	
	<!-- Modal Structure -->
	<div id="modal2" class="modal">
	  <div class="modal-content container">
	    <h4>cadastrar novo e-mail</h4>  
		<form action="cadastrarEmail.jsp" id="formEmail">
			Novo Email
			<input type="text" placeholder="endereço de e-mail:" name="email" id="email"/>
			<br>
			<input type="password" placeholder="senha:" name="senha" id="senha"/>
			<br>
			<input type="text" placeholder="porta:" name="porta" id="porta"/>
			<br>
			<input type="text" placeholder="host:" name="host" id="host"/>
			<br>
			<input type="text" placeholder="protocolo:" name="protocolo" id="protocolo"/>
			<br>
			<button type="submit" id="botao" class="btn deep-purple" value="Enviar e-mail">
				Cadastrar e-mail
				<i class="material-icons right">send</i>
			</button>
		</form>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
	  </div>
	</div>
	
	
	<div class="row">
	   	<div class="input-field col s3">
		    <select multiple>
		      <option value="" disabled selected>Todos</option>
		      <c:forEach var="email" items="${todosEmails}">
		        <option value="${email.getEmail()}">
		            ${email.getEmail()}
		        </option>
		      </c:forEach>
		    </select>
		    <label>Endereços exibidos</label>
	  	</div>
  	</div>
	
	<ul class="collection with-header collapsible">
		<li class="collection-header">
		    <h4>Emails</h4>
		</li>
				
		<c:catch var="erroCarregarMensagens">
			<%	
				int qtosEmails = 0;
				todasMensagens = new ArrayList<Message>();
				for(EmailHandler emailAtual : todosEmailHandlers) {
					Message[] mensagens = emailAtual.listInboxEmails();
					for(int i = 0; i < mensagens.length; i++) {
						todasMensagens.add(mensagens[i]);
					}
				}

				todasMensagens.sort(
					new Comparator<Message>() {
						@Override
						public int compare(Message m1, Message m2) {
							try {
								return m2.getReceivedDate().compareTo(m1.getReceivedDate());
							} catch (Exception e) {
								return -1;
							}
						}
					}
				);
				
				if (todasMensagens.size() == 0 || todasMensagens == null)
					throw new Exception("Você não possui nenhuma mensagem");
				
				session.setAttribute("todasMensagens", todasMensagens);
			%>
		</c:catch>
		
		<c:if test="${erroCarregarMensagens != null}">
			<li>Nenhuma mensagem disponível! + ${erroCarregarMensagens.getCause()}</li>
		</c:if>
		<!--  
			<li class="collection-item avatar">
				<img src="images/yuna.jpg" alt="" class="circle">
				<span class="title"><c:out value="${mensagemAt}"></c:out></span>
				<p><c:out value="${mensagemAt.getReceivedDate()}"></c:out> <br></p>
				<a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
			</li>
		-->
		<c:forEach var="mensagemAtual" items="${sessionScope.todasMensagens}">
			<li class="collection-item avatar">
			  <img src="images/yuna.jpg" alt="" class="circle">
			  <span class="title"><c:out value="${mensagemAtual.getSubject()}"></c:out></span>
			  <p><c:out value="${mensagemAtual.getReceivedDate()}"></c:out> <br></p>
			  <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
			</li>
		</c:forEach>
		
	</ul>
            
	<% 
		if(!(session.getAttribute("erroLogin") == null)) {
			
	%>
		<script type="text/javascript">
			M.toast({html: '<%= session.getAttribute("erroLogin")%>', classes: "rounded"});
		</script>
	<% 
			session.removeAttribute("erroLogin");
		}
	%>
	<script>
		$(document).ready(function(){
		    $('select').formSelect();
		});
		
		$(document).ready(function(){
		    $('.modal').modal();
		});
		
		$(document).ready(function(){
		    $('.sidenav').sidenav();
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