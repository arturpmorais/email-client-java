<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="bd.dbos.*, bd.daos.*, email.EmailHandler, javax.mail.*, javax.mail.internet.*, java.util.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>eMali: página inicial</title>
		<jsp:include page="header.jsp"></jsp:include>
		<style>
			.btn {
			    text-transform: none;
			}
			
			.input-field {
		    	color: #673AB7;	
		    }
		</style>
		<script>
			function submitForm(x) {
			     if(x.name=='excluir') {
			        document.getElementById('acao').value='excluir';
			     }
			     else if(x.name=='favoritar') {
			       document.getElementById('hid1').value='favoritar';
			     }
			     else if(x.name=='marcarLido'){
			       document.getElementById('hid1').value='marcarLido';
			     }
			     //alert(document.getElementById('hid1').value);
			     document.getElementById("formMensagem" + x.name).submit();
			}
		</script>
	</head>
	<body>
		<%
				ArrayList<Email> todosEmails = null;
				ArrayList<EmailHandler> todosEmailHandlers = null;
				ArrayList<Message> todasMensagens = null;
				session.removeAttribute("todasMensagens");
		%>
		<c:catch var="erroCarregarMensagens">
			<%
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
					session.setAttribute("todosEmailHandlers", todosEmailHandlers);	
				}
					
				//if(!Emails.getEmails(usuario.getId()).isEmpty())
					//session.setAttribute("emails", Emails.getEmails(usuario.getId()));
			%>
		</c:catch>
		
		<nav class="pink darken-1">
		  <div class="nav-wrapper container">
		    <a href="#" class="brand-logo">eMali: gerenciador de emails</a>
		    <ul id="nav-mobile" class="right hide-on-med-and-down">
		      <li><a href="sass.html">Sass</a></li>
		      <li><a class='dropdown-trigger' href='#' data-target='dropdown1'>opções</a></li>
		    </ul>
		  </div>
		</nav>
		
		<!-- dropdown opções -->
		<ul id='dropdown1' class='dropdown-content'>
			<li>
				<a data-target="slide-out" class="black-text">
					informações da conta
					<i class="material-icons">person_outline</i>
				</a>
			</li>
			<li>
				<a class="modal-trigger black-text" href="#modal2">
					cadastrar novo email
					<i class="material-icons left">library_add</i>
				</a>
			</li>
			<li class="divider" tabindex="-1"></li>
			<li>
				<a class="black-text" href="logout.jsp">deslogar
					<i class="material-icons left">exit_to_app</i>
				</a>
			</li>
		</ul>
		
		
		<div class="container">
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
			<div class="row">
				<a class="waves-effect waves-light btn-large modal-trigger pink darken-1 col s3" href="#modal1">
					nova mensagem
					<i class="material-icons left">add</i>	
				</a>
				<div class="input-field col s4 offset-s1">
				    <select multiple>
						<option value="" selected>Todos</option>
						<c:forEach var="email" items="${todosEmails}">
							<option value="${email.getEmail()}">
								${email.getEmail()}
							</option>
						</c:forEach>
				    </select>
				    <label>Endereços exibidos</label>
			  	</div>
			</div>
			
		
			<!-- Modal Structure -->
			<div id="modal1" class="modal">
			  <div class="modal-content container">
			    <h4>Modal Header</h4>
			    <a class="material-icons modal-close waves-effect waves-green btn-flat">close</a>
				<form action="enviarEmail.jsp" id="formEmail">
					Novo Email
					<br>
					<div class="input-field col s12">
						<select name="emailOrigem" id="emailOrigem">
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
			          <textarea name="conteudo" id="conteudo" class="materialize-textarea"></textarea>
			          <label for="textarea1">Textarea</label>
			        </div>
					<br>
					<button type="submit" id="botao" class="btn deep-purple" value="Enviar e-mail">
						Enviar e-mail
						<i class="material-icons right">send</i>
					</button>
				</form>
			  </div>
			</div>
			
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
						throw new Exception("Lista de mensagens vazia");
					
					session.setAttribute("todasMensagens", todasMensagens);
				%>
			</c:catch>
		
			<c:if test="${erroCarregarMensagens != null}">
				<li>Erro ao carregar as mensagens! + ${erroCarregarMensagens.getMessage()}</li>
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
					<form id="form${todasMensagens.indexOf(mensagemAtual)}" action="acaoForm.jsp">
						<input type="hidden" name="index" id="index" value="${todasMensagens.indexOf(mensagemAtual)}"/>
						<input type="hidden" name="acao" id="acao" value=""/>
						<img src="images/yuna.jpg" alt="" class="circle">
						<span class="title"><c:out value="${mensagemAtual.getSubject()}"></c:out></span>
						<p><c:out value="${mensagemAtual.getReceivedDate()}"></c:out><br></p>
						<a onclick="submitForm()" class="secondary-content"><i class="material-icons red-text">delete_forever</i></a>
					</form>
				</li>
			</c:forEach>
			
		</ul>
		</div>
	            
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
			
			var elem = document.querySelector('.dropdown-trigger');
			var instance = new M.Dropdown(elem, {
				coverTrigger: false,
			    constrainWidth: false
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