<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<tr>
					<td>Gast ${status.count}</td>
					<td>${b.naam}</td>
					<td>${b.leeftijd}</td>
					<td><c:if test="${b.vrouw == true}"> vrouw </c:if> <c:if
							test="${b.vrouw == false}"> man </c:if></td>
					<td><a href="deleteGast?id=${b.id}">verwijder</a></td>
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
				<td><input type="submit" value='Toevoegen'></td>
			</tr>
		</table>

	</form>