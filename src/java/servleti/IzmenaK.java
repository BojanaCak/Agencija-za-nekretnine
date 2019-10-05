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
public class IzmenaK extends HttpServlet {

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
        int idKorisnika = Integer.parseInt(request.getParameter("idKorisnika"));
        String ime = (String)request.getParameter("ime");
        String prezime = (String)request.getParameter("prezime");
        String telefon = (String)request.getParameter("telefon");
        String email = (String)request.getParameter("email");
        String lozinka = (String)request.getParameter("lozinka");
        String potvrda = (String)request.getParameter("potvrda");
        HttpSession sesija = request.getSession();
        String mesg = (String)sesija.getAttribute("mesg");
        
        if(lozinka.equals(potvrda)){
        try{Class.forName("com.mysql.jdbc.Driver");
            Connection con;
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement st;
            st = con.createStatement();
                    
            st.executeUpdate("UPDATE korisnik SET Ime = '"+ime+"',Prezime= '"+prezime+"',Email= '"+email+"',Telefon= '"+telefon+"' WHERE KorisnikID = '"+idKorisnika+"';");
                   
                    st.close();
                    con.close();
                    
                    request.setAttribute("jej","Uspešno izmenjeno!");
                    if(mesg.equals("menadzer@gmail.com")){
                        request.getRequestDispatcher("KorisniciLista").forward(request, response);                                     
                    }else{
                       request.getRequestDispatcher("index.jsp").forward(request, response);  
                    }
        }catch(ClassNotFoundException ex){}
        catch(SQLException sqe){
                    String msg=sqe.getMessage();
                    request.setAttribute("msg",msg);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                 
        }}else{
            request.setAttribute("jej","Lozinke se ne poklapaju!");
                    request.getRequestDispatcher("izmenaKorisnika.jsp").forward(request, response); 
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
