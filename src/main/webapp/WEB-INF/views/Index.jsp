<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/forminput.js"></script>

<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/main.css">

<br><br><br>

<title>TafelSchikking</title>


</head>


<body>
<!-- Dit is de navigatiebar -->
	<%@include file="Navbar.jsp" %>

	<div class="row">
	<div class="col-md-2"></div>

	<div class="col-md-8">

	<!-- Hier is het evenementformulier -->
	
	<h1>Jouw evenement</h1>

	<p>Vul hieronder de gegevens in van jouw evenement, voeg de gasten
		toe en de tafels. Als alles klopt, klik je onderaan op de verzendknop.
		De ideale tafelschikking voor het evenement wordt dan berekend.</p>


	<br>


	<h3>Het evenement:</h3>


	<%@include file="EvenementForm.jsp" %>

	<br>

	<!-- Hier begint het formulier om de gasten toe te voegen, met tabel erin -->

	<h3>De gastenlijst:</h3>
	
	<%@include file="GastenlijstForm.jsp"%>
	
	<br>


	<!-- Hier begint het formulier om de tafels toe te voegen met tabel erin -->

	<h3>De tafels:</h3>

	<%@include file="TafelForm.jsp"%>
	
	
	
	<h3>De voorkeurenlijst:</h3>

	<%@include file="VoorkeurenForm.jsp"%>

	<br>

	<!-- Hieronder de link om naar de pagina te gaan om gegevens te controleren -->

	<h3>Klaar met invullen? Klik hieronder voor het controleren van de
		gegevens</h3>

	<strong><h2>
			<a href="gegevens-controleren"> --> Gegevens controleren</a></strong>
	</h2>
	
	<br>
	

<!-- Hier is de footer -->	
<%@include file="OnzeFooter.jsp"%>

	   
	   
 </div>
	<div class="col-md-2"></div>
	</div>

</body>
</html>

