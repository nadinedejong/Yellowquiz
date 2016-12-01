<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${!empty events }">
		<p id="eventGegevens">
			<strong> Het volgende event is ingevoerd:</strong><br>
			${events[0].naam } &nbsp; op &nbsp; ${events[0].datum }<br> <input
				id="aanpasknop" type=button value="Evenementgegevens aanpassen">
		</p>
	</c:if>

	<div <c:if test="${!empty events }">style="display: none"</c:if>
		id="eventForm">
		<form method="post" action="/aanpassenEvent">
			Naam: &nbsp; <input type="text" name="naam"
				<c:if test="${ !empty events }"> 
								value="${events[0].naam }" </c:if>
				<c:if test="${ empty events }"> 
								placeholder="voer naam van event in..."</c:if>>
			<br> Datum: &nbsp;<input type="date" name="datum"
				<c:if test="${ !empty events }"> 
								value ="${ events[0].datum }"> </c:if>>
			<!--  <br> Sorteren op geslacht? <select name="sorteergeslacht">
				<option value="false">ja</option>
				<option value="true">nee</option>-->
			</select><br> <input id="eventsubmitknop" type="submit" value="Opslaan">
		</form>
	</div>