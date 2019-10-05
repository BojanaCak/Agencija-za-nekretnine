<%-- 
    Document   : listaKorisnika
    Created on : Jun 20, 2019, 4:51:23 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% HttpSession sesija= request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista korisnika</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="bootstrap">
        <link rel="stylesheet" type="text/css" href="jquery-master/src/event/ajax.js">
        <link rel="stylesheet" type="text/css" href="jquery-master/src/event/jquery.js">
        <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/carousel.js.map">
        <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/carousel.js">
        <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/dropdown.js">
        <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/dropdown.js.map">
        

    <style>
            body {
            background-image: url("img/prva.jpg");
            }      
            .tabela{
             background-color:hsla(45, 49%, 56%, 0.6);
             border:2px solid gray;
             width:920px;
             margin:20px 10px 10px 50px;
             position:absolute;
             padding: 30px;
             }          
        </style>
    </head>
    <body>
                    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <a class="navbar-brand" href="index.jsp" > <img src="img/Nekretnine.JPG" alt="Home" style="width:42px;height:42px;border:0;" > Nekretnine</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
    </button>
     <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <ul class="navbar-nav">
            
                <% String mesg= (String) sesija.getAttribute("mesg");
                    if(mesg != null && mesg.length()>0){
                        if(mesg.equals("kpodrska@gmail.com")){
                %>
              <li class="nav-item"><a class="nav-link" href="PorukeListaServlet">Lista poruka</a></li>
              <li class="nav-item"><a class="nav-link" href="kontakt.jsp">Kontakt</a></li> 
                <%}else if(mesg.equals("admin@gmail.com")){
                                               %>
            <li class="nav-item"><a class="nav-link" href="OglasiListaServlet">Oglasi</a></li>
            <li class="nav-item"><a class="nav-link" href="DK">Dodaj oglas</a></li>
                <%}
                   else if(mesg.equals("menadzer@gmail.com"))
                {%>
            <li class="nav-item"><a class="nav-link" href="KorisniciLista">Lista korisnika</a></li>
            <li class="nav-item"><a class="nav-link" href="dodajKorisnika.jsp">Dodaj korisnika</a></li>
                <%}else{%>
                        <li class="nav-item"><a class="nav-link" href="MojiOglasi">Moji oglasi</a></li>
                       <li class="nav-item"><a class="nav-link" href="OglasiListaServlet">Lista oglasa</a></li>
                       <li class="nav-item"><a class="nav-link" href="PorukeListaServlet">Poruke</a></li>
                  <% }
                    } else{%>
            <li class="nav-item"><a class="nav-link" href="OglasiListaServlet">Lista oglasa</a></li>
            <li class="nav-item"><a class="nav-link" href="login.jsp">Prijava</a></li>
            <li class="nav-item"><a class="nav-link" href="signup.jsp">Registracija</a></li>            
                 <%}%>
            <li class="nav-item"><a class="nav-link" href="kontakt.jsp">Kontakt</a></li>   
             </ul>
            <% if(mesg != null && mesg.length()>0){%>
            <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><img style="width:20px;height:20px;" src="img/user.jpg"> <%=mesg%>
            <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="logout">Izloguj se</a></li>
                <li><a href="IzmeniKorisnika">Izmeni podatke o sebi</a></li>
            </ul>
            </li>
           <%}%>
        </div>   
    </nav>
        <div class="tabela" >
            <div class="obave">
               <% String msg= (String)request.getAttribute("jej");
               if(msg != null && msg.length()>0){%>
                <p><%= msg%></p>
               <% } %>
            </div>
            <h2>Korisnici</h2>
                <table>
                    <tr>
                        <th width="98px">Id korisnika</th>
                        <th width="98px">Ime</th>
                        <th width="98px">Prezime</th>
                        <th width="98px">Telefon</th>
                        <th width="98px">Email</th>
                        <th width="98px">Izmeni</th>
                        <th width="98px">Obrisi</th>
                    </tr>
                    <c:forEach items="${korisnici}" var="korisnik">

                    <tr><td >${korisnik.idKorisnika}</td>
                        <td >${korisnik.ime}</td>
                        <td >${korisnik.prezime}</td>
                        <td >${korisnik.telefon}</td>
                        <td >${korisnik.email}</td> 
                        <td ><a style='font-size:35px;' href="IzmeniKorisnika?idKorisnika=${korisnik.idKorisnika}">&#9997</a></td> 
                        <td align="center"><a href="ObrisiKorisnika?idKorisnika=${korisnik.idKorisnika}">&#10007</a></td>
                    </tr>    
                    </c:forEach>
            </table>
        </div>
    </body>
</html>