<%-- 
    Document   : listaOglasa
    Created on : Jun 27, 2019, 3:04:17 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% HttpSession sesija= request.getSession();%>
<%@page import="java.util.ArrayList" %>
<%@page import="beans.Oglas" %>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="beans.Oglas"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista oglasa</title>
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
     body{
     background-image: url("img/bg.png");
     background-repeat: repeat; 
     margin-right: 0;
     }
     .bodi{
         position:absolute;
     }
     select{
         border-radius: 4px;
      background-color: #f1f1f1;
      padding: 7px;
     }
    .abs-center-x {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    }
     input[type=submit], input[type=reset], button {
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
      .pretraga{
      border-color: black;
      border-style: solid;
      border-radius: 12px;
      width: 650px;
      display: float;
      background-color: lightgray;
      padding: 10px; 
      position: absolute;
      margin-left: 170px;
      margin-bottom: 20px;
  }
  .istaknuti{
    background-color: #404040;
    width:320px ;
    color:white;
    display: float;
    margin-left: 1020px;
    float:right; 
)
    </style>
    <body>
        <div class="obave">
           <% String msg= (String) request.getAttribute("jej");
           if(msg != null && msg.length()>0){
           %>
           <p><%= msg%></p>
           <%} %>
        </div><br><br>
        
                <div class="istaknuti" class="bg-dark">
            <ul class="nav flex-column">
      <% 
        List<Oglas> oglasisi = new ArrayList();
        Connection con=null;
        String i = "1";
        HttpSession sesij = request.getSession();
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement stmt=con.createStatement();
            String upit="select * from oglas where `Istaknut`='"+i+"' ";
            ResultSet rs=stmt.executeQuery(upit);
          while(rs.next()){
              Oglas oglasis = new Oglas();
              int idKorisnika=rs.getInt("KorisnikID");
              int idOglas=rs.getInt("IDOglas");
              int Cena=rs.getInt("Cena");
              String Struktura=rs.getString("Struktura");
              int Kvadratura=rs.getInt("Kvadratura");
              String Status=rs.getString("Status");
              String Grad=rs.getString("Grad");
              String Opstina=rs.getString("Opstina");
              String Adresa=rs.getString("Adresa");
              String Tip=rs.getString("Tip");
              String Slika = rs.getString("Slika");
              String Istaknut=rs.getString("Istaknut");
              String Opis = rs.getString("Opis");
              oglasis.setIDKorisnik(idKorisnika);
              oglasis.setIDOglas(idOglas);
              oglasis.setCena(Cena);
              oglasis.setStruktura(Struktura);
              oglasis.setKvadratura(Kvadratura);
              oglasis.setStatus(Status);
              oglasis.setTip(Tip);
              oglasis.setGrad(Grad);
              oglasis.setOpstina(Opstina);
              oglasis.setAdresa(Adresa);
              oglasis.setSlika(Slika);
              oglasis.setOpis(Opis);
              oglasis.setIstaknut(Istaknut);
              oglasisi.add(oglasis);              
              sesij.setAttribute("oglasis",oglasis);
          }sesij.setAttribute("oglasisi",oglasisi);
                
      }catch(SQLException e){
          sesij.invalidate();
          String errormsg=e.getMessage();
          if(con!=null)
              try{
                  con.close();
              }catch(SQLException ex){
                  errormsg=errormsg+ex.getMessage();
              }
          request.setAttribute("errormsg",errormsg);
          RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
          rd.forward(request,response);
      }catch(ClassNotFoundException cnf){}
        
        %>
       <h2>Nudimo za Vas</h2> 
         <div class="container" >
            <div class="row"><br>
      <c:forEach items="${oglasisi}" var="oglasis">
       <form action="OglasiServlet" method="post" >           
             
        <div class="col-4" style="margin:10px">
            <div class="card-deck bg-black shadow p-3 mb-6 rounded" style="width: 18rem;">
                <img src="Oglasi/${oglasis.slika}" class="card-img-top" height="200px" width="300px" alt="Nije moguce ucitati sliku"> 
                <div class="card-body">
                    <h4 class="card-title">${oglasis.grad}-${oglasis.opstina}</h4>
                    <h6 class="card-text">${oglasis.cena} &euro; &emsp; ${oglasis.kvadratura} m<sup>2</sup></h6>
                    <h6 class="card-text">${oglasis.status}</h6>
                    <h6 class="card-text">ID oglasa: <input type="hidden" name="IDOglas" value="${oglasis.IDOglas}">${oglasis.IDOglas}</h6>
                    
                         <% if(mesg != null && mesg.length()>0){
                                if(mesg.equals("admin@gmail.com")){%>
                                    <input type="submit" name="akcija"  value="Izmeni">
                                    <input type="submit" name="akcija"  value="Obrisi"> 
                                    <input type="submit" name="akcija"  value="Detalji"> 
                                <%}else{%>
                                <input type="submit" name="akcija"  value="Detalji"> 
                        <% }
                    }else{%>
                        <input type="submit" name="akcija"  value="Detalji"> 
                 <%}%> 
                </div>
            </div>
        </div>                
           
       </form>
               
        </c:forEach>
            
            </ul>
        </div> 

        <form name="pretraga" class="pretraga" action="pretraga">
            &emsp;Grad:   <select name="Grad">
                <option value="Sve" <c:if test="${'Sve' eq Grad}">selected</c:if> >Sve</option>    
                <option value="Beograd" <c:if test="${'Beograd' eq Grad}">selected</c:if> >Beograd</option>
                <option value="Novi Sad" <c:if test="${'Novi Sad' eq Grad}">selected</c:if> >Novi Sad</option>
                </select>
            &emsp;Status:   <select name="Status">
                <option value="Sve" <c:if test="${'Sve' eq Status}">selected</c:if> >Sve</option>
                <option value="Prodaja" <c:if test="${'Prodaja' eq Status}">selected</c:if> >Prodaja</option>
                <option value="Iznajmljivanje"  <c:if test="${'Iznajmljivanje' eq Status}">selected</c:if> >Iznajmljivanje</option>
                <option value="Kratkorocno iznajmljivanje" <c:if test="${'Kratkorocno iznajmljivanje' eq Status}">selected</c:if> >Kratkorocno iznajmljivanje</option>
            </select>
            &emsp;Tip:   <select name="Tip">
                <option  value="Sve" <c:if test="${'Sve' eq Tip}">selected</c:if>>Sve</option>
                        <option value="Stan" <c:if test="${'Stan' eq Tip}">selected</c:if>>Stan</option>
                        <option value="Kuca" <c:if test="${'Kuca' eq Tip}">selected</c:if>>Kuca</option>
                        <option value="Garaza" <c:if test="${'Garaza' eq Tip}">selected</c:if>>Garaža</option>
                </select>
              &emsp;  Sortiraj po:  <select name="Sort">
                    <option value="IDOglas" <c:if test="${'IDOglas' eq Sort}">selected</c:if>>ID-u</option>
                    <option value="Cena" <c:if test="${'Cena' eq Sort}">selected</c:if>>Ceni</option>
                    <option value="Kvadratura" <c:if test="${'Kvadratura' eq Sort}">selected</c:if>>Kvadraturi</option>
                    
                </select>
                   &emsp;&emsp; <input type="submit" value="Traži">
             
        </form><br><br><br><br><br><br>
    <div class="bodi">
        
                <form method="post" action="PretragaID">
                    &emsp; <b>Pretrazi po ID-u: </b> <input style="width:70px" type="text" name="ID"> <input type="submit" value="Traži">
                </form>
        <div class="container" >
            <div class="row"><br>
               
        <c:forEach items="${oglasi}" var="oglas">
       <form action="OglasiServlet" method="get" >
           
               
        <div class="col-4" style="margin:10px">
            <div class="card-deck bg-secondary shadow p-3 mb-5 rounded" style="width: 18rem;">
                <img src="Oglasi/${oglas.slika}" class="card-img-top" height="200px" width="300px" alt="Nije moguce ucitati sliku"> 
                <div class="card-body">
                    <h4 class="card-title">${oglas.grad}-${oglas.opstina}</h4>
                    <h5 class="card-text">${oglas.cena} &euro;</h5>
                    <h5 class="card-text">${oglas.kvadratura} m<sup>2</sup></h5>
                    <h6 class="card-text">${oglas.status}</h6>
                    <h6 class="card-text">ID oglasa:<input type="hidden" name="IDOglas" value="${oglas.IDOglas}" >${oglas.IDOglas}</h6>
                         <% if(mesg != null && mesg.length()>0){
                                if(mesg.equals("admin@gmail.com")){%>
                                    <input type="submit" name="akcija"  value="Izmeni">
                                    <button><a style="color:white;" href="ObrisiOglas?IDOglas=${oglas.IDOglas}">Obrisi</a></button> 
                                    
                                <%}}%>
                                <input type="submit" name="akcija" value="Detalji">
                </div>
            </div>
                
        </div>  
                     
           
       </form>
        </c:forEach>
            
            </div>
        </div>
    </div>
           <script type="text/javascript" src="js/bootstrap.bundle.js"></script>
        <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
