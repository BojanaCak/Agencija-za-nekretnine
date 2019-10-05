/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import beans.Poruka;
import java.util.ArrayList;

/**
 *
 * @author korisnik
 */
public class PorukeListaServlet extends HttpServlet {

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
        ArrayList<Poruka> poruke= new ArrayList<>();
        String ko = (String)sesija.getAttribute("mesg");
        
        Connection con=null;
         try{
                Class.forName("com.mysql.jdbc.Driver");
                 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
                Statement st= con.createStatement();

                String upit="select KorisnikID from korisnik where Email = '"+ko+"'";                    
                ResultSet rs =st.executeQuery(upit); 

                while(rs.next()){
                    int KorisnikID = rs.getInt("KorisnikID");
                    sesija.setAttribute("kid", KorisnikID);
                }
            }catch(ClassNotFoundException ex){}
             catch(SQLException sqe){
                String mesg=sqe.getMessage();
                request.setAttribute("msg",mesg);
                request.getRequestDispatcher("error.jsp").forward(request, response);}
      try{
          int kid = (int)sesija.getAttribute("kid");
          Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt=con.createStatement();
          String upit="select `p`.`PorukaID`, `p`.`Sadrzaj`, `p`.`Telefon`, `p`.`KorisnikID`, `p`.`EmailP`, `k`.`Email` from poruka `p` left join korisnik `k` on `p`.`KorisnikID` = `k`.`KorisnikID` where `p`.`KorisnikID` = '"+kid+"' or `p`.`EmailP` = '"+ko+"';";
          ResultSet rs=stmt.executeQuery(upit);
          while(rs.next()){
              Poruka poruka= new Poruka();
              int PorukaID = rs.getInt("PorukaID");
              String Sadrzaj= rs.getString("Sadrzaj");
              String Email= rs.getString("EmailP");
              int KorisnikID= rs.getInt("KorisnikID");
              String Telefon= rs.getString("Telefon");
              String Primalac = rs.getString("Email");
              poruka.setIDPoruka(PorukaID);
              poruka.setEmail(Email);
              poruka.setIdKorisnika(KorisnikID);
              poruka.setSadrzaj(Sadrzaj);
              poruka.setTelefon(Telefon);
              poruka.setPrimalac(Primalac);
              poruke.add(poruka);
              
              sesija.setAttribute("Primalac",Primalac);
              sesija.setAttribute("poruka",poruka);
          }
                
              sesija.setAttribute("poruke",poruke);
              request.getRequestDispatcher("listaPoruka.jsp").forward(request, response);
              
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