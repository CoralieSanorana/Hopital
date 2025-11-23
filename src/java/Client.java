package model;
import java.util.*;
public class Client{
    private String id;
    private String nom;
    private String telephone;
    private String email;
    private String adresse;
    private String remarque;
    private String pers_sexe;
    private Date pers_date_naissance;
    private String situation_prof;

    public Client(){}
    public Client(String id,String nom,String telephone,
    String email,String adresse,String remarque,String pers_sexe,
    Date pers_date_naissance,String situation_prof)throws Exception {
        try{
            set_id(id);
            set_nom(nom);
            set_telephone(telephone);
            set_email(email);
            set_adresse(adresse);
            set_remarque(remarque);
            set_pers_sexe(pers_sexe);
            set_pers_date_naissance(pers_date_naissance);
            set_situation_prof(situation_prof);
        }catch (Exception e) {
            throw e;
        }
    }

    public String get_id(){ return this.id ; }
    public String get_nom(){ return this.nom ; }
    public String get_adresse(){ return this.adresse ; }
    public String get_email(){ return this.email ; }
    public String get_telephone(){ return this.telephone ; }
    public String get_situation_prof(){ return this.situation_prof ; }
    public String get_remarque(){ return this.remarque ; }
    public String get_pers_sexe(){ return this.pers_sexe ; }
    public Date get_pers_date_naissance(){ return this.pers_date_naissance; }

    public void set_id(String id) throws Exception{ 
        try{
            if(id == ""|| id == null){
                throw new Exception("ID Client INVALIDE");
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
                throw new Exception("NOM Client INVALIDE");
            }else{
                this.nom = nom; 
            }
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_adresse(String adresse) throws Exception{ 
        try{
            /* if(adresse == ""|| adresse == null){
                throw new Exception("ADRESSE Client INVALIDE");
            }else{ */
                this.adresse = adresse; 
            //}
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
    public void set_situation_prof(String situation_prof) throws Exception{ 
        try{
            this.situation_prof = situation_prof ; 
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_remarque(String remarque) throws Exception{ 
        try{
            this.remarque = remarque ; 
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_pers_sexe(String pers_sexe) throws Exception{ 
        try{
            /* if(pers_sexe == ""|| pers_sexe == null){
                throw new Exception("SEXE Client INVALIDE");
            }else{ */
                this.pers_sexe = pers_sexe; 
            //}
        }catch (Exception e) {
            throw e;
        }
    }
    public void set_pers_date_naissance(Date pers_date_naissance) throws Exception{ 
        try{
            /* if(pers_date_naissance == null){
                throw new Exception("ACTE NAISSANCE Client INVALIDE");
            }else{ */
                this.pers_date_naissance = pers_date_naissance; 
            //}
        }catch (Exception e) {
            throw e;
        }
    }

}