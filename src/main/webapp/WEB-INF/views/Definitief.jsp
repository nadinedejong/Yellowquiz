<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<br><br><br>

<title>GegevensControle</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/forminput.js"></script>
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/main.css">

<style>
 html{
  background: url('gedektetafel3.jpg') no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
  }
</style>

</head>
<body>
<!-- Dit is de navigatiebar -->
	<%@include file="Navbar.jsp" %>
	
	<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-8 achtergrondkleur">

<br>

<H1>Gegevens controleren</H1>

<h3>Evenement: ${events[0].naam },&nbsp; op ${events[0].datum }</h3>

<br>

<h3>Gasten:</h3>
<table class="table">
		<!--  Rij 1 (de kopjes van de tabel)-->
		<tr>
			<th>Nummer</th>
			<th>Naam</th>
			<th>Leeftijd</th>
			<th>Geslacht</th>
			<th>Interesse</th>
			<th>Relatie</th>
		</tr>

		<!--  Rij 2 t/m... (dus de ingevoerde gasten) -->
	<c:forEach items="${gastenlijst}" var="b" varStatus="status">
		<tr><td>Gast ${status.count}</td>
			<td>${b.naam}</td>
			<td>${b.leeftijd}</td>
			<td><c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if test="${b.vrouw == false}"> man </c:if>  </td>
			<td><c:if test="${b.interesse == 0}"> voetbal </c:if>
				<c:if test="${b.interesse == 1}"> lego </c:if>
				<c:if test="${b.interesse == 2}"> gtst </c:if>
				<c:if test="${b.interesse == 3}"> spreekwoorden </c:if></td>
			<td><c:if test="${b.relatie == 0}"> familie </c:if>
				<c:if test="${b.relatie == 1}"> vrienden </c:if>
				<c:if test="${b.relatie == 2}"> collega's </c:if></td>
		</tr>
	</c:forEach>		
</table>

<br>

<h3>Tafels:</h3>
<table class="table">
		<!--  Rij 1 (de kopjes van de tabel)-->
		<tr>
			<th>Tafelnummer</th>
			<th>Aantal stoelen</th>
			<th>Vorm</th>
		</tr>

		<!--  Rij 2 t/m... (dus de ingevoerde tafels) -->
	<c:forEach items="${tafels}" var="t" varStatus="aant">
		<tr><td>Tafel ${aant.count}</td>
			<td>${t.stoelen}</td>
			<td>rond</td>
		</tr>
	</c:forEach>
</table>

<br>

<h3>Voorkeuren:</h3>
<table class="table">
	<tr> 
		<td> <c:if test="${voorkeuren.factManVrouw != 0 }">
				<c:if test="${voorkeuren.manVrouw == true}"> Mannen en vrouwen apart,</c:if> 
			 	<c:if test="${voorkeuren.manVrouw == false}"> Mannen en vrouwen gemengd,</c:if>
				met factor ${voorkeuren.factManVrouw}.
			</c:if>	
		</td>
	</tr>
	<tr>
		<td> <c:if test="${voorkeuren.factOpLeeftijd != 0 }">
				<c:if test="${voorkeuren.opLeeftijd == true}"> Gelijke leeftijden bij elkaar,</c:if> 
			 	<c:if test="${voorkeuren.opLeeftijd == false}"> Leeftijden zoveel mogelijk gemixt,</c:if>
				met factor ${voorkeuren.factOpLeeftijd}.
			 </c:if>	
		</td>			
	</tr>
	<tr>
		<td> <c:if test="${voorkeuren.factInteresse != 0 }">
				<c:if test="${voorkeuren.interesse == true}"> Gelijke interesses bij elkaar,</c:if> 
			 	<c:if test="${voorkeuren.interesse == false}"> Interesses zoveel mogelijk gemixt,</c:if>
				met factor ${voorkeuren.factInteresse}.
			</c:if>
		</td>
	</tr>
	<tr>
		<td> <c:if test="${voorkeuren.factRelatie != 0 }">
				<c:if test="${voorkeuren.relatie == true}"> Gelijke relaties bij elkaar,</c:if> 
			 	<c:if test="${voorkeuren.relatie == false}"> Relaties zoveel mogelijk gemixt,</c:if>
					met factor ${voorkeuren.factRelatie}.
			</c:if>
		</td>
	</tr>
</table>

<br><br><br>

<a class="btn btn-warning" href="index" role="button">Pas de gegevens aan</a>
<a class="btn btn-primary" href="plaatsGasten" role="button">Genereer de tafelschikking</a>

<br>
<!-- Hier is de footer -->	
<%@include file="OnzeFooter.jsp"%>

	   
	   
 </div>
<div class="col-md-2"></div>
</div>

</body>
</html>