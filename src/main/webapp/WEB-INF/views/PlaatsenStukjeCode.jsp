<!--  
	<a href="plaatsGasten">Plaats de gasten randomly</a>
	<br> Tafellijst gasten
	<br>
	<br>
	<br>

	 Hier worden gasten aan tafels geplaatst als test -->

<!--

	<h3>We plaatsen de gasten aan tafels</h3>
	<ol>
		<c:forEach items="${gastenlijst}" var="g">
			<li>Naam: ${g.naam}, Tafel: ${g.tafel.id}</li>
		</c:forEach>
	</ol>
	<br> Gastenlijst Per Tafel
	<ol>
		<c:forEach items="${tafels}" var="t">
			<li>Tafel ID: ${t.id}, Aantal stoelen: ${t.stoelen} <br>
				Gasten: <c:forEach items="${t.gasten}" var="g">     
				${g.naam}, ${g.leeftijd }, ${g.vrouw };
			</c:forEach>
			</li>
		</c:forEach>
	</ol>
-->