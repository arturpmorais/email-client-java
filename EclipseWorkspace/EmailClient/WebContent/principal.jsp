<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="erro.jsp"
    import="bd.dbos.*, bd.daos.*, email.EmailHandler, javax.mail.*, javax.mail.internet.*, java.util.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>eMali: caixa de entrada</title>
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
			
			function adicionarNoInput(x) {
				document.getElementById('hidEmails').value = x;
			}
			
			function updateEmails() {
				var values = $('#selectEmails').val();
				console.log(values);
				var enderecos = '';
				for (let i in values) {
					enderecos += values[i];
					
				}
				adicionarNoInput(enderecos);
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
			<%
				if(session.getAttribute("usuario") == null) {
					session.setAttribute("erroLogin", "Você precisa estar logado para acessar o site.");
					response.sendRedirect("index.jsp");
				} else {
					Usuario usuario = (Usuario)session.getAttribute("usuario");
					todosEmails = Emails.getEmails(usuario.getId());
					todosEmailHandlers = new ArrayList<EmailHandler>();
					
					
					if(request.getParameter("hidEmails") == null || request.getParameter("hidEmails").equals("")) {
						int i = 0;
						for(Email emailAtual : todosEmails) {
							todosEmailHandlers.add(new EmailHandler(emailAtual));
							System.out.println(i);
							i++;
						}
						
					} 
					
					
					else {
						String enderecosACarregar = request.getParameter("hidEmails");
						
						for(Email emailAtual : todosEmails) {
							if(enderecosACarregar.contains(emailAtual.getEmail())) {
								todosEmailHandlers.add(new EmailHandler(emailAtual));
								System.out.println("entrou");
							}
						}
					}
					
					
					session.setAttribute("todosEmails", todosEmails);
					System.out.println("setou emails");
					session.setAttribute("todosEmailHandlers", todosEmailHandlers);	
					System.out.println("setou handlers");
				}
					
				//if(!Emails.getEmails(usuario.getId()).isEmpty())
					//session.setAttribute("emails", Emails.getEmails(usuario.getId()));
			%>
		
		<jsp:include page="navbar.jsp"></jsp:include>
		
		
		<div class="container">
			<div class="row">
			
			</div>			
			<div class="row">
				<a class="waves-effect waves-light btn-large modal-trigger pink darken-1 col s3 left" href="#modal1">
					nova mensagem
					<i class="material-icons left">add</i>	
				</a>
				<form action="principal.jsp">
					<input type="text" id="hidEmails" name="hidEmails" value="" style="visible:false !important;"/>
					<div class="input-field col s4">
					    <select multiple onchange="updateEmails()" id="selectEmails">
							<option value="" selected>Todos</option>
							<c:forEach var="email" items="${todosEmails}">
								<option value="${email.getEmail()}">
									${email.getEmail()}
								</option>
							</c:forEach>
					    </select>
					    <label>Endereços exibidos</label>
				  	</div>
				  	<button type="submit" class="waves-effect waves-dark btn-flat pink-text darken-1">
						atualizar
						<i class="material-icons left">refresh</i>	
					</button>
				</form>
			</div>
			
		
			<!-- Modal Structure -->
			<div id="modal1" class="modal">
			  <div class="modal-content container">
				<form action="enviarEmail.jsp" id="formEmail">
					<h5>novo email</h5>
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
			
			
			
			
			<div class="row">
			   	
		  	</div>
			
		<ul class="collection with-header">
			<li class="collection-header">
			    <h4>Emails</h4>
			</li>
					
			<%	
				System.out.println("tamo voando");
				int qtosEmails = 0;
				todasMensagens = new ArrayList<Message>();
				for(EmailHandler emailAtual : todosEmailHandlers) {
					Message[] mensagens = emailAtual.listInboxEmails();
					for(int i = 0; i < 50; i++) {
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
		
			<c:if test="${erroCarregarMensagens != null}">
				<li>Erro ao carregar as mensagens! ${erroCarregarMensagens}</li>
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
					<p><c:out value="${mensagemAtual.getReceivedDate()}"></c:out><br></p>
					<a class="modal-trigger blue btn white-text" href="#modal${mensagemAtual.getMessageNumber()}">
						<i class="material-icons right">open_with</i>
					</a>
				</li>
			</c:forEach>
			
		</ul>
		</div>
	            
		<% 
			if(session.getAttribute("erroLogin") != null) {
				
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
			
			$(document).ready(function(){
				$('.collapsible').collapsible();
			});
			
			/*
	            
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
			
			*/
		</script>
	</body>
</html>