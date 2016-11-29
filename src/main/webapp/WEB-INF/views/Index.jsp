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

<style>
 
 html{
  background: url('gedektetafel.jpeg') no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
  }
</style>

<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/main.css">

<br><br><br>

<title>TafelSchikking</title>


</head>


<body>



	<!-- De navigatiebar -->
	<%@include file="Navbar.jsp" %>

	<div class="row">
	<div class="col-md-2"></div>

	<div class="col-md-8 achtergrondkleur">




	<!-- Hier is het evenementformulier -->
	
	<h1>Jouw evenement</h1>

	<p><i>Vul hieronder de gegevens in van jouw evenement. Maak een gastenlijst en een lijst van de 
	   beschikbare tafels. Voer vervolgens jouw wensen in voor een ideale tafelschikking, zoals, 
	   mannen of vrouwen gemengd? Familie bij mekaar en collega's aan een andere tafel, of juist
	   door elkaar?  Als alles klopt, klik je onderaan op de verzendknop. De ideale tafelschikking 
	   voor het evenement wordt dan berekend.</i></p>


	<h3>Het evenement:</h3>


	<%@include file="EvenementForm.jsp" %><br>

	

	<!-- Hier begint het formulier om de gasten toe te voegen, met tabel erin -->

	<h3>Vul de gastenlijst in:</h3>
	
	<%@include file="GastenlijstForm.jsp"%><br>
	
	


	<!-- Hier begint het formulier om de tafels toe te voegen met tabel erin -->

	<h3>Geef de lijst van beschikbare tafels:</h3>

	<%@include file="TafelForm.jsp"%><br>
	
	
	
	<h3>Wat zijn je voorkeuren voor de tafelschikking?:</h3>
	<p><i>De score representeert een 'belangrijkheidsfactor'. Deze kan een waarde 0 t/m 5 hebben.<br>
	Bij 0 wordt de voorkeur niet meegewogen, bij 5 maximaal.</i></p>
	<br><br>
	
	<%@include file="VoorkeurenForm.jsp"%><br>

	

	<!-- Hieronder de link om naar de pagina te gaan om gegevens te controleren -->
	<c:if test="${voorkeuren != null}"> 

		<h3>Klaar met invullen? Klik hieronder voor het controleren van de
			gegevens</h3>
		
				<a class="btn btn-primary btn-lg" href="gegevens-controleren" role="button">Naar gegevens controleren</a>
				
		
	</c:if>
	<br>
	

<!-- Hier is de footer -->	
<%@include file="OnzeFooter.jsp"%>

 </div>
	<div class="col-md-2"></div>
	</div>	   


   

</body>
</html>

