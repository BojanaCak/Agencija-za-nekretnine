<%--- 
    Document   : index
    Created on : Jun 6, 2019, 10:18:10 PM
    Author     : korisnik
--%>

<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="beans.Oglas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Korisnik"%>
<% HttpSession sesija= request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nekretnine</title>
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
        <link rel="stylesheet" type="text/css" href="bootstrap/js/src/dropdown.js">
        <link rel="stylesheet" type="text/css" href="bootstrap/js/dist/dropdown.js.map">
  <style>
      .carousel-inner{
          height: 380px;
      }
  body{
     background-image: url("img/bg.png");
     background-repeat: repeat; 
  }
  h1{
      text-align: center;
  }
  .pretraga{
      border-color: black;
      border-style: solid;
      border-radius: 12px;
      width: 900px;
      display: float;
      background-color: lightgray;
      padding: 20px; 
      position: relative;
      margin:auto;
  }
  table{ 
      margin: auto;
          
  }
  td{
      padding: 10px; 
  }
  .button {
  background-color: #1f1f14;
  border: none;
  color: white;
  padding: 10px 17px;
  text-align: center;
  font-size: 16px;
  cursor: pointer;
}

.button:hover {
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
 input[type=submit], input[type=reset] {
      background-color: hsla(45, 49%, 66%, 1);
      border: none;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      margin: 10px 10px;
      cursor: pointer;  
      border-radius: 4px;
    }
    input[type=submit]:hover, input[type=reset]:hover{
                
            background-color: gray;
            color:white;
            box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
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
        
      
   <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
        <img src="img/1.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="img/2.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="img/3.jpg" class="d-block w-100" alt="...">
    </div>
  </div>
       <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
        <div class="obave">
           <% String msg= (String)request.getAttribute("jej");
           if(msg != null && msg.length()>0){
           %>
           <p><%= msg%></p>
           <%} %>
        </div > 
</div>
        <% 
            List<Oglas> oglasisi = new ArrayList();
        Connection con=null;
        HttpSession sesij = request.getSession();
        String i= "1";
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
        <h1>Istaknuti oglasi</h1>
         <div class="container" >
            <div class="row"><br>
      <c:forEach items="${oglasisi}" var="oglasis">
       <form action="OglasiServlet" method="post" >
           
               
        <div class="col-4" style="margin:10px">
            <div class="card-deck bg-secondary shadow p-3 mb-5 rounded" style="width: 18rem;">
                <img src="Oglasi/${oglasis.slika}" class="card-img-top" height="200px" width="300px" alt="Nije moguce ucitati sliku"> 
                <div class="card-body">
                    <h4 class="card-title">${oglasis.grad}-${oglasis.opstina}</h4>
                    <h5 class="card-text">${oglasis.cena} &euro;</h5>
                    <h5 class="card-text">${oglasis.kvadratura} m<sup>2</sup></h5>
                    <h6 class="card-text">${oglasis.status}</h6>
                    <h6 class="card-text">ID oglasa: <input type="hidden" name="IDOglas" value="${oglasis.IDOglas}">${oglasis.IDOglas}</h6>
                         <% if(mesg != null && mesg.length()>0){
                                if(mesg.equals("admin@gmail.com")){%>
                                    <input type="submit" name="akcija"  value="Izmeni" >
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
                 <form action="OglasiListaServlet" method="post">
                    <b>Idi na listu oglasa</b>
                    <input type="submit" value="Potvrdi">
                </form>
            </div>
         </div>
        
</body>
</html>
