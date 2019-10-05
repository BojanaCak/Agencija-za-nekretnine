/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import beans.Oglas;
import java.io.IOException;
import java.io.PrintWriter;
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
public class PretragaID extends HttpServlet {

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
        int ID = Integer.parseInt(request.getParameter("ID"));
        ArrayList<Oglas> oglasi = new ArrayList<>();
        Connection con=null;
        HttpSession sesija = request.getSession();
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement stmt=con.createStatement();
            String upit="select `IDOglas`, `KorisnikID`, `Struktura`, `Kvadratura`, `Status`, `Cena`, `Grad`, `Opstina`, `Adresa`, `Tip`, `Slika` from oglas where `IDOglas` = '"+ID+"'";
            ResultSet rs=stmt.executeQuery(upit);
          while(rs.next()){
              Oglas oglas = new Oglas();
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
              oglas.setIDKorisnik(idKorisnika);
              oglas.setIDOglas(idOglas);
              oglas.setCena(Cena);
              oglas.setStruktura(Struktura);
              oglas.setKvadratura(Kvadratura);
              oglas.setStatus(Status);
              oglas.setTip(Tip);
              oglas.setGrad(Grad);
              oglas.setOpstina(Opstina);
              oglas.setAdresa(Adresa);
              oglas.setSlika(Slika);
              oglasi.add(oglas);              
              sesija.setAttribute("oglas",oglas);
          }
                
              sesija.setAttribute("oglasi",oglasi);
              if(oglasi.isEmpty()){
              request.setAttribute("jej","Ne postoji oglas sa unetim ID-om!");}
              request.getRequestDispatcher("listaOglasa.jsp").forward(request, response);
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
