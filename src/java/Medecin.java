package model;
import java.util.*;

public class Medecin{
    private String id;
    private String nom;
    private String prenom;
    private String matricule;
    private String telephone;
    private String email;
    private String niveau;
    private double horaire;
    private String centre;
    private int niveaurole;
    private int iduser;
    private String profile;

    public Medecin(){}
    public Medecin(String id,String nom,String prenom,String matricule,
    String telephone,String email,String niveau,double horaire,
    String centre,int niveaurole,int iduser,String profile)throws Exception {
        try{
            set_id(id);
            set_nom(nom);
            set_prenom(prenom);
            set_matricule(matricule);
            set_telephone(telephone);
            set_email(email);
            set_niveau(niveau);
            set_horaire(horaire);
            set_centre(centre);
            set_niveaurole(niveaurole);
            set_iduser(iduser);
            set_profile(profile);
        }catch (Exception e) {
            throw e;
        }
    }

    public String get_id(){ return this.id ; }
    public String get_nom(){ return this.nom ; }
    public String get_prenom(){ return this.prenom ; }
    public String get_matricule(){ return this.matricule ; }
    public String get_telephone(){ return this.telephone ; }
    public String get_email(){ return this.email ; }
    public String get_niveau(){ return this.niveau ; }
    public double get_horaire(){ return this.horaire ; }
    public String get_centre(){ return this.centre; }
    public int get_niveaurole(){ return this.niveaurole; }
    public int get_iduser(){ return this.iduser; }
    public String get_profile(){ return this.profile; }

    public void set_id(String id) throws Exception{ 
        try{
            if(id == ""|| id == null){
                throw new Exception("ID Medecin INVALIDE");
            }else{
                this.id = id; 
            }

        }catch (Exception e) {
            throw e;
        }
    }
    public void set_nom(String nom) throws Exception{ 
        try{
            if(nom == ""|| nom == null){
                throw new Exception("NOM Medecin INVALIDE");
            }else{
                this.nom = nom; 
            }
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_prenom(String prenom) throws Exception{ 
        try{
            if(prenom == ""|| prenom == null){
                throw new Exception("prenom Medecin INVALIDE");
            }else{
                this.prenom = prenom; 
            }
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_email(String email) throws Exception{ 
        try{
            this.email = email; 
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_telephone(String telephone) throws Exception{ 
        try{
            this.telephone = telephone; 
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_matricule(String matricule) throws Exception{ 
        try{
            this.matricule = matricule ; 
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_niveau(String niveau) throws Exception{ 
        try{
            this.niveau = niveau ; 
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_horaire(double horaire) throws Exception{ 
        try{
            if(horaire < 0.0){
                throw new Exception("HORAIRE < 0 Medecin INVALIDE");
            }else{
                this.horaire = horaire; 
            }
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_centre(String centre) throws Exception{ 
        try{
            /* if(centre == null){
                throw new Exception("CENTRE Medecin INVALIDE");
            }else{ */
                this.centre = centre; 
            //}
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_niveaurole(int niveaurole) throws Exception{
        try{
            /* if(niveaurole < 0){
                throw new Exception("NIVEAUROLE Medecin INVALIDE");
            }else{ */
                this.niveaurole = niveaurole; 
            //}
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_iduser(int iduser) throws Exception{
        try{
            /* if(iduser < 0){
                throw new Exception("iduser Medecin INVALIDE");
            }else{ */
                this.iduser = iduser; 
            //}
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_profile(String profile) throws Exception{
        try{
            /* if(profile == null){
                throw new Exception("profile Medecin INVALIDE");
            }else{ */
                this.profile = profile; 
            //}
        }catch (Exception e) {
            throw e;
        }
    }

}