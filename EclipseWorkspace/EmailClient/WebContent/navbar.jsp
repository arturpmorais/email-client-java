<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="pink darken-1">
	  <div class="nav-wrapper container">
	    <a href="#" class="brand-logo">eMali: gerenciador de emails</a>
	    <ul id="nav-mobile" class="right hide-on-med-and-down">
	      <li><a class='dropdown-trigger' href='#' data-target='dropdown1'>opções</a></li>
	    </ul>
	  </div>
	</nav>
	
	<!-- dropdown opções -->
	<ul id='dropdown1' class='dropdown-content'>
		<li>
			<a class="black-text" href="principal.jsp">
				página inicial
				<i class="material-icons">home</i>
			</a>
		</li>
		<li>
			<a class="black-text" href="infos.jsp">
				suas informações
				<i class="material-icons">person_outline</i>
			</a>
		</li>
		<li>
			<a class="black-text" href="emails.jsp">
				emails cadastrados
				<i class="material-icons">view_list</i>
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
	</div>
	<script>
		var elem = document.querySelector('.dropdown-trigger');
		var instance = new M.Dropdown(elem, {
			coverTrigger: false,
		    constrainWidth: false
		});
		
		$(document).ready(function(){
		    $('.modal').modal();
		});
	</script>
</body>
</html>