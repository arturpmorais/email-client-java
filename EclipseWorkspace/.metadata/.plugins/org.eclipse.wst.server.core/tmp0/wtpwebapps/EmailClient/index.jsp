<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
<style type="text/css">
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

</style>
</head>
<body>
	<div class="valign-wrapper row login-box">
	  <div class="col card s10 pull-s1 m6 pull-m3 l4 pull-l4">
	    <form method="POST" action="login.jsp">
	      <div class="card-content">
	        <span class="card-title">login</span>
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
	        <input type="reset" id="reset" class="btn-flat grey-text waves-effect">
	        <input type="submit" class="btn deep-purple waves-effect waves-light white-text" value="Login">
	      </div>
	    </form>
	  </div>
	</div>
	<% 
		boolean sucessoLogin = (session.getAttribute("erroLogin") == null);
	
		if(!sucessoLogin) {
			
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
                maxParticles: 150,
                speed: 0.2
        	});
		};
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/particlesjs/2.2.2/particles.min.js"></script>
</body>
</html>