<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="database.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
Connection con = null;
Function fonction = new Function();
boolean success = false;

    String dateString = request.getParameter("date");
    if (dateString == null || dateString.isEmpty()) {
        response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Aucune Date selectionner", "UTF-8"));
        return;
    }
    java.util.Date date = null;
    try{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
        date = sdf.parse(dateString);
    }catch(Exception e){
        String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
        response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
            return;
    }

    try {
        con = VanialaConnection.getConnection();
        con.setAutoCommit(false);

        Vector<EtatsStock> etats = fonction.get_EtatStock(con);
        Vector<Medicament> medicaments = fonction.get_medicaments(con);
            if(etats == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Vector etats NULL", "UTF-8"));
                return;
            }
            if(medicaments == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Vector medicaments NULL", "UTF-8"));
                return;
            }

        // inserer Inventaire
            String id = "id";
            String designation = "Inventaire du "+date;
            Inventaire inv = new Inventaire(id,date,designation,"PHARM004",11,"","","");
            String idInv = fonction.insert_inventaire(con,inv);
            if(idInv == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Insert Inventaire IMPOSSIBLE", "UTF-8"));
                return;
            }
        // inserer MVT Stock
            java.util.Date datyPrevu = date;
            String idMVTstock = fonction.set_MvtStock(con,"",datyPrevu);
            if(idMVTstock == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Insert MVT Stock IMPOSSIBLE", "UTF-8"));
                return;
            }
        for (int i = 0; i < etats.size(); i++) {
            EtatsStock medoc_etat = etats.get(i);
            int indice = i;
            if (medoc_etat == null) continue;

            Medicament medoc = null; 
            for(Medicament me: medicaments){
                String libel = me.getLibelle();
                if(java.util.Objects.equals(libel, medoc_etat.getIdProduitLib())){
                    medoc = me;
                    break;
                }
            }
            if(medoc == null){
                con.rollback();
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Le medicament "+medoc_etat.getIdProduitLib()+" est introuvable", "UTF-8"));
                return;
            }
            String idmedoc = medoc.getId();


            // Recuperer la quantite saisie
            String quantiteStr = request.getParameter("quantite_" + indice);
            int quantiteSaisie = 1;
            if (quantiteStr != null && !quantiteStr.trim().isEmpty()) {
                try {
                    quantiteSaisie = Integer.parseInt(quantiteStr.trim());
                    if (quantiteSaisie < 0) quantiteSaisie = 0;
                } catch (NumberFormatException e) {
                    quantiteSaisie = 0; 
                }
            }

            double quantiteLogiciel = medoc_etat.getReste();
            double quantiteReelle = quantiteSaisie;

            // === Insertion dans InventaireFille ===
            InventaireFille invF = new InventaireFille(
                "id", idInv, idmedoc, "", quantiteLogiciel, quantiteReelle, "", date, ""
            );
            String idInvF = fonction.insert_inventairefille(con, invF);
            if (idInvF == null) {
                con.rollback();
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Erreur insertion ligne inventaire", "UTF-8"));
                return;
            }

            // === Calcul de l'ecart ===
             double ecart = 0.0;
             double entree = 0.0;
             double sortie = 0.0;
             double qte = 0.0;

            if( quantiteReelle > quantiteLogiciel ){ 
                ecart = quantiteReelle - quantiteLogiciel;
                 //→ entree en stock
                 entree = ecart;
            } else if( quantiteReelle < quantiteLogiciel ){
                ecart = quantiteLogiciel - quantiteReelle; 
                // → sortie de stock
                sortie = ecart;
            }
            qte = ecart;
            // meme valeur dans reelle & logiciel
            if (ecart == 0) { continue; }  

            // === Insertion mouvement de stock fille ===
            double pu = medoc.getPv(); 
            String design = medoc_etat.getIdProduitLib(); 
            String unite = medoc.getUnite();
            double pvT = qte * medoc.getPv();
            MvtStockfille mvtF = new MvtStockfille(
                "id",idMVTstock,
                idmedoc,
                entree,sortie,
                null,
                "idtransfer",
                pu,"mvtsrc",
                0,design,
                null,
                "dateperemption",
                "source",
                unite,qte,pvT
            );
            String idMVTstock_fille = fonction.set_MvtStockFille(con,mvtF) ;  
            
            if (idMVTstock_fille == null) {
                con.rollback();
                response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Erreur de insert mouvement stock fille", "UTF-8"));
                return;
            }
        }
        
        con.commit();
        success = true;
        response.sendRedirect("Stock.jsp");

    } catch (Exception e) {
        try { con.rollback(); } catch (SQLException ex) { throw ex; }
        e.printStackTrace();
        String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
        response.sendRedirect("Arreter.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
    } finally {
        if (con != null) {
            try {
                con.setAutoCommit(true); 
                con.close();
            } catch (SQLException ex) {
                throw ex;
            }
        }
    }

%>