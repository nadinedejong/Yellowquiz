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


	<h3>Nieuw evenement aanmaken</h3>


	<%@include file="EvenementForm.jsp" %><br>

	

	<!-- Hier begint het formulier om de gasten toe te voegen, met tabel erin -->

	
	<br><button class="accordion">1. Vul de gastenlijst in</button>
	<div class="panel">
  		<p>
	<%@include file="GastenlijstForm.jsp"%></p>
	</div><br>


	<!-- Hier begint het formulier om de tafels toe te voegen met tabel erin -->
	
	<br><button class="accordion">2. Voer de beschikbare tafels in</button>
		<div class="panel">
  		<p>
	
	<%@include file="TafelForm.jsp"%></p>
	</div><br>
	
	
	<!--  Hier begint het formulier voor het invullen van de voorkeuren -->
	
	
		<br><button class="accordion">3. Geef je voorkeuren aan</button>
	<div class="panel">
  		<p>
	
	<p><i>De score representeert een 'belangrijkheidsfactor'. Deze kan een waarde 0 t/m 5 hebben.<br>
	Bij 0 wordt de voorkeur niet meegewogen, bij 5 maximaal.</i></p>
	<br><br>
	
	<%@include file="VoorkeurenForm.jsp"%></p>
	</div><br>
	

	<!-- Hieronder de link om naar de pagina te gaan om gegevens te controleren -->
	<c:if test="${voorkeuren != null}"> 

		<br><p><i>Klaar met invullen? Klik hieronder voor het controleren van de
			gegevens</i></p>
		
				<a class="btn btn-primary btn-lg" href="gegevens-controleren" role="button">Naar gegevens controleren</a>
				
		
	</c:if>
	<br>
	

<!-- Hier is de footer -->	
<%@include file="OnzeFooter.jsp"%>

 </div>
	<div class="col-md-2"></div>
	</div>	   


 <script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        this.nextElementSibling.classList.toggle("show");
  }
}
</script>

</body>
</html>

