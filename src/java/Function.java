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
        String sql = "SELECT * FROM med_ordonnance ORDER BY daty DESC"; // tri utile

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
    public Vector<MedOrdonnanceFille> get_medordonnances_fille(String idOrdonnance, Connection con) 
        throws Exception {
    
        if (idOrdonnance == null || idOrdonnance.trim().isEmpty()) {
            throw new IllegalArgumentException("L'ID de l'ordonnance est obligatoire");
        }

        String sql = """
            SELECT * FROM med_ordonnance_fille 
            WHERE idordonnance = ? 
            ORDER BY id
            """;

        Vector<MedOrdonnanceFille> lignes = new Vector<>();

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idOrdonnance.trim());

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
    public String insert_ordonnance(Med_Ordonnance ordonnance, Connection con) throws SQLException {
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
                CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ?, ?,
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
                throw new SQLException("Échec de l'insertion de l'ordonnance, aucune ligne insérée.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getString(1); 
                } else {
                    throw new SQLException("Insertion réussie mais impossible de récupérer l'ID généré.");
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
   
// fonctions utiles
    private java.util.Date getDateFromResultSet(ResultSet rs, String columnName) throws SQLException {
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

}