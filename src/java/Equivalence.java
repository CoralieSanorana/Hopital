package model;

public class Equivalence {
    String id;
    String idproduit;
    String unite;
    String unite_ref;
    double quantite;
    double pv;
    int etat;

    public Equivalence(){}
    public Equivalence(String id, String idproduit, String unite, String unite_ref,
    double quantite, double pv) throws Exception{
        try{
            setId(id);
            setIdproduit(idproduit);
            setUnite(unite);
            setUnite_ref(unite_ref);
            setQuantite(quantite);
            setPv(pv);
        } catch(Exception e){
            throw e;
        }
    }

    public void setId(String id) throws Exception{
        if(id == null){
            throw new Exception("Id equivalence NULL");
        } else{
            this.id = id; 
        }
    }
    public void setIdproduit(String idproduit) throws Exception{
        if (idproduit == null) {
            throw new Exception("ID produit equivalence NULL");
        } else {
            this.idproduit = idproduit;
        }
    }
    public void setUnite(String unite) throws Exception{
        if(unite == null){
            throw new Exception("Unite equivalence NULL");
        } else{
            this.unite = unite;
        }
    }
    public void setUnite_ref(String unite_ref) throws Exception{
        if(unite_ref == null){
            throw new Exception("Unite_ref equivalence NULL");
        } else{
            this.unite_ref = unite_ref;
        }
    }
    public void setQuantite(double quantite) throws Exception{
        if(quantite < 0){
            throw new Exception("Quantite equivalence < 0");
        } else{
            this.quantite = quantite;
        }
    }
    public void setPv(double pv) throws Exception{
        if(pv < 0){
            throw new Exception("PV equivalence < 0");
        } else{
            this.pv = pv;
        }
    } 
    public void setEtat(int etat) {
        this.etat = etat;
    }
    public String getId(){ return this.id; }
    public String getIdproduit() { return idproduit; }
    public String getUnite() { return this.unite; }
    public String getUnite_ref() { return this.unite_ref; }
    public double getQuantite() { return this.quantite; }
    public double getPv() { return this.pv; }
    public int getEtat() { return etat;}
}
