<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Schikking</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/forminput.js"></script>
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/main.css">

</head>
<body>

<!-- Dit is de navigatiebar -->
	<%@include file="Navbar.jsp" %>

<br><br><br>


<h1>Tafelschikking gasten</h1>

<br>

<h3>Overzicht:</h3>
<br>
	<table>

			<!--  Rij 2 t/m... (dus de ingevoerde gasten) -->
			<c:forEach items="${ tafels }" var="t" varStatus="status">
				<tr>
					<th>Tafel ${ status.count } </th>
				</tr>
		
				<tr>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th>Gast &nbsp; </th>
					<th>Leeftijd &nbsp;</th>
					<th>Geslacht &nbsp;</th>
					<th>Interesse &nbsp;</th>
					<th>Relatie &nbsp;</th>
				</tr>
				<c:forEach items="${ t.gasten }" var="g" varStatus="gastnummer">	
					<tr>
						<td></td>
						<td>${gastnummer.count } &nbsp;</td>
						<td>${g.naam }</td>
						<td>${g.leeftijd }</td>
						<td><c:if test="${g.vrouw == true}"> vrouw </c:if> 
							<c:if test="${g.vrouw == false}"> man </c:if>  </td>
						<td><c:if test="${g.interesse == 0}"> voetbal </c:if>
							<c:if test="${g.interesse == 1}"> lego </c:if>
							<c:if test="${g.interesse == 2}"> gtst </c:if>
							<c:if test="${g.interesse == 3}"> spreekwoorden </c:if></td>
						<td><c:if test="${g.relatie == 0}"> familie </c:if>
							<c:if test="${g.relatie == 1}"> vrienden </c:if>
							<c:if test="${g.relatie == 2}"> collega's </c:if></td>
					</tr>
				</c:forEach>
				<td><br></td>
			</c:forEach>
	</table>



<!-- Hier is de footer -->	
<%@include file="OnzeFooter.jsp"%>

</body>
</html>