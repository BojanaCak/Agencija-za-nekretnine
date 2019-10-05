/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author korisnik
 */
public class Poruka {
     
    private int IDPoruka;
    private String email = "";

    private String primalac = "";
    private int idKorisnika;
    private String sadrzaj = "";
    private String telefon = "";
  

    public String getPrimalac() {
        return primalac;
    }

    public void setPrimalac(String primalac) {
        this.primalac = primalac;
    }
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getIdKorisnika() {
        return idKorisnika;
    }

    public void setIdKorisnika(int idKorisnika) {
        this.idKorisnika = idKorisnika;
    }
        
    public int getIDPoruka() {
        return IDPoruka;
    }

    public void setIDPoruka(int IDPoruka) {
        this.IDPoruka = IDPoruka;
    }
    
   
    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }

    public String getSadrzaj() {
        return sadrzaj;
    }

    public void setSadrzaj(String sadrzaj) {
        this.sadrzaj = sadrzaj;
    }

 
  
    
}
