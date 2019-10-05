<%-- 
    Document   : login
    Created on : Jun 10, 2019, 4:44:36 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% HttpSession sesija = request.getSession(); %>
<!DOCTYPE html>
<html>
    <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logovanje</title>
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
          <a class="nav-link" href="OglasiListaServlet">Lista oglasa</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="login.jsp">Prijava</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="signup.jsp">Registracija</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="kontakt.jsp">Kontakt</a>
      </li>    
    </ul>
  </div> 
    </nav>
  <style>
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  body {
       background-image: url("img/prva.jpg");
    }
    .log {
        border: 2px solid black;
            background-color:  hsla(0, 0%, 50%, 0.7);
            width:400px ;
            height:400px;
            margin:auto;
            top: 50%;
            left: 50%;
            padding: 10px;
            margin-top: 40px ;
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
        <div id="nav">
        </div>
        <form action="logovanje" method="post">
         <div class="log" align="center">
             <br><h2>PRIJAVITE SE</h2><br>
            <table>
                <tr>
                    <td>Email:</td>
                    <td><input type="text" name="Email"></td>
                </tr>
                <tr>
                    <td>Lozinka:</td>
                    <td><input type="password" name="Lozinka"></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Ulogujte se"></td>
                    <td><input type="reset" value="Poništite"></td>
                </tr>
            </table>
            
            <br>  <% String msg= (String) request.getAttribute("msg");
               if(msg != null && msg.length()>0){
               %>
               <p><b><%= msg%></b></p>
               <%} %>
               
               <br> Niste registrovani? <a href="signup.jsp">Registrujte se!</a>
            </div>
        </form>
    </body>
</html>
