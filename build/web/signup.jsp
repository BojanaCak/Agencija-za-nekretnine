<%-- 
    Document   : signup
    Created on : Jun 7, 2019, 5:40:33 PM
    Author     : korisnik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>        
               <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registracija</title>
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
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
    body {
       background-image: url("img/prva.jpg");
    }
    .reg {
        border: 2px solid black;
            background-color:  hsla(45, 49%, 56%, 0.7);
            width:400px ;
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
</head>


    <body>
        <div id="nav">
            
        </div>
               <form method="post" action="registracija">
        
            
            <div class="reg" align="center">
                <br> <h2>REGISTRACIJA</h2><br>
            <table>
               <tr>
                    <td>Ime:</td>
                    <td><input type="text" name="ime" ></td>
                </tr>
                <tr>
                    <td>Prezime:</td>
                    <td><input type="text" name="prezime"</td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="text" name="email" ></td>
                </tr>
                <tr>
                    <td>Telefon:</td>
                    <td><input type="text" name="telefon"></td>
                </tr>
                <tr>
                    <td>Lozinka:</td>
                    <td><input type="password" name="lozinka"></td>
                </tr>
                <tr>
                    <td>Potvrda lozinke:</td>
                    <td><input type="password" name="potvrda"></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Registrujte se"></td>
                    <td><input type="reset" value="Poništite"></td>
                </tr>
                
            </table>
                <br>
            <br> <% String mesg= (String) request.getAttribute("msg");
               if(mesg != null && mesg.length()>0){
               %>
               <p><b><%= mesg%></b></p>
               <%} %>
               Već ste registrovani? <a href="login.jsp">Ulogujte se!</a>
               </div>
        </form>
        
    </body>
</html>
