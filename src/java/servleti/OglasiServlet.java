/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servleti;

import beans.Oglas;
import beans.Slike;
import java.io.IOException;
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
public class OglasiServlet extends HttpServlet {

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
        String akcija = (String)request.getParameter("akcija");
        int IDOglas = Integer.parseInt(request.getParameter("IDOglas"));
        HttpSession sesija = request.getSession();
        ArrayList<Oglas> ioglasi = new ArrayList<>();
        Connection con=null; 
        
        try{           
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
            Statement stmt=con.createStatement();
            String upit="select `o`.`IDOglas`, `o`.`KorisnikID`, `o`.`Struktura`, `o`.`Kvadratura`, `o`.`Status`, `o`.`Cena`, `o`.`Grad`, `o`.`Opstina`, `o`.`Adresa`, `o`.`Tip`, `o`.`Slika`,`o`.`Opis`,`o`.`Istaknut`,`k`.`Telefon`,`k`.`Email` from oglas `o` left join korisnik `k` on `o`.KorisnikID = `k`.KorisnikID where `o`.IDOglas = "+IDOglas+";";
            ResultSet rs=stmt.executeQuery(upit);
            while(rs.next()){
                Oglas ioglas = new Oglas();
                int idKorisnika=rs.getInt("KorisnikID");
                int idOglas=rs.getInt("IDOglas");
                int Cena=rs.getInt("Cena");
                String Struktura=rs.getString("Struktura");
                int Kvadratura=rs.getInt("Kvadratura");
                String telefon = rs.getString("Telefon");
                String Status=rs.getString("Status");
                String Grad=rs.getString("Grad");
                String Opstina=rs.getString("Opstina");
                String Adresa=rs.getString("Adresa");
                String Tip=rs.getString("Tip");
                String Slika = rs.getString("Slika");
                String email = rs.getString("Email");
                String opis = rs.getString("Opis");
                String istaknut = rs.getString("Istaknut");

                ioglas.setIDKorisnik(idKorisnika);
                ioglas.setIDOglas(idOglas);
                ioglas.setCena(Cena);
                ioglas.setStruktura(Struktura);
                ioglas.setKvadratura(Kvadratura);
                ioglas.setStatus(Status);
                ioglas.setTip(Tip);
                ioglas.setGrad(Grad);
                ioglas.setOpstina(Opstina);
                ioglas.setAdresa(Adresa);
                ioglas.setSlika(Slika);
                ioglas.setOpis(opis);
                ioglas.setIstaknut(istaknut);
                ioglasi.add(ioglas); 
                sesija.setAttribute("ist",istaknut);
                sesija.setAttribute("ioglas",ioglas);
                sesija.setAttribute("telefon",telefon);
                sesija.setAttribute("email",email);
            }
            sesija.setAttribute("ioglasi",ioglasi);                     
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
                    
            
            ArrayList<Slike> slike = new ArrayList<>();         

            try{
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
                Statement stmt1=con.createStatement();
                String upit="select `IDOglas`, `SlikaID`, `slika` from slike where `IDOglas` = '"+IDOglas+"'";
                ResultSet rs=stmt1.executeQuery(upit);
                while(rs.next()){
                    Slike slika = new Slike();
                    int SlikaID=rs.getInt("SlikaID");
                    String Slika = rs.getString("slika");
                    slika.setSlikaID(SlikaID);
                    slika.setIDOglas(IDOglas);                 
                    slika.setSlika(Slika);
                    slike.add(slika);              
                    sesija.setAttribute("slika",slika);               
                }
                sesija.setAttribute("slike",slike);
                if("Detalji".equals(akcija)){
                    request.getRequestDispatcher("detaljiOglasa.jsp").forward(request, response);
                
                }else if("Izmeni".equals(akcija)){
                    sesija.setAttribute("IDOdodaj",IDOglas); 
                    request.getRequestDispatcher("izmenaOglasa.jsp").forward(request, response);}
            }catch(SQLException e){
                sesija.invalidate();
                String errormsg=e.getMessage();
                if(con!=null){
                    try{
                        con.close();
                    }catch(SQLException ex){
                        errormsg=errormsg+ex.getMessage();
                    }
                    request.setAttribute("errormsg",errormsg);
                    RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
                    rd.forward(request,response);}
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
