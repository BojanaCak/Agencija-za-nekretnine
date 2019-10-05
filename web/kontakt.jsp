<%-- 
    Document   : kontakt
    Created on : Jul 5, 2019, 3:02:11 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Korisnik"%>
<% HttpSession sesija= request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kontakt</title>
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
  body{
     background-image: url("img/bg.png");
     background-repeat: repeat; 
  }
  .carousel-inner {
      height: 360px;
  }
  h1{
      text-align: center;
  }
  table{ 
      margin: auto;          
  }
  td{
      padding: 10px; 
  }
  input[type=submit], input[type=reset] {
  background-color: #1f1f14;
  border: none;
  color: white;
  padding: 10px 17px;
  text-align: center;
  font-size: 16px;
  cursor: pointer;
}

 input[type=submit]:hover ,input[type=reset]:hover {
  background-color: black;
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);            
}
 input[type=text], select {
 
  padding: 5px 5px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
.dropdown{
    float: right;
}
.tabela{
    width:520px ;
    height:420px;
    margin:20px 10px 10px 500px;
    padding: 40px;    
    }
.kontakt{
    background-color: #404040;
    width:220px ;
    height:920px;
    color:white;
    position:fixed;
    padding-left:10px;
    padding-top: 10px;
)
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
        <div class="kontakt" class="bg-dark">
            <ul class="nav flex-column">
            <ul class="nav flex-column">
                <li class="nav-item"><h4>Kontaktirajte nas</h4></li><br>
                <li class="nav-item">Brace Jerkovic 37</li>
                <li class="nav-item">+381 66 878 787</li>
                <li class="nav-item">nekretnine@gmail.com</li>
            </ul>
                <br><br><br>
            <ul class="nav flex-column">
                <li class="nav-item"><h4>Radno vreme:</h4></li><br>
                <li class="nav-item">09:00 - 21:00</li>
                <li class="nav-item">Pon-Ned</li>
            </ul>
            </ul>
        </div>
    
        <div class="tabela">
            <form action="SlanjePor" method="post">
                <table>
                    <tr>
                        <td colspan="2">
                            <% String msg= (String) request.getAttribute("msg");
                                if(msg != null && msg.length()>0){
                                %>
                                <b><%= msg%></b>
                                <%} %>
                        </td>
                    </tr>
                    <tr><input hidden type="text" name="KorisnikID" value="6">
                        <td>Broj telefona:</td>
                        <td><input type="text" name="telefon" placeholder="Nije obavezno polje"></td>
                    </tr>
                    <tr>
                        <td>Sadrzaj:</td>
                        <td><textarea rows="5" cols="35" name="sadrzaj"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="akcija" value="Posalji"></td>
                        <td><input type="reset" value="Ponisti"></td>
                    </tr>
                </table>
            </form>
        </div>
        
</body>
</html>
        
