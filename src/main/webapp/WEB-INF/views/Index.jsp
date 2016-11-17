<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Tafelzetting</title>
</head>
<body>
We hebben de volgende gasten: 
<ol>
	<c:forEach items="${gastenlijst}" var="b">
		<li> Naam: ${b.naam}, Leeftijd: ${b.leeftijd},
		Geslacht: <c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if test="${b.vrouw == false}"> man </c:if>  
		<a href="delete?id=${b.id}">verwijder</a> </li> 
	</c:forEach>
</ol>

Vul hier de gasten in:

<form method="post" action="/index">
	Naam: <input type = "text" name="naam">
	Leeftijd: <input type = "text" name="leeftijd">
	Geslacht:
			<select name="vrouw">
			<option value="false">man</option>
			<option value="true">vrouw</option></select>
	<input type="submit">
</form>



Voer hier gegevens over de accomodatie in: 
<a href="accomodatie">accomodatie</a>
</body>
</html>
