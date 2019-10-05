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
public class registracija extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        HttpSession sesija = request.getSession();
        String ime=(String)request.getParameter("ime");
        String email=(String)request.getParameter("email");
        String telefon=(String)request.getParameter("telefon");
        String prezime=(String)request.getParameter("prezime");
        String lozinka=(String)request.getParameter("lozinka");
        String potvrda=(String)request.getParameter("potvrda");       
                 
        try{
          Class.forName("com.mysql.jdbc.Driver");
          Connection con;
          con=DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
          Statement st = con.createStatement();
          ResultSet rs;
          String upit="Select Email from korisnik";
          
          rs= st.executeQuery(upit);
          
        while(rs.next()){
            String mejl = rs.getString("email");
            sesija.setAttribute("mejl",mejl);
            if(email.equals(rs.getString("email"))){
                request.setAttribute("msg","Korisnik već postoji");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }
        
        st.close();
        con.close();
        }catch(ClassNotFoundException ex){}
        catch(SQLException sqe){
            String mesg=sqe.getMessage();
            request.setAttribute("mesg",mesg);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        
        if(ime!=null && ime.length()>0 && email!=null && 
                email.length()>0 && telefon!=null && telefon.length()>0 && prezime!=null && 
                prezime.length()>0 && lozinka!=null && lozinka.length()>0 && 
                potvrda!=null && potvrda.length()>0 ){
            if(lozinka.equals(potvrda)){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nekretnine", "root", "");
                    Statement st= con.createStatement();
                    
                    st.executeUpdate("insert into korisnik(Ime, Email, Telefon, Prezime, Lozinka)"
                            + " VALUES('"+ime+"','"+email+"','"+telefon+"','"+prezime+"','"+lozinka+"');");
                   
                    st.close();
                    con.close();
                    
                    request.setAttribute("msg","Registrovanje uspesno!Ulogujte se!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    
                    
                }catch(ClassNotFoundException ex){}
                 catch(SQLException sqe){
                    String mesg=sqe.getMessage();
                    request.setAttribute("msg",mesg);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                 
                 }
            }else{
                    request.setAttribute("msg","Lozinke se ne podudaraju!");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }else{
                    request.setAttribute("msg","Morate popuniti sva polja!");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        
    }

    }



