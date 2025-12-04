package model;

public class MedOrdonnanceFille {

    private String idMedicament;
    private String posologie;
    private String idOrdonnance;
    private String id;                    
    private int etat;
    private String idUser;
    private double prix;
    private String magasin;
    private int nbJours;
    private String unite;
    private String remarque;
    private double puUnite;           
    private double quantite;
    private double tauxPriseEnCharge;

    public MedOrdonnanceFille(
    String idMedicament, String posologie, String idOrdonnance,
    String id, int etat, String idUser, double prix,
    String magasin, int nbJours, String unite,
    String remarque, double puUnite, double quantite,
    double tauxPriseEnCharge) {
        
        this.setIdMedicament(idMedicament);
        this.setPosologie(posologie);
        this.setIdOrdonnance(idOrdonnance);
        this.setId(id);  
        this.setEtat(etat);
        this.setIdUser(idUser);
        this.setPrix(prix);
        this.setMagasin(magasin);
        this.setNbJours(nbJours);
        this.setUnite(unite);
        this.setRemarque(remarque);
        this.setPuUnite(puUnite);
        this.setQuantite(quantite);
        this.setTauxPriseEnCharge(tauxPriseEnCharge);
    }

    public MedOrdonnanceFille() {
    }

    public String getIdMedicament() { return idMedicament; }
    public String getPosologie() { return posologie; }
    public String getIdOrdonnance() { return idOrdonnance; }
    public String getId() { return id; }
    public int getEtat() { return etat; }
    public String getIdUser() { return idUser; }
    public double getPrix() { return prix; }
    public String getMagasin() { return magasin; }
    public int getNbJours() { return nbJours; }
    public String getUnite() { return unite; }
    public String getRemarque() { return remarque; }
    public double getPuUnite() { return puUnite; }
    public double getQuantite() { return quantite; }
    public double getTauxPriseEnCharge() { return tauxPriseEnCharge; }

    public void setIdMedicament(String idMedicament) {
        if (idMedicament != null && idMedicament.trim().isEmpty()) {
            throw new IllegalArgumentException("IDMEDICAMENT ne peut pas être une chaîne vide");
        }
        if (idMedicament != null && idMedicament.length() > 4000) {
            throw new IllegalArgumentException("IDMEDICAMENT dépasse 4000 caractères");
        }
        this.idMedicament = idMedicament;
    }

    public void setPosologie(String posologie) {
        if (posologie != null && posologie.length() > 100) {
            throw new IllegalArgumentException("POSOLOGIE dépasse 100 caractères");
        }
        this.posologie = posologie;
    }

    public void setIdOrdonnance(String idOrdonnance) {
        if (idOrdonnance != null && idOrdonnance.length() > 1000) {
            throw new IllegalArgumentException("IDORDONNANCE dépasse 1000 caractères");
        }
        this.idOrdonnance = idOrdonnance;
    }

    public void setId(String id) {
        if (id == null || id.trim().isEmpty()) {
            throw new IllegalArgumentException("ID est obligatoire (NOT NULL)");
        }
        if (id.length() > 50) {
            throw new IllegalArgumentException("ID dépasse 50 caractères");
        }
        this.id = id.trim();
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public void setIdUser(String idUser) {
        if (idUser != null && idUser.length() > 50) {
            throw new IllegalArgumentException("IDUSER dépasse 50 caractères");
        }
        this.idUser = idUser;
    }

    public void setPrix(double prix) {
        if (prix  < 0) {
            throw new IllegalArgumentException("PRIX ne peut pas être négatif");
        }
        this.prix = prix;
    }

    public void setMagasin(String magasin) {
        if (magasin != null && magasin.length() > 100) {
            throw new IllegalArgumentException("MAGASIN dépasse 100 caractères");
        }
        this.magasin = magasin;
    }

    public void setNbJours(int nbJours) {
        if (nbJours <= 0) {
            throw new IllegalArgumentException("NB_JOURS doit être positif");
        }
        this.nbJours = nbJours;
    }

    public void setUnite(String unite) {
        if (unite != null && unite.length() > 100) {
            throw new IllegalArgumentException("UNITE dépasse 100 caractères");
        }
        this.unite = unite;
    }

    public void setRemarque(String remarque) {
        if (remarque != null && remarque.length() > 4000) {
            throw new IllegalArgumentException("REMARQUE dépasse 4000 caractères");
        }
        this.remarque = remarque;
    }

    public void setPuUnite(double puUnite) {
        if (puUnite < 0) {
            throw new IllegalArgumentException("PUUNITE ne peut pas être négatif");
        }
        this.puUnite = puUnite;
    }

    public void setQuantite(double quantite) {
        if (quantite <= 0) {
            throw new IllegalArgumentException("QUANTITE doit être strictement positive");
        }
        this.quantite = quantite;
    }

    public void setTauxPriseEnCharge(double tauxPriseEnCharge) {
        /* if (tauxPriseEnCharge != null && (tauxPriseEnCharge.signum() < 0 || tauxPriseEnCharge.compareTo(double.valueOf(100)) > 0)) {
            throw new IllegalArgumentException("TAUXPRISEENCHARGE doit être entre 0 et 100 %");
        } */
        this.tauxPriseEnCharge = tauxPriseEnCharge;
    }
}