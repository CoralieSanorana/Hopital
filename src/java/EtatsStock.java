package model;

import java.util.Date;

public class EtatsStock {

    private String id;
    private String idProduitLib;
    private String categorieIngredient;
    private String idTypeProduitLib;
    private String idMagasin;
    private String idMagasinLib;
    private Date dateDernierMouvement;
    private double quantite;
    private double entree;
    private double sortie;
    private double reste;
    private String unite;
    private String idUniteLib;
    private double puVente;
    private String idPoint;
    private String idTypeMagasin;
    private double seuilMin;
    private double seuilMax;
    private double montantEntree;
    private double montantSortie;
    private double pu;
    private double montantReste;
    private Date daty;

    public EtatsStock() {}

    public EtatsStock(String id, String idProduitLib, String categorieIngredient, String idTypeProduitLib,
                      String idMagasin, String idMagasinLib, Date dateDernierMouvement, double quantite,
                      double entree, double sortie, double reste, String unite, String idUniteLib,
                      double puVente, String idPoint, String idTypeMagasin, double seuilMin, double seuilMax,
                      double montantEntree, double montantSortie, double pu, double montantReste, Date daty) throws Exception{
        try {
            setId(id);
            setIdProduitLib(idProduitLib);
            setCategorieIngredient(categorieIngredient);
            setIdTypeProduitLib(idTypeProduitLib);
            setIdMagasin(idMagasin);
            setIdMagasinLib(idMagasinLib);
            setDateDernierMouvement(dateDernierMouvement);
            setQuantite(quantite);
            setEntree(entree);
            setSortie(sortie);
            setReste(reste);
            setUnite(unite);
            setIdUniteLib(idUniteLib);
            setPuVente(puVente);
            setIdPoint(idPoint);
            setIdTypeMagasin(idTypeMagasin);
            setSeuilMin(seuilMin);
            setSeuilMax(seuilMax);
            setMontantEntree(montantEntree);
            setMontantSortie(montantSortie);
            setPu(pu);
            setMontantReste(montantReste);
            setDaty(daty);
        } catch (Exception e) {
            throw e;
        }
    }

    // Setters
    public void setId(String id) throws Exception {
        if (id != null && !id.isEmpty()) this.id = id; else throw new Exception("ID invalide");
    }
    public void setIdProduitLib(String idProduitLib) { this.idProduitLib = idProduitLib; }
    public void setCategorieIngredient(String categorieIngredient) { this.categorieIngredient = categorieIngredient; }
    public void setIdTypeProduitLib(String idTypeProduitLib) { this.idTypeProduitLib = idTypeProduitLib; }
    public void setIdMagasin(String idMagasin) { this.idMagasin = idMagasin; }
    public void setIdMagasinLib(String idMagasinLib) { this.idMagasinLib = idMagasinLib; }
    public void setDateDernierMouvement(Date dateDernierMouvement) { this.dateDernierMouvement = dateDernierMouvement; }
    public void setQuantite(double quantite) throws Exception { this.quantite = quantite;}
    public void setEntree(double entree) throws Exception { this.entree = entree; }
    public void setSortie(double sortie) throws Exception { this.sortie = sortie; }
    public void setReste(double reste) throws Exception { this.reste = reste; }
    public void setUnite(String unite) { this.unite = unite; }
    public void setIdUniteLib(String idUniteLib) { this.idUniteLib = idUniteLib; }
    public void setPuVente(double puVente) throws Exception { if (puVente >= 0) this.puVente = puVente; else throw new Exception("PUVENTE invalide"); }
    public void setIdPoint(String idPoint) { this.idPoint = idPoint; }
    public void setIdTypeMagasin(String idTypeMagasin) { this.idTypeMagasin = idTypeMagasin; }
    public void setSeuilMin(double seuilMin) throws Exception { if (seuilMin >= 0) this.seuilMin = seuilMin; else throw new Exception("SEUILMIN invalide"); }
    public void setSeuilMax(double seuilMax) throws Exception { if (seuilMax >= 0) this.seuilMax = seuilMax; else throw new Exception("SEUILMAX invalide"); }
    public void setMontantEntree(double montantEntree) throws Exception { this.montantEntree = montantEntree;}
    public void setMontantSortie(double montantSortie) throws Exception { this.montantSortie = montantSortie;}
    public void setPu(double pu) throws Exception { this.pu = pu;}
    public void setMontantReste(double montantReste) throws Exception { this.montantReste = montantReste;}
    public void setDaty(Date daty) { this.daty = daty; }

    // Getters
    public String getId() { return id; }
    public String getIdProduitLib() { return idProduitLib; }
    public String getCategorieIngredient() { return categorieIngredient; }
    public String getIdTypeProduitLib() { return idTypeProduitLib; }
    public String getIdMagasin() { return idMagasin; }
    public String getIdMagasinLib() { return idMagasinLib; }
    public Date getDateDernierMouvement() { return dateDernierMouvement; }
    public double getQuantite() { return quantite; }
    public double getEntree() { return entree; }
    public double getSortie() { return sortie; }
    public double getReste() { return reste; }
    public String getUnite() { return unite; }
    public String getIdUniteLib() { return idUniteLib; }
    public double getPuVente() { return puVente; }
    public String getIdPoint() { return idPoint; }
    public String getIdTypeMagasin() { return idTypeMagasin; }
    public double getSeuilMin() { return seuilMin; }
    public double getSeuilMax() { return seuilMax; }
    public double getMontantEntree() { return montantEntree; }
    public double getMontantSortie() { return montantSortie; }
    public double getPu() { return pu; }
    public double getMontantReste() { return montantReste; }
    public Date getDaty() { return daty; }

}
