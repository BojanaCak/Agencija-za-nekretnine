/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import beans.Korisnik;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author korisnik
 */
public class KorisniciLista extends HttpServlet {

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
            HttpSession sesija=request.getSession();
        ArrayList<Korisnik> korisnici = new ArrayList<>();
        
        Connection con=null;
      try{
          Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt=con.createStatement();
          String upit="select KorisnikID,Ime,Prezime,Email,Telefon,Lozinka from korisnik";
          ResultSet rs=stmt.executeQuery(upit);
          while(rs.next()){
              Korisnik korisnik = new Korisnik();
              int idKorisnika=rs.getInt("KorisnikID");
              String ime=rs.getString("Ime");
              String prezime=rs.getString("Prezime");
              String email=rs.getString("Email");
              String telefon=rs.getString("Telefon");
              String lozinka=rs.getString("Lozinka");
              korisnik.setIdKorisnika(idKorisnika);
              korisnik.setIme(ime);
              korisnik.setPrezime(prezime);
              korisnik.setEmail(email);
              korisnik.setTelefon(telefon);
              korisnik.setLozinka(lozinka);
              korisnik.setPotvrda(lozinka);
              korisnici.add(korisnik);              
              sesija.setAttribute("korisnik",korisnik);
          }
                
              sesija.setAttribute("korisnici",korisnici);
              String izmn = (String)request.getAttribute("izmn");
              request.setAttribute("izmn",izmn);
              request.getRequestDispatcher("listaKorisnika.jsp").forward(request, response);
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
        
    }

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
