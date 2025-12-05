<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="database.*"%>
<%@ page import="java.text.*"%>

<%@ page import="java.net.URLEncoder"%>

<%
Connection con = null;
Function fonction = new Function();
boolean success = false;


try {
    con = VanialaConnection.getConnection();
    con.setAutoCommit(false);
    String idmedoc = request.getParameter("idmedoc");
    String unite = request.getParameter("unite");
    java.util.Date date = new java.util.Date();


    if (idmedoc == null) {
        response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Aucun médicament sélectionné", "UTF-8"));
        return;
    }
    if (unite == null || unite.isEmpty()) {
        response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Aucune Unite selectionner", "UTF-8"));
        return;
    }
    Vector<Medicament> medicaments = fonction.get_medicaments(con);
    // inserer MVT Stock
        String idMVTstock = fonction.set_MvtStock(con,"",date);
        if(idMVTstock == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert MVT Stock IMPOSSIBLE", "UTF-8"));
            return;
        }

        Medicament medoc = null;
        int indice = 0;
        for(int i = 0;  i < medicaments.size(); i++){
            if(medicaments.get(i).getId().equals(idmedoc)){
                medoc = medicaments.get(i);
                break;
            }
        }

        String quantiteStr = request.getParameter("quantite");

        double quantite = 1;
        if (quantiteStr != null && !quantiteStr.trim().isEmpty()) {
            try {
                quantite = Double.parseDouble(quantiteStr.trim());
                if (quantite <= 0) quantite = 1;
            } catch (NumberFormatException e) {
                quantite = 1;
            }
        }


    // inserer MVT Stock fille
        double entree = 0.0;
        double pu = 0.0;
        double pvT = 0.0;
        double qte = 0.0;
       // tsy miova
        double sortie = 0.0;
        String idprod = medoc.getId();
        String designe = medoc.getLibelle();
        if(medoc.getUnite().equals(unite)){
            entree = quantite;      
            pu = medoc.getPv();
            pvT = pu * quantite;
            qte = quantite;

            MvtStockfille mvtF = new MvtStockfille(
                "id",idMVTstock,
                idprod,
                entree,sortie,
                null,
                "idtransfer",
                pu,"mvtsrc",
                0,designe,
                null,
                "dateperemption",
                "source",
                unite,qte,pvT
            );
            String idMVTstock_fille = fonction.set_MvtStockFille(con,mvtF) ;  
            if(idMVTstock_fille == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille IMPOSSIBLE", "UTF-8"));
                return;
            }
        } else {
            Equivalence eq = fonction.get_equivalence(con,unite);
            if(eq == null) {
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Aucune équivalence trouvée pour l'unité sélectionnée", "UTF-8"));
                return;
            }
            // partie int
            int qteInt = (int) quantite;
            entree = qteInt * eq.getQuantite();
            pu = eq.getPv();
            pvT = qteInt * pu;
            qte = qteInt;
            
            MvtStockfille mvtF1 = new MvtStockfille(
                "id",idMVTstock,
                idprod,
                entree,sortie,
                null,
                "idtransfer",
                pu,"mvtsrc",
                0,designe,
                null,
                "dateperemption",
                "source",
                unite,qte,pvT
            );
            String idMVTstock_fille1 = fonction.set_MvtStockFille(con,mvtF1) ;  
            if(idMVTstock_fille1 == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille1 IMPOSSIBLE", "UTF-8"));
                return;
            }
            // partie double
            double qteDouble = (double) (quantite - qteInt);
            entree = qteDouble * eq.getQuantite();
            pu = medoc.getPv();
            pvT = pu * entree;
            qte = entree;

            MvtStockfille mvtF = new MvtStockfille(
                "id",idMVTstock,
                idprod,
                entree,sortie,
                null,
                "idtransfer",
                pu,"mvtsrc",
                0,designe,
                null,
                "dateperemption",
                "source",
                unite,qte,pvT
            );
            String idMVTstock_fille = fonction.set_MvtStockFille(con,mvtF) ;  
            if(idMVTstock_fille == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille IMPOSSIBLE", "UTF-8"));
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
    response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
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