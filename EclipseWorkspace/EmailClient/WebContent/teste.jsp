<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
		
	<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
	<style type="text/css">
	.wrapper {
	    padding-left: 300px;
	}
	</style>

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  </head>

  <body>
	<div class="wrapper">
	    <div class="">
	        <!-- Dropdown Structure -->
	        <ul id="dropdown1" class="dropdown-content">
	            <li><a href="#!">User Profile</a></li>
	            <li><a href="#!">Settings</a></li>
	            <li class="divider"></li>
	            <li><a href="#!">Logout</a></li>
	        </ul>
	
	        <nav class="light-blue lighten-1" role="navigation">
	            <div class="nav-wrapper container">
	                <a href="#!" class="brand-logo">Point of Sale</a>
	                <ul class="right hide-on-med-and-down">
	                    <!-- Dropdown Trigger -->
	                    <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Profile<i class="material-icons right">arrow_drop_down</i></a></li>
	                </ul>
	            </div>
	        </nav>
	    </div>
	</div>
	
	<ul id="slide-out" class="side-nav fixed">
	    <li><a href="#!">First Sidebar Link</a></li>
	    <li><a href="#!">Second Sidebar Link</a></li>
	</ul>

    <script>
	    $(document).ready(function(){
	        $('.sidenav').sidenav();
	      });
    </script>
  </body>
</html>