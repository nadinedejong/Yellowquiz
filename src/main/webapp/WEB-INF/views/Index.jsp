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

<br><br><br>
		<!--  Rij 2 t/m... (dus de ingevoerde gasten) -->
	<c:forEach items="${gastenlijst}" var="b" varStatus="status">
		<tr><td>Gast ${status.count}</td>
			<td>${b.naam}</td>
			<td>${b.leeftijd}</td>
			<td><c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if test="${b.vrouw == false}"> man </c:if>  </td>
			<td><a href="deleteGast?id=${b.id}">verwijder</a> </td>
		</tr>
	</c:forEach>
		
		<!--  Laatste rij (nieuwe gast toevoegen) -->
		<tr>
			<td>Nieuwe gast</td>
			<td><input type = "text" name="naam"></td>
			<td><input type = "text" name="leeftijd">
			<td><select name="vrouw">
				<option value="false">man</option>
				<option value="true">vrouw</option></select></td>
			<td><input type="submit"></td>
		</tr>
</table>

</form>

<br><br><br>


<!-- Hier begint het formulier om de tafels toe te voegen met tabel erin -->

<h3>Ingevoerde tafels: </h3>

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
			<td>rond of niet</td>
			<td>${t.id}</td>
			<td><a href="deleteTafel?id=${t.id}">verwijder</a></td>
		</tr>
	</c:forEach>

		<!--  Laatste rij (nieuwe tafel toevoegen) -->
		<tr>
			<td>Nieuwe tafel</td>
			<td><input type = "text" name="stoelen"></td>
			<td><select name="Vorm">
					<option value="Vorm.ROND">rond</option>
					<option value="Vorm.VIERKANT">vierkant</option>
					<option value="Vorm.RECHTHOEK">rechthoek</option>
				</select></td>
			<td><input type="submit"></td>
		</tr>
		
</table>

</form>
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

