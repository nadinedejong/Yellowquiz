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
		<li> Aantal stoelen: ${t.stoelen}  
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

We plaatsen de gasten aan tafels
<ol>
	<c:forEach items="${gastenlijst}" var="g">
		<li> Naam: ${g.naam} 
			<a href="zetGastAanTafel?id=${g.id}">gast aan tafel</a> </li> 
	</c:forEach>
</ol>
