<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GegevensControle</title>
</head>
<body>

<H1>Gegevens controleren</H1>

<h3>Event:</h3>
<p> Bruiloft, 19-4-1989 </p>

<br><br><br>

<h3>Gasten:</h3><br>
<table>
		<!--  Rij 1 (de kopjes van de tabel)-->
		<tr>
			<th>Nummer</th>
			<th>Naam</th>
			<th>Leeftijd</th>
			<th>Geslacht</th>

		</tr>

		<!--  Rij 2 t/m... (dus de ingevoerde gasten) -->
	<c:forEach items="${gastenlijst}" var="b" varStatus="status">
		<tr><td>Gast ${status.count}</td>
			<td>${b.naam}</td>
			<td>${b.leeftijd}</td>
			<td><c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if test="${b.vrouw == false}"> man </c:if>  </td>

		</tr>
	</c:forEach>		
</table>

<br><br><br>

<h3>Tafels:</h3><br>


<table>
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

<h3>Voorkeuren:</h3><br>

<table>
	<tr> 
		<td> Mannen en vrouwen apart?</td>
		<td><select name="manVrouw">
		    <option value="true">ja</option>
			<option value="false">nee</option></select></td>
		<td> Hoe belangrijk? Geef een score van 0-5 </td>
		<td> <select name="factManVrouw">
			 <option value="0">0</option>
			 <option value="1">1</option>
			 <option value="2">2</option>
			 <option value="3">3</option>
			 <option value="4">4</option>
			 <option value="5">5</option></select></td>
	</tr>
</table>

<h3> Kloppen de gegevens? Ga dan verder naar de tafelschikking</h3><br>

<strong><h2><a href="index"> Gegevens aanpassen </a></h2></strong> &nbsp; &nbsp;
<strong><a href="plaatsGasten">Genereer een optimale tafelschikking</a></strong>

<br><br>

</body>
</html>