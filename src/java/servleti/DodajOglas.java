/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
public class DodajOglas extends HttpServlet {

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
        
        int KorisnikID = Integer.parseInt(request.getParameter("KorisnikID"));
        int Kvadratura = Integer.parseInt(request.getParameter("Kvadratura"));        
        int Cena = Integer.parseInt(request.getParameter("Cena"));
        String Struktura = (String)request.getParameter("Struktura");
        String Status = (String)request.getParameter("Status");
        String Tip = (String)request.getParameter("Tip");
        String Grad = (String)request.getParameter("Grad");
        String Opstina = (String)request.getParameter("Opstina");
        String Adresa = (String)request.getParameter("Adresa");
        String Slika = (String)request.getParameter("Slika");
        String Opis = (String)request.getParameter("Opis");
        String Istaknut = (String)request.getParameter("Istaknut");
        int IDOglas;
                
       if(KorisnikID > 0 && Kvadratura >0 && Cena >0 && Struktura!=null && Struktura.length()>0 && Status!=null && 
           Status.length()>0 && Tip!=null && Tip.length()>0 && Grad!=null && Grad.length()>0 && Opstina!=null && 
           Opstina.length()>0 && Adresa!=null && Adresa.length()>0 && Slika!=null && Slika.length()>0 ){
            try{
                
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
                String sql = "INSERT INTO `oglas` (`KorisnikID`, `Struktura`, `Kvadratura`, `Status`, `Cena`, `Grad`, `Opstina`, `Adresa`, `Tip`, `Slika`,`Opis`,`Istaknut`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
                try(
                PreparedStatement st = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
                    st.setInt(1,KorisnikID);
                    st.setString(2,Struktura);
                    st.setInt(3,Kvadratura);
                    st.setString(4,Status);
                    st.setInt(5,Cena);
                    st.setString(6,Grad);
                    st.setString(7,Opstina);
                    st.setString(8,Adresa);
                    st.setString(9,Tip);
                    st.setString(10,Slika);
                    st.setString(11,Opis);
                    st.setString(12,Istaknut);
                    
                    st.addBatch();
                    st.executeBatch();
                    
                    ResultSet rs = st.getGeneratedKeys();
                    while(rs.next()){
                        IDOglas = rs.getInt(1);
                        sesija.setAttribute("IDOdodaj",IDOglas);
                    }
                    st.close();
                }catch(Exception e){ e.printStackTrace();}
                
                con.close();                
                
                request.setAttribute("jej","Oglas uspesno dodat, dodajte slike!");
                request.getRequestDispatcher("dodajSlike.jsp").forward(request, response);

                    
                }catch(ClassNotFoundException ex){System.err.println(ex.getMessage());}
                 catch(SQLException sqe){
                    String mesg=sqe.getMessage();
                    request.setAttribute("msg",mesg);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                 
                }
            }else{
                    request.setAttribute("jej","Morate popuniti sva polja!");
                    request.getRequestDispatcher("dodajOglas.jsp").forward(request, response);
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
