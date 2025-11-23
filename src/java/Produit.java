package model;

public class Produit {
    private String id;
    private String val;
    private String desce;
    private String idtypeproduit;
    private double puachat;
    private double puvente;
    private String idunite;
    private String idcategorie;
    private String idsouscategorie;
    private String presentation;
    private double seuilmin;
    private double seuilmax;
    private int isachat;
    private int isvente;

    public Produit() {
    }

    public Produit(
            String id,
            String val,
            String desce,
            String idtypeproduit,
            double puachat,
            double puvente,
            String idunite,
            String idcategorie,
            String idsouscategorie,
            String presentation,
            double seuilmin,
            double seuilmax,
            int isachat,
            int isvente) {
                try {
                    setDesce(desce);
                    setId(id);
                    setVal(val);
                    setIdtypeproduit(idtypeproduit);
                    setPuachat(puachat);
                    setPuvente(puvente);
                    setIdunite(idunite);
                    setIdcategorie(idcategorie);
                    setIdsouscategorie(idsouscategorie);
                    setPresentation(presentation);
                    setSeuilmin(seuilmin);
                    setSeuilmax(seuilmax);
                    setIsachat(isachat);
                    setIsvente(isvente);
                    
                } catch (Exception e) {
                    e.fillInStackTrace();
                }


    }

    public void setId(String id) throws Exception {
        try {
            if (id != null && !id.isEmpty()) {
                this.id = id;
            } else {
                throw new Exception("ID Produit Invalide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setVal(String val) throws Exception {
        try {
            if (val != null && val != "") {
                this.val = val;
            } else {
                throw new Exception("Valeur invalide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setDesce(String desce) throws Exception {
        try {
            if (desce != null && desce != "") {
                this.desce = desce;
            } else {
                throw new Exception("Il n'y pas de description");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setIdtypeproduit(String idtypeproduit) throws Exception {
        try {
            if (idtypeproduit != null && idtypeproduit != "") {
                this.idtypeproduit = idtypeproduit;
            } else {
                throw new Exception("ID ty produit invalide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setPuachat(double puachat) throws Exception{
        try {
            if (puachat > 0) {
                this.puachat = puachat;
            } else {
                throw new Exception("Le prix d'achat n'est pas valide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setPuvente(double puvente) throws Exception {
        try {
            if (puvente > 0) {
                this.puvente = puvente;
            } else {
                throw new Exception("Le prix de vente n'est pas valide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setIdunite(String idunite) throws Exception{
       try {
            if (idunite != null && idunite != "") {
                this.idunite = idunite;
            } else {
                throw new Exception("ID unite invalide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void setIdcategorie(String idcategorie) throws Exception{
        try {
            if (idcategorie != null && idcategorie != "") {
                this.idcategorie = idcategorie;
            } else {
                throw new Exception("ID sous categorie invalide");
            }
        } catch (Exception e) {
            throw e;
        };
    }

    public void setIdsouscategorie(String idsouscategorie) throws Exception {
         try {
            if (idsouscategorie != null && idsouscategorie != "") {
                this.idsouscategorie = idsouscategorie;
            } else {
                throw new Exception("Id categorie invalide");
            }
        } catch (Exception e) {
            throw e;
        };
    }

    public void setPresentation(String presentation) {
        this.presentation = presentation;
    }

    public void setSeuilmin(double seuilmin) {
        this.seuilmin = seuilmin;
    }

    public void setSeuilmax(double seuilmax) {
        this.seuilmax = seuilmax;
    }
   
    public void setIsachat(int isachat) throws Exception {
       try {
            if (isachat > 0) {
                this.isachat = isachat;
            } else {
                throw new Exception("Le isachat n'est pas valide");
            }
        } catch (Exception e) {
            throw e;
        }
    }
   
    public void setIsvente(int isvente) throws Exception {
        try {
            if (isvente > 0) {
                this.isvente = isvente;
            } else {
                throw new Exception("Le isvente n'est pas valide");
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public String getDesce() {
        return desce;
    }
    public String getId() {
        return id;
    }
    public String getIdcategorie() {
        return idcategorie;
    }
    public String getIdsouscategorie() {
        return idsouscategorie;
    }
    public String getIdtypeproduit() {
        return idtypeproduit;
    }
    public String getIdunite() {
        return idunite;
    }
    public int getIsachat() {
        return isachat;
    }
    public int getIsvente() {
        return isvente;
    }
    public String getPresentation() {
        return presentation;
    }
    public double getPuachat() {
        return puachat;
    }
    public double getPuvente() {
        return puvente;
    }
    public double getSeuilmax() {
        return seuilmax;
    }
    public double getSeuilmin() {
        return seuilmin;
    }
    public String getVal() {
        return val;
    }
}