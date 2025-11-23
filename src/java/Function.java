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
    public Vector<Med_Ordonnance> get_Med_Ordonnances(Connection con) throws Exception {
        String sql = "SELECT * FROM med_ordonnance";
        Vector<Med_Ordonnance> ordonnances = new Vector<>();
        Statement ps = null;

        try {
            ps = con.createStatement();
            ResultSet rs = ps.executeQuery(sql);

            while (rs.next()) {
                ordonnances.add(new Med_Ordonnance(
                    rs.getString("id"),
                    rs.getString("idconsultation"),
                    new java.util.Date(rs.getDate("daty").getTime()),
                    rs.getString("nb_jours"),
                    new java.util.Date(rs.getDate("date_debut").getTime()),
                    new java.util.Date(rs.getDate("date_fin").getTime()),
                    rs.getString("type"),
                    rs.getInt("etat"),
                    rs.getString("observation_s"),
                    rs.getString("idmedecin")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return ordonnances;
    }
    public Vector<MedOrdonnanceFille> get_MedOrdonnanceFilles(String idOrdonnance,Connection con) throws Exception {
        String sql = "SELECT * FROM med_ordonnance_fille WHERE idordonnance = ?";
        Vector<MedOrdonnanceFille> ordonnances_fille = new Vector<>();
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, idOrdonnance);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ordonnances_fille.add(new MedOrdonnanceFille(
                    rs.getString("id"),
                    rs.getString("idconsultation"),
                    new java.util.Date(rs.getDate("daty").getTime()),
                    rs.getString("nb_jours"),
                    new java.util.Date(rs.getDate("date_debut").getTime()),
                    new java.util.Date(rs.getDate("date_fin").getTime()),
                    rs.getString("type"),
                    rs.getInt("etat"),
                    rs.getString("observation_s"),
                    rs.getString("idmedecin")
                ));
            }

        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return ordonnances_fille;
    }
    public boolean insert_ordonnance(Med_Ordonnance ordonnance, Connection con) throws Exception {
        String sql = "INSERT INTO med_ordonnance (id,id_consultation,daty,nb_jours,date_debut,date_fin,idmedecin) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement ps = null;
        boolean retour = false;

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, ordonnance.getId());
            ps.setString(2, ordonnance.getId_consultation());
            new java.sql.Date(ps.setDate(3, ordonnance.getDaty().getTime()));
            ps.setString(4, ordonnance.getNb_jours());
            new java.sql.Date(ps.setDate(5, ordonnance.getDate_debut().getTime()));
            new java.sql.Date(ps.setDate(6, ordonnance.getDate_fin().getTime()));
            ps.setString(7, ordonnance.getIdmedecin());

            if(ps.executeUpdate()){
                retour = true;
            }
        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
        }
        return retour;
    }
    public boolean insert_ordonnance_fille(MedOrdonnanceFille ordonnance_fille, Connection con) throws Exception {
        String sql = "INSERT INTO med_ordonnance_fille (idmedicament,posologie,idordonnance,id,etat,prix,nb_jours,unite) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement ps = null;
        boolean retour = false;

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, ordonnance_fille.getIdMedicament());
            ps.setString(2, ordonnance_fille.getPosologie());
            ps.setString(3, ordonnance_fille.getIdOrdonnance());
            ps.setString(4, ordonnance_fille.getId());
            ps.setString(5, ordonnance_fille.getEtat());
            ps.setString(6, ordonnance_fille.getPrix());
            ps.setString(7, ordonnance_fille.getNbJours());
            ps.setString(8, ordonnance_fille.getUnite());


            if(ps.executeUpdate()){
                retour = true;
            }
        } catch (Exception e) {
            throw e;
        } finally{
            if(ps != null){
                ps.close();
            }
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

}