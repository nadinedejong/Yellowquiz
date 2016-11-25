<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schikking</title>
</head>
<body>
Hier komt de uiteindelijke tafelschikking op met javascript of ajax


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
			Gasten: <br>
			<c:forEach items="${t.gasten}" var="g">     
				${g.naam}, ${g.vrouw}, ${g.leeftijd}, ${g.interesse}, ${g.relatie };
				<br>
			</c:forEach>
		</li> 
	</c:forEach>
</ol>


</body>
</html>