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
        response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Aucune Date selectionner", "UTF-8"));
        return;
    }

java.util.Date date = null;
try{
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
    date = sdf.parse(dateString);
}catch(Exception e){
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
        return;
}
String[] selectedMedocIds = request.getParameterValues("selectedMedoc");

try {
    con = VanialaConnection.getConnection();
    con.setAutoCommit(false);

    if (selectedMedocIds == null || selectedMedocIds.length == 0) {
        response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Aucun médicament sélectionné", "UTF-8"));
        return;
    }
    Vector<Medicament> medicaments = fonction.get_medicaments(con);
    int prochainNumero = medicaments.size() + 1;

    // inserer MVT Stock
        String idMVTstock = fonction.set_MvtStock(con,"",date);
        if(idMVTstock == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Insert MVT Stock IMPOSSIBLE", "UTF-8"));
            return;
        }

    for(String idmedoc : selectedMedocIds){
        Medicament medoc = null;
        int indice = 0;
        for(int i = 0;  i < medicaments.size(); i++){
            if(medicaments.get(i).getId().equals(idmedoc)){
                medoc = medicaments.get(i);
                indice = i;
                break;
            }
        }

        String quantiteStr = request.getParameter("quantite_" + indice);
        String unite = request.getParameter("unite_" + indice);

        double quantite = 1;
        if (quantiteStr != null && !quantiteStr.trim().isEmpty()) {
            try {
                quantite = Double.parseDouble(quantiteStr.trim());
                if (quantite <= 0) quantite = 1;
            } catch (NumberFormatException e) {
                quantite = 1;
            }
        }
      // obligatoire
        String idprod = medoc.getId();
        String designe = medoc.getLibelle();
        double entree = 0.0;
        double sortie = 0.0;

      // les quantite int & double
        int qteInt = (int) quantite;
        double qteDouble = quantite - qteInt;
        double puInt = 0.0;
        double puDouble = 0.0;
        double pvInt = 0.0;
        double pvDouble = 0.0;

        if(medoc.getUnite().equals(unite)){
                entree = quantite;      
                double pu = medoc.getPv();
                double pvT = pu * quantite;
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
                unite,quantite,pvT
            );
            String idMVTstock_fille = fonction.set_MvtStockFille(con,mvtF) ;
            if(idMVTstock_fille == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille IMPOSSIBLE", "UTF-8"));
                return;
            }
        } else {
            Equivalence eq = fonction.get_equivalence(con,unite);
            {
                if(eq == null) {
                    try { con.rollback(); } catch (SQLException ex) { throw ex; }
                    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Aucune équivalence trouvée pour l'unité sélectionnée", "UTF-8"));
                    return;
                }
                
                // la partie int
                puInt = eq.getPv();
                pvInt = puInt * qteInt;
                entree = eq.getQuantite() * qteInt;
                MvtStockfille mvtF1 = new MvtStockfille(
                    "id",idMVTstock,
                    idprod,
                    entree,sortie,
                    null,
                    "idtransfer",
                    puInt,"mvtsrc",
                    0,designe,
                    null,
                    "dateperemption",
                    "source",
                    unite,qteInt,pvInt
                );
                String idMVTstock_fille1 = fonction.set_MvtStockFille(con,mvtF1) ;
                if(idMVTstock_fille1 == null){
                    try { con.rollback(); } catch (SQLException ex) { throw ex; }
                    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille1 IMPOSSIBLE", "UTF-8"));
                    return;
                }

                // la parti double
                puDouble = medoc.getPv();
                pvDouble = puDouble * qteDouble;
                entree = qteDouble * eq.getQuantite();
                MvtStockfille mvtF2 = new MvtStockfille(
                    "id",idMVTstock,
                    idprod,
                    entree,sortie,
                    null,
                    "idtransfer",
                    puDouble,"mvtsrc",
                    0,designe,
                    null,
                    "dateperemption",
                    "source",
                    medoc.getUnite(),entree,pvDouble
                );
                String idMVTstock_fille2 = fonction.set_MvtStockFille(con,mvtF2) ;
                if(idMVTstock_fille2 == null){
                    try { con.rollback(); } catch (SQLException ex) { throw ex; }
                    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille2 IMPOSSIBLE", "UTF-8"));
                    return;
                }
            }
        }

    }
    
    con.commit();
    success = true;
    response.sendRedirect("Stock.jsp");

} catch (Exception e) {
    try { con.rollback(); } catch (SQLException ex) { throw ex; }
    e.printStackTrace();
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
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