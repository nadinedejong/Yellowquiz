<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form method="post" action="/maakGast">

		<table class="table">
			<!--  Rij 1 (de kopjes van de tabel)-->
			<tr>
				<th>Nummer</th>
				<th>Naam</th>
				<th>Leeftijd</th>
				<th>Geslacht</th>
				<th>Interesse</th>
				<th>Relatie</th>
				<th>Actie</th>
			</tr>

			<!--  Rij 2 t/m... (dus de ingevoerde gasten) -->
			<c:forEach items="${gastenlijst}" var="b" varStatus="status">
				<tr>
					<td>Gast ${status.count}</td>
					<td>${b.naam}</td>
					<td>${b.leeftijd}</td>
					<td><c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if
							test="${b.vrouw == false}"> man </c:if></td>
					<td><c:if test="${b.interesse == 0}"> voetbal </c:if>
						<c:if test="${b.interesse == 1}"> lego </c:if>
						<c:if test="${b.interesse == 2}"> gtst </c:if>
						<c:if test="${b.interesse == 3}"> spreekwoorden </c:if></td>
					<td><c:if test="${b.relatie == 0}"> familie </c:if>
						<c:if test="${b.relatie == 1}"> vrienden </c:if>
						<c:if test="${b.relatie == 2}"> collega's </c:if></td>	
					<td><a class="btn btn-danger btn-xs" href="deleteGast?id=${b.id}" role="button">verwijder</a></td>
				</tr>
			</c:forEach>

			<!--  Laatste rij (nieuwe gast toevoegen) -->
			<tr>
				<td>Nieuwe gast</td>
				<td><input type="text" name="naam"
					placeholder='Vul naam in ...'></td>
				<td><input type="text" name="leeftijd"
					placeholder='Vul leeftijd in ...'>
				<td><select name="vrouw">
						<option value="false">man</option>
						<option value="true">vrouw</option>
				</select></td>
				<td><select name="interesse">
						<option value="0">voetbal</option>
						<option value="1">lego</option>
						<option value="2">gtst</option>
						<option value="3">spreekwoorden</option>
				</select></td>
				<td><select name="relatie">
						<option value="0">familie</option>
						<option value="1">vrienden</option>
						<option value="2">collega's</option>
				</select></td>
				<td><input type="submit" value='Toevoegen' role="button" class="btn btn-success btn-xs"></td>
			</tr>
		</table>

	</form>