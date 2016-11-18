<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

 <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <style>
            body {
                padding-top: 50px;
                padding-bottom: 20px;
            }
        </style>
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/main.css">

        <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>

<title>Tafelzetting</title>
</head>


<body>



<!-- Hier begint het formulier om de gasten toe te voegen, met tabel erin -->

<h3>De gastenlijst</h3>
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
			<th>Actie</th>
		</tr>

	<c:forEach items="${tafels}" var="t" varStatus="aant">
		<tr><td>Tafel ${aant.count}</td>
			<td>${t.stoelen}</td>
			<td>rond of niet</td>
			<td><a href="deleteTafel?id=${t.id}">verwijder</a></td>
		</tr>
	</c:forEach>


		<tr>
			<td>Nieuwe gast</td>
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

<!-- Hier worden gasten aan tafels geplaatst als test -->



We plaatsen de gasten aan tafels
<ol>
	<c:forEach items="${gastenlijst}" var="g">
		<li> Naam: ${g.naam} 
			<a href="zetGastAanTafel?id=${g.id}">gast aan tafel</a> </li> 
	</c:forEach>
</ol>
