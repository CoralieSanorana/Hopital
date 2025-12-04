package model;

import java.util.Date;

public class Medicament {

    private String id;
    private String libelle;
    private double seuil;
    private String unite;
    private double quantiteParPack;
    private double pu;
    private int actif;
    private String photo;
    private double calorie;
    private int durre;
    private int compose;
    private String categorieIngredient;
    private String idFournisseur;
    private Date daty;
    private double qtLimite;
    private double pv;
    private String libelleVente;
    private double seuilMin;
    private double seuilMax;
    private double puAchatUSD;
    private double puAchatEuro;
    private double puAchatAutreDevise;
    private double puVenteUSD;
    private double puVenteEuro;
    private double puVenteAutreDevise;
    private int isVente;
    private int isAchat;
    private String compteVente;
    private String compteAchat;
    private String libelleExtActe;
    private double tva;
    private String filepath;
    private double reste;
    private String typeStock;
    private String idChambre;
    private int isPerishable;
    private double pv2;
    private String codeBarre;
    private String typeIngredient;
    private String reference;

    public Medicament() {}

    public Medicament(String id, String libelle, double seuil, String unite, double quantiteParPack, double pu,
    int actif, String photo, double calorie, int durre, int compose, String categorieIngredient,
    String idFournisseur, Date daty, double qtLimite, double pv, String libelleVente, double seuilMin,
    double seuilMax, double puAchatUSD, double puAchatEuro, double puAchatAutreDevise,
    double puVenteUSD, double puVenteEuro, double puVenteAutreDevise, int isVente, int isAchat,
    String compteVente, String compteAchat, String libelleExtActe, double tva, String filepath,
    double reste, String typeStock, String idChambre, int isPerishable, double pv2,
    String codeBarre, String typeIngredient, String reference) throws Exception{
        try {
            setId(id);
            setLibelle(libelle);
            setSeuil(seuil);
            setUnite(unite);
            setQuantiteParPack(quantiteParPack);
            setPu(pu);
            setActif(actif);
            setPhoto(photo);
            setCalorie(calorie);
            setDurre(durre);
            setCompose(compose);
            setCategorieIngredient(categorieIngredient);
            setIdFournisseur(idFournisseur);
            setDaty(daty);
            setQtLimite(qtLimite);
            setPv(pv);
            setLibelleVente(libelleVente);
            setSeuilMin(seuilMin);
            setSeuilMax(seuilMax);
            setPuAchatUSD(puAchatUSD);
            setPuAchatEuro(puAchatEuro);
            setPuAchatAutreDevise(puAchatAutreDevise);
            setPuVenteUSD(puVenteUSD);
            setPuVenteEuro(puVenteEuro);
            setPuVenteAutreDevise(puVenteAutreDevise);
            setIsVente(isVente);
            setIsAchat(isAchat);
            setCompteVente(compteVente);
            setCompteAchat(compteAchat);
            setLibelleExtActe(libelleExtActe);
            setTva(tva);
            setFilepath(filepath);
            setReste(reste);
            setTypeStock(typeStock);
            setIdChambre(idChambre);
            setIsPerishable(isPerishable);
            setPv2(pv2);
            setCodeBarre(codeBarre);
            setTypeIngredient(typeIngredient);
            setReference(reference);
        } catch (Exception e) {
            throw e;
        }
    }

    // -------------------- SETTERS --------------------

    public void setId(String id) throws Exception {
        if (id != null && !id.isEmpty()) this.id = id;
        else throw new Exception("ID Invalide");
    }

    public void setLibelle(String libelle) throws Exception {
        this.libelle = libelle;
    }

    public void setSeuil(double seuil) throws Exception {
        this.seuil = seuil;
    }

    public void setUnite(String unite) throws Exception {
        if (unite != null && !unite.isEmpty()) this.unite = unite;
        else throw new Exception("Unité invalide");
    }

    public void setQuantiteParPack(double quantiteParPack) throws Exception {
        this.quantiteParPack = quantiteParPack;
    }

    public void setPu(double pu) throws Exception {
        if (pu >= 0) this.pu = pu;
        else throw new Exception("Prix unitaire invalide");
    }

    public void setActif(int actif) throws Exception {
        this.actif = actif;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public void setCalorie(double calorie) throws Exception {
        this.calorie = calorie;
    }

    public void setDurre(int durre) throws Exception {
        this.durre = durre;
    }

    public void setCompose(int compose) throws Exception {
        this.compose = compose;
    }

    public void setCategorieIngredient(String categorieIngredient) {
        this.categorieIngredient = categorieIngredient;
    }

    public void setIdFournisseur(String idFournisseur) {
        this.idFournisseur = idFournisseur;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public void setQtLimite(double qtLimite) throws Exception {
        this.qtLimite = qtLimite;
    }

    public void setPv(double pv) throws Exception {
        this.pv = pv;
    }

    public void setLibelleVente(String libelleVente) {
        this.libelleVente = libelleVente;
    }

    public void setSeuilMin(double seuilMin) throws Exception {
        this.seuilMin = seuilMin;
    }

    public void setSeuilMax(double seuilMax) throws Exception {
        this.seuilMax = seuilMax;
    }

    public void setPuAchatUSD(double puAchatUSD) throws Exception {
        this.puAchatUSD = puAchatUSD;
    }

    public void setPuAchatEuro(double puAchatEuro) throws Exception {
        this.puAchatEuro = puAchatEuro;
    }

    public void setPuAchatAutreDevise(double puAchatAutreDevise) throws Exception {
        this.puAchatAutreDevise = puAchatAutreDevise;
    }

    public void setPuVenteUSD(double puVenteUSD) throws Exception {
        this.puVenteUSD = puVenteUSD;
    }

    public void setPuVenteEuro(double puVenteEuro) throws Exception {
        this.puVenteEuro = puVenteEuro;
    }

    public void setPuVenteAutreDevise(double puVenteAutreDevise) throws Exception {
       this.puVenteAutreDevise = puVenteAutreDevise;
    }

    public void setIsVente(int isVente) throws Exception {
        this.isVente = isVente;
    }

    public void setIsAchat(int isAchat) throws Exception {
        this.isAchat = isAchat;
    }

    public void setCompteVente(String compteVente) {
        this.compteVente = compteVente;
    }

    public void setCompteAchat(String compteAchat) {
        this.compteAchat = compteAchat;
    }

    public void setLibelleExtActe(String libelleExtActe) {
        this.libelleExtActe = libelleExtActe;
    }

    public void setTva(double tva) throws Exception {
        this.tva = tva;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    public void setReste(double reste) throws Exception {
        this.reste = reste;
    }

    public void setTypeStock(String typeStock) {
        this.typeStock = typeStock;
    }

    public void setIdChambre(String idChambre) {
        this.idChambre = idChambre;
    }

    public void setIsPerishable(int isPerishable) throws Exception {
        this.isPerishable = isPerishable;
    }

    public void setPv2(double pv2) throws Exception {
        this.pv2 = pv2;
    }

    public void setCodeBarre(String codeBarre) {
        this.codeBarre = codeBarre;
    }

    public void setTypeIngredient(String typeIngredient) {
        this.typeIngredient = typeIngredient;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    // -------------------- GETTERS --------------------

    public String getId() { return id; }
    public String getLibelle() { return libelle; }
    public double getSeuil() { return seuil; }
    public String getUnite() { return unite; }
    public double getQuantiteParPack() { return quantiteParPack; }
    public double getPu() { return pu; }
    public int getActif() { return actif; }
    public String getPhoto() { return photo; }
    public double getCalorie() { return calorie; }
    public int getDurre() { return durre; }
    public int getCompose() { return compose; }
    public String getCategorieIngredient() { return categorieIngredient; }
    public String getIdFournisseur() { return idFournisseur; }
    public Date getDaty() { return daty; }
    public double getQtLimite() { return qtLimite; }
    public double getPv() { return pv; }
    public String getLibelleVente() { return libelleVente; }
    public double getSeuilMin() { return seuilMin; }
    public double getSeuilMax() { return seuilMax; }
    public double getPuAchatUSD() { return puAchatUSD; }
    public double getPuAchatEuro() { return puAchatEuro; }
    public double getPuAchatAutreDevise() { return puAchatAutreDevise; }
    public double getPuVenteUSD() { return puVenteUSD; }
    public double getPuVenteEuro() { return puVenteEuro; }
    public double getPuVenteAutreDevise() { return puVenteAutreDevise; }
    public int getIsVente() { return isVente; }
    public int getIsAchat() { return isAchat; }
    public String getCompteVente() { return compteVente; }
    public String getCompteAchat() { return compteAchat; }
    public String getLibelleExtActe() { return libelleExtActe; }
    public double getTva() { return tva; }
    public String getFilepath() { return filepath; }
    public double getReste() { return reste; }
    public String getTypeStock() { return typeStock; }
    public String getIdChambre() { return idChambre; }
    public int getIsPerishable() { return isPerishable; }
    public double getPv2() { return pv2; }
    public String getCodeBarre() { return codeBarre; }
    public String getTypeIngredient() { return typeIngredient; }
    public String getReference() { return reference; }

}
