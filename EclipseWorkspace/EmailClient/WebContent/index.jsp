<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
<style type="text/css">
    .mg{

    margin-top: 50px;
    }

    .iwrapper{
    position: relative;
    width: 100%;
    text-align: center;
    transition: transform 0.6s;
    transform-style: preserve-3d;

    }
    .rotate  {
    transform: rotateY(180deg);
    }
    .rotateb {
    transform: rotateY(0deg);
    z-index: 3;
    }

    .front, .back {
    position: absolute;
    width: 100%;
    backface-visibility: hidden;
    }
    .front{

    z-index: 2;
    }
    .back{
    transform: rotateY(180deg);
    z-index: 1;
    }

    html, body, wrapper {
        margin: 0;
        padding: 0;
        height: 100%;
    }
    
    #login {
    	background-color: #121212;
    }

    .background {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        z-index: -1;
        background-color: #303030;
    }
    
    .input-field {
    	color: #673AB7;	
    }
    
    textarea:focus {
		border-bottom: 1px solid orange !important
		-webkit-box-shadow: 0 1px 0 0 orange;
		-moz-box-shadow: 0 1px 0 0 orange;
		box-shadow: 0 1px 0 0 orange;
	}

</style>
</head>
<body>
	<div class="row">
		<br/>
		<br/>
		<br/>
		<br/>
	</div>
	<div class="iwrapper" id="iwp">
		<div class="valign-wrapper row login-box front">
		  <div class="col card s10 pull-s1 m6 pull-m3 l4 pull-l4">
		    <form method="POST" action="login.jsp">
		      <div class="card-content">
		        <span class="card-title">login</span>
		        <a class="btn-floating halfway-fab waves-effect waves-light red" id="bt">
		        	<i class="material-icons">add</i>
		        </a>
		        <div class="row">
		          <div class="input-field col s12">
		            <label for="email">endereço de email</label>
		            <input type="email" class="validate" name="email" id="email" />
		          </div>
		          <div class="input-field col s12">
		            <label for="password">senha</label>
		            <input type="password" class="validate" name="senha" id="senha" />
		          </div>
		        </div>
		      </div>
		      <div class="card-action center-align">
		        <input type="reset" id="reset" class="btn-flat pink-text darken-1 waves-effect offset-s2 col s4">
		        <input type="submit" class="btn pink darken-1 white-text col s4" value="Entrar">
		        <br>
		        <br>
		      </div>
		    </form>
		  </div>
		</div>
		<div class="valign-wrapper row login-box back">
		  <div class="col card s10 pull-s1 m6 pull-m3 l4 pull-l4">
		    <form method="POST" action="cadastro.jsp">
		      <div class="card-content">
		        <span class="card-title">cadastro</span>
		        <a class="btn-floating halfway-fab waves-effect waves-light red" id="bt2">
		        	<i class="material-icons">add</i>
		        </a>
		        <div class="row">
		          <div class="input-field col s12">
		            <label for="email">nome</label>
		            <input type="text" class="validate" name="nome" id="nome" />
		          </div>
		          <div class="input-field col s12">
		            <label for="email">endereço de email</label>
		            <input type="email" class="validate" name="email" id="email" />
		          </div>
		          <div class="input-field col s6">
		            <label for="password">senha</label>
		            <input type="password" class="validate" name="senha" id="senha" />
		          </div>
		          <div class="input-field col s6">
		            <label for="password">confirmar senha</label>
		            <input type="password" class="validate" name="confirmarSenha" id="confirmarSenha" />
		          </div>
		        </div>
		      </div>
		      <div class="card-action center-align">
		        <input type="reset" id="reset" class="btn-flat pink-text darken-1 waves-effect offset-s2 col s4">
		        <input type="submit" class="btn pink darken-1 white-text col s4" value="Cadastrar">
		        <br>
		        <br>
		      </div>
		    </form>
		  </div>
		</div>
	</div>
	
	<% 
		if(session.getAttribute("usuario") != null)
			response.sendRedirect("principal.jsp");
	
		if(!(session.getAttribute("erroLogin") == null)) {
			
	%>
		<script type="text/javascript">
			M.toast({html: '<%= session.getAttribute("erroLogin")%>', classes: "rounded"});
		</script>
	<% 
			session.removeAttribute("erroLogin");
		}
	%>
	
	<canvas class="background"></canvas>
	
	<script type="text/javascript">		
		window.onload = function() {
            Particles.init({
                selector: '.background',
                color: ['#DA0463', '#404B69', '#DBEDF3'],
                connectParticles: true,
                maxParticles: 250,
                speed: 0.5
        	});
		};
		
		$(document).ready(function(){
	        $("#bt").click(function(){
	        if ($('.rotate').length > 0) {
	          $("#iwp").removeClass("rotate");
	        }  
	        if ($('.rotateb').length > 0) {
	          $("#iwp").removeClass("rotateb");
	
	        }  
	        $("#iwp").addClass("rotate");
	
	        });
	        $("#bt2").click(function(){
	
	         if ($('.rotate').length > 0) {
	          $("#iwp").removeClass("rotate");
	         }
	         if ($('.rotateb').length > 0) {
	          $("#iwp").removeClass("rotateb");
	        }  
	         $("#iwp").addClass("rotateb");
	
	        });
        });
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/particlesjs/2.2.2/particles.min.js"></script>
</body>
</html>