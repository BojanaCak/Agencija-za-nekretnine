<%-- 
    Document   : izmenaOglasa
    Created on : Jun 28, 2019, 2:41:48 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% HttpSession sesija= request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Izmena oglasa</title>
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
            background-image: url("img/bg.png");
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
            width:1200px ;
            height:720px;
            margin:20px 10px 10px 50px;
            position:absolute;
            padding: 40px;
            display:inline-table;
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
        #forma{
            display:none;
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
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <img style="width:20px;height:20px;" src="img/user.jpg"> <%=mesg%>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="logout">Izloguj se</a></li>
                        <li><a href="IzmeniKorisnika">Izmeni podatke o sebi</a></li>
                    </ul>
                </li>
                <%}else{ 
                    request.setAttribute("log","Morate se prvo ulogovati!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);}
                %>
            </div>  
        </nav>
    
        <div class="tabela" >
            <form action="IzmenaO" method="post">        
                <h2>Izmenite oglas</h2> <br>
                <table>
                    <tr>
                        <td>Id oglasa</td>
                        <td><input type="hidden" name="IDO" value="${ioglas.IDOglas}">${ioglas.IDOglas}</td>
                       
                        <td>Id korisnika</td>
                        <td><input name="IDKorisnik" value="${ioglas.IDKorisnik}"></td>
                    </tr>                       
                    <tr>
                        <td>Grad</td>
                        <td><select name="grad">  
                            <option selected="${ioglas.grad}" value="${ioglas.grad}">${ioglas.grad}</option>
                            <option value="Beograd">Beograd</option>
                            <option value="Novi Sad">Novi Sad</option>
                            </select>
                        </td>
                        <td>Opstina </td>
                        <td><input type="text" name="opstina" value="${ioglas.opstina}"></td>
                    </tr>
                    <tr>
                        <td>Struktura</td>
                        <td><input type="text" name="struktura" value="${ioglas.struktura}"></td>
                        <td>Kvadratura</td>
                        <td><input type="text" name="kvadratura" value="${ioglas.kvadratura}"></td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td><input type="text" name="status" value="${ioglas.status}"></td>
                        <td>Tip</td>
                        <td><input type="text" name="tip" value="${ioglas.tip}"></td>
                    </tr>
                    <tr>
                        <td>Cena</td>
                        <td><input type="text" name="cena" value="${ioglas.cena}"></td>
                        <td>Adresa</td>
                        <td><input type="text" name="adresa" value="${ioglas.adresa}"></td>
                       <div class="form-group">
                           <td>Slika/thumnail: </td>
                           <td><input type="file" name="slika" id="slika"  value="${ioglas.slika}"></td>
                        </div>
                    </tr>
                    <tr>
                        <td>Opis</td>
                        <td><textarea rows="6" cols="40" name="opis">${ioglas.opis}</textarea></td>
                        <td>Istaknut</td>
                        <td><select name="istaknut" >
                                <% String Ist = (String)sesija.getAttribute("ist");
                                    if(Ist.equals("1")){
                               %>
                                <option selected name="da" value="1">Da</option>
                                <option name="ne" value="0">Ne</option>
                                <%}else{%>
                                <option name="da" value="1">Da</option>
                                <option selected name="ne" value="0">Ne</option><%}%>
                        </select></td>
                    </tr>
                    <tr>
                        <td ><button>Izmeni</button></td>
                        <td ><input type="reset" value="Poništi"></td>
                        <td></td>
                    </tr>
                </table>
                <div class="obave">
                   <% String msg= (String) request.getAttribute("jej");
                   if(msg != null && msg.length()>0){
                   %>
                   <p><%= msg%></p>
                   <%} %>
                </div >               
            </form>
            
            <div class="nazad">
                <form action="OglasiListaServlet">
                    <input type="submit" value="Nazad"  >
                </form>
            </div>            
            <div>                
               <input type="submit" onclick="myFunction()" value="Izmeni slike" >
                <script>
                    function myFunction() {
                       var x = document.getElementById("forma");
                      if (x.style.display === "block") {
                        x.style.display = "none";
                      } else {
                        x.style.display = "block";
                      }
                    } 
                  </script>
            <form  name="forma" id="forma" method="post" action="SlikeServlet" enctype="multiple/form-data">
                <table>
                    <th>Slike</th>
                    <th>ID Slike</th>
                    <th>Obrisi sliku</th>
                    <c:forEach items="${slike}" var="slika">
                        <tr><input type="hidden" name="IDOglas" value="${slika.IDOglas}">
                            <td>
                                <a  href="Oglasi/${slika.slika}" >
                                    <img src="Oglasi/${slika.slika}" value="${slika.slika}" alt="${slika.slika}" class="card-img-top">
                                </a>
                            </td>
                            <td class="ID">
                                <b><input type="text" name="SlikaID" value="${slika.slikaID}" ></b> 
                            </td>
                            <td>
                                <input type="submit" value="Obrisi" name="akcija" >                            
                            </td>
                        </tr>               
                  
                    </c:forEach>
                </table> 
            </form>
            <form method="post" action="DodajSliku" >
                <table> 
                    <tr>
                        <td>Id oglasa</td>
                        <td><input readonly type="text"  name="IDOgl" value="<%=sesija.getAttribute("IDOdodaj")%>"></td>
                    </tr>
                      <tr> 
                         <td>                        
                            Dodaj novu sliku: <input type="file" name="pic" id="slika"> 
                        </td>
                        <td>
                            <input type="submit" value="Dodaj" name="akcija" >
                        </td>
                    </tr>
                </table>    
            </form>
            </div> 
        </div>
    </body>
</html>

