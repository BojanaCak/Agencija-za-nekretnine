/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import beans.Oglas;
import java.util.ArrayList;
/**
 *
 * @author korisnik
 */
public class pretraga extends HttpServlet {

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
        ArrayList<Oglas> oglasi = new ArrayList<>();
        String Status = (String)request.getParameter("Status");
        String Grad = (String)request.getParameter("Grad");
        String Tip = (String)request.getParameter("Tip");
        String Sort = (String)request.getParameter("Sort");
        request.setAttribute("Sort", Sort);
        request.setAttribute("Grad", Grad);
        request.setAttribute("Status", Status);
        request.setAttribute("Tip", Tip);
        try{
          Class.forName("com.mysql.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement stmt =con.createStatement();
          String upit = "";
         if(!Status.equals("Sve") && !Grad.equals("Sve") && !Tip.equals("Sve")){
             upit= "select * from oglas where Status ='"+Status+"' and Grad ='"+Grad+"' and Tip ='"+Tip+"' order by `"+Sort+"`" ;}
         else if(!Status.equals("Sve") && !Grad.equals("Sve") && Tip.equals("Sve")){
             upit = "select * from oglas where Status ='"+Status+"' and Grad ='"+Grad+"' order by `"+Sort+"`" ;
         }else if(!Tip.equals("Sve") && !Grad.equals("Sve") && Status.equals("Sve")){
             upit = "select * from oglas where Tip ='"+Tip+"' and Grad ='"+Grad+"' order by `"+Sort+"`" ;}
         else if(!Tip.equals("Sve") && !Status.equals("Sve") && Grad.equals("Sve")){
             upit = "select * from oglas where Status ='"+Status+"' and Tip ='"+Tip+"' order by `"+Sort+"`" ;}
         else if(!Status.equals("Sve") && Tip.equals("Sve") && Grad.equals("Sve")){
             upit = "select * from oglas where Status ='"+Status+"' order by `"+Sort+"`" ;
         }else if(!Grad.equals("Sve") && Tip.equals("Sve") && Status.equals("Sve")){
             upit = "select * from oglas where Grad ='"+Grad+"' order by `"+Sort+"`";
         }else if(!Tip.equals("Sve") && Status.equals("Sve") && Grad.equals("Sve")){
             upit = "select * from oglas where Tip ='"+Tip+"' order by `"+Sort+"`";
         }else if(Status.equals("Sve") && Grad.equals("Sve") && Tip.equals("Sve")){
             upit= "select * from oglas order by `"+Sort+"`" ;}
            ResultSet rs = stmt.executeQuery(upit);
            while(rs.next()){
              Oglas oglas = new Oglas();
              int idKorisnika=rs.getInt("KorisnikID");
              int idOglas=rs.getInt("IDOglas");
              int Cena=rs.getInt("Cena");
              String Struktura=rs.getString("Struktura");
              int Kvadratura=rs.getInt("Kvadratura");
              Status=rs.getString("Status");
              Grad=rs.getString("Grad");
              String Opstina=rs.getString("Opstina");
              String Adresa=rs.getString("Adresa");
              Tip=rs.getString("Tip");
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
            
            request.getRequestDispatcher("listaOglasa.jsp").forward(request, response);
        stmt.close();
        con.close();
        }catch(ClassNotFoundException ex){}
        catch(SQLException sqe){
            String poruka=sqe.getMessage();
            request.setAttribute("poruka",poruka);
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
