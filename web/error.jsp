<%-- 
    Document   : error
    Created on : Jun 7, 2019, 5:53:13 PM
    Author     : korisnik
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Greskica!</h1>
        <h3><%String por = (String)request.getAttribute("poruka");%></h3>
        <h3><%=por%></h3>
    </body>
</html>
