<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form method="post" action="/zetVoorkeuren">
<table>
	<tr> 
		<td> Mannen en vrouwen apart?</td>
		<td><select name="manVrouw">
		    <option value="true">ja</option>
			<option value="false">nee</option></select></td>
		<td> Hoe belangrijk? Geef een score van 0-5 </td>
		<td> <select name="factManVrouw">
			 <option value="0">0</option>
			 <option value="1">1</option>
			 <option value="2">2</option>
			 <option value="3">3</option>
			 <option value="4">4</option>
			 <option value="5">5</option></select></td>
	</tr>
	<tr> 
		<td> Dezelfde leeftijd bij mekaar?</td>
		<td><select name="opLeeftijd">
		    <option value="true">ja</option>
			<option value="false">nee</option></select></td>
		<td> Hoe belangrijk? Geef een score van 0-5 </td>
		<td> <select name="factOpLeeftijd">
			 <option value="0">0</option>
			 <option value="1">1</option>
			 <option value="2">2</option>
			 <option value="3">3</option>
			 <option value="4">4</option>
			 <option value="5">5</option></select></td>
	</tr>
	<tr> 
		<td> Dezelfde interesses bij mekaar?</td>
		<td><select name="interesse">
		    <option value="true">ja</option>
			<option value="false">nee</option></select></td>
		<td> Hoe belangrijk? Geef een score van 0-5 </td>
		<td> <select name="factInteresse">
			 <option value="0">0</option>
			 <option value="1">1</option>
			 <option value="2">2</option>
			 <option value="3">3</option>
			 <option value="4">4</option>
			 <option value="5">5</option></select></td>
	</tr>
		<tr> 
		<td> Dezelfde relaties bij mekaar?</td>
		<td><select name="relatie">
		    <option value="true">ja</option>
			<option value="false">nee</option></select></td>
		<td> Hoe belangrijk? Geef een score van 0-5 </td>
		<td> <select name="factRelatie">
			 <option value="0">0</option>
			 <option value="1">1</option>
			 <option value="2">2</option>
			 <option value="3">3</option>
			 <option value="4">4</option>
			 <option value="5">5</option></select></td>
		<td> <input type="submit"></td>
	</tr>
</table>
</form>