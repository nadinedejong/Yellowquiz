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

	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Tafelschikking generator</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<form class="navbar-form navbar-right" role="form">
				<div class="form-group">
					<input type="text" placeholder="E-mail" class="form-control">
				</div>
				<div class="form-group">
					<input type="password" placeholder="wachtwoord" class="form-control">
				</div>
				<button type="submit" class="btn btn-success">Inloggen</button>
			</form>
		</div>
		<!--/.navbar-collapse -->
	</div>
	</nav>

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


	<c:if test="${!empty events }">
		<p id="eventGegevens">
			<strong> Het volgende event is ingevoerd:</strong><br>
			${events[0].naam } &nbsp; op &nbsp; ${events[0].datum }<br> <input
				id="aanpasknop" type=button value="Evenementgegevens aanpassen">
		</p>
	</c:if>



	<div <c:if test="${!empty events }">style="display: none"</c:if>
		id="eventForm">
		<form method="post" action="/aanpassenEvent">
			Naam: &nbsp; <input type="text" name="naam"
				<c:if test="${ !empty events }"> 
								value="${events[0].naam }" </c:if>
				<c:if test="${ empty events }"> 
								placeholder="voer naam van event in..."</c:if>>
			<br> Datum: &nbsp;<input type="date" name="datum"
				<c:if test="${ !empty events }"> 
								value ="${ events[0].datum }"> </c:if>>
			<br> Sorteren op geslacht? <select name="sorteergeslacht">
				<option value="false">ja</option>
				<option value="true">nee</option>
			</select><br> <input id="eventsubmitknop" type="submit" value="Opslaan">
		</form>
	</div>


	<br>

	<!-- Hier begint het formulier om de gasten toe te voegen, met tabel erin -->

	<h3>De gastenlijst:</h3>
	<form method="post" action="/maakGast">

		<table>
			<!--  Rij 1 (de kopjes van de tabel)-->
			<tr>
				<th>Nummer</th>
				<th>Naam</th>
				<th>Leeftijd</th>
				<th>Geslacht</th>
				<th>Actie</th>
			</tr>

			<!--  Rij 2 t/m... (dus de ingevoerde gasten) -->
			<c:forEach items="${gastenlijst}" var="b" varStatus="status">
				<tr>
					<td>Gast ${status.count}</td>
					<td>${b.naam}</td>
					<td>${b.leeftijd}</td>
					<td><c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if
							test="${b.vrouw == false}"> man </c:if></td>
					<td><a href="deleteGast?id=${b.id}">verwijder</a></td>
				</tr>
			</c:forEach>

			<!--  Laatste rij (nieuwe gast toevoegen) -->
			<tr>
				<td>Nieuwe gast</td>
				<td><input type="text" name="naam"
					placeholder='Vul naam in ...'></td>
				<td><input type="text" name="leeftijd"
					placeholder='Vul leeftijd in ...'>
				<td><select name="vrouw">
						<option value="false">man</option>
						<option value="true">vrouw</option>
				</select></td>
				<td><input type="submit" value='Toevoegen'></td>
			</tr>
		</table>

	</form>

	<br>


	<!-- Hier begint het formulier om de tafels toe te voegen met tabel erin -->

	<h3>De tafels:</h3>

	<form method="post" action="/maakTafel">

		<table>

			<!--  Rij 1 (de kopjes van de tabel)-->
			<tr>
				<th>Tafelnummer</th>
				<th>Aantal stoelen</th>
				<th>Vorm</th>
				<th>TafelID</th>
				<th>Actie</th>
			</tr>

			<!--  Rij 2 t/m... (dus de ingevoerde tafels) -->
			<c:forEach items="${tafels}" var="t" varStatus="aant">
				<tr>
					<td>Tafel ${aant.count}</td>
					<td>${t.stoelen}</td>
					<td>rond</td>
					<td>${t.id}</td>
					<td><a href="deleteTafel?id=${t.id}">verwijder</a></td>
				</tr>
			</c:forEach>

			<!--  Laatste rij (nieuwe tafel toevoegen) -->
			<tr>
				<td>Nieuwe tafel</td>
				<td><input type="text" name="stoelen"
					placeholder='Vul aantal stoelen in ...'></td>
				<td><select name="Vorm">
						<option value="Vorm.ROND">rond</option>
						<option value="Vorm.VIERKANT">vierkant</option>
						<option value="Vorm.RECHTHOEK">rechthoek</option>
				</select></td>
				<td><input type="submit" value='Toevoegen'></td>
			</tr>

		</table>

	</form>

	<br>

	<!-- Hieronder de link om naar de pagina te gaan om gegevens te controleren -->

	<h3>Klaar met invullen? Klik hieronder voor het controleren van de
		gegevens</h3>

	<strong><h2>
			<a href="gegevens-controleren"> --> Gegevens controleren</a></strong>
	</h2>
	

	<br>
	
	      <footer>
        <p>&copy; Partypeople 2016</p>
      </footer>
 </div>
	<div class="col-md-2"></div>
	</div>


	<br>
	<br>

	<a href="plaatsGasten">Plaats de gasten randomly</a>
	<br> Tafellijst gasten
	<br>
	<br>
	<br>

	<!-- Hier worden gasten aan tafels geplaatst als test -->



	<h3>We plaatsen de gasten aan tafels</h3>
	<ol>
		<c:forEach items="${gastenlijst}" var="g">
			<li>Naam: ${g.naam}, Tafel: ${g.tafel.id}</li>
		</c:forEach>
	</ol>
	<br> Gastenlijst Per Tafel
	<ol>
		<c:forEach items="${tafels}" var="t">
			<li>Tafel ID: ${t.id}, Aantal stoelen: ${t.stoelen} <br>
				Gasten: <c:forEach items="${t.gasten}" var="g">     
				${g.naam}, ${g.leeftijd }, ${g.vrouw };
			</c:forEach>
			</li>
		</c:forEach>
	</ol>

</body>
</html>

