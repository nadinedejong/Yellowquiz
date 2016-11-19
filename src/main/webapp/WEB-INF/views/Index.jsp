<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>TafelSchikking</title>
</head>
<body>
We hebben de volgende gasten: 
<ol>
	<c:forEach items="${gastenlijst}" var="b">
		<li> Naam: ${b.naam}, Leeftijd: ${b.leeftijd},
		Geslacht: <c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if test="${b.vrouw == false}"> man </c:if>  
		<a href="deleteGast?id=${b.id}">verwijder</a> </li> 
	</c:forEach>
</ol>

Voeg een nieuwe gast toe:

<form method="post" action="/maakGast">
	Naam: <input type = "text" name="naam">
	Leeftijd: <input type = "text" name="leeftijd">
	Geslacht:
			<select name="vrouw">
			<option value="false">man</option>
			<option value="true">vrouw</option></select>
	<input type="submit">
</form>


<br><br><br>
We hebben de volgende tafels: 
<ol>
	<c:forEach items="${tafels}" var="t">
		<li> Aantal stoelen: ${t.stoelen}, tafel ID: ${t.id}
		<a href="deleteTafel?id=${t.id}">verwijder</a> </li> 
	</c:forEach>
</ol>

Voeg een nieuwe tafel toe:  

<form method="post" action="/maakTafel">
	Aantal stoelen: <input type = "text" name="stoelen">
	Vorm tafel: <select name="Vorm">
					<option value="Vorm.ROND">rond</option>
					<option value="Vorm.VIERKANT">vierkant</option>
					<option value="Vorm.RECHTHOEK">rechthoek</option>
				</select>
	<input type="submit">
</form>
<br><br><br>
<a href="plaatsGasten">Plaats de gasten randomly</a>
<br>

Tafellijst gasten
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
				${g.naam},
			</c:forEach>
		</li> 
	</c:forEach>
</ol>

</body>
</html>

