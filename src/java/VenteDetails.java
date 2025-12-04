package model;

public class VenteDetails {

    private String id;
    private String idVente;
    private String idProduit;
    private String idOrigine;
    private double qte;
    private double pu;
    private double remise;
    private double tva;
    private double puAchat;
    private double puVente;
    private String idDevise;
    private double tauxDeChange;
    private String designation;
    private String compte;
    private double puRevient;
    private String idActe;
    private double remiseMontant;
    private String idMedecin;
    private String unite;
    private double qte_total;

    public VenteDetails() {}

    public VenteDetails(String id, String idVente, String idProduit, String idOrigine,
                        double qte, double pu, double remise, double tva, double puAchat,
                        double puVente, String idDevise, double tauxDeChange, String designation,
                        String compte, double puRevient, String idActe, double remiseMontant,
                        String idMedecin, String unite, double qte_total) {
        try {
            setId(id);
            setIdVente(idVente);
            setIdProduit(idProduit);
            setIdOrigine(idOrigine);
            setQte(qte);
            setPu(pu);
            setRemise(remise);
            setTva(tva);
            setPuAchat(puAchat);
            setPuVente(puVente);
            setIdDevise(idDevise);
            setTauxDeChange(tauxDeChange);
            setDesignation(designation);
            setCompte(compte);
            setPuRevient(puRevient);
            setIdActe(idActe);
            setRemiseMontant(remiseMontant);
            setIdMedecin(idMedecin);
            setUnite(unite);
            setQte_total(qte_total);
        } catch (Exception e) {
            e.fillInStackTrace();
        }
    }

    // ---------- SETTERS ----------

    public void setId(String id) throws Exception {
        if (id != null && !id.isEmpty()) this.id = id;
        else throw new Exception("ID invalide");
    }
    public void setQte_total(double qte_total) {
        this.qte_total = qte_total;
    }
    public void setUnite(String unite) {
        this.unite = unite;
    }

    public void setIdVente(String idVente) { this.idVente = idVente; }
    public void setIdProduit(String idProduit) { this.idProduit = idProduit; }
    public void setIdOrigine(String idOrigine) { this.idOrigine = idOrigine; }

    public void setQte(double qte) throws Exception {
        if (qte >= 0) this.qte = qte;
        else throw new Exception("QTE invalide");
    }

    public void setPu(double pu) throws Exception {
        if (pu >= 0) this.pu = pu;
        else throw new Exception("PU invalide");
    }

    public void setRemise(double remise) throws Exception {
        if (remise >= 0) this.remise = remise;
        else throw new Exception("REMISE invalide");
    }

    public void setTva(double tva) throws Exception {
        if (tva >= 0) this.tva = tva;
        else throw new Exception("TVA invalide");
    }

    public void setPuAchat(double puAchat) throws Exception {
        if (puAchat >= 0) this.puAchat = puAchat;
        else throw new Exception("PUACHAT invalide");
    }

    public void setPuVente(double puVente) throws Exception {
        if (puVente >= 0) this.puVente = puVente;
        else throw new Exception("PUVENTE invalide");
    }

    public void setIdDevise(String idDevise) { this.idDevise = idDevise; }

    public void setTauxDeChange(double tauxDeChange) throws Exception {
        if (tauxDeChange >= 0) this.tauxDeChange = tauxDeChange;
        else throw new Exception("TAUXDECHANGE invalide");
    }

    public void setDesignation(String designation) { this.designation = designation; }
    public void setCompte(String compte) { this.compte = compte; }

    public void setPuRevient(double puRevient) throws Exception {
        if (puRevient >= 0) this.puRevient = puRevient;
        else throw new Exception("PUREVIENT invalide");
    }

    public void setIdActe(String idActe) { this.idActe = idActe; }

    public void setRemiseMontant(double remiseMontant) throws Exception {
        if (remiseMontant >= 0) this.remiseMontant = remiseMontant;
        else throw new Exception("REMISEMONTANT invalide");
    }

    public void setIdMedecin(String idMedecin) { this.idMedecin = idMedecin; }

    // ---------- GETTERS ----------

    public String getId() { return id; }
    public String getIdVente() { return idVente; }
    public String getIdProduit() { return idProduit; }
    public String getIdOrigine() { return idOrigine; }
    public double getQte() { return qte; }
    public double getPu() { return pu; }
    public double getRemise() { return remise; }
    public double getTva() { return tva; }
    public double getPuAchat() { return puAchat; }
    public double getPuVente() { return puVente; }
    public String getIdDevise() { return idDevise; }
    public double getTauxDeChange() { return tauxDeChange; }
    public String getDesignation() { return designation; }
    public String getCompte() { return compte; }
    public double getPuRevient() { return puRevient; }
    public String getIdActe() { return idActe; }
    public double getRemiseMontant() { return remiseMontant; }
    public String getIdMedecin() { return idMedecin; }
    public double getQte_total() {
        return qte_total;
    }
    public String getUnite() {
        return unite;
    }
}