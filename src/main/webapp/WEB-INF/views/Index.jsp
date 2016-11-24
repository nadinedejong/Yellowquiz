<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>TafelSchikking</title>


</head>


<body>
<!-- Hier is het beginformulier -->

<h1>Jouw evenement</h1>

<p> Vul hieronder de gegevens in van jouw evenement, voeg de gasten toe en de tafels. Als alles klopt, klik je onderaan op de verzendknop.
De ideale tafelschikking voor het evenement wordt dan berekend.
</p>


<br><br>


<h3> Het evenement: </h3>
<form method="post" action="/maakEvent">

Naam: &nbsp; <input type = "text" name ="naam" value="${e.naam}"> <br>
Datum: &nbsp;<input type="date" name ="datum"><br>
Sorteren op geslacht?	<select name="sorteergeslacht">
						<option value="false">ja</option>
						<option value="true">nee</option></select><br>
						<input type="submit">

</form>

<br><br>

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
			<th>Interesse</th>
			<th>Relatie</th>
			<th>Actie</th>
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
				<c:if test="${b.relatie == 2}"> collega's </c:if> </td>
			<td><a href="deleteGast?id=${b.id}">verwijder</a> </td>
		</tr>
	</c:forEach>
		
		<!--  Laatste rij (nieuwe gast toevoegen) -->
		<tr>
			<td>Nieuwe gast</td>
			<td><input type = "text" name="naam" placeholder='Vul naam in ...'></td>
			<td><input type = "text" name= "leeftijd" placeholder='Vul leeftijd in ...'>
			<td><select name="vrouw">
				<option value="false">man</option>
				<option value="true">vrouw</option></select></td>
			<td><select name="interesse">
				<option value = "0">voetbal</option>
				<option value = "1">lego</option>
				<option value = "2">gtst</option>
				<option value = "3">spreekwoorden</option></select></td>
			<td><select name="relatie">
				<option value = "0">familie</option>
				<option value = "1">vrienden</option>
				<option value = "2">collega's</option></select></td>
			<td><input type="submit" value='Toevoegen'></td>
		</tr>
</table>

</form>

<br><br>


<!-- Hier begint het formulier om de tafels toe te voegen met tabel erin -->

<h3>De tafels: </h3>

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
		<tr><td>Tafel ${aant.count}</td>
			<td>${t.stoelen}</td>
			<td>rond</td>
			<td>${t.id}</td>
			<td><a href="deleteTafel?id=${t.id}">verwijder</a></td>
		</tr>
	</c:forEach>

		<!--  Laatste rij (nieuwe tafel toevoegen) -->
		<tr>
			<td>Nieuwe tafel</td>
			<td><input type = "text" name="stoelen" placeholder='Vul aantal stoelen in ...'></td>
			<td><select name="Vorm">
					<option value="Vorm.ROND">rond</option>
					<option value="Vorm.VIERKANT">vierkant</option>
					<option value="Vorm.RECHTHOEK">rechthoek</option>
				</select></td>
			<td><input type="submit" value='Toevoegen'></td>
		</tr>
		
</table>

</form>

<br><br>

<!-- Hieronder de link om naar de pagina te gaan om gegevens te controleren -->

<h3> Klaar met invullen? Klik hieronder voor het controleren van de gegevens</h3>

<strong><h2><a href="gegevens-controleren"> --> Gegevens controleren</a></strong></h2>


<br><br><br>

<a href="plaatsGasten">Plaats de gasten randomly</a>
<br>

Tafellijst gasten
<br><br><br>

<!-- Hier worden gasten aan tafels geplaatst als test -->



<h3> We plaatsen de gasten aan tafels </h3>
<ol>
	<c:forEach items="${gastenlijst}" var="g">
		<li> Naam: ${g.naam}, Tafel: ${g.tafel.id} </li> 
	</c:forEach>
</ol>
<br>
Gastenlijst Per Tafel
<ol>
	<c:forEach items="${tafels}" var="t">
		<li> Tafel ID: ${t.id}, Aantal stoelen: ${t.stoelen} <br> 
			Gasten:
			<c:forEach items="${t.gasten}" var="g">     
				${g.naam}, ${g.leeftijd }, ${g.vrouw };
			</c:forEach>
		</li> 
	</c:forEach>
</ol>

</body>
</html>

