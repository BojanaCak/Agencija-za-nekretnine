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
public class Oglas {
    
    private int IDOglas;
    private int IDKorisnik;
    private int kvadratura;
    private int cena;
    private String status = "";
    private String struktura = "";
    private String grad = "";
    private String opstina = "";
    private String tip = "";
    private String adresa="";
    private String slika="";
    private String opis="";
    private String istaknut="";

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public String getIstaknut() {
        return istaknut;
    }

    public void setIstaknut(String istaknut) {
        this.istaknut = istaknut;
    }
    

    public String getSlika() {
        return slika;
    }

    public void setSlika(String slika) {
        this.slika = slika;
    }
    

    public int getIDOglas() {
        return IDOglas;
    }

    public void setIDOglas(int IDOglas) {
        this.IDOglas = IDOglas;
    }

    public int getIDKorisnik() {
        return IDKorisnik;
    }

    public void setIDKorisnik(int IDKorisnik) {
        this.IDKorisnik = IDKorisnik;
    }

    public int getKvadratura() {
        return kvadratura;
    }

    public void setKvadratura(int kvadratura) {
        this.kvadratura = kvadratura;
    }

    public int getCena() {
        return cena;
    }

    public void setCena(int cena) {
        this.cena = cena;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStruktura() {
        return struktura;
    }

    public void setStruktura(String struktura) {
        this.struktura = struktura;
    }

    public String getGrad() {
        return grad;
    }

    public void setGrad(String grad) {
        this.grad = grad;
    }

    public String getOpstina() {
        return opstina;
    }

    public void setOpstina(String opstina) {
        this.opstina = opstina;
    }

    public String getTip() {
        return tip;
    }

    public void setTip(String tip) {
        this.tip = tip;
    }

    public String getAdresa() {
        return adresa;
    }

    public void setAdresa(String adresa) {
        this.adresa = adresa;
    }



  
   
}
