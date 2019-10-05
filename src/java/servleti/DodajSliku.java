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
import javax.servlet.http.HttpSession;

/**
 *
 * @author korisnik
 */
public class DodajSliku extends HttpServlet {

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
        HttpSession sesija = request.getSession();
        Connection con;
        String Slika = (String)request.getParameter("pic");
        String akcija = (String)request.getParameter("akcija");
        int IDOglas = (int)sesija.getAttribute("IDOdodaj");
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement st= con.createStatement();        
            st.executeUpdate("insert into slike(IDOglas, slika)"
                        + " VALUES('"+IDOglas+"','"+Slika+"');");  
                            
            st.close();
            con.close();                

            request.setAttribute("jej","Slika je dodata, dodajte jos slika!");
            if(akcija.equals("Potvrdi")){
                request.getRequestDispatcher("dodajSlike.jsp").forward(request, response);
            }else if(akcija.equals("Dodaj")){
                request.getRequestDispatcher("OglasiListaServlet").forward(request, response);}
            
        }catch(ClassNotFoundException ex){
            System.err.println(ex.getMessage());
        }catch(SQLException sqe){
            String mesg=sqe.getMessage();
            request.setAttribute("msg",mesg);
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
