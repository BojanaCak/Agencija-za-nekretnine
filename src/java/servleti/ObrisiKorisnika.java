/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author korisnik
 */
public class ObrisiKorisnika extends HttpServlet {

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
        
             int idKorisnika =Integer.parseInt(request.getParameter("idKorisnika")); 
             String email = (String)request.getParameter("email");
             String prezime = request.getParameter("prezime");
             
                             
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con;
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement st;
            Statement st1;
            Statement st2;
            st = con.createStatement();
            st1 = con.createStatement();
            st2 = con.createStatement();
                    
            st.executeUpdate("DELETE FROM poruka WHERE KorisnikID = '"+idKorisnika+"';");
            st1.executeUpdate("DELETE FROM oglas WHERE KorisnikID = '"+idKorisnika+"';");
            st2.executeUpdate("DELETE FROM korisnik WHERE KorisnikID = '"+idKorisnika+"';");
                   
                    st.close();
                    st1.close();
                    st2.close();
                    con.close();
                    
                    request.setAttribute("jej","Uspešno izbrisan korisnik!");
                    request.getRequestDispatcher("KorisniciLista").forward(request, response);                                       
                    
        }catch(ClassNotFoundException ex){}
        catch(SQLException sqe){
                    String mesg=sqe.getMessage();
                    request.setAttribute("mesg",mesg);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                 
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
