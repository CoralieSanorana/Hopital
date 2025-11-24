package model;

import java.util.Date;

public class MvtStockfille {

    private String id;
    private String idMvtStock;
    private String idProduit;
    private double entree;
    private double sortie;
    private String idVenteDetail;
    private String idTransfertDetail;
    private double pu;
    private String mvtSrc;
    private double reste;
    private String designation;
    private Date datePeremption;
    private String datePeremptionLib;
    private String source;

    public MvtStockfille() {}

    public MvtStockfille(String id, String idMvtStock, String idProduit, double entree, double sortie,
                         String idVenteDetail, String idTransfertDetail, double pu, String mvtSrc,
                         double reste, String designation, Date datePeremption, String datePeremptionLib,
                         String source) {
        try {
            setId(id);
            setIdMvtStock(idMvtStock);
            setIdProduit(idProduit);
            setEntree(entree);
            setSortie(sortie);
            setIdVenteDetail(idVenteDetail);
            setIdTransfertDetail(idTransfertDetail);
            setPu(pu);
            setMvtSrc(mvtSrc);
            setReste(reste);
            setDesignation(designation);
            setDatePeremption(datePeremption);
            setDatePeremptionLib(datePeremptionLib);
            setSource(source);
        } catch (Exception e) {
            e.fillInStackTrace();
        }
    }

    // -------------------- SETTERS --------------------

    public void setId(String id) throws Exception {
        if (id != null && !id.isEmpty()) this.id = id;
        else throw new Exception("ID Invalide");
    }

    public void setIdMvtStock(String idMvtStock) {
        this.idMvtStock = idMvtStock;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public void setEntree(double entree) throws Exception {
        if (entree >= 0) this.entree = entree;
        else throw new Exception("Entrée invalide");
    }

    public void setSortie(double sortie) throws Exception {
        if (sortie >= 0) this.sortie = sortie;
        else throw new Exception("Sortie invalide");
    }

    public void setIdVenteDetail(String idVenteDetail) {
        this.idVenteDetail = idVenteDetail;
    }

    public void setIdTransfertDetail(String idTransfertDetail) {
        this.idTransfertDetail = idTransfertDetail;
    }

    public void setPu(double pu) throws Exception {
        if (pu >= 0) this.pu = pu;
        else throw new Exception("PU invalide");
    }

    public void setMvtSrc(String mvtSrc) {
        this.mvtSrc = mvtSrc;
    }

    public void setReste(double reste) throws Exception {
        if (reste >= 0) this.reste = reste;
        else throw new Exception("Reste invalide");
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public void setDatePeremption(Date datePeremption) {
        this.datePeremption = datePeremption;
    }

    public void setDatePeremptionLib(String datePeremptionLib) {
        this.datePeremptionLib = datePeremptionLib;
    }

    public void setSource(String source) {
        this.source = source;
    }

    // -------------------- GETTERS --------------------

    public String getId() { return id; }
    public String getIdMvtStock() { return idMvtStock; }
    public String getIdProduit() { return idProduit; }
    public double getEntree() { return entree; }
    public double getSortie() { return sortie; }
    public String getIdVenteDetail() { return idVenteDetail; }
    public String getIdTransfertDetail() { return idTransfertDetail; }
    public double getPu() { return pu; }
    public String getMvtSrc() { return mvtSrc; }
    public double getReste() { return reste; }
    public String getDesignation() { return designation; }
    public Date getDatePeremption() { return datePeremption; }
    public String getDatePeremptionLib() { return datePeremptionLib; }
    public String getSource() { return source; }

}
