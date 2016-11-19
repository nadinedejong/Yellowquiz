<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TafelSchikking</title>
</head>
<body>

Tafellijst gasten
<ol>
	<c:forEach items="${gastenlijst}" var="g">
		<li> Naam: ${g.naam}, Tafel: ${g.tafel.id} </li> 
	</c:forEach>
</ol>

</body>
</html>