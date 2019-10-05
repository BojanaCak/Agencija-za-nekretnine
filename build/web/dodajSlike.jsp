<%-- 
    Document   : dodajSlike
    Created on : Jul 10, 2019, 5:13:20 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% HttpSession sesija= request.getSession();%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Korisnik"%>
<%@page import="beans.Slike"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodaj slike</title>
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
        
            <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <a class="navbar-brand" href="index.jsp" > <img src="img/Nekretnine.JPG" alt="Home" style="width:42px;height:42px;border:0;" > Nekretnine</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="OglasiListaServlet">Oglasi</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="DK">Dodaj oglas</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="kontakt.jsp">Kontakt</a>
      </li>    
    </ul>
        <% String mesg= (String) sesija.getAttribute("mesg");
            if(mesg != null && mesg.length()>0){%>
            <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><img style="width:20px;height:20px;" src="img/user.jpg"> <%=mesg%>
            <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="logout">Izloguj se</a></li>
                <li><a href="IzmeniKorisnika">Izmeni podatke o sebi</a></li>
            </ul>
            </li>
            <%}else if(mesg == null || mesg.length()==0){ 
                    request.setAttribute("log","Morate se prvo ulogovati!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);}%>
    </div>  
    </nav>
    </head>
    <style>
            .fakeimg {
            height: 200px;
            background: #aaa;
            }
            body {
            background-image: url("img/prva.jpg");
            }
            .user{
             background-color:hsla(45, 49%, 56%, 0.6);
             width:200px ;
             float:right;
             text-align:center;
             border:2px solid gray;
            }
            .tabela{
             background-color:hsla(45, 49%, 56%, 0.6);
             border:2px solid gray;
             width:920px ;
             height:720px;
             margin:20px 10px 10px 50px;
             position:absolute;
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
       <form action="DodajSliku" method="post">                  
            <table>
                <tr>
                    <td>
                        Id oglasa
                    </td>
                    <td>
                        <input  type="text" value="<%=sesija.getAttribute("IDOdodaj")%>" name="IDOgl" readonly>              
                    </td>
                </tr>
                <tr>
                    <td><input type="file" name="pic"></td>
                    <td><input type="submit" name="akcija" value="Potvrdi"></td>
                </tr>       
            </table>
       </form>
    </body>
</html>

