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

<br>

<h3>Gasten:</h3>
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

<br>

<h3>Tafels:</h3>
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

<br><br><br>

<h3>Voorkeuren:</h3>
<table>
	<tr> 
		<td> <c:if test="${voorkeuren.manVrouw == true}"> Mannen en vrouwen apart,</c:if> 
			 <c:if test="${voorkeuren.manVrouw == false}"> Mannen en vrouwen gemengd,</c:if>
			met factor ${voorkeuren.factManVrouw}.</td>
	</tr>
	<tr>
		<td> <c:if test="${voorkeuren.opLeeftijd == true}"> Gelijke leeftijden bij mekaar,</c:if> 
			 <c:if test="${voorkeuren.opLeeftijd == false}"> Leeftijden zoveel mogelijk gemixt,</c:if>
			met factor ${voorkeuren.factOpLeeftijd}.</td>	
	</tr>
	<tr>
		<td> <c:if test="${voorkeuren.interesse == true}"> Gelijke interesses bij mekaar,</c:if> 
			 <c:if test="${voorkeuren.interesse == false}"> Interesses zoveel mogelijk gemixt,</c:if>
			met factor ${voorkeuren.factInteresse}.</td>
	</tr>
	<tr>
		<td> <c:if test="${voorkeuren.relatie == true}"> Gelijke relaties bij mekaar,</c:if> 
			 <c:if test="${voorkeuren.relatie == false}"> Relaties zoveel mogelijk gemixt,</c:if>
			met factor ${voorkeuren.factRelatie}.</td>
	</tr>
</table>

<h3> Kloppen de gegevens? Ga dan verder naar de tafelschikking</h3><br>

<strong><h2><a href="index"> Gegevens aanpassen </a></h2></strong> &nbsp; &nbsp;
<strong><a href="plaatsGasten">Genereer een optimale tafelschikking</a></strong>

<br>

</body>
</html>