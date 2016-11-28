<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form method="post" action="/maakTafel">

		<table>

			<!--  Rij 1 (de kopjes van de tabel)-->
			<tr>
				<th>Tafelnummer</th>
				<th>Aantal stoelen</th>
				<th>Vorm</th>
				<th>TafelID</th>
				<th>Actie</th>
			</tr>

			<!--  Rij 2 t/m... (dus de ingevoerde tafels) -->
			<c:forEach items="${tafels}" var="t" varStatus="aant">
				<tr>
					<td>Tafel ${aant.count}</td>
					<td>${t.stoelen}</td>
					<td>rond</td>
					<td>${t.id}</td>
					<td><a href="deleteTafel?id=${t.id}">verwijder</a></td>
				</tr>
			</c:forEach>

			<!--  Laatste rij (nieuwe tafel toevoegen) -->
			<tr>
				<td>Nieuwe tafel</td>
				<td><input type="text" name="stoelen"
					placeholder='Vul aantal stoelen in ...'></td>
				<td><select name="Vorm">
						<option value="Vorm.ROND">rond</option>
						<option value="Vorm.VIERKANT">vierkant</option>
						<option value="Vorm.RECHTHOEK">rechthoek</option>
				</select></td>
				<td><input type="submit" value='Toevoegen'></td>
			</tr>

		</table>

	</form>