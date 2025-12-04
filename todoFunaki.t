Entree de produit dans le stock :

    - [pk] Entree.jsp :
        -> [ok] rajouter une liste deroulante pour choisir lunite du produit entre "Boite", "Comprime", "Flacon", etc.
            -> [ok] calculer la quantite totale en fonction de lunite choisie et de la quantite entree
            
            -> [ok] enregistrer lunite choisie et la quantite totale dans la table mvtstockfille    
                - java :
                    - [ok] modifier la table mvtstockfille pour ajouter les colonnes "unite" et "qte_total" et "prix_total"
                    - [ok] modifier la classe MvtStockFille.java pour ajouter les attributs "unite", "qte_total" et "prix_total" avec leurs getters et setters

                - Function.java :  
                    - [ok] modifier set_mvtstockfille() pour ajouter son unite et la quantite totale et le prix total
        
    - [ok] Traitement.jsp :
        -> [ok] recuperer lunite choisie depuis Entree.jsp
        -> [ok] calculer le prix unitaire en fonction de lunite choisie
        -> [ok] enregistrer le prix total dans la table mvtstockfille
            - [ok] modifier set_mvtstockfille() pour ajouter le prix total



   public String set_MvtStockFille(Connection con, String idMvtStock,String idproduit, double entree, double sortie, String designation, double pu,double prix_total, String unite , double qte_total) throws Exception {
        String id = null;
        PreparedStatement ps = null;
        try {
            long now = System.currentTimeMillis();
            id = "MVTSFI" + String.format("%012d", now % 1000000000000L);

            String sql = "INSERT INTO MVTSTOCKFILLE (ID, IDMVTSTOCK, IDPRODUIT, ENTREE, SORTIE, IDVENTEDETAIL, IDTRANSFERTDETAIL, PU, MVTSRC, RESTE, DESIGNATION, DATEPEREMPTION, DATEPEREMPTIONLIB, SOURCE, UNITE,QTE_TOTAL,PRIX_TOTAL) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, idMvtStock);
            ps.setString(3, idproduit); // IDPRODUIT
            ps.setDouble(4, entree); // ENTREE
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
            ps.setString(15, unite);
            ps.setDouble(16, qte_total);
            ps.setDouble(17, prix_total);

            ps.executeUpdate();

        } catch (Exception e) {
            throw e;
        } finally {
            if (ps != null) ps.close();
        }

        return id;
    }


        public String set_MvtStockFille(String idMvtStock ,String idproduit,double entree ,double sortie, String designation, double pu,double prix_total, String unite , double qte_total) throws Exception {
        String id = null;
        Connection con = null;
        try {
            con = VanialaConnection.getConnection();
            id = set_MvtStockFille(con, idMvtStock,idproduit, entree, sortie, designation, pu, prix_total, unite , qte_total);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) con.close();
        }
        return id;
    }