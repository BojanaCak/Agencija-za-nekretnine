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
public class logovanje extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
      
        
        HttpSession sesija=request.getSession();
        String email =(String)request.getParameter("Email");
        String lozinka =(String)request.getParameter("Lozinka");
        String admin = "admin@gmail.com";
        String menadzer = "menadzer@gmail.com";
        String kpodrska ="kpodrska@gmail.com";
        
        if(email.isEmpty() || lozinka.isEmpty()){
            request.setAttribute("msg","Morate popuniti sva polja!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else{
      Connection con=null;
      try{
          Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt=con.createStatement();
          
          String upit="select * from korisnik where Email='"+email+"' and Lozinka='"+lozinka+"';";
          ResultSet rs=stmt.executeQuery(upit);
          if(rs.next()){              
                if(email.equals(admin)){
                    sesija.setAttribute("mesg",email);
                    request.getRequestDispatcher("OglasiListaServlet").forward(request, response);               

                }else if(email.equals(menadzer)){
                    sesija.setAttribute("mesg",email);
                    request.getRequestDispatcher("KorisniciLista").forward(request, response);
                }else if(email.equals(kpodrska)){
                    sesija.setAttribute("mesg",email);
                    request.getRequestDispatcher("PorukeListaServlet").forward(request, response);
                }else{
                    sesija.setAttribute("mesg",email);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }   
              
          }else{
                request.setAttribute("msg","Nisu uneti tacni podaci!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
          
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
