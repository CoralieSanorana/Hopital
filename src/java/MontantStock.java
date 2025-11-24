package model;

import java.util.Date;

public class MontantStock {

	private String idProduit;
	private double entree;
	private double sortie;
	private double quantite;
	private double montantEntree;
	private double montantSortie;
	private double montant;
	private String idMagasin;
	private Date daty;

	public MontantStock() {}

	public MontantStock(String idProduit, double entree, double sortie, double quantite,
						double montantEntree, double montantSortie, double montant,
						String idMagasin, Date daty) {
		try {
			setIdProduit(idProduit);
			setEntree(entree);
			setSortie(sortie);
			setQuantite(quantite);
			setMontantEntree(montantEntree);
			setMontantSortie(montantSortie);
			setMontant(montant);
			setIdMagasin(idMagasin);
			setDaty(daty);
		} catch (Exception e) {
			e.fillInStackTrace();
		}
	}

	// ---------- SETTERS ----------

	public void setIdProduit(String idProduit) throws Exception {
		if (idProduit != null && !idProduit.isEmpty()) this.idProduit = idProduit;
		else throw new Exception("IDPRODUIT invalide");
	}

	public void setEntree(double entree) throws Exception {
		if (entree >= 0) this.entree = entree;
		else throw new Exception("ENTREE invalide");
	}

	public void setSortie(double sortie) throws Exception {
		if (sortie >= 0) this.sortie = sortie;
		else throw new Exception("SORTIE invalide");
	}

	public void setQuantite(double quantite) throws Exception {
		if (quantite >= 0) this.quantite = quantite;
		else throw new Exception("QUANTITE invalide");
	}

	public void setMontantEntree(double montantEntree) throws Exception {
		if (montantEntree >= 0) this.montantEntree = montantEntree;
		else throw new Exception("MONTANTENTREE invalide");
	}

	public void setMontantSortie(double montantSortie) throws Exception {
		if (montantSortie >= 0) this.montantSortie = montantSortie;
		else throw new Exception("MONTANTSORTIE invalide");
	}

	public void setMontant(double montant) throws Exception {
		if (montant >= 0) this.montant = montant;
		else throw new Exception("MONTANT invalide");
	}

	public void setIdMagasin(String idMagasin) {
		this.idMagasin = idMagasin;
	}

	public void setDaty(Date daty) {
		this.daty = daty;
	}

	// ---------- GETTERS ----------

	public String getIdProduit() { return idProduit; }
	public double getEntree() { return entree; }
	public double getSortie() { return sortie; }
	public double getQuantite() { return quantite; }
	public double getMontantEntree() { return montantEntree; }
	public double getMontantSortie() { return montantSortie; }
	public double getMontant() { return montant; }
	public String getIdMagasin() { return idMagasin; }
	public Date getDaty() { return daty; }

	@Override
	public String toString() {
		return "MontantStock{" +
				"idProduit='" + idProduit + '\'' +
				", entree=" + entree +
				", sortie=" + sortie +
				", quantite=" + quantite +
				", montantEntree=" + montantEntree +
				", montantSortie=" + montantSortie +
				", montant=" + montant +
				", idMagasin='" + idMagasin + '\'' +
				", daty=" + daty +
				'}';
	}

}
