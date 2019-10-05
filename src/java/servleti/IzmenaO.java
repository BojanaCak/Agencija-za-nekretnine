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
import beans.Oglas;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author korisnik
 */
public class IzmenaO extends HttpServlet {

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
         
         int IDOglas = Integer.parseInt(request.getParameter("IDO"));         
         Connection con=null; 
          
         try{       
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt=con.createStatement();
          String upit="select `Slika` from oglas where oglas.IDOglas = '"+IDOglas+"';";
          ResultSet rs=stmt.executeQuery(upit);
           while(rs.next()){
              Oglas o = new Oglas();
              String slika1 = rs.getString("Slika");
              o.setSlika(slika1);
              sesija.setAttribute("slika1",o);
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
        
        
        int IDKorisnik = Integer.parseInt(request.getParameter("IDKorisnik"));
        int kvadratura = Integer.parseInt(request.getParameter("kvadratura"));
        int cena = Integer.parseInt(request.getParameter("cena"));
        String struktura = (String)request.getParameter("struktura");
        String status = (String)request.getParameter("status");
        String tip = (String)request.getParameter("tip");
        String grad = (String)request.getParameter("grad");
        String opstina = (String)request.getParameter("opstina");        
        String adresa = (String)request.getParameter("adresa");
        String slika = (String)request.getParameter("slika");
        String opis = (String)request.getParameter("opis");
        String istaknut = (String)request.getParameter("istaknut");
        Oglas o = (Oglas)sesija.getAttribute("slika1");
        String slika1 = o.getSlika();
        if(slika.isEmpty() || slika.equals("")){
        slika = slika1;
        }
         if(IDKorisnik > 0 && kvadratura >0 && cena >0 && struktura!=null && struktura.length()>0 && status!=null && 
           status.length()>0 && tip!=null && tip.length()>0 && grad!=null && grad.length()>0 && opstina!=null && 
           opstina.length()>0 && adresa!=null && adresa.length()>0){
        try{Class.forName("com.mysql.jdbc.Driver");
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement st;
            st = conn.createStatement();
                    
            st.executeUpdate("UPDATE `oglas` SET `IDOglas`='"+IDOglas+"',`KorisnikID`='"+IDKorisnik+"',`Struktura`='"+struktura+"',`Kvadratura`='"+kvadratura+"',`Status`='"+status+"',`Cena`='"+cena+"',`Grad`='"+grad+"',`Opstina`='"+opstina+"',`Adresa`='"+adresa+"',`Tip`='"+tip+"',`Slika`='"+slika+"', `Opis`='"+opis+"', `Istaknut`='"+istaknut+"' WHERE `IDOglas`='"+IDOglas+"' ;");
                   
                    st.close();
                    conn.close();
                    
                    request.setAttribute("jej","Uspešno izmenjen oglas!");
                    request.getRequestDispatcher("OglasiListaServlet").forward(request, response);                                      
                    
        }catch(ClassNotFoundException ex){}
        catch(SQLException sqe){
                    String mesg=sqe.getMessage();
                    request.setAttribute("msg",mesg);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                 
        }
    }else{
                    request.setAttribute("jej","Morate popuniti sva polja!");
                    request.getRequestDispatcher("izmenaOglasa.jsp").forward(request, response);
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
