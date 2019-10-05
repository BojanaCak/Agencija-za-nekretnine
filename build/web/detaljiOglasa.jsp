<%-- 
    Document   : detaljiOglasa
    Created on : Jul 8, 2019, 7:51:32 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% HttpSession sesija= request.getSession();%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Korisnik"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalji oglasa</title>
         <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="bootstrap/dist/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="bootstrap">
  <link rel="stylesheet" type="text/css" href="jquery-master/src/event/ajax.js">
  <link rel="stylesheet" type="text/css" href="jquery-master/src/event/jquery.js">
  <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/carousel.js.map.js">
  <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/carousel.js">

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
                <%}else if(mesg.equals("admin@gmail.com")){
                                               %>
            <li class="nav-item"><a class="nav-link" href="OglasiListaServlet">Oglasi</a></li>
            <li class="nav-item"><a class="nav-link" href="DK">Dodaj oglas</a></li>
            <li class="nav-item"><a class="nav-link" href="kontakt.jsp">Kontakt</a></li> 
                <%}
                   else if(mesg.equals("menadzer@gmail.com"))
                {%>
            <li class="nav-item"><a class="nav-link" href="KorisniciLista">Lista korisnika</a></li>
            <li class="nav-item"><a class="nav-link" href="dodajKorisnika.jsp">Dodaj korisnika</a></li>
            <li class="nav-item"><a class="nav-link" href="kontakt.jsp">Kontakt</a></li> 
                <%}else{%>
                       <li class="nav-item"><a class="nav-link" href="MojiOglasi">Moji oglasi</a></li>
                       <li class="nav-item"><a class="nav-link" href="OglasiListaServlet">Lista oglasa</a></li>
                       <li class="nav-item"><a class="nav-link" href="PorukeListaServlet">Poruke</a></li>
                       <li class="nav-item"><a class="nav-link" href="kontakt.jsp">Kontakt</a></li> 
                  <% }
                    } else{%>
                       <li class="nav-item"><a class="nav-link" href="OglasiListaServlet">Lista oglasa</a></li>
            <li class="nav-item"><a class="nav-link" href="login.jsp">Prijava</a></li>
            <li class="nav-item"><a class="nav-link" href="signup.jsp">Registracija</a></li>
            <li class="nav-item"><a class="nav-link" href="kontakt.jsp">Kontakt</a></li> 
                 <%}%>
              
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
    </head>
    <style>
            
            body {
            background-image: url("img/bg.jpg");
            }
            .tabela{
             background-color:hsla(0, 0%, 50%, 0.7);
             border:2px solid gray;
             width:520px ;
             height:620px;
             margin:10px 10px 10px 50px;
             padding: 40px;
             
             
             }
             button,input[type=submit], input[type=reset] {
              background-color: hsla(45, 49%, 66%, 1);
              border: none;
              color: white;
              padding: 10px 20px;
              text-decoration: none;
              margin: 10px 10px;
              cursor: pointer;  
              border-radius: 4px;
            }
            button:hover, input[type=submit]:hover, input[type=reset]:hover{
                
                background-color: gray;
                color:white;
                box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
            }
            .nazad{
                    margin: 20px;                
            }
            table{
                margin-left: 20px;
            }
            
            
        </style>

    <body>
        <div class="obave">
           <% String msg= (String) request.getAttribute("jej");
           if(msg != null && msg.length()>0){
           %>
           <p><%= msg%></p>
           <%} %>
        </div><br>
  
        <div class="container"> 
            <div class="container gallery-container">
            <h1 class="text-center">Detalji oglasa</h1>
                <div class="tz-gallery">
                    <div class="row mb-3">
                    <p hidden name="IDKorisnika" value="${ioglas.IDKorisnik}"></p>
                       
                    <c:forEach items="${slike}" var="slika">
                    <div class="col-md-4">
                        <div class="card">
                            <a class="lightbox" href="Oglasi/${slika.slika}">
                            <img src="Oglasi/${slika.slika}" alt="${slika.slika}"class="card-img-top">
                            </a>
                        </div>
                    </div>
                    </c:forEach>  
                    <div class="col-md-4">
                        <div class="card">
                            <a class="lightbox" href="Oglasi/${ioglas.slika}">
                            <img src="Oglasi/${ioglas.slika}" alt="${ioglas.slika}"class="card-img-top">
                            </a>
                        </div>
                    </div>
                    </div>        
                </div> 
            </div>  
        </div>  
         
                    <div class="tabela">
                    <table>
                       
                        <tr>
                            <td><b>Id oglasa:</b></td>
                            <td colspan="2">${ioglas.IDOglas}</td>
                        </tr>
                        <tr>
                            <td><b>Telefon:</b></td>
                            <td colspan="2">${telefon}</td>
                        </tr> 
                        <tr>
                            <td><b>Struktura:</b></td>
                            <td colspan="2">${ioglas.struktura}</td>
                        </tr>
                        <tr>
                            <td><b>Kvadratura:</b></td>
                            <td colspan="2">${ioglas.kvadratura}&nbsp;m<sup>2</sup></td>
                        </tr>
                        <tr>
                            <td><b>Status:</b></td>
                            <td colspan="2">${ioglas.status}</td>
                        </tr>
                        <tr>
                            <td><b>Tip:</b></td>
                            <td colspan="2">${ioglas.tip}</td>
                        </tr>
                        <tr>
                            <td><b>Cena:</b></td>
                            <td colspan="2">${ioglas.cena}&nbsp;&euro;</td>
                        </tr>                       
                        <tr>
                            <td><b>Grad:</b></td>
                            <td colspan="2">${ioglas.grad}</td>
                        </tr>
                        <tr>
                            <td><b>Opstina:</b> </td>
                            <td colspan="2">${ioglas.opstina}</td>
                        </tr>
                        <tr>
                            <td><b>Adresa:</b></td>
                            <td colspan="2">${ioglas.adresa}</td>
                        </tr>
                        <tr>
                            <td><b>Opis:</b></td>
                            <td colspan="2"><textarea type="hidden" readonly="readonly" rows="6" cols="40">${ioglas.opis}</textarea></td>
                        </tr>
                        
                        <tr>
                            <td><button><a style="color:white;" href="OglasiListaServlet">Nazad</a></button></td>
                            <td><button><a style="color:white;"  href="posaljip.jsp?IDKorisnik=${ioglas.IDKorisnik}">Posalji poruku</a></td>
                        </tr> <% if (mesg != null && mesg.equals("admin@gmail.com")){%>
                    </table><form action="OglasiServlet" method="post">
                        <input type="submit" value="Izmeni" name="akcija">
                        <input type="hidden" value="${ioglas.IDOglas}" name="IDOglas">
                     </form><%}%>
    </body>
                    </div> <br>
                    
</html>
