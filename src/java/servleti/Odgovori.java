/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author korisnik
 */
public class Odgovori extends HttpServlet {

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
        HttpSession sesija= request.getSession();
        String email = (String)sesija.getAttribute("mesg");
        String ko = (String)request.getParameter("Email");
        String telefon = (String)request.getParameter("Telefon");
        String sadrzaj = (String)request.getParameter("odgovor");
               
        
        if(email != null && email.length()>0){
            if(ko != null && ko.length()>0 && sadrzaj != null && sadrzaj.length()>0){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
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

                int KorisnikID=(int)sesija.getAttribute("kid");
                
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
                Statement st= con.createStatement();

                st.executeUpdate("insert into poruka(Sadrzaj, Telefon, KorisnikID, EmailP)"
                        + " VALUES('"+sadrzaj+"','"+telefon+"','"+KorisnikID+"','"+email+"');");

                st.close();
                con.close();

                request.setAttribute("jej","Slanje poruke uspesno!");
                request.getRequestDispatcher("PorukeListaServlet").forward(request, response);                    

            }catch(ClassNotFoundException ex){}
             catch(SQLException sqe){
                String mesg=sqe.getMessage();
                request.setAttribute("msg",mesg);
                request.getRequestDispatcher("error.jsp").forward(request, response);

             }            
        }else{
        request.setAttribute("jej","Ne mozete poslati praznu poruku!");
        request.getRequestDispatcher("odgovori.jsp").forward(request, response);
        }}else{
            request.setAttribute("msg","Morate se prvo ulogovati!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
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
