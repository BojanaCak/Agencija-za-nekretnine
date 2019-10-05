/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.Korisnik;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author korisnik
 */
public class IzmeniKorisnika extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String KID = request.getParameter("idKorisnika");
         HttpSession sesija = request.getSession();
         String mesg= (String) sesija.getAttribute("mesg");
        Connection con=null;
        if(KID == null || KID.length()==0){
      try{
          Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt=con.createStatement();
          String upit="select korisnik.KorisnikID,korisnik.Ime,korisnik.Prezime,korisnik.Email,korisnik.Telefon,korisnik.Lozinka from korisnik where korisnik.Email = '"+mesg+"';";
          ResultSet rs=stmt.executeQuery(upit);
          while(rs.next()){
              Korisnik izmeni = new Korisnik();
              int idKorisnika=rs.getInt("KorisnikID");
              String ime=rs.getString("Ime");
              String prezime=rs.getString("Prezime");
              String email=rs.getString("Email");
              String telefon=rs.getString("Telefon");
              String lozinka=rs.getString("Lozinka");
              izmeni.setIdKorisnika(idKorisnika);
              izmeni.setIme(ime);
              izmeni.setPrezime(prezime);
              izmeni.setEmail(email);
              izmeni.setTelefon(telefon);
              izmeni.setLozinka(lozinka);
              izmeni.setPotvrda(lozinka);             
              sesija.setAttribute("izmeni",izmeni);
          }
                
              request.getRequestDispatcher("izmenaKorisnika.jsp").forward(request, response);
      }catch(SQLException e){
          sesija.invalidate();
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
        
    }else{
            try{
                int KorisnikID = Integer.parseInt(KID);
          Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt=con.createStatement();
          String upit="select korisnik.KorisnikID,korisnik.Ime,korisnik.Prezime,korisnik.Email,korisnik.Telefon,korisnik.Lozinka from korisnik where korisnik.KorisnikID = '"+KorisnikID+"';";
          ResultSet rs=stmt.executeQuery(upit);
          while(rs.next()){
              Korisnik izmeni = new Korisnik();
              int idKorisnika=rs.getInt("KorisnikID");
              String ime=rs.getString("Ime");
              String prezime=rs.getString("Prezime");
              String email=rs.getString("Email");
              String telefon=rs.getString("Telefon");
              String lozinka=rs.getString("Lozinka");
              izmeni.setIdKorisnika(idKorisnika);
              izmeni.setIme(ime);
              izmeni.setPrezime(prezime);
              izmeni.setEmail(email);
              izmeni.setTelefon(telefon);
              izmeni.setLozinka(lozinka);
              izmeni.setPotvrda(lozinka);             
              sesija.setAttribute("izmeni",izmeni);
          }
                
              request.getRequestDispatcher("izmenaKorisnika.jsp").forward(request, response);
      }catch(SQLException e){
          sesija.invalidate();
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
        }}
        
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
