package model;
import java.util.*;
import java.sql.*;
import database.*;

public class Function{
// mini fonctions mila Connection comme ARG
    public User login(String nom,String pwd, Connection con) throws Exception{
        String sql = "SELECT * FROM user_log WHERE nom_user_log = ? AND pwd_user_log = ?";
        User user = null;
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, nom);
            ps.setString(2, pwd);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id_user_log"),
                    rs.getString("nom_user_log"),
                    rs.getString("pwd_user_log")
                );
            }

        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return user;
    }
    public Vector<Client> get_clients(Connection con) throws Exception{
        String sql = "SELECT * FROM client";
        Vector<Client> clients = new Vector<>();
        Statement ps = null;

        try {
            ps = con.createStatement();
            ResultSet rs = ps.executeQuery(sql);

            while (rs.next()) {
                clients.add(new Client(
                    rs.getString("id"),
                    rs.getString("nom"),
                    rs.getString("telephone"),
                    rs.getString("mail"),
                    rs.getString("adresse"),
                    rs.getString("remarque"),
                    rs.getString("pers_sexe"),
                    null,
                    rs.getString("pers_situation_professionnelle")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return clients;
    }
    public Vector<Medecin> get_medecins(Connection con) throws Exception{
        String sql = "SELECT * FROM med_medecin";
        Vector<Medecin> medecins = new Vector<>();
        Statement ps = null;

        try {
            ps = con.createStatement();
            ResultSet rs = ps.executeQuery(sql);

            while (rs.next()) {
                medecins.add(new Medecin(
                    rs.getString("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
                    rs.getString("matricule"),
                    rs.getString("telephone"),
                    rs.getString("email"),
                    rs.getString("niveau"),
                    rs.getDouble("tarif_horaire"),
                    rs.getString("centre"),
                    rs.getInt("niveaurole"),
                    rs.getInt("iduser"),
                    rs.getString("profile")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return medecins;
    }
    public Vector<Produit> get_produits(Connection con) throws Exception{
        String sql = "SELECT * FROM produit";
        Vector<Produit> produits = new Vector<>();
        Statement ps = null;

        try {
            ps = con.createStatement();
            ResultSet rs = ps.executeQuery(sql);

            while (rs.next()) {
                produits.add(new Produit(
                    rs.getString("id"),
                    rs.getString("val"),
                    rs.getString("desce"),
                    rs.getString("idtypeproduit"),
                    rs.getDouble("puachat"),
                    rs.getDouble("puvente"),
                    rs.getString("idunite"),
                    rs.getString("idcategorie"),
                    rs.getString("idsouscategorie"),
                    rs.getString("presentation"),
                    rs.getDouble("seuilmin"),
                    rs.getDouble("seuilmax"),
                    rs.getInt("isachat"),
                    rs.getInt("isvente")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return produits;
    }
    public Vector<Medicament> get_medicaments(Connection con) throws Exception {
        String sql = "SELECT * FROM as_ingredients order by libelle asc";
        Vector<Medicament> medicaments = new Vector<>();
        Statement stmt = null;

        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                medicaments.add(new Medicament(
                        rs.getString("ID"),
                        rs.getString("LIBELLE"),
                        rs.getDouble("SEUIL"),
                        rs.getString("UNITE"),
                        rs.getDouble("QUANTITEPARPACK"),
                        rs.getDouble("PU"),
                        rs.getInt("ACTIF"),
                        rs.getString("PHOTO"),
                        rs.getDouble("CALORIE"),
                        rs.getInt("DURRE"),
                        rs.getInt("COMPOSE"),
                        rs.getString("CATEGORIEINGREDIENT"),
                        rs.getString("IDFOURNISSEUR"),
                        rs.getDate("DATY"),
                        rs.getDouble("QTELIMITE"),
                        rs.getDouble("PV"),
                        rs.getString("LIBELLEVENTE"),
                        rs.getDouble("SEUILMIN"),
                        rs.getDouble("SEUILMAX"),
                        rs.getDouble("PUACHATUSD"),
                        rs.getDouble("PUACHATEURO"),
                        rs.getDouble("PUACHATAUTREDEVISE"),
                        rs.getDouble("PUVENTEUSD"),
                        rs.getDouble("PUVENTEEURO"),
                        rs.getDouble("PUVENTEAUTREDEVISE"),
                        rs.getInt("ISVENTE"),
                        rs.getInt("ISACHAT"),
                        rs.getString("COMPTE_VENTE"),
                        rs.getString("COMPTE_ACHAT"),
                        rs.getString("LIBELLEEXTACTE"),
                        rs.getDouble("TVA"),
                        rs.getString("FILEPATH"),
                        rs.getDouble("RESTE"),
                        rs.getString("TYPESTOCK"),
                        rs.getString("IDCHAMBRE"),
                        rs.getInt("ISPERISHABLE"),
                        rs.getDouble("PV2"),
                        rs.getString("CODEBARRE"),
                        rs.getString("TYPEINGREDIENT"),
                        rs.getString("REFERENCE")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (stmt != null) stmt.close();
        }

        return medicaments;
    }
    public Vector<Med_Ordonnance> get_medordonnances(Connection con) throws Exception {
        String sql = "SELECT * FROM med_ordonnance ORDER BY daty DESC";

        Vector<Med_Ordonnance> ordonnances = new Vector<>();

        try (Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Med_Ordonnance ord = new Med_Ordonnance();

                ord.setId(rs.getString("ID"));
                ord.setId_consultation(rs.getString("ID_CONSULTATION"));
                ord.setDaty(getDateFromResultSet(rs, "DATY"));
                ord.setNb_jours(rs.getString("NB_JOURS"));
                ord.setDate_debut(getDateFromResultSet(rs, "DATE_DEBUT"));
                ord.setDate_fin(getDateFromResultSet(rs, "DATE_FIN"));
                ord.setObservation_s(rs.getString("OBSERVATION_SOINS"));
                ord.setIdmedecin(rs.getString("IDMEDECIN"));

                ord.setId_type_arret(rs.getString("ID_TYPE_ARRET"));
                ord.setObservation(rs.getString("OBSERVATION"));
                ord.setId_type_soins(rs.getString("ID_TYPE_SOINS"));
                ord.setType(rs.getString("TYPE"));
                ord.setEtat(rs.getInt("ETAT"));
                ord.setIdentite(rs.getString("IDENTITE"));
                ord.setIdretraite(rs.getString("IDRETRAITE"));
                ord.setIddeces(rs.getString("IDDECES"));
                ord.setIdmembre(rs.getString("IDMEMBRE"));
                ord.setSocietepriseen(rs.getString("SOCIETEPRISEENCHARGE"));

                ordonnances.add(ord);
            }
        }
        return ordonnances;
    }
    public Vector<MedOrdonnanceFille> get_medordonnances_fille(String idordonnance, Connection con) 
        throws Exception {
    
        if (idordonnance == null || idordonnance.trim().isEmpty()) {
            throw new IllegalArgumentException("L'ID de l'ordonnance est obligatoire");
        }

        String sql = """
            SELECT * FROM med_ordonnance_fille 
            WHERE idordonnance = ? 
            ORDER BY id
            """;

        Vector<MedOrdonnanceFille> lignes = new Vector<>();

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idordonnance.trim());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MedOrdonnanceFille fille = new MedOrdonnanceFille(
                        rs.getString("IDMEDICAMENT"),
                        rs.getString("POSOLOGIE"),
                        rs.getString("IDORDONNANCE"),
                        rs.getString("ID"),
                        rs.getInt("ETAT"),
                        rs.getString("IDUSER"),
                        rs.getDouble("PRIX"),
                        rs.getString("MAGASIN"),
                        rs.getInt("NB_JOURS"),
                        rs.getString("UNITE"),
                        rs.getString("REMARQUE"),
                        rs.getDouble("PUUNITE"),
                        rs.getDouble("QUANTITE"),
                        rs.getDouble("TAUXPRISEENCHARGE")
                    );
                    lignes.add(fille);
                }
            }
        }
        return lignes;
    }
    public String insert_ordonnance(Med_Ordonnance ordonnance, Connection con) throws Exception {
        if (ordonnance == null) {
            throw new IllegalArgumentException("L'ordonnance ne peut pas être null");
        }

        String sql = """
            INSERT INTO VANIALA.med_ordonnance (
                id_consultation, daty, nb_jours,
                date_debut, date_fin, observation_soins, idmedecin,
                id_type_arret, observation, id_type_soins, type, etat,
                identite, idretraite, iddeces, idmembre, societepriseencharge
            ) VALUES (
                ?, CURRENT_TIMESTAMP, ?,
                CURRENT_TIMESTAMP, NULL, ?, ?,
                ?, ?, ?, ?, ?,
                ?, ?, ?, ?, ?
            )
            """;

        try (PreparedStatement ps = con.prepareStatement(sql, new String[]{"ID"})) {  

            int i = 1;
            ps.setString(i++, ordonnance.getId_consultation());
            ps.setString(i++, ordonnance.getNb_jours());
            ps.setString(i++, ordonnance.getObservation_s());
            ps.setString(i++, ordonnance.getIdmedecin());
            ps.setString(i++, ordonnance.getId_type_arret());
            ps.setString(i++, ordonnance.getObservation());
            ps.setString(i++, ordonnance.getId_type_soins());
            ps.setString(i++, ordonnance.getType());
            ps.setInt(i++, ordonnance.getEtat());
            ps.setString(i++, ordonnance.getIdentite());
            ps.setString(i++, ordonnance.getIdretraite());
            ps.setString(i++, ordonnance.getIddeces());
            ps.setString(i++, ordonnance.getIdmembre());
            ps.setString(i++, ordonnance.getSocietepriseen());

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new Exception("Échec de l'insertion de l'ordonnance, aucune ligne insérée.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getString(1); 
                } else {
                    throw new Exception("Insertion réussie mais impossible de récupérer l'ID généré.");
                }
            }
        }
    }
    public boolean insert_ordonnance_fille(MedOrdonnanceFille ordonnanceFille, Connection con) 
        throws Exception {
    
        if (ordonnanceFille == null) {
            throw new IllegalArgumentException("L'ordonnance fille ne peut pas être null");
        }

        String sql = """
            INSERT INTO med_ordonnance_fille (
                idmedicament, posologie, idordonnance, etat,
                iduser, prix, magasin, nb_jours, unite,
                remarque, puunite, quantite, tauxpriseencharge
            ) VALUES (
                ?, ?, ?, ?,
                ?, ?, ?, ?, ?,
                ?, ?, ?, ?
            )
            """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            
            int i = 1;
            
            setStringOrNull(ps, i++, ordonnanceFille.getIdMedicament());
            setStringOrNull(ps, i++, ordonnanceFille.getPosologie());
            setStringOrNull(ps, i++, ordonnanceFille.getIdOrdonnance());
            ps.setInt(i++, ordonnanceFille.getEtat());
            setStringOrNull(ps, i++, ordonnanceFille.getIdUser());
            
            setDoubleOrNull(ps, i++, ordonnanceFille.getPrix());
            setStringOrNull(ps, i++, ordonnanceFille.getMagasin());
            ps.setInt(i++, ordonnanceFille.getNbJours());
            setStringOrNull(ps, i++, ordonnanceFille.getUnite());
            setStringOrNull(ps, i++, ordonnanceFille.getRemarque());
            setDoubleOrNull(ps, i++, ordonnanceFille.getPuUnite());
            setDoubleOrNull(ps, i++, ordonnanceFille.getQuantite());
            setDoubleOrNull(ps, i++, ordonnanceFille.getTauxPriseEnCharge());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (Exception e) {
            throw new Exception(
                "Échec de l'insertion de l'ordonnance fille [ID=" + ordonnanceFille.getId() + 
                ", Médicament=" + ordonnanceFille.getIdMedicament() + "]", e);
        }
    }
    public Med_Ordonnance get_1ordonnance(String idordonnance, Connection con) throws Exception {
        String sql = "SELECT * FROM med_ordonnance WHERE id = ?";
        Med_Ordonnance ordonnance = null;

        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1,idordonnance);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Med_Ordonnance ord = new Med_Ordonnance();

                ord.setId(rs.getString("ID"));
                ord.setId_consultation(rs.getString("ID_CONSULTATION"));
                ord.setDaty(getDateFromResultSet(rs, "DATY"));
                ord.setNb_jours(rs.getString("NB_JOURS"));
                ord.setDate_debut(getDateFromResultSet(rs, "DATE_DEBUT"));
                ord.setDate_fin(getDateFromResultSet(rs, "DATE_FIN"));
                ord.setObservation_s(rs.getString("OBSERVATION_SOINS"));
                ord.setIdmedecin(rs.getString("IDMEDECIN"));

                ord.setId_type_arret(rs.getString("ID_TYPE_ARRET"));
                ord.setObservation(rs.getString("OBSERVATION"));
                ord.setId_type_soins(rs.getString("ID_TYPE_SOINS"));
                ord.setType(rs.getString("TYPE"));
                ord.setEtat(rs.getInt("ETAT"));
                ord.setIdentite(rs.getString("IDENTITE"));
                ord.setIdretraite(rs.getString("IDRETRAITE"));
                ord.setIddeces(rs.getString("IDDECES"));
                ord.setIdmembre(rs.getString("IDMEMBRE"));
                ord.setSocietepriseen(rs.getString("SOCIETEPRISEENCHARGE"));

                ordonnance = ord;
            }
        } catch(Exception e){
            throw e;
        }

        return ordonnance;
    }
    public Vector<EtatStockAll> get_etatStockAll(Connection con) throws Exception {
        String sql = "SELECT * FROM v_etatstock_ing_all";
        Vector<EtatStockAll> etats = new Vector<>();
        Statement stmt = null;

        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                etats.add(new EtatStockAll(
                        rs.getString("ID"),
                        rs.getString("IDPRODUITLIB"),
                        rs.getString("CATEGORIEINGREDIENT"),
                        rs.getString("IDTYPEPRODUITLIB"),
                        rs.getString("IDMAGASIN"),
                        rs.getString("IDMAGASINLIB"),
                        rs.getDate("DATEDERNIERMOUVEMENT"),
                        rs.getDouble("QUANTITE"),
                        rs.getDouble("ENTREE"),
                        rs.getDouble("SORTIE"),
                        rs.getDouble("RESTE"),
                        rs.getString("UNITE"),
                        rs.getString("IDUNITELIB"),
                        rs.getDouble("PUVENTE"),
                        rs.getString("IDPOINT"),
                        rs.getString("IDTYPEMAGASIN"),
                        rs.getDouble("SEUILMIN"),
                        rs.getDouble("SEUILMAX"),
                        rs.getDouble("MONTANTENTREE"),
                        rs.getDouble("MONTANTSORTIE"),
                        rs.getDouble("PU"),
                        rs.getDouble("MONTANTRESTE"),
                        rs.getDate("DATY")
                    ));
                }

            } catch (Exception e) {
            throw e;
        } finally {
            if (stmt != null) stmt.close();
        }
        
        return etats;
    }
    public Vector<EtatsStock> get_EtatStock(Connection con) throws Exception {
        String sql = "SELECT * FROM V_ETATSTOCK_ING order by DATEDERNIERMOUVEMENT asc";
        Vector<EtatsStock> etats = new Vector<>();
        Statement stmt = null;

        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                etats.add(new EtatsStock(
                        rs.getString("ID"),
                        rs.getString("IDPRODUITLIB"),
                        rs.getString("CATEGORIEINGREDIENT"),
                        rs.getString("IDTYPEPRODUITLIB"),
                        rs.getString("IDMAGASIN"),
                        rs.getString("IDMAGASINLIB"),
                        rs.getDate("DATEDERNIERMOUVEMENT"),
                        rs.getDouble("QUANTITE"),
                        rs.getDouble("ENTREE"),
                        rs.getDouble("SORTIE"),
                        rs.getDouble("RESTE"),
                        rs.getString("UNITE"),
                        rs.getString("IDUNITELIB"),
                        rs.getDouble("PUVENTE"),
                        rs.getString("IDPOINT"),
                        rs.getString("IDTYPEMAGASIN"),
                        rs.getDouble("SEUILMIN"),
                        rs.getDouble("SEUILMAX"),
                        rs.getDouble("MONTANTENTREE"),
                        rs.getDouble("MONTANTSORTIE"),
                        rs.getDouble("PU"),
                        rs.getDouble("MONTANTRESTE"),
                        rs.getDate("DATY")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (stmt != null) stmt.close();
        }

        return etats;
    }
    public Vector<MvtStockfille> get_MvtStockfille(Connection con) throws Exception {
            String sql = "SELECT * FROM mvtstockfille";
            Vector<MvtStockfille> mvts = new Vector<>();
            Statement stmt = null;
    
            try {
                stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
    
                while (rs.next()) {
                    mvts.add(new MvtStockfille(
                            rs.getString("ID"),
                            rs.getString("IDMVTSTOCK"),
                            rs.getString("IDPRODUIT"),
                            rs.getDouble("ENTREE"),
                            rs.getDouble("SORTIE"),
                            rs.getString("IDVENTEDETAIL"),
                            rs.getString("IDTRANSFERTDETAIL"),
                            rs.getDouble("PU"),
                            rs.getString("MVTSRC"),
                            rs.getDouble("RESTE"),
                            rs.getString("DESIGNATION"),
                            rs.getDate("DATEPEREMPTION"),
                            rs.getString("DATEPEREMPTIONLIB"),
                            rs.getString("SOURCE")
                    ));
                }
    
            } catch (Exception e) {
                throw e;
            } finally {
                if (stmt != null) stmt.close();
            }
    
            return mvts;
        }
    public Vector<MontantStock> get_MontantStock(Connection con) throws Exception {
        String sql = "SELECT * FROM montant_stock";
        Vector<MontantStock> montants = new Vector<>();
        Statement stmt = null;

        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                montants.add(new MontantStock(
                        rs.getString("IDPRODUIT"),
                        rs.getDouble("ENTREE"),
                        rs.getDouble("SORTIE"),
                        rs.getDouble("QUANTITE"),
                        rs.getDouble("MONTANTENTREE"),
                        rs.getDouble("MONTANTSORTIE"),
                        rs.getDouble("MONTANT"),
                        rs.getString("IDMAGASIN"),
                        rs.getDate("DATY")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (stmt != null) stmt.close();
        }

        return montants;
    }
    public Medicament get_1medicament(String idmedicament,Connection con) throws Exception {
        String sql = "SELECT * FROM as_ingredients WHERE id = ?";
        Medicament medicament = null;
        PreparedStatement stmt = null;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, idmedicament);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                medicament = new Medicament(
                        rs.getString("ID"),
                        rs.getString("LIBELLE"),
                        rs.getDouble("SEUIL"),
                        rs.getString("UNITE"),
                        rs.getDouble("QUANTITEPARPACK"),
                        rs.getDouble("PU"),
                        rs.getInt("ACTIF"),
                        rs.getString("PHOTO"),
                        rs.getDouble("CALORIE"),
                        rs.getInt("DURRE"),
                        rs.getInt("COMPOSE"),
                        rs.getString("CATEGORIEINGREDIENT"),
                        rs.getString("IDFOURNISSEUR"),
                        rs.getDate("DATY"),
                        rs.getDouble("QTELIMITE"),
                        rs.getDouble("PV"),
                        rs.getString("LIBELLEVENTE"),
                        rs.getDouble("SEUILMIN"),
                        rs.getDouble("SEUILMAX"),
                        rs.getDouble("PUACHATUSD"),
                        rs.getDouble("PUACHATEURO"),
                        rs.getDouble("PUACHATAUTREDEVISE"),
                        rs.getDouble("PUVENTEUSD"),
                        rs.getDouble("PUVENTEEURO"),
                        rs.getDouble("PUVENTEAUTREDEVISE"),
                        rs.getInt("ISVENTE"),
                        rs.getInt("ISACHAT"),
                        rs.getString("COMPTE_VENTE"),
                        rs.getString("COMPTE_ACHAT"),
                        rs.getString("LIBELLEEXTACTE"),
                        rs.getDouble("TVA"),
                        rs.getString("FILEPATH"),
                        rs.getDouble("RESTE"),
                        rs.getString("TYPESTOCK"),
                        rs.getString("IDCHAMBRE"),
                        rs.getInt("ISPERISHABLE"),
                        rs.getDouble("PV2"),
                        rs.getString("CODEBARRE"),
                        rs.getString("TYPEINGREDIENT"),
                        rs.getString("REFERENCE")
                );
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (stmt != null) stmt.close();
        }

        return medicament;
    }
    public Vente getVenteById(String idVente, Connection con) throws Exception {
        if (idVente == null || idVente.trim().isEmpty()) {
            return null;
        }
        String sql = "SELECT * FROM VENTE WHERE ID = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idVente.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Vente vente = new Vente();
                    vente.setId(rs.getString("ID"));
                    vente.setDesignation(rs.getString("DESIGNATION"));
                    vente.setIdMagasin(rs.getString("IDMAGASIN"));
                    vente.setDaty(rs.getTimestamp("DATY"));
                    vente.setRemarque(rs.getString("REMARQUE"));
                    vente.setEtat(rs.getInt("ETAT"));
                    vente.setIdOrigine(rs.getString("IDORIGINE"));
                    vente.setIdClient(rs.getString("IDCLIENT"));
                    vente.setEstPrevu(rs.getInt("ESTPREVU"));
                    vente.setDatyPrevu(rs.getTimestamp("DATYPREVU"));
                    vente.setIdReservation(rs.getString("IDRESERVATION"));
                    vente.setRemise(rs.getDouble("REMISE"));
                    vente.setIdModePaiement(rs.getString("IDMODEPAIEMENT"));
                    vente.setRemiseMontant(rs.getDouble("REMISEMONTANT"));
                    vente.setMontantDonne(rs.getDouble("MONTANTDONNE"));
                    return vente;
                }
            }
        }
        return null; // Si aucune vente trouvée
    }
    public boolean update_datefin_ordonnance(String idordonnance,java.util.Date fin, Connection con) throws Exception{
        String sql = "UPDATE med_ordonnance SET date_fin = ? WHERE id = ?";
        boolean retour = false;
        try{
            PreparedStatement st = con.prepareStatement(sql);
            st.setDate(1, new java.sql.Date(fin.getTime()));
            st.setString(2,idordonnance);
            if(st.executeUpdate() > 0){
                retour = true;
            }

        } catch(Exception e){
            throw e;
        }
        return retour;
    }

// mini fonctions manokatra Connection
    public User login(String nom,String pwd) throws Exception{
        User user = null;
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            user = login(nom,pwd,con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return user;
    }
    public Vector<Client> get_clients() throws Exception{
        Vector<Client> clients = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            clients = get_clients(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return clients;
    }
    public Vector<Medecin> get_medecins() throws Exception{
        Vector<Medecin> medecins = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            medecins = get_medecins(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return medecins;
    }
    public Vector<Produit> get_produits() throws Exception{
        Vector<Produit> produits = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            produits = get_produits(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return produits;
    }
    public Vector<Medicament> get_medicaments() throws Exception{
        Vector<Medicament> medicaments = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            medicaments = get_medicaments(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return medicaments;
    }
    public Vector<Med_Ordonnance> get_medordonnances() throws Exception{
        Vector<Med_Ordonnance> ordonnances = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            ordonnances = get_medordonnances(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return ordonnances;
    }
    public Vector<MedOrdonnanceFille> get_medordonnances_fille(String idordonnance) throws Exception{
        Vector<MedOrdonnanceFille> ordonnances_fille = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            ordonnances_fille = get_medordonnances_fille(idordonnance,con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return ordonnances_fille;
    }
    public Med_Ordonnance get_1ordonnance(String idordonnance) throws Exception{
        Med_Ordonnance ordonnance = null;
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            ordonnance = get_1ordonnance(idordonnance,con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return ordonnance;
    }
    public Vente getVenteById(String idVente) throws Exception {
        Vente vente = null;
        Connection con = null;

        try {
            con = VanialaConnection.getConnection();
            vente = getVenteById(idVente, con);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
        return vente;
    }
    public Vector<EtatStockAll> get_etatStockAll() throws Exception{
        Vector<EtatStockAll> etats = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            etats = get_etatStockAll(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return etats;
    }
    public Vector<MvtStockfille> get_MvtStockfille() throws Exception{
        Vector<MvtStockfille> mvts = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            mvts = get_MvtStockfille(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return mvts;
    }
    public Vector<EtatsStock> get_EtatStock() throws Exception{
        Vector<EtatsStock> etats = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            etats = get_EtatStock(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return etats;
    }
    public Vector<MontantStock> get_MontantStock() throws Exception{
        Vector<MontantStock> montants = new Vector<>();
        Connection con = null;
        try{
            con = VanialaConnection.getConnection();
            montants = get_MontantStock(con);

        }catch (Exception e) {
            throw e;
        } finally{
            if(con != null){
                con.close();
            }
        }
        return montants;
    }
    

// fonctions utiles
    private java.util.Date getDateFromResultSet(ResultSet rs, String columnName) throws Exception {
        java.sql.Date sqlDate = rs.getDate(columnName);
        return sqlDate != null ? new java.util.Date(sqlDate.getTime()) : null;
    }
    private void setStringOrNull(PreparedStatement ps, int index, String value) throws Exception {
        if (value == null || value.trim().isEmpty()) {
            ps.setNull(index, java.sql.Types.VARCHAR);
        } else {
            ps.setString(index, value.trim());
        }
    }
    private void setDoubleOrNull(PreparedStatement ps, int index, Double value) throws Exception {
        if (value == null || value.isNaN()) {
            ps.setNull(index, java.sql.Types.NUMERIC);
        } else {
            ps.setDouble(index, value);
        }
    }


    /* Fonction set vente */
    public String set_vente(Connection con ,String idClient, java.util.Date daty) throws Exception {
        String idVente = null;
        PreparedStatement ps = null;
        try {
            long now = System.currentTimeMillis();
            // ID format: VNT + 12 digits based on current time (keeps format like VNT002954105735)
            idVente = "VNT" + String.format("%012d", now % 1000000000000L);
            String sql = "INSERT INTO vente (id, idclient, daty, datyprevu,idmagasin) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, idVente);
            ps.setString(2, idClient);
            if (daty != null) ps.setTimestamp(3, new java.sql.Timestamp(daty.getTime()));
            else ps.setTimestamp(3, new java.sql.Timestamp(System.currentTimeMillis()));
            // datyprevu = now()
            ps.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.setString(5, "TEST");

            ps.executeUpdate();

        } catch (Exception e) {
            throw e;
        } finally {
            if (ps != null) ps.close();
        }

        return idVente;
    }
/* Mini fonction de set_vente */
    public String set_vente(String idClient, java.util.Date daty) throws Exception {
        String id = null;
        Connection con = null;
        try {
            con = VanialaConnection.getConnection();
            id = set_vente(con, idClient, daty);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) con.close();
        }
        return id;
    }
// Insertion dans VenteDetails
    public String set_vente_details(Connection con, String idVente, String idProduit, double quantite, double pu,
    String designation, String idMedecin) throws Exception {
        String idDetail = null;
        PreparedStatement ps = null;
        try {
            long now = System.currentTimeMillis();
            idDetail = "VTD" + String.format("%012d", now % 1000000000000L);

            String sql = "INSERT INTO vente_details (id, idvente, idproduit, idorigine, qte, pu, remise, tva, puachat, puvente, iddevise, tauxdechange, designation, compte, purevient, idacte, remisemontant, idmedecin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, idDetail);
            ps.setString(2, idVente);
            ps.setString(3, idProduit);
            ps.setNull(4, java.sql.Types.VARCHAR); // idorigine unknown here
            ps.setDouble(5, quantite);
            ps.setDouble(6, pu);
            ps.setDouble(7, 0.0); // remise
            ps.setDouble(8, 0.0); // tva
            ps.setDouble(9, 0.0); // puachat
            ps.setDouble(10, 0.0); // puvente
            ps.setNull(11, java.sql.Types.VARCHAR); // iddevise
            ps.setDouble(12, 0.0); // tauxdechange
            ps.setString(13, designation);
            ps.setNull(14, java.sql.Types.VARCHAR); // compte
            ps.setDouble(15, 0.0); // purevient
            ps.setNull(16, java.sql.Types.VARCHAR); // idacte
            ps.setDouble(17, 0.0); // remisemontant
            ps.setString(18, idMedecin);

            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            if (ps != null) ps.close();
        }
        return idDetail;
    }
/* mini Set_vente_details */
    public String set_vente_details(String idVente, String idProduit, double quantite, double pu,
                                     String designation, String idMedecin) throws Exception {
        String id = null;
        Connection con = null;
        try {
            con = VanialaConnection.getConnection();
            id = set_vente_details(con, idVente, idProduit, quantite, pu, designation, idMedecin);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) con.close();
        }
        return id;
    }
// Récupère tous les VenteDetails pour un idVente donné (avec Connection)
    public Vector<VenteDetails> get_VenteDetails(Connection con, String idVente) throws Exception {
        String sql = "SELECT * FROM vente_details WHERE idvente = ?";
        Vector<VenteDetails> details = new Vector<>();
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, idVente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                details.add(new VenteDetails(
                        rs.getString("ID"),
                        rs.getString("IDVENTE"),
                        rs.getString("IDPRODUIT"),
                        rs.getString("IDORIGINE"),
                        rs.getDouble("QTE"),
                        rs.getDouble("PU"),
                        rs.getDouble("REMISE"),
                        rs.getDouble("TVA"),
                        rs.getDouble("PUACHAT"),
                        rs.getDouble("PUVENTE"),
                        rs.getString("IDDEVISE"),
                        rs.getDouble("TAUXDECHANGE"),
                        rs.getString("DESIGNATION"),
                        rs.getString("COMPTE"),
                        rs.getDouble("PUREVIENT"),
                        rs.getString("IDACTE"),
                        rs.getDouble("REMISEMONTANT"),
                        rs.getString("IDMEDECIN")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (ps != null) ps.close();
        }

        return details;
    }
// get_VenteDetails sans connection
    public Vector<VenteDetails> get_VenteDetails(String idVente) throws Exception {
        Vector<VenteDetails> details = new Vector<>();
        Connection con = null;
        try {
            con = VanialaConnection.getConnection();
            details = get_VenteDetails(con, idVente);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) con.close();
        }
        return details;
    }   
// Insertion dans MvtStock (avec Connection) — seuls idVente, daty et designation sont fournis; autres colonnes = NULL
    public String set_MvtStock(Connection con, String idVente, java.util.Date daty) throws Exception {
        String idMvt = null;
        PreparedStatement ps = null;
        try {
            long now = System.currentTimeMillis();
            idMvt = "MVTST" + String.format("%012d", now % 1000000000000L);

            String sql = "INSERT INTO MVTSTOCK (ID, DESIGNATION, IDMAGASIN, IDVENTE, IDTRANSFERT, IDTYPEMVSTOCK, DATY, ETAT, IDPOINT, IDOBJET, FABPRECEDENT, SOURCE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, idMvt);
            ps.setString(2, "Mouvement relatif ...");
            ps.setString(3, "PHARM004"); // magasin par défaut
            ps.setString(4, idVente);
            ps.setNull(5, java.sql.Types.VARCHAR); // IDTRANSFERT
            ps.setNull(6, java.sql.Types.VARCHAR); // IDTYPEMVSTOCK
            if (daty != null) ps.setTimestamp(7, new java.sql.Timestamp(daty.getTime())); else ps.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.setNull(8, java.sql.Types.NUMERIC); // ETAT
            ps.setNull(9, java.sql.Types.VARCHAR); // IDPOINT
            ps.setNull(10, java.sql.Types.VARCHAR); // IDOBJET
            ps.setNull(11, java.sql.Types.VARCHAR); // FABPRECEDENT
            ps.setNull(12, java.sql.Types.VARCHAR); // SOURCE

            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            if (ps != null) ps.close();
        }
        return idMvt;
    }
// Wrapper sans Connection
    public String set_MvtStock(String idVente, java.util.Date daty) throws Exception {
        String id = null;
        Connection con = null;
        try {
            con = VanialaConnection.getConnection();
            id = set_MvtStock(con, idVente, daty);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) con.close();
        }
        return id;
    }
// Insert MvtStockFille using an existing Connection (follows project pattern)
    public String set_MvtStockFille(Connection con, String idMvtStock, int sortie, String designation, double pu) throws Exception {
        String id = null;
        PreparedStatement ps = null;
        try {
            long now = System.currentTimeMillis();
            id = "MVTSFI" + String.format("%012d", now % 1000000000000L);

            String sql = "INSERT INTO MVTSTOCKFILLE (ID, IDMVTSTOCK, IDPRODUIT, ENTREE, SORTIE, IDVENTEDETAIL, IDTRANSFERTDETAIL, PU, MVTSRC, RESTE, DESIGNATION, DATEPEREMPTION, DATEPEREMPTIONLIB, SOURCE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, idMvtStock);
            ps.setNull(3, java.sql.Types.VARCHAR); // IDPRODUIT
            ps.setDouble(4, 0.0); // ENTREE
            ps.setDouble(5, sortie);
            ps.setNull(6, java.sql.Types.VARCHAR); // IDVENTEDETAIL
            ps.setNull(7, java.sql.Types.VARCHAR); // IDTRANSFERTDETAIL
            ps.setDouble(8, pu);
            ps.setNull(9, java.sql.Types.VARCHAR); // MVTSRC
            ps.setDouble(10, 0.0); // RESTE
            ps.setString(11, designation);
            ps.setNull(12, java.sql.Types.DATE); // DATEPEREMPTION
            ps.setNull(13, java.sql.Types.VARCHAR); // DATEPEREMPTIONLIB
            ps.setNull(14, java.sql.Types.VARCHAR); // SOURCE

            ps.executeUpdate();

        } catch (Exception e) {
            throw e;
        } finally {
            if (ps != null) ps.close();
        }

        return id;
    }
// Wrapper that opens a Connection and delegates to the Connection-taking method
    public String set_MvtStockFille(String idMvtStock, int sortie, String designation, double pu) throws Exception {
        String id = null;
        Connection con = null;
        try {
            con = VanialaConnection.getConnection();
            id = set_MvtStockFille(con, idMvtStock, sortie, designation, pu);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) con.close();
        }
        return id;
    }
}